if CLIENT then 
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/vgui_afak" )
	SWEP.BounceWeaponIcon = true 
    SWEP.DrawWeaponInfoBox = true
end

SWEP.PrintName = "AFAK First Aid Kit"
SWEP.Author = "Craft_Pig"
SWEP.Purpose = 
[[
Heals up to 30HP
Cures Bleeding
]]
SWEP.Category = "EFT"
SWEP.Category1 = "EFT"
SWEP.Category2 = "Medkits"

SWEP.ViewModelFOV = 85
SWEP.ViewModel = "models/weapons/sweps/eft/afak/v_meds_afak.mdl"
SWEP.WorldModel = "models/weapons/sweps/eft/afak/w_meds_afak.mdl"
SWEP.UseHands = true
SWEP.DrawCrosshair = false 

SWEP.Spawnable = true
SWEP.Slot = 5
SWEP.SlotPos = 7
SWEP.DrawAmmo = true

SWEP.SwayScale = 0.15
SWEP.BobScale = 0.75

SWEP.Primary.Ammo = "afak"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 400
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.MaxHeal = 30

local INI_SEF = false
local INI_VIVO = false
local ID_WEAPON = "weapon_eft_afak"
local ID_PRIMARYAMMO = "afak"

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
	return true
end

function SWEP:Heal(owner)
	local owner = self:GetOwner() 
	local VarMissingHealth = owner:GetMaxHealth() - owner:Health()
	local VarGetHealth = math.min(VarMissingHealth, owner:GetAmmoCount(ID_PRIMARYAMMO))
	local VarHealHealth = math.min(VarGetHealth, self.MaxHeal) 
	
	if IsValid(owner) and SERVER and owner:GetActiveWeapon():GetClass() == ID_WEAPON then
		if INI_SEF == true then
			if owner:HaveEffect("Bleeding") then
					owner:RemoveEffect("Bleeding")
					owner:RemoveAmmo(30, ID_PRIMARYAMMO)    
			end	
		end
		
		if INI_VIVO == true then 
			math.Round(OJSWounds:HealHP(owner, self.MaxHeal, VarHealHealth), 0)
			if (OJSWounds:HasStatusWholeBody(owner, "Bleed")) then
				OJSWounds:HealBleed(owner)
				owner:RemoveAmmo(30, ID_PRIMARYAMMO)    
			end
		else
			owner:SetHealth(math.min(owner:GetMaxHealth(), owner:Health() + VarHealHealth)) 
		end
		owner:RemoveAmmo(VarHealHealth, ID_PRIMARYAMMO) 
		self:Deploy()
	end
end

function SWEP:PrimaryAttack()
    local owner = self.Owner
	
    if owner:GetAmmoCount(self.Primary.Ammo) == 0 then return end
	if self.IniAnimBandage == 1 or self.IniAnimSyringe == 1 or self.IniAnimPills == 1 then return end
	
	self:SendWeaponAnim(ACT_VM_RECOIL1)
	self.IniAnimBandage = 1
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	
	timer.Simple(0.6, function() -- Audio Timer
		if IsValid(self) and IsValid(self.Owner) then
			if owner:GetActiveWeapon():GetClass() == ID_WEAPON then owner:EmitSound("MedsGrizzly.Open") end
		end
	end)
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
	if SERVER then
		if self.IniHeal == 1 and self.IdleTimer <= CurTime() then -- Initialize Heal
			self.IniAnimBandage = 0
			self.AnimTimes = 0
			self.IniHeal = 0
			self:Heal(owner)
		end
		
		if self.IniAnimBandage == 1 and self.AnimTimes <= 1 and self.IdleTimer <= CurTime() then -- Bandage Sequence
			if math.random(1,2) == 1 then
				self:SendWeaponAnim(ACT_VM_RECOIL2)
			else
				self:SendWeaponAnim(ACT_VM_HITRIGHT)
			end
			self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
			self.AnimTimes = self.AnimTimes + 1
		elseif self.IniAnimBandage == 1 and self.AnimTimes == 2 and self.IdleTimer <= CurTime() then
			self:SendWeaponAnim(ACT_VM_RECOIL3)
			self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
			self.IniHeal = 1
		end
	end
	
	-- if SERVER then return end
	-- if GetConVar("cl_eftmeds_quick"):GetBool() then
		-- LocalPlayer():ConCommand("+attack")
		-- if self.IniHeal == 1 then
			-- print("hi")
		-- end
	-- end
end


function SWEP:Holster()
	if CLIENT then LocalPlayer():ConCommand("-attack") end
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
			local offsetVec = Vector(3, -4, 3)
			local offsetAng = Angle(-0, -0, -180)
			
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