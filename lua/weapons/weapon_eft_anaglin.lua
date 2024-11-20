if CLIENT then 
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/vgui_alusplint" )
	SWEP.BounceWeaponIcon = true 
    SWEP.DrawWeaponInfoBox = true
end

SWEP.PrintName = "Anaglin"
SWEP.Author = "Craft_Pig"
SWEP.Purpose = 
[[
Gives On Painkillers, 95s
]]
SWEP.Category = "EFT"
SWEP.Category1 = "EFT"
SWEP.Category2 = "Drugs"

SWEP.ViewModelFOV = 85
SWEP.ViewModel = "models/weapons/sweps/eft/anaglin/v_meds_anaglin.mdl"
SWEP.WorldModel = "models/weapons/sweps/eft/anaglin/w_meds_anaglin.mdl"
SWEP.UseHands = true
SWEP.DrawCrosshair = false 

SWEP.Spawnable = true
SWEP.Slot = 5
SWEP.SlotPos = 7
SWEP.DrawAmmo = true

SWEP.SwayScale = 0.15
SWEP.BobScale = 0.75

SWEP.Primary.Ammo = "anaglin"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 4
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.MaxHeal = 0

local INI_SEF = false
local INI_VIVO = false
local ID_WEAPON = "weapon_eft_anaglin"
local ID_PRIMARYAMMO = "anaglin"

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
	self.AnimTimes = 0
	self.IniHeal = 0
	
	self:SendWeaponAnim(ACT_VM_IDLE)
	
	if owner:GetAmmoCount(self.Primary.Ammo) == 0 then 
		owner:StripWeapon(ID_WEAPON)
		owner:SelectWeapon(owner:GetPreviousWeapon())
	end
	
	OJSWounds:HealPain(owner)
	return true
end

function SWEP:Heal(owner)
	local owner = self:GetOwner() 
	
	if IsValid(self) then
		if IsValid(owner) and SERVER and owner:GetActiveWeapon():GetClass() == ID_WEAPON then -- Heal logic
			if INI_SEF == true then
				owner:ApplyEffect("OnPainkillers", 5)
			end
			owner:RemoveAmmo(1, ID_PRIMARYAMMO)   
		end
		self:Deploy()
	end
end

function SWEP:Heal(owner)
	local owner = self:GetOwner() 
	local VarMissingHealth = owner:GetMaxHealth() - owner:Health()
	local VarGetHealth = math.min(VarMissingHealth, owner:GetAmmoCount(ID_PRIMARYAMMO))
	local VarHealHealth = math.min(VarGetHealth, self.MaxHeal) 
	
	if IsValid(owner) and SERVER and owner:GetActiveWeapon():GetClass() == ID_WEAPON then
		if INI_SEF == true then
				owner:ApplyEffect("OnPainkillers", 95)
		end
		if INI_VIVO == true then 
			OJSWounds:AddStatus(owner,"Head","Painkillers", 95, 1)
			for i=1,7 do
				OJSWounds:HealPain(owner)
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

    if owner:GetAmmoCount(self.Primary.Ammo) == 0 then return end
	if self.IniAnimBandage == 1 or self.IniAnimSyringe == 1 or self.IniAnimPills == 1 then return end
	
	self:SendWeaponAnim(ACT_VM_RECOIL1)
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	self.IniAnimBandage = 1
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
	if self.IniAnimBandage == 1 and self.IdleTimer <= CurTime() then -- Bandage Sequence
		self.IniAnimBandage = 0
		self:Heal(owner)
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
			local offsetVec = Vector(4, -3, -2)
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