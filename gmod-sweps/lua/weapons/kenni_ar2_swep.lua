-- ============================================================
--  kenni_weapon_base — FULL WEAPON TEMPLATE
--  Copy this file, rename it to your weapon classname, and
--  place it in: lua/weapons/your_weapon_name.lua
--  Fill in the values you need. Remove systems you don't use.
-- ============================================================

AddCSLuaFile()

-- ─── Identity ────────────────────────────────────────────────────────────────

SWEP.Base           = "kenni_weapon_base"   -- REQUIRED: always this value
SWEP.PrintName      = "My Weapon"           -- display name in HUD and spawn menu
SWEP.Author         = "yourname"
SWEP.Category       = "My Weapons"          -- spawn menu folder
SWEP.Spawnable      = true                  -- visible to all players in spawn menu
SWEP.AdminSpawnable = true                  -- visible to admins in spawn menu

-- Hotbar slot: 0=melee  1=pistol  2=smg/rifle  3=shotgun  4=heavy  5=grenade
SWEP.Slot    = 2
SWEP.SlotPos = 0   -- position within the slot (lower = higher up)

-- ─── Model ───────────────────────────────────────────────────────────────────

-- HoldType controls the third-person player pose.
-- Options: pistol  smg  ar2  shotgun  rpg  grenade  melee  melee2  knife  passive  normal
SWEP.HoldType     = "ar2"
SWEP.UseHands     = true          -- use c_hands (player skin on viewmodel hands)
SWEP.ViewModelFOV = 60            -- viewmodel field of view
SWEP.ViewModel    = "models/weapons/c_yourweapon.mdl"
SWEP.WorldModel   = "models/weapons/w_yourweapon.mdl"

-- ─── Primary Fire ────────────────────────────────────────────────────────────

SWEP.Primary = {
    -- Ammo type string consumed per shot.
    -- Common values: "pistol"  "357"  "smg1"  "ar2"  "buckshot"  "RPG_Round"  "xbowbolt"
    Ammo        = "smg1",

    ClipSize    = 30,        -- magazine capacity
    DefaultClip = 30,        -- ammo in magazine when first picked up

    Automatic   = true,      -- true = hold to fire  /  false = click per shot
    FireMode    = "auto",    -- "auto"  "semi"  "burst"
    Delay       = 0.1,       -- seconds between shots (RPM formula: 60 / RPM)
    ADSDelay    = 0.12,      -- fire delay override while ADS (defaults to Delay if unset)

    Damage      = 15,        -- damage per bullet
    NumShots    = 1,         -- bullets per shot  (set 7+ for shotgun spread)
    Force       = 500,       -- physics force applied to hit objects
    Sound       = "Weapon_SMG1.Single",
    TracerName  = nil,       -- tracer effect name  (nil = default,  "" = none)
    ADSDamage   = nil,       -- damage override while ADS (nil = use Damage)

    -- ── Spread ───────────────────────────────────────────────────────────────
    -- Final spread = Spread * (stance multiplier)
    -- When ADS: final spread = Spread * (stance multiplier) * SpreadADS
    Spread       = 0.02,     -- base spread radius
    SpreadStand  = 1.0,      -- multiplier: standing still
    SpreadCrouch = 0.4,      -- multiplier: crouching
    SpreadWalk   = 2.5,      -- multiplier: walking
    SpreadSprint = 6.0,      -- multiplier: sprinting
    SpreadAir    = 10.0,     -- multiplier: airborne
    SpreadADS    = 0.25,     -- additional multiplier applied on top when ADS

    -- ── Recoil ───────────────────────────────────────────────────────────────
    -- ViewPunch = camera shake applied each shot (recovers automatically).
    -- EyeAngle  = camera physically rotates upward (permanent until player corrects).
    Recoil              = 1.5,   -- base ViewPunch magnitude
    RecoilKick          = 1.5,   -- how fast _CurrentRecoil builds per shot
    RecoilMax           = 4.0,   -- maximum accumulated recoil
    RecoilDecay         = 2.0,   -- recoil recovery per second (higher = snappier)
    RecoilResetThreshold = 10,   -- ViewPunchReset threshold passed each shot
    RecoilSide          = 0.5,   -- horizontal ViewPunch randomness multiplier
    RecoilRoll          = 0.0,   -- roll ViewPunch randomness multiplier
    EyeAngleRecoil      = 0.3,   -- degrees camera tilts upward per shot
    EyeAngleRecoilSide  = 0.5,   -- horizontal eye angle randomness multiplier
    ADSRecoilMult       = 0.6,   -- multiplier on all recoil values while ADS

    -- ── Burst fire (FireMode = "burst" only) ─────────────────────────────────
    BurstCount    = 3,       -- shots fired per trigger pull
    BurstDelay    = 0.08,    -- seconds between shots within a burst
    BurstCooldown = 0.4,     -- lockout time after burst completes
}

-- ─── Secondary Ammo Pool ─────────────────────────────────────────────────────
-- Used by the SecondaryAttack clip2 system.
-- Set ClipSize = -1 if your weapon has no secondary clip.

SWEP.Secondary = {
    ClipSize    = -1,
    DefaultClip = -1,
    Automatic   = false,
    Ammo        = "",
}

-- ─── Reload ──────────────────────────────────────────────────────────────────

SWEP.CanReload = true   -- false = reloading is completely disabled (e.g. melee, single-use)

-- ─── Fire Behaviour ──────────────────────────────────────────────────────────

-- Seconds after firing that IsFiring() returns true.
-- Blocks walk/sprint animations from interrupting the fire animation.
-- Set this to roughly match your fire animation length for semi-auto weapons.
SWEP.FireMoveDelay = 0.5

-- true  = exits ADS automatically when the trigger is pulled
-- false = stays in ADS after firing (default for most guns)
SWEP.ExitADSOnFire = false

-- ─── Bolt Action / Pump Action ───────────────────────────────────────────────
-- Plays a bolt/pump animation after each shot before the weapon is ready again.
-- Used for sniper rifles, shotguns, lever-actions, etc.

SWEP.IsBoltAction = false
SWEP.BoltTime     = 0.68     -- duration of the bolt animation in seconds
SWEP.BoltSound    = nil      -- sound played when bolt animation starts (nil = silent)
-- Required animation: bolt

-- ─── ADS (Aim Down Sights) ───────────────────────────────────────────────────

-- Viewmodel world-space offset applied when fully in ADS.
-- x = right/left   y = forward/back   z = up/down
-- Tune these in-game by pressing the ADS key and nudging until sights line up.
SWEP.ADSOffset = Vector(0, 0, 0)

-- Viewmodel offset at hip fire (not ADS).
SWEP.VMOffset = Vector(0, 0, 0)

-- How much the viewmodel dips vertically during the ADS transition (cosmetic).
-- 0 = no dip   negative = dips down   positive = rises up
SWEP.ADSMidDip = 0

-- Speed of the ADS lerp transition. Higher = snappier.
SWEP.ADSSpeed = 8

-- FOV multiplier while fully in ADS.
-- 1.0 = no zoom   0.85 = slight zoom   0.5 = 2x   0.25 = 4x
SWEP.ADSFOVMult = 1.0

-- true  = hold the ADS key to stay aimed in, release to exit
-- false = press to toggle ADS on/off
SWEP.ADSHoldToAim = true

-- ─── Scope Overlay ───────────────────────────────────────────────────────────
-- Draws a fullscreen material over the screen when ADS is active.
-- Good for sniper scopes. Remove block entirely if not needed.

-- SWEP.ScopeOverlay = {
--     Material = "path/to/your/scope_overlay",
-- }

-- ─── Sounds ──────────────────────────────────────────────────────────────────

SWEP.Sounds = {
    empty    = "Weapon_Pistol.Empty",   -- played when firing on an empty clip
    enterads = "",                       -- played when entering ADS  ("" = silent)
    exitads  = "",                       -- played when exiting ADS
}

-- ─── Muzzle Light ────────────────────────────────────────────────────────────
-- A dynamic point light spawned at the muzzle attachment on every shot.
-- Set MuzzleLightConfig = nil to disable entirely.

SWEP.MuzzleLightConfig = {
    r             = 255,     -- red
    g             = 200,     -- green
    b             = 80,      -- blue
    BrightnessMin = 5,
    BrightnessMax = 10,
    SizeMin       = 100,     -- minimum light radius
    SizeMax       = 150,     -- maximum light radius
    Decay         = 2500,    -- how fast the light fades
    DieTime       = 0.1,     -- seconds until the light dies
}

-- ─── Muzzle Flash Effect ─────────────────────────────────────────────────────
-- Controls what happens on muzzle animation events (AE_MUZZLEFLASH / event 21, 5001 etc.)
--
-- IMPORTANT: Do NOT use SWEP.MuzzleFlash — that name is reserved by GMod internally.
--            Always use SWEP.MuzzleFlash1.
--
-- nil    = default GMod muzzle flash (no override)
-- false  = suppress muzzle flash entirely
-- string = play a named util.Effect
-- table  = play a particle effect attached to the viewmodel muzzle

SWEP.MuzzleFlash1 = nil

-- Examples:
-- SWEP.MuzzleFlash1 = false
-- SWEP.MuzzleFlash1 = "CS_MuzzleFlash"
-- SWEP.MuzzleFlash1 = {
--     particle     = "muzzleflash_smg",
--     attachType   = PATTACH_POINT_FOLLOW,
--     attachmentID = 1,    -- attachment index on the viewmodel (check your .qc)
-- }
-- NOTE: For particles you must call game.AddParticles() and PrecacheParticleSystem()
--       yourself — the base does not do this for you.

-- ─── Impact Effect ───────────────────────────────────────────────────────────
-- Override the bullet impact effect and/or decal.
--
-- nil    = default GMod impact (no override)
-- false  = suppress impact entirely
-- string = play a named util.Effect (default bullet decal still shows)
-- table  = full control with optional particle, util.Effect, and decal suppression

SWEP.ImpactEffect = nil

-- Examples:
-- SWEP.ImpactEffect = false
-- SWEP.ImpactEffect = "AR2Impact"
-- SWEP.ImpactEffect = {
--     effect   = "AR2Impact",           -- util.Effect name (optional)
--     particle = "impact_concrete",     -- particle at hit point (optional)
--     scale    = 1.0,
--     flags    = 0,
--     override = false,   -- true = also suppress the default bullet hole decal
-- }
-- NOTE: The string form never suppresses the default decal.
--       Use table with override = true to suppress it.

-- ─── Keys ────────────────────────────────────────────────────────────────────
-- Maps action names to input keys.
-- primary and reload are REQUIRED.
--
-- Key types:
--   IN_*     engine input flags  (IN_ATTACK, IN_RELOAD, IN_ATTACK2, IN_SPEED …)
--   MOUSE_*  mouse buttons       (MOUSE_LEFT, MOUSE_RIGHT, MOUSE_MIDDLE …)
--   KEY_*    keyboard keys       (KEY_R, KEY_F, KEY_V, KEY_N …)
--
-- IMPORTANT: reload MUST be IN_RELOAD. Using KEY_R will silently break reloading.
-- IMPORTANT: inspect and reload may safely share the same key. The base auto-arbitrates:
--              full clip or no reserve ammo  → inspect wins
--              otherwise                     → reload wins

SWEP.Keys = {
    primary  = IN_ATTACK,    -- REQUIRED: primary fire
    reload   = IN_RELOAD,    -- REQUIRED: reload (must be IN_RELOAD)
    ads      = MOUSE_RIGHT,  -- aim down sights        (remove line if no ADS)
    inspect  = IN_RELOAD,    -- inspect animation      (may share with reload)
    lowered  = KEY_N,        -- lower/raise weapon     (remove line if not wanted)
    -- altfire = KEY_V,      -- AltFire system         (requires SWEP.AltFire table)
}

-- ─── PLFireMoveDelay ─────────────────────────────────────────────────────────
-- Seconds after a ProjectileLauncher shot that the weapon blocks walk/sprint anims.
-- Default 2.0. Increase for weapons with long PL recovery sequences.
SWEP.PLFireMoveDelay = 2.0

-- ─── Animations ──────────────────────────────────────────────────────────────
-- Map animation names to viewmodel sequences.
-- Find sequence names by decompiling your model with Crowbar and reading the .qc file.
-- Look for $sequence entries — the quoted name after $sequence is your seq value.
--
-- ── Entry format ─────────────────────────────────────────────────────────────
--
--   single animation:
--     fire = { seq = "shoot" }
--
--   with custom playback rate (omit if not needed — default is 1.0):
--     fire = { seq = "shoot", rate = 1.5 }
--
--   with explicit duration override in seconds (use when auto-detection fails):
--     fire = { seq = "shoot", dur = 0.4 }
--
--   random selection — picks one entry randomly each time the animation plays:
--     fire = {
--         { seq = "shoot1" },
--         { seq = "shoot2" },
--         { seq = "shoot3" },
--     }
--
-- ── Automatic variant fallback chain ─────────────────────────────────────────
-- The base automatically tries variant names in this order and plays the first one found.
-- You only need to define the variants your model actually has.
--
-- For FIRE specifically (the only animation with _iron ADS variants):
--   fire_iron_empty  →  fire_iron  →  fire_empty  →  fire
--
-- For ALL other animations the chain is simply:
--   <anim>_empty  →  <anim>
--
-- This means every supported animation key below can optionally have:
--   <key>_empty        played when clip is empty
--
-- And "fire" can additionally have:
--   fire_iron          played while ADS
--   fire_iron_empty    played while ADS with empty clip
--
-- ── Inspect rule ─────────────────────────────────────────────────────────────
-- If fire_empty is defined but inspect_empty is NOT defined,
-- the base will automatically block inspect when the clip is empty.
-- This prevents showing a bullet-visible inspect animation on an empty weapon.

SWEP.Animations = {

    -- ── Required ─────────────────────────────────────────────────────────────
    -- The weapon will not work correctly without at minimum these three.
    draw  = { seq = "draw"  },
    idle  = { seq = "idle"  },
    fire  = { seq = "shoot" },

    -- ── Recommended ──────────────────────────────────────────────────────────
    reload       = { seq = "reload"       },
    reload_empty = { seq = "reload_empty" },   -- played when reloading from a fully empty clip
    draw_empty   = { seq = "draw_empty"   },   -- played when deploying with empty clip
    idle_empty   = { seq = "idle_empty"   },   -- looping idle with empty clip

    -- ── Fire variants ────────────────────────────────────────────────────────
    fire_empty      = { seq = "fire_empty"      },   -- fire animation for the last shot
    fire_iron       = { seq = "iron_fire"       },   -- fire while ADS (fire ONLY)
    fire_iron_empty = { seq = "iron_fire_empty" },   -- fire while ADS on last shot (fire ONLY)

    -- ── ADS transitions (cosmetic, optional) ─────────────────────────────────
    ads     = { seq = "ads_in"  },   -- plays when entering ADS
    ads_out = { seq = "ads_out" },   -- plays when exiting ADS

    -- ── Bolt action (requires IsBoltAction = true) ────────────────────────────
    bolt = { seq = "bolt" },

    -- ── Inspect ──────────────────────────────────────────────────────────────
    -- Random selection example:
    inspect       = {
        { seq = "inspect1" },
        { seq = "inspect2" },
    },
    inspect_empty = { seq = "inspect_empty" },

    -- ── Movement ─────────────────────────────────────────────────────────────
    walk         = { seq = "Walk"         },
    walk_empty   = { seq = "Walk_empty"   },   -- optional empty variant
    sprint       = { seq = "Sprint"       },
    sprint_empty = { seq = "Sprint_empty" },   -- optional empty variant

    -- ── Lowered state ────────────────────────────────────────────────────────
    lowered     = { seq = "lowidle"   },   -- looping idle while weapon is lowered
    lowered_on  = { seq = "idletolow" },   -- transition: raised → lowered
    lowered_off = { seq = "lowtoidle" },   -- transition: lowered → raised

    -- ── Secondary fire ───────────────────────────────────────────────────────
    secondary_fire         = { seq = "secondary_fire"         },
    secondary_fire_empty   = { seq = "secondary_fire_empty"   },
    secondary_reload       = { seq = "secondary_reload"       },
    secondary_reload_empty = { seq = "secondary_reload_empty" },

    -- ── Charge weapon (requires SWEP.Charge table) ───────────────────────────
    charge_spinup = { seq = "charge_spinup" },
    charge_fire   = { seq = "charge_fire"   },

    -- ── Phased reload / shell-by-shell (requires SWEP.PhasedReload table) ────
    reload_start      = { seq = "reload_start"     },
    reload_insert     = { seq = "reload_insert"    },
    reload_end        = { seq = "reload_end"       },
    reload_end_nobolt = { seq = "reload_end_nobolt" },

    -- ── AR2Ball projectile launcher (requires ProjectileLauncher Type="AR2Ball") ──
    -- secondary_reload    used as the load/charge anim
    -- secondary_fire      used as the actual fire anim
    -- secondary_fire_prep used as the prep/shake anim before firing

    -- ── Throwing (requires SWEP.Throwing table) ───────────────────────────────
    throw_prep = { seq = "throw_prep" },   -- overhand throw windup
    throw_fire = { seq = "throw_fire" },   -- overhand throw release
    lob_prep   = { seq = "lob_prep"   },   -- lob windup   (falls back to throw_prep if absent)
    lob_fire   = { seq = "lob_fire"   },   -- lob release  (falls back to throw_fire if absent)
    roll_prep  = { seq = "roll_prep"  },   -- roll windup  (falls back to throw_prep if absent)
    roll_fire  = { seq = "roll_fire"  },   -- roll release (falls back to throw_fire if absent)
}

-- ─── Phased Reload ───────────────────────────────────────────────────────────
-- Shell-by-shell reloading. Used for tube-fed shotguns, lever-actions, etc.
-- The player can interrupt a phased reload at any time by firing.
-- Set PhasedReload = nil to disable.
--
-- Requires in SWEP.Animations:
--   reload_start, reload_insert, reload_end
-- Optional:
--   reload_end_nobolt  (used when TrackNoBolt = true and clip was not empty)

SWEP.PhasedReload = nil
--[[
SWEP.PhasedReload = {
    StartTime        = 0.8,                      -- reload_start anim duration (seconds)
    InsertTime       = 0.6,                      -- reload_insert anim duration per shell
    FinishTime       = 0.5,                      -- reload_end anim duration
    NoBoltTime       = 0.4,                      -- reload_end_nobolt anim duration
    TrackNoBolt      = true,                     -- play NoBolt anim if clip wasn't empty
    InsertSound      = "Weapon_Shotgun.Reload",  -- sound played per shell insert
    InsertSoundDelay = 0.15,                     -- delay before insert sound plays
    FinishSound      = "",                       -- sound played when reload finishes
}
]]

