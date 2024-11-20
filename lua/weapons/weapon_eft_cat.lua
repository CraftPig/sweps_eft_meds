if CLIENT then 
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/vgui_cat" )
	SWEP.BounceWeaponIcon = true 
    SWEP.DrawWeaponInfoBox = true
end

SWEP.PrintName = "CAT hemostatic tourniquet"
SWEP.Author = "Craft_Pig"
SWEP.Purpose = 
[[
Cures Bleeding
]]
SWEP.Category = "EFT"
SWEP.Category1 = "EFT"
SWEP.Category2 = "Injury Treatment"

SWEP.ViewModelFOV = 85
SWEP.ViewModel = "models/weapons/sweps/eft/cat/v_meds_cat.mdl"
SWEP.WorldModel = "models/weapons/sweps/eft/cat/w_meds_cat.mdl"
SWEP.UseHands = true
SWEP.DrawCrosshair = false 

SWEP.Spawnable = true
SWEP.Slot = 5
SWEP.SlotPos = 7
SWEP.DrawAmmo = true

SWEP.SwayScale = 0.15
SWEP.BobScale = 0.75

SWEP.Primary.Ammo = "cattourniquet"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.MaxHeal = 90

local INI_SEF = false
local INI_VIVO = false
local ID_WEAPON = "weapon_eft_cat"
local ID_PRIMARYAMMO = "cattourniquet"

function SWEP:Initialize()
    self:SetHoldType("slam")
	
	local FilePathSEF = "lua/SEF/SEF_Functions.lua"
    if file.Exists(FilePathSEF, "GAME") then
        INI_SEF = true
    end
	
	local FilePathVIVO = "lua/autorun/ojsshared.lua"
    if file.Exists(FilePathVIVO, "GAME") then
        INI_VIVO = true
    end
end 

function SWEP:Deploy()
    local owner = self:GetOwner() 
	
	self.IniAnimBandage = 0
	self.IniAnimSyringe = 0
	self.IniAnimPills = 0
	self.AnimTimes = 0
	self.IniHeal = 0
	
	self:SendWeaponAnim(ACT_VM_IDLE)
	
	if owner:GetAmmoCount(self.Primary.Ammo) == 0 then 
		owner:StripWeapon(ID_WEAPON)
		owner:SelectWeapon(owner:GetPreviousWeapon())
	end
	return true
end

function SWEP:Heal(owner)
	local owner = self:GetOwner() 
	local VarMissingHealth = owner:GetMaxHealth() - owner:Health()
	local VarGetHealth = math.min(VarMissingHealth, owner:GetAmmoCount(ID_PRIMARYAMMO))
	local VarHealHealth = math.min(VarGetHealth, self.MaxHeal) 
	
	if IsValid(owner) and SERVER and owner:GetActiveWeapon():GetClass() == ID_WEAPON then
		if INI_SEF == true then
				owner:RemoveEffect("Bleeding")
		end	
		if INI_VIVO == true then 
			if (OJSWounds:HasStatusWholeBody(owner, "Bleed")) then
				OJSWounds:HealBleed(owner)
			end
		else
			owner:SetHealth(math.min(owner:GetMaxHealth(), owner:Health() + VarHealHealth)) 
		end
		owner:RemoveAmmo(1, ID_PRIMARYAMMO) 
		self:Deploy()
	end
end

function SWEP:PrimaryAttack()
    local owner = self.Owner

    if owner:GetAmmoCount(ID_PRIMARYAMMO) == 0 then return end
	if self.IniAnimBandage == 1 or self.IniAnimSyringe == 1 or self.IniAnimPills == 1 then return end
	
	self:SendWeaponAnim(ACT_VM_RECOIL1)
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	self.IniAnimBandage = 1
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
	if self.IniHeal == 1 and self.IdleTimer <= CurTime() then -- Initialize Heal
		self.IniHeal = 0
		self.IniAnimBandage = 0
		self:Heal(owner)
	end
	
	if self.IniAnimBandage == 1 and self.AnimTimes <= 0 and self.IdleTimer <= CurTime() then -- Bandage Sequence
		self:SendWeaponAnim(ACT_VM_RECOIL2)
		self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		self.AnimTimes = self.AnimTimes + 1
	elseif self.IniAnimBandage == 1 and self.AnimTimes == 1 and self.IdleTimer <= CurTime() then
		self:SendWeaponAnim(ACT_VM_RECOIL3)
		self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		self.IniHeal = 1
	end
end

function SWEP:Holster()
	return true
end

function SWEP:PostDrawViewModel( vm )
    local attachment = vm:GetAttachment(1)
    if attachment then
        self.vmcamera = vm:GetAngles() - attachment.Ang
    else
        self.vmcamera = Angle(0, 0, 0) 
    end
end

function SWEP:CalcView( ply, pos, ang, fov )
	self.vmcamera = self.vmcamera or Angle(0, 0, 0)  
    return pos, ang + self.vmcamera, fov
end

if CLIENT then -- Worldmodel offset
	local WorldModel = ClientsideModel(SWEP.WorldModel)

	WorldModel:SetSkin(0)
	WorldModel:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		local owner = self:GetOwner()

		if (IsValid(owner)) then
			local offsetVec = Vector(0, -5, -0)
			local offsetAng = Angle(-90, 180, 0)
			
			local boneid = owner:LookupBone("ValveBiped.Bip01_R_Hand") -- Right Hand
			if !boneid then return end

			local matrix = owner:GetBoneMatrix(boneid)
			if !matrix then return end

			local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

			WorldModel:SetPos(newPos)
			WorldModel:SetAngles(newAng)

            WorldModel:SetupBones()
		else
			
			WorldModel:SetPos(self:GetPos())
			WorldModel:SetAngles(self:GetAngles())
			self:DrawModel()
		end

		WorldModel:DrawModel()

	end
end