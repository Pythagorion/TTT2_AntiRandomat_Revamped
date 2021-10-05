if SERVER then
    AddCSLuaFile("shared.lua")
    resource.AddFile("")
    util.AddNetworkString("AntiRandomatRanWeps")
end

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