-- ─── Charge ──────────────────────────────────────────────────────────────────
-- Wind-up mechanic before firing. Good for miniguns, railguns, charged shots.
-- Set Charge = nil to disable.
--
-- Requires in SWEP.Animations: charge_spinup, charge_fire
-- Optional: set SWEP.Sounds.charge to a looping sound path for the spin-up loop.
--
-- Modes:
--   "auto"   = fires automatically once spinup completes
--   "hold"   = hold to spin up, release key to fire
--   "stream" = hold to fire continuously, release to cancel

SWEP.Charge = nil
--[[
SWEP.Charge = {
    Key  = IN_ATTACK,
    Mode = "auto",
}
SWEP.Sounds.charge = "weapons/gauss/spin.wav"   -- looping charge sound (optional)
]]

-- ─── Alt Fire ────────────────────────────────────────────────────────────────
-- A second fire mode on a separate key that consumes primary ammo.
-- Useful for underbarrel modes, charged shots, wide-spread blasts, etc.
-- Add "altfire" to SWEP.Keys. Uses the secondary_fire animation.
-- Set AltFire = nil to disable.

SWEP.AltFire = nil
--[[
SWEP.AltFire = {
    AmmoCost           = 1,     -- primary ammo consumed per shot
    NumShots           = 1,     -- bullets fired (defaults to Primary.NumShots)
    SpreadMult         = 1.0,   -- spread multiplier on top of current spread
    RecoilMult         = 1.5,   -- ViewPunch multiplier
    EyeAngleRecoilMult = 1.5,   -- eye angle recoil multiplier
    Sound              = nil,   -- fire sound override (nil = use Primary.Sound)
    Cooldown           = 0.5,   -- weapon lock duration after firing
}
]]

-- ─── Projectile Launcher ─────────────────────────────────────────────────────
-- Fires a scripted entity rather than hitscan bullets.
-- Used for grenade launchers, RPGs, energy balls, etc.
-- Set ProjectileLauncher = nil to disable.
--
-- Type = "standard"  fires an entity with velocity
-- Type = "AR2Ball"   uses point_combine_ball_launcher (HL2 energy ball)
--
-- Non-IN keys (MOUSE_*, KEY_*) are automatically registered through the key system
-- — you do NOT need to add them to SWEP.Keys manually.

SWEP.ProjectileLauncher = nil
--[[
-- Standard launcher example:
SWEP.ProjectileLauncher = {
    Enabled    = true,
    Type       = "standard",
    Key        = IN_ATTACK2,
    AmmoType   = "smg1_grenade",
    Entity     = "grenade_ar2",
    Velocity   = 800,
    Recoil     = 8,
    FireTime   = 0.7,        -- fire anim lock duration (seconds)
    ReloadTime = 2.0,        -- auto-reload delay after firing (nil = no reload)
    Sound      = "Weapon_SMG1.Alt",
    Pos = function(wep)
        return wep.Owner:GetShootPos() + wep.Owner:GetAimVector() * 48
    end,
    Ang = function(wep)
        return wep.Owner:EyeAngles()
    end,
}

-- AR2Ball launcher example:
SWEP.ProjectileLauncher = {
    Enabled     = true,
    Type        = "AR2Ball",
    Key         = MOUSE_MIDDLE,
    AmmoType    = "AR2AltFire",
    Recoil      = 20,
    ChargeSound = "weapons/cguard/charging.wav",
    FireSound   = "weapons/irifle/irifle_fire2.wav",
    BallConfig  = {
        RespawnTime = -1,
        MaxBounces  = 5,
        MaxSpeed    = 1000,
        MinSpeed    = 1000,
    },
}
-- AR2Ball requires in SWEP.Animations:
--   secondary_reload    (load/charge anim)
--   secondary_fire      (fire anim)
--   secondary_fire_prep (prep/shake anim)
]]

