if CLIENT then 
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/vgui_L1" )
	SWEP.BounceWeaponIcon = true 
    SWEP.DrawWeaponInfoBox = true
end

SWEP.PrintName = "L1 Norepinephrine"
SWEP.Author = "Craft_Pig"
SWEP.Purpose = 
[[
Gives Tenacity 3s, 35%
Gives Exhausted 60s
Cures Dark Vision
]]
SWEP.Category = "EFT"
SWEP.Category1 = "EFT"
SWEP.Category2 = "Stimulants"

SWEP.ViewModelFOV = 85
SWEP.ViewModel = "models/weapons/sweps/eft/injector/v_meds_injector.mdl"
SWEP.WorldModel = "models/weapons/sweps/eft/injector/w_meds_injector.mdl"
SWEP.UseHands = true
SWEP.DrawCrosshair = false 

SWEP.Spawnable = true
SWEP.Slot = 5
SWEP.SlotPos = 7
SWEP.DrawAmmo = true

SWEP.SwayScale = 0.15
SWEP.BobScale = 0.75

SWEP.Primary.Ammo = "l1"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.MaxHeal = 0

local INI_SEF = false
local ID_WEAPON = "weapon_eft_injectorl1"
local ID_PRIMARYAMMO = "l1"

function SWEP:Initialize()
    self:SetHoldType("slam")
	
	local FilePathSEF = "lua/SEF/SEF_Functions.lua"
    if file.Exists(FilePathSEF, "GAME") then
        INI_SEF = true
    else
        INI_SEF = false
    end
end 

function SWEP:Deploy()
    local owner = self:GetOwner() 
	
	self.IniAnimBandage = 0
	self.AnimTimes = 0
	self.IniHeal = 0
	
	self:SendWeaponAnim(ACT_VM_IDLE)
	
	timer.Simple(0.05, function()
        if IsValid(self) and IsValid(self.Owner) then
            local vm = self.Owner:GetViewModel()
            if IsValid(vm) then
                vm:SetSkin(4) 
            end
        end
    end)
	
	if owner:GetAmmoCount(self.Primary.Ammo) == 0 then 
		owner:StripWeapon(ID_WEAPON)
		owner:SelectWeapon(owner:GetPreviousWeapon())
	end
	return true
end

function SWEP:Heal(owner)
	local owner = self:GetOwner() 
	
	if IsValid(self) then
		if IsValid(owner) and SERVER and owner:GetActiveWeapon():GetClass() == ID_WEAPON then -- Heal logic
			if INI_SEF == true then
				owner:ApplyEffect("Exhaust", 93)
				owner:ApplyEffect("Tenacity", 3, 35)
				
				owner:RemoveEffect("DarkVision")
			end
			
			owner:RemoveAmmo(1, ID_PRIMARYAMMO)  
			
		end
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

	WorldModel:SetSkin(4)
	WorldModel:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		local owner = self:GetOwner()

		if (IsValid(owner)) then
			local offsetVec = Vector(3, -1, 2)
			local offsetAng = Angle(-180, 0, 0)
			
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