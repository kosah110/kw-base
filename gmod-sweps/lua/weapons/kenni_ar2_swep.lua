--[[AddCSLuaFile()

SWEP.Base           = "kenni_weapon_base"
SWEP.PrintName      = "AR2 Pulse Rifle"
SWEP.Author         = "kenni"
SWEP.Category       = "Eaasy Weapons"
SWEP.Spawnable      = true
SWEP.AdminSpawnable = true

SWEP.Slot    = 3
SWEP.SlotPos = 0

SWEP.HoldType     = "ar2"
SWEP.UseHands     = true
SWEP.ViewModelFOV = 54
SWEP.ViewModel    = "models/mmod/weapons/irifle/c_irifle.mdl"
SWEP.WorldModel   = "models/weapons/w_irifle.mdl"

SWEP.Primary = {
    ClipSize    = 30,
    DefaultClip = 60,
    Ammo        = "AR2",
    Automatic   = true,
    Delay       = 0.12,
    ADSDelay    = 0.14,

    Damage      = 25,
    NumShots    = 1,
    Force       = 600,
    TracerName  = "AR2Tracer",

    Spread       = 0.01,
    SpreadStand  = 1.0,
    SpreadCrouch = 0.3,
    SpreadWalk   = 2.0,
    SpreadSprint = 5.0,
    SpreadAir    = 8.0,
    SpreadADS    = 0.2,

    Recoil              = 1.2,
    RecoilKick          = 1.2,
    RecoilMax           = 3.5,
    RecoilDecay         = 2.5,
    RecoilResetThreshold = 10,
    RecoilSide          = 0.4,
    RecoilRoll          = 0.0,
    EyeAngleRecoil      = 0.2,
    EyeAngleRecoilSide  = 0.3,
    ADSRecoilMult       = 0.5,

    FireMode = "auto",

    Sound = "Weapon_AR2.Single",
}

SWEP.Secondary = {
    ClipSize    = -1,
    DefaultClip = -1,
    Automatic   = false,
    Ammo        = "AR2AltFire",
}

SWEP.CanReload     = true
SWEP.FireMoveDelay = 1
SWEP.PLFireMoveDelay = 1

SWEP.ExitADSOnFire = false

SWEP.VMOffset     = Vector(0, 0, 0)
SWEP.ADSOffset    = Vector(-2, -2, 2)
SWEP.ADSMidDip    = 0.015
SWEP.ADSSpeed     = 7
SWEP.ADSFOVMult   = 0.88
SWEP.ADSHoldToAim = false

SWEP.Sounds = {
    empty    = "Weapon_AR2.Empty",
    enterads = "",
    exitads  = "",
}

SWEP.MuzzleLightConfig = {
    r             = 180,
    g             = 220,
    b             = 255,   
    BrightnessMin = 4,
    BrightnessMax = 8,
    SizeMin       = 80,
    SizeMax       = 130,
    Decay         = 3000,
    DieTime       = 0.08,
}

SWEP.Keys = {
    primary = IN_ATTACK,
    reload  = IN_RELOAD,
    inspect = IN_RELOAD,   
    ads     = MOUSE_MIDDLE,
    lowered = KEY_N,
}

SWEP.ProjectileLauncher = {
    Enabled  = true,
    Type     = "AR2Ball",

    Key      = IN_ATTACK2,   
    AmmoType = "AR2AltFire",

    ChargeSound = "weapons/cguard/charging.wav",
    FireSound   = "weapons/irifle/irifle_fire2.wav",
    Recoil      = 6.0,

    BallConfig = {
        RespawnTime = -1,    
        MaxBounces  = 5,
        MaxSpeed    = 1000,
        MinSpeed    = 1000,
    },
}

SWEP.Animations = {

    -- Draw
    draw          = { seq = "draw"          },
    draw_empty    = { seq = "draw_empty"    },

    -- Idle
    idle          = { seq = "idle"          },
    idle_empty    = { seq = "idle_empty"    },
    idle_iron     = { seq = "idle_ironsight" },
    idle_iron_empty = { seq = "idle_empty_ironsight" },

    -- Fire (random variants)
    fire = {seq = "fire1" },
    fire_iron = {seq = "fire1_is"},
    fire_empty      = { seq = "fire_last"            },
    fire_iron_empty = { seq = "fire_last_ironsight"  },

    -- Reload
    reload       = { seq = "reload"      },
    reload_empty = { seq = "reloadempty" },

    -- Inspect (random variants)
    inspect = {
        { seq = "fidget"  },
        { seq = "fidget2" },
    },
    inspect_empty = {
        { seq = "fidget_empty"  },
        { seq = "fidget2_empty" },
    },

    -- Walk / Sprint
    walk         = { seq = "Walk"         },
    walk_empty   = { seq = "Walk_empty"   },
    sprint       = { seq = "Sprint"       },
    sprint_empty = { seq = "Sprint_empty" },

    ads_out = {seq="idle"},
    ads_out_empty = {seq="idle_empty"},

    -- Lowered
    lowered     = { seq = "lowidle"   },
    lowered_on  = { seq = "idletolow" },
    lowered_off = { seq = "lowtoidle" },

    -- AR2Ball launcher
    secondary_fire_prep       = { seq = "shake"          },
    secondary_fire_prep_empty = { seq = "shake_empty"    },
    secondary_fire            = { seq = "fire_alt"       },
    secondary_fire_empty      = { seq = "fire_alt_empty" },

    holster       = { seq = "holster"       },
    holster_empty = { seq = "holster_empty" },
}

SWEP.ImpactEffect = "AR2Impact"--]]