-- ─── Melee Attacks ───────────────────────────────────────────────────────────
-- Define one or more melee attacks. Multiple entries on the SAME Key form a
-- combo chain — each press of that key cycles to the next attack in order.
--
-- For PURE MELEE weapons: set Primary.ClipSize = -1, Primary.Ammo = "",
-- CanReload = false, and bind Key = IN_ATTACK.
--
-- For GUNS WITH A MELEE BASH: bind Key to MOUSE_MIDDLE or any KEY_* value.
-- Binding to IN_ATTACK or IN_ATTACK2 will replace the fire/secondary on that button.
--
-- Non-IN keys are automatically registered — no need to add them to SWEP.Keys.
-- Set MeleeAttacks = nil to disable.

SWEP.MeleeAttacks = nil
--[[
SWEP.MeleeAttacks = {
    {
        Key      = IN_ATTACK2,           -- key for this attack
        Seq      = "melee",              -- viewmodel sequence name from .qc
        Act      = ACT_VM_SECONDARYATTACK, -- fallback ACT_ if seq not found on model
        Damage   = 50,
        DmgType  = DMG_CLUB,             -- DMG_SLASH  DMG_CLUB  DMG_CRUSH  DMG_GENERIC
        Force    = 8,                    -- physics force multiplier
        Length   = 55,                   -- trace length in units
        Hull     = 10,                   -- sweep hull size (larger = wider swing)
        Delay    = 0.2,                  -- seconds after swing start before hit fires
        End      = 0.5,                  -- total lock duration of the attack
        Sound    = "",                   -- swing sound
        HitFlesh = "",                   -- sound on flesh / NPC / player hit
        HitWorld = "",                   -- sound on world / prop hit
        HitDecal = "ManhackCut",         -- decal placed on surfaces
        ViewPunch  = Angle(-5, 4, 0),    -- camera punch on swing
        DamageDir  = Angle(0, 45, 0),    -- optional: direction force is applied (relative to eye)
    },
    -- Add more entries with the same Key to create a combo chain:
    -- { Key = IN_ATTACK2, Seq = "melee2", ... },
}
]]

-- ─── Throwing ────────────────────────────────────────────────────────────────
-- Three-phase thrown weapon system: prep → cook → release.
-- Spawns a physics entity and launches it. Consumes Primary.Ammo.
-- After throwing, the draw animation replays if ammo remains.
-- Set Throwing = nil to disable.
--
-- Three throw modes:
--   Throw key (standing)   → mode 1: overhand throw
--   Lob key   (standing)   → mode 2: lob (high arc)
--   Lob key   (crouching)  → mode 3: roll (ground-hugging)
--
-- Requires Primary.ClipSize = -1, Primary.Ammo = your grenade ammo type,
-- CanReload = false.
--
-- Requires in SWEP.Animations: throw_prep, throw_fire
-- Optional: lob_prep, lob_fire, roll_prep, roll_fire
--           (fall back to throw_prep / throw_fire if absent)

SWEP.Throwing = nil
--[[
SWEP.Throwing = {
    Entity   = "npc_grenade_frag",   -- classname of the entity to spawn
    Timer    = 3.5,                  -- fuse time in seconds  (nil = no timer input)
                                     -- passed via ent:Input("settimer", ..., Timer)
    HoldTime = 3.5,                  -- maximum cook duration before auto-release
                                     -- set to 0 for no cook limit
    Sound    = "Grenade.Blip",       -- sound played when throw prep starts

    Throw = {
        Key     = IN_ATTACK,         -- key for overhand throw
        Force   = 1200,              -- forward velocity
        ArcBias = 0.1,               -- slight upward vector bias (cosmetic arc)
        Spin    = Vector(600, 200, 0), -- angular velocity on spawned entity
    },

    Lob = {
        Key     = IN_ATTACK2,        -- key for lob / roll
        Force   = 800,
        ArcBias = 50,                -- flat Z additive (higher = more loft)
        Spin    = Vector(300, 200, 0),
    },

    Roll = {
        -- uses the same key as Lob but activates when the player is crouching
        Force = 600,
        Spin  = Vector(0, 0, 900),   -- spin around Z for a rolling grenade
    },
}
]]
