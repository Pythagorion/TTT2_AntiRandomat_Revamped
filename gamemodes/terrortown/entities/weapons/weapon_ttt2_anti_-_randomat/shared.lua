if SERVER then
    AddCSLuaFile("shared.lua")
    resource.AddFile("materials/vgui/ttt/icon_ttt2_antirandomat.vmt")
    util.AddNetworkString("AntiRandomatRanWeps")
end

local easterEggSounds = {
    "zetros_ideas/ChrisBall.mp3",
    "zetros_ideas/HardiRage.mp3"
}

SWEP.Base = "weapon_tttbase"
SWEP.Spawnable = true
SWEP.AutoSpawnable = false
SWEP.AdminSpawnable = true

SWEP.HoldType = "slam"
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

if CLIENT then
    SWEP.Author = "aPythagorion"
    SWEP.Slot = 8

    SWEP.ViewModelFOV = 60
    SWEP.ViewModelFlip = false

    SWEP.Icon = "vgui/ttt/icon_ttt2_antirandomat"
    SWEP.EquipMenuData = {
        type = "weapon",
        name = "ttt2_weapon_antirandomat",
        desc = "ttt2_weapon_antirandomat_desc"
    }
end

-- damage values
SWEP.Primary.Delay = 10
SWEP.Primary.Recoil = 0
SWEP.Primary.Automatic = false
SWEP.Primary.NumShots = 1
SWEP.Primary.Damage = 0
SWEP.Primary.Cone = 0
SWEP.Primary.Ammo = nil
SWEP.Primary.ClipSize = -1
SWEP.Primary.ClipMax = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Sound = ""

-- others
SWEP.Kind = WEAPON_EQUIP2
SWEP.InLoadoutFor = nil
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = true
SWEP.UseHands = true
SWEP.HeadshotMultiplier = 0
SWEP.CanBuy = { ROLE_TRAITOR }
SWEP.LimitedStock = true
SWEP.AmmoEnt = nil

-- 3D model stuff
SWEP.ViewModel = "models/weapons/apythagorion/c_csgo_c4.mdl"
SWEP.WorldModel = "models/weapons/apythagorion/w_c4_planted.mdl"
SWEP.Weight = 2

-- prepare sound file
function SWEP:Initialize()
    util.PrecacheSound("weapons/init_c4_cs.wav")
end

function SWEP:OnRemove()
    if CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then
        RunConsoleCommand("lastinv")
    end
end

function SWEP:PrimaryAttack()
    if SERVER and IsFirstTimePredicted() then
        AntiRandomat:TriggerEvilEvent(self.Owner)
        DamageLog("ttt2_weapon_antirandomat_log" .. self.Owner:Nick() .. " (" .. self.Owner:GetRoleString() .. ").") 
        self:SetNextPrimaryFire(CurTime() + 10)
        self:Remove()  
    end
end

function SWEP:SecondaryAttack()
    if CLIENT then
        self:EmitSound(Sound(easterEggSounds[math.random(1, #easterEggSounds)], 1000))
    end
end
