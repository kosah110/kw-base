-- ============================================================
--  kenni_weapon_base — FULL WEAPON TEMPLATE  (v2)
--  Copy this file, rename it to your weapon classname, and
--  place it in: lua/weapons/your_weapon_name.lua
--
--  MUST READ!!!!!
--  HOW TO USE THIS BASE PROPERLY:
--  ─────────────────────────────────────────────────────────
--  This base is DETERMINISTIC. It prioritizes exact, predictable
--  behavior over convenience.
--
--  1. Tools required:
--     - Crowbar (for decompiling models)
--     - Text editor (Notepad++, VSCode, etc.)
--
--  2. You MUST decompile your model.
--     This is REQUIRED if you want:
--       - correct animation sequences
--       - attachment points (for muzzle, laser, etc.)
--
--     Decompile the model and inspect the .qc file.
--
--  3. This base uses SEQUENCES, NOT ACT.
--
--     SWEP.Animations works ONLY with sequence names from the model.
--     (Example: "draw", "idle", "shoot", etc.)
--
--     DO NOT rely on ACT enums like ACT_VM_PRIMARYATTACK.
--
--  4. Why NOT ACT?
--
--     ACT (activity system) is NOT consistent across Source games
--     and is NOT deterministic.
--
--     Problems with ACT:
--
--     - Cross-game inconsistency:
--       Different Source branches (HL2, CSS, DoD:S, etc.)
--       use different ACT mappings.
--
--     - One-to-many mapping:
--       A single ACT can map to MULTIPLE sequences.
--       The engine may choose a sequence automatically.
--
--       This means:
--         - you do NOT have full control over which animation plays
--         - results may vary depending on model or compile settings
--
--     - Model-dependent behavior:
--       ACT relies on how the model was compiled ($sequence activity).
--       Poorly compiled models may have missing or incorrect ACT bindings.
--
--     Result:
--       ACT-based systems are:
--         - non-deterministic
--         - inconsistent
--         - harder to debug
--
--  5. Why SEQUENCES?
--
--     Sequences are defined directly in the model (.qc $sequence)
--     and map ONE-TO-ONE to animations.
--
--     This guarantees:
--       - exact animation playback (no randomness or engine selection)
--       - full developer control
--       - consistent results across all environments
--
--     Unlike ACT:
--       - no automatic mapping
--       - no ambiguity
--       - no hidden engine behavior
--
--     Tradeoff:
--       - You MUST manually specify sequence names
--       - You MUST ensure they exist in the model
--
--  6. Animation requirement
--
--     Your model MUST contain the required sequences used in SWEP.Animations.
--
--     If a sequence does not exist:
--       - the animation will fail
--       - fallback may occur (if defined)
--       - or nothing will play
--
--     Always check sequence names in the decompiled .qc file.
--
--  7. This base does NOT auto-adapt to models.
--
--     Unlike ACT-based systems:
--       - there is NO automatic mapping
--       - there is NO fallback to generic animations
--
--     You are responsible for:
--       - correct sequence naming
--       - correct animation setup
--
--     In return, you get:
--       - full control
--       - zero ambiguity
--       - consistent behavior across all weapons
--
--
--  DEVELOPER TIPS:
--  ─────────────────────────────────────────────────────────
--  1. Call self.BaseClass.FunctionName(self) unless you intentionally 
--     want to replace the entire behavior. Skipping it may break internal 
--     pipelines (timers, recoil, animations, etc.).
--
--  2. When adding custom Think handlers, register them in
--     Initialize() BEFORE calling self.BaseClass.Initialize(self).
--     There are THREE think buckets:
--
--       server  = runs on SERVER only
--       client  = runs on CLIENT only  
--       shared  = runs on both (use IsFirstTimePredicted() for
--                 visuals: sound, anim, FireBullets, ViewPunch)
--
--     Rule of thumb:
--       server  → state mutation (ammo, timers, NetworkVars)
--       shared  → anything with sound/anim/FireBullets/ViewPunch
--       client  → pure visual, no state
--
--  3. NetworkVar rule: if a plain Lua field is read in a shared
--     or client context, it MUST be a NetworkVar. Plain fields
--     set on server are invisible to client.
--
--  4. Always test in MULTIPLAYER. Singleplayer is permissive.
--     Bugs hide there but explode in MP.
--
--  5. This base handles most standard SWEP behavior (pistol, rifle, SMG, shotgun, sniper etc.) 
--     including firing, recoil, ADS, animations, and movement states.
--     However, these systems rely on correct setup (animations, keys, and configuration).
--     If your weapon requires behavior beyond what the base supports, implement 
--     custom logic in the SWEP instead while preserving the base pipeline.
--
--  EXAMPLE: Adding a custom Think handler
--
--  function SWEP:Initialize()
--      table.insert(self._ThinkHandlers.server, "MyServerThink")
--      table.insert(self._ThinkHandlers.shared, "MySharedThink")
--      table.insert(self._ThinkHandlers.client, "MyClientThink")
--      self.BaseClass.Initialize(self)  -- ALWAYS call this last
--  end
--
--  function SWEP:MyServerThink()
--      -- pure state: set NetworkVars, timers, ammo
--  end
--
--  function SWEP:MySharedThink()
--      if not IsFirstTimePredicted() then return end
--      -- sound, anim, FireBullets, ViewPunch go here
--  end
--
--  function SWEP:MyClientThink()
--      -- client-only visuals: beams, overlays, particles
--  end
--
--  EXAMPLE: Overriding PrimaryAttack safely
--
--  function SWEP:PrimaryAttack()
--      if self:Clip1() <= 0 then
--          self:PlayEmpty()
--          return
--      end
--      self.BaseClass.PrimaryAttack(self)
--      -- your extra logic here (e.g. net message for beam effect)
--  end
--
--  EXAMPLE: Overriding CreateBullets for bullet callbacks
--  (e.g. beam weapons that need the exact hit position)
--
--  function SWEP:CreateBullets()
--      self.Owner:FireBullets({
--          Num      = 1,
--          Src      = self.Owner:GetShootPos(),
--          Dir      = self.Owner:GetAimVector(),
--          Spread   = Vector(self:GetCurrentSpread(), self:GetCurrentSpread(), 0),
--          Tracer   = 0,
--          Force    = self.Primary.Force or 500,
--          Damage   = self.Primary.Damage or 10,
--          AmmoType = self.Primary.Ammo,
--          Callback = function(attacker, tr, dmginfo)
--              if SERVER then
--                  net.Start("my_beam")
--                      net.WriteVector(tr.HitPos)
--                  net.Broadcast()
--              end
--          end,
--      })
--  end
--  NOTE: PrimaryBullets() calls CreateBullets() + PlayPrimarySound()
--        + Recoil() + SetLastFireTime(). Only override CreateBullets()
--        if you need the bullet callback. Override PrimaryBullets() if
--        you need to change the full fire pipeline.
-- ============================================================

AddCSLuaFile()

-- ─── Identity ────────────────────────────────────────────────────────────────

SWEP.Base           = "kenni_weapon_base"   -- REQUIRED: always this value
SWEP.PrintName      = "My Weapon"           -- display name in HUD and spawn menu
SWEP.Author         = "yourname"
SWEP.Category       = "My Weapons"          -- spawn menu folder
SWEP.Spawnable      = true
SWEP.AdminSpawnable = true

-- Hotbar slot: 0=melee  1=pistol  2=smg/rifle  3=shotgun  4=heavy  5=grenade
SWEP.Slot    = 2
SWEP.SlotPos = 0

-- ─── Model ───────────────────────────────────────────────────────────────────

-- HoldType controls the third-person player pose.
-- Options: pistol  smg  ar2  shotgun  rpg  grenade  melee  melee2  knife  passive  normal
SWEP.HoldType     = "ar2"
SWEP.UseHands     = true
SWEP.ViewModelFOV = 60
SWEP.ViewModel    = "models/weapons/c_yourweapon.mdl"
SWEP.WorldModel   = "models/weapons/w_yourweapon.mdl"

-- ─── Primary Fire ────────────────────────────────────────────────────────────

SWEP.Primary = {
    -- Ammo type string consumed per shot.
    -- Common values: "pistol"  "357"  "smg1"  "ar2"  "buckshot"  "RPG_Round"  "xbowbolt"
    Ammo        = "smg1",

    ClipSize    = 30,
    DefaultClip = 30,

    Automatic   = true,      -- true = hold to fire  /  false = click per shot
    FireMode    = "burst",   -- specify burst if you're going for burst
                             -- "burst" requires BurstCount/BurstDelay/BurstCooldown
                             -- FireMode is NetworkVar'd — switches via HandleFireModeSwitch
    Delay       = 0.1,       -- seconds between shots  (RPM formula: 60 / RPM)
    ADSDelay    = nil,       -- fire delay override while ADS (nil = use Delay)

    Damage      = 15,
    NumShots    = 1,         -- bullets per shot  (set 7+ for shotgun pellets)
    Force       = 500,
    Sound       = "Weapon_SMG1.Single",
    TracerName  = nil,       -- nil = default tracer  /  "" = no tracer
    ADSDamage   = nil,       -- damage override while ADS (nil = use Damage)

    -- ── Projectile Settings ──────────────────────────────────────────────────
    -- If BulletType is set, the SWEP spawns an entity instead of hitscan bullets.
    -- Use this instead if the main attack of your SWEP shoots out projectiles. See SWEP.ProjectileLauncher
    -- for secondary version.
    BulletType          = "rpg_missile", -- Entity classname (e.g., "prop_physics", "grenade_ar2")
    BulletVelocity      = 3000,          -- Initial speed of the projectile
    BulletPhysicsForce  = 500,           -- Continuous force (constant thrust like a rocket)
    BulletSpawnOffset   = Vector(0, 0, 0), -- Additional offset from the Viewmodel position
    
    -- Note: If BulletType is nil, the weapon defaults back to Hitscan.

    -- ── Spread ───────────────────────────────────────────────────────────────
    -- Final spread = Spread * (stance multiplier)
    -- ADS applies SpreadADS on top: Spread * stance * SpreadADS
    Spread       = 0.02,
    SpreadStand  = 1.0,
    SpreadCrouch = 0.4,
    SpreadWalk   = 2.5,
    SpreadSprint = 6.0,
    SpreadAir    = 10.0,
    SpreadADS    = 0.25,

    -- ── Recoil ───────────────────────────────────────────────────────────────
    -- ViewPunch  = screen shake that auto-recovers.
    -- EyeAngle   = camera physically rotates up (player must correct manually).
    -- _CurrentRecoil accumulates per shot up to RecoilMax, decays over time.
    Recoil               = 1.5,   -- base ViewPunch magnitude
    RecoilKick           = 1.5,   -- how much _CurrentRecoil builds per shot
    RecoilMax            = 4.0,   -- maximum accumulated recoil
    RecoilDecay          = 2.0,   -- recoil recovery per second (higher = snappier)
    RecoilResetThreshold = 10,    -- ViewPunchReset threshold passed each shot
    RecoilSide           = 0.5,   -- horizontal ViewPunch randomness multiplier
    RecoilRoll           = 0.0,   -- roll ViewPunch randomness multiplier
    EyeAngleRecoil       = 0.3,   -- degrees camera tilts upward per shot
    EyeAngleRecoilSide   = 0.5,   -- horizontal eye angle randomness multiplier
    ADSRecoilMult        = 0.6,   -- all recoil multiplied by this while ADS

    -- ── Burst fire ───────────────────────────────────────────────────────────
    -- Only active when FireMode = "burst".
    -- FireMode is toggled via HandleFireModeSwitch (Keys.firemode).
    -- BurstActive/BurstShotsLeft/BurstNextShot are NetworkVar'd automatically.
    BurstCount    = 3,       -- shots per trigger pull
    BurstDelay    = 0.08,    -- seconds between shots within burst
    BurstCooldown = 0.4,     -- lock time after burst finishes

    -- ── Fire mode switch ─────────────────────────────────────────────────────
    -- Plays firemode_switch anim and emits this sound when mode toggles.
    -- Requires Keys.firemode to be set.
    FireModeSound = "",      -- e.g. "Weapon_SMG1.Burst"

    -- ── Ammo refill (passive, no reload) ─────────────────────────────────────
    -- If set, the weapon auto-refills its clip over time.
    -- Good for energy weapons with regenerating ammo.
    -- RefillNum   = 1,      -- ammo added per tick
    -- RefillDelay = 1.0,    -- seconds between refill ticks
}

-- ─── Secondary Ammo Pool ─────────────────────────────────────────────────────
-- Used by the built-in SecondaryAttack clip2 system.
-- Set ClipSize = -1 if your weapon has no secondary ammo.

SWEP.Secondary = {
    ClipSize    = -1,
    DefaultClip = -1,
    Automatic   = false,
    Ammo        = "",
}

-- ─── Reload ──────────────────────────────────────────────────────────────────

SWEP.CanReload = true   -- false = disable all reloading (e.g. pure melee, single-use)

-- ─── Fire Behaviour ──────────────────────────────────────────────────────────

-- Seconds after firing that IsFiring() returns true.
-- Blocks walk/sprint animations from playing mid-fire.
-- Match this to your fire animation duration for semi-auto weapons.
SWEP.FireMoveDelay = 0.5

-- true  = exits ADS when primary fire is triggered
-- false = stays ADS after firing
SWEP.ExitADSOnFire = false

-- ─── Bolt / Pump Action ──────────────────────────────────────────────────────
-- Plays a bolt/pump animation after each shot before next shot is allowed.
-- Used for sniper rifles, pump shotguns, lever-actions.

SWEP.IsBoltAction = false
SWEP.BoltTime     = 0.68     -- bolt anim duration in seconds
SWEP.BoltSound    = nil      -- sound when bolt starts (nil = silent)
-- Required animation: bolt

-- ─── ADS (Aim Down Sights) ───────────────────────────────────────────────────

-- Viewmodel offset when fully in ADS. Tune in-game until iron sights align.
-- x = right/left   y = forward/back   z = up/down
SWEP.ADSOffset = Vector(0, 0, 0)

-- Viewmodel offset at hip (no ADS).
SWEP.VMOffset = Vector(0, 0, 0)

-- How much the viewmodel dips vertically during ADS transition.
-- 0 = no dip   negative = dips down   positive = rises
SWEP.ADSMidDip = 0

-- Speed of the ADS lerp. Higher = snappier.
SWEP.ADSSpeed = 8

-- FOV multiplier while fully ADS.
-- 1.0 = no zoom   0.85 = slight zoom   0.5 = 2x   0.25 = 4x
SWEP.ADSFOVMult = 1.0

-- true  = hold key to stay aimed in, release to exit
-- false = press to toggle
SWEP.ADSHoldToAim = true

-- ADS is automatically blocked during:
--   reload, phased reload, PL reload, attachment flip, draw animation
-- No manual guard needed in your code.

-- ─── Scope Overlay ───────────────────────────────────────────────────────────
-- Draws a fullscreen material when ADS is active.
-- Remove block entirely if not needed.
-- Useful for simple sweps like sniper or crossbow

-- SWEP.ScopeOverlay = {
--     Material = "path/to/scope_overlay",
-- }

-- ─── Sounds ──────────────────────────────────────────────────────────────────

SWEP.Sounds = {
    empty    = "Weapon_Pistol.Empty",   -- fired on empty clip
    enterads = "",                       -- entering ADS ("" = silent)
    exitads  = "",                       -- exiting ADS
    -- charge = "path/to/loop.wav"      -- looping sound during charge spinup
                                        -- (used by SWEP.Charge system only)
}

-- ─── Muzzle Light ────────────────────────────────────────────────────────────
-- Dynamic point light spawned at the muzzle attachment on each shot.
-- Set MuzzleLightConfig = nil to disable.

SWEP.MuzzleLightConfig = {
    r             = 255,
    g             = 200,
    b             = 80,
    BrightnessMin = 5,
    BrightnessMax = 10,
    SizeMin       = 100,
    SizeMax       = 150,
    Decay         = 2500,
    DieTime       = 0.1,
}

-- ─── Muzzle Flash Effect ─────────────────────────────────────────────────────
-- Controls what happens on muzzle animation events (AE_MUZZLEFLASH / event 21, 5001+).
--
-- IMPORTANT: Do NOT use SWEP.MuzzleFlash — reserved by GMod internally.
--            Always use SWEP.MuzzleFlash1.
--
-- nil    = default GMod muzzle flash
-- false  = suppress muzzle flash entirely
-- string = play a named util.Effect
-- table  = particle attached to viewmodel

SWEP.MuzzleFlash1 = nil
-- Examples:
-- SWEP.MuzzleFlash1 = false
-- SWEP.MuzzleFlash1 = "CS_MuzzleFlash"
-- SWEP.MuzzleFlash1 = {
--     particle     = "muzzleflash_smg",
--     attachType   = PATTACH_POINT_FOLLOW,
--     attachmentID = 1,    -- attachment index on viewmodel (from .qc $attachment)
-- }
-- NOTE: You must call game.AddParticles() and PrecacheParticleSystem() yourself.

-- ─── Impact Effect ───────────────────────────────────────────────────────────
-- nil    = default GMod impact
-- false  = suppress entirely
-- string = play a named util.Effect (default decal still shows)
-- table  = full control

SWEP.ImpactEffect = nil
-- Examples:
-- SWEP.ImpactEffect = false
-- SWEP.ImpactEffect = "AR2Impact"
-- SWEP.ImpactEffect = {
--     effect   = "AR2Impact",
--     particle = "impact_concrete",
--     scale    = 1.0,
--     flags    = 0,
--     override = false,   -- true = also suppress default bullet hole decal
-- }

-- ─── Keys ────────────────────────────────────────────────────────────────────
-- Maps weapon actions to input keys.
-- primary and reload are REQUIRED.
--
-- This base supports THREE input types:
--
--   IN_*     → engine action binds (recommended)
--   MOUSE_*  → raw mouse buttons
--   KEY_*    → raw keyboard keys
--
-- ── IN_* (engine actions) ────────────────────────────────────────────────────
-- IN_* enums represent ACTIONS, not physical keys.
-- These are bound in the user's GMod settings.
--
-- Example:
--   IN_ATTACK may be bound to LMB, keyboard, or any key.
--   Your code does NOT care — it always works.
--
-- This makes IN_*:
--   - rebind-safe
--   - user-configurable
--   - consistent across setups
--
-- ── MOUSE_* and KEY_* (raw input) ────────────────────────────────────────────
-- These refer to the actual physical inputs directly.
--
-- Example:
--   MOUSE_RIGHT = right click (always)
--   KEY_F       = F key (always)
--
-- These:
--   - ignore user keybinds
--   - are fixed inputs
--   - should be used for secondary features (altfire, inspect, etc.)
--
-- ── IMPORTANT RULES ──────────────────────────────────────────────────────────
--
-- 1. Keys MUST be unique.
--    Each action must have its own input to avoid conflicts.
--
--    EXCEPTION:
--      inspect and reload MAY share the same key.
--      The base automatically resolves this:
--
--        full clip or no reserve ammo  → inspect
--        otherwise                     → reload
--
-- 2. reload MUST be IN_RELOAD.
--    Using KEY_R will silently break reload logic.
--
-- 3. Avoid overlapping core actions:
--
--    - altfire must NOT use IN_ATTACK2 if melee uses IN_ATTACK2
--      (melee takes priority in SecondaryAttack)
--
--    - firemode must NOT share any key with primary (IN_ATTACK)
--      (runs every Think tick and will conflict)
--
--     This system allows mixing:
--       - rebindable inputs (IN_*)
--       - fixed inputs (KEY_*, MOUSE_*)
--
--     Giving you:
--       - flexibility for advanced features
--       - consistency for core gameplay

SWEP.Keys = {
    primary    = IN_ATTACK,    -- REQUIRED
    reload     = IN_RELOAD,    -- REQUIRED (must be IN_RELOAD)
    ads        = MOUSE_RIGHT,  -- aim down sights        (remove if no ADS)
    inspect    = IN_RELOAD,    -- inspect anim           (may share with reload)
    lowered    = KEY_N,        -- lower/raise weapon     (remove if not wanted)
    -- altfire  = IN_ATTACK2,  -- AltFire system         (requires SWEP.AltFire table)
    -- firemode = KEY_B,       -- fire mode toggle       (requires SWEP.Primary.FireModeSound)
    -- attachment = KEY_T,     -- attachment toggle      (requires SWEP.Attachments table)
}

-- ─── Animations ──────────────────────────────────────────────────────────────
-- Map animation names to viewmodel sequences from your .qc file.
-- Find sequence names by decompiling your model with Crowbar.
-- Look for $sequence entries — the first quoted string after $sequence is the name.
--
-- ── Entry formats ────────────────────────────────────────────────────────────
--
--   Single animation:
--     fire = { seq = "shoot" }
--
--   With custom playback rate (default is 1.0):
--     fire = { seq = "shoot", rate = 1.5 }
--
--   With explicit duration override in seconds (use if you want custom duration for a sequence):
--     fire = { seq = "shoot", dur = 0.4 }
--
--   Random selection — picks one entry randomly each play:
--     fire = {
--         { seq = "shoot1" },
--         { seq = "shoot2" },
--         { seq = "shoot3" },
--     }
--
--   With eye attachment camera (for muzzle-cam / scope effects):
--     fire = { seq = "shoot", eye_attachment = { att = "muzzle", scale = 1.0 } }
--
-- ── Automatic variant fallback chain ─────────────────────────────────────────
-- The base tries variants in order and plays the first one found.
-- You only need to define variants your model actually has.
--
-- For FIRE (only animation with ADS variants):
--   fire_iron_empty  →  fire_iron  →  fire_empty  →  fire
--
-- For ALL other animations:
--   <key>_empty  →  <key>
--
-- ── Inspect rule ─────────────────────────────────────────────────────────────
-- If fire_empty is defined but inspect_empty is NOT defined,
-- inspect is automatically blocked when clip is empty.
-- This prevents showing a bullet-visible inspect on an empty weapon.

SWEP.Animations = {

    -- ── Required ─────────────────────────────────────────────────────────────
    draw  = { seq = "draw"  },
    idle  = { seq = "idle"  },
    fire  = { seq = "shoot" },

    -- ── Recommended ──────────────────────────────────────────────────────────
    reload       = { seq = "reload"       },
    reload_empty = { seq = "reload_empty" },
    draw_empty   = { seq = "draw_empty"   },
    idle_empty   = { seq = "idle_empty"   },

    -- ── Holster (played by the holster system when switching weapons) ─────────
    -- If defined, the weapon will play this anim before switching.
    -- The holster system automatically delays the switch until it finishes.
    holster = { seq = "holster" },

    -- ── Fire variants ────────────────────────────────────────────────────────
    fire_empty      = { seq = "fire_empty"      },
    fire_iron       = { seq = "iron_fire"       },   -- fire while ADS
    fire_iron_empty = { seq = "iron_fire_empty" },   -- fire while ADS on last shot

    -- ── ADS transitions (optional, cosmetic) ─────────────────────────────────
    ads     = { seq = "ads_in"  },
    ads_out = { seq = "ads_out" },

    -- ── Bolt action (requires IsBoltAction = true) ────────────────────────────
    bolt = { seq = "bolt" },

    -- ── Inspect ──────────────────────────────────────────────────────────────
    inspect       = {
        { seq = "inspect1" },
        { seq = "inspect2" },
    },
    inspect_empty = { seq = "inspect_empty" },

    -- ── Movement ─────────────────────────────────────────────────────────────
    walk         = { seq = "Walk"         },
    walk_empty   = { seq = "Walk_empty"   },
    sprint       = { seq = "Sprint"       },
    sprint_empty = { seq = "Sprint_empty" },

    -- ── Lowered state (requires Keys.lowered) ────────────────────────────────
    lowered     = { seq = "lowidle"   },
    lowered_on  = { seq = "idletolow" },
    lowered_off = { seq = "lowtoidle" },

    -- ── Fire mode switch (requires Keys.firemode) ─────────────────────────────
    -- Plays when the player toggles between auto/burst.
    -- Base will lock NextPrimaryFire/NextSecondaryFire for its duration.
    firemode_switch = { seq = "firemode" },

    -- ── Secondary fire ───────────────────────────────────────────────────────
    -- Used by SecondaryAttack (clip2 system), AltFire, and ProjectileLauncher.
    secondary_fire         = { seq = "secondary_fire"         },
    secondary_fire_empty   = { seq = "secondary_fire_empty"   },
    secondary_reload       = { seq = "secondary_reload"       },
    secondary_reload_empty = { seq = "secondary_reload_empty" },

    -- ── Attachment toggle (requires SWEP.Attachments + Keys.attachment) ───────
    -- Plays when adding/removing an attachment.
    attach_add    = { seq = "attach_on"  },
    attach_remove = { seq = "attach_off" },

    -- ── Charge weapon (requires SWEP.Charge table) ───────────────────────────
    charge_spinup = { seq = "charge_spinup" },
    charge_fire   = { seq = "charge_fire"   },

    -- ── Phased reload (requires SWEP.PhasedReload table) ─────────────────────
    reload_start      = { seq = "reload_start"      },
    reload_insert     = { seq = "reload_insert"     },
    reload_end        = { seq = "reload_end"        },
    reload_end_nobolt = { seq = "reload_end_nobolt" },

    -- ── AR2Ball launcher (requires ProjectileLauncher Type="AR2Ball") ─────────
    -- secondary_reload     = load/charge anim
    -- secondary_fire       = fire anim
    -- secondary_fire_prep  = pre-fire shake anim

    -- ── Throwing (requires SWEP.Throwing table) ───────────────────────────────
    throw_prep = { seq = "throw_prep" },
    throw_fire = { seq = "throw_fire" },
    lob_prep   = { seq = "lob_prep"   },   -- falls back to throw_prep if absent
    lob_fire   = { seq = "lob_fire"   },   -- falls back to throw_fire if absent
    roll_prep  = { seq = "roll_prep"  },   -- falls back to throw_prep if absent
    roll_fire  = { seq = "roll_fire"  },   -- falls back to throw_fire if absent
}

-- ─── PLFireMoveDelay ─────────────────────────────────────────────────────────
-- Seconds after a ProjectileLauncher shot that walk/sprint anims are blocked.
-- Increase for weapons with long PL recovery animations.
SWEP.PLFireMoveDelay = 2.0

-- ─── Phased Reload ───────────────────────────────────────────────────────────
-- Shell-by-shell reload. Used for tube-fed shotguns, lever-actions.
-- Player can interrupt at any time by firing — the base handles this correctly.
-- Set PhasedReload = nil to disable.
--
-- Required animations: reload_start, reload_insert, reload_end
-- Optional:            reload_end_nobolt

SWEP.PhasedReload = nil
--[[
SWEP.PhasedReload = {
    StartTime        = 0.8,                        -- reload_start duration (auto if nil)
    InsertTime       = 0.6,                        -- reload_insert duration per shell (auto if nil)
    FinishTime       = 0.5,                        -- reload_end duration (auto if nil)
    NoBoltTime       = 0.4,                        -- reload_end_nobolt duration (auto if nil)
    TrackNoBolt      = true,                       -- play NoBolt anim if clip wasn't empty
    InsertSound      = "Weapon_Shotgun.Reload",    -- sound per shell insert
    InsertSoundDelay = 0.15,                       -- delay before insert sound
    FinishSound      = "",                         -- sound when reload finishes
}
]]

-- ─── Charge ──────────────────────────────────────────────────────────────────
-- Wind-up mechanic before firing. For miniguns, railguns, charged shots.
-- Set Charge = nil to disable.
--
-- Required animations: charge_spinup, charge_fire
-- Optional:            set SWEP.Sounds.charge for a looping spin-up sound
--
-- Modes:
--   "auto"   = fires automatically once spinup completes
--   "hold"   = hold to charge, release to fire
--   "stream" = hold to fire continuously, release to cancel

SWEP.Charge = nil
--[[
SWEP.Charge = {
    Key  = IN_ATTACK,
    Mode = "auto",   -- "auto"  "hold"  "stream"
}
SWEP.Sounds.charge = "weapons/gauss/spin.wav"
]]

-- ─── Alt Fire ────────────────────────────────────────────────────────────────
-- A second fire mode on a separate key, consuming primary ammo.
-- Runs through HandleAltFire (shared) and HandleAltBurstFire (shared).
-- AltBurstActive/AltBurstShotsLeft/AltBurstNextShot are NetworkVar'd automatically.
-- Set AltFire = nil to disable.
--
-- Requires Keys.altfire to be set.
-- Uses secondary_fire animation by default. Override with Anim field.
--
-- FireMode options:
--   nil / unset  = semi (one shot per press)
--   "burst"      = fires BurstCount shots per press
--                  set Automatic = true for burst-on-hold (re-arms while held)

SWEP.AltFire = nil
--[[
SWEP.AltFire = {
    AmmoCost           = 1,        -- primary ammo consumed per shot
    NumShots           = 1,        -- bullets per shot (defaults to Primary.NumShots)
    Anim               = "fire",   -- animation to play per shot (defaults to "secondary_fire")
    SpreadMult         = 1.0,      -- spread multiplier on top of current spread
    RecoilMult         = 1.5,      -- ViewPunch multiplier
    EyeAngleRecoilMult = 1.5,      -- eye angle recoil multiplier
    Sound              = nil,      -- fire sound (nil = use Primary.Sound)
    Cooldown           = 0.5,      -- lock duration after firing (semi/auto modes)
    Damage             = nil,      -- damage override (nil = use Primary.Damage)

    -- Burst mode:
    FireMode      = "burst",
    Automatic     = true,          -- true = re-arms while key held
    BurstCount    = 3,
    BurstDelay    = 0.08,
    BurstCooldown = 0.25,
}
]]

-- ─── Projectile Launcher ─────────────────────────────────────────────────────
-- Fires a scripted entity rather than hitscan bullets.
-- Runs in shared Think (HandleProjectileLauncher).
-- Primary attack is automatically blocked during PL fire and reload.
-- Set ProjectileLauncher = nil to disable.
--
-- Non-IN keys (MOUSE_*, KEY_*) are auto-registered — no need to add to Keys.
--
-- Type = "standard"  fires an entity with velocity
-- Type = "AR2Ball"   uses point_combine_ball_launcher (HL2 energy ball)
--
-- Required animations: secondary_fire, secondary_reload (optional)
-- AR2Ball additionally requires: secondary_fire_prep
-- Note this should be used if the SWEP you're trying to make has a secondary projectile attack

SWEP.ProjectileLauncher = nil
--[[
-- Standard launcher:
SWEP.ProjectileLauncher = {
    Enabled    = true,
    Type       = "standard",
    Key        = IN_ATTACK2,
    AmmoType   = "SMG1_Grenade",
    Entity     = "grenade_ar2",
    Velocity   = 800,
    Recoil     = 8,
    FireTime   = nil,        -- nil = auto from secondary_fire anim duration
    ReloadTime = nil,        -- nil = auto from secondary_reload anim duration
                             -- if ReloadTime is set and ammo remains, auto-reloads after fire
    Sound      = "Weapon_SMG1.Alt",
    Pos = function(wep)
        return wep.Owner:GetShootPos() + wep.Owner:GetAimVector() * 48
    end,
    Ang = function(wep)
        return wep.Owner:EyeAngles()
    end,
}

-- AR2Ball launcher:
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
]]

-- ─── Melee Attacks ───────────────────────────────────────────────────────────
-- One or more melee attacks. Multiple entries on the same Key form a combo chain.
-- Runs on SERVER via HandleMeleeLogic + HandleMeleeKeys.
-- DoMeleeTrace handles multi-ray sweep, flesh/world/prop hit separation, decals.
--
-- For PURE MELEE: set Primary.ClipSize = -1, Primary.Ammo = "",
--                 CanReload = false, Key = IN_ATTACK.
--
-- For GUN WITH BASH: use MOUSE_MIDDLE or KEY_* to avoid conflicting with fire.
--   Non-IN keys are auto-registered — no need to add to SWEP.Keys.
--
-- Set MeleeAttacks = nil to disable.

SWEP.MeleeAttacks = nil
--[[
SWEP.MeleeAttacks = {
    {
        Key      = IN_ATTACK2,
        Seq      = "melee",
        Act      = ACT_VM_SECONDARYATTACK,   -- fallback if Seq not found on model
        Damage   = 50,
        DmgType  = DMG_CLUB,    -- DMG_SLASH  DMG_CLUB  DMG_CRUSH  DMG_GENERIC
        Force    = 8,
        Length   = 55,          -- trace length in units
        Hull     = 10,          -- sweep width (larger = wider arc)
        Delay    = 0.2,         -- seconds after swing before hit registers
        End      = 0.5,         -- total lock duration
        Sound    = "",          -- swing whoosh sound
        HitFlesh = "",          -- sound on NPC/player hit
        HitWorld = "",          -- sound on world/prop hit
        HitDecal = "ManhackCut",
        ViewPunch  = Angle(-5, 4, 0),
        DamageDir  = Angle(0, 45, 0),  -- force direction relative to eye angle (optional)
    },
    -- Add more with the same Key to create a combo:
    -- { Key = IN_ATTACK2, Seq = "melee2", ... },
}
]]

-- ─── Attachments ─────────────────────────────────────────────────────────────
-- Togglable weapon attachments: laser sight, suppressor.
-- Runs in shared Think (HandleAttachment).
-- Toggle sound is played via IsFirstTimePredicted() so shooter hears it in MP.
-- AttachmentActive is a NetworkVar — visible on both sides.
-- Set Attachments = nil to disable. Requires Keys.attachment to be set.
--
-- ── Laser sight ──────────────────────────────────────────────────────────────
-- Draws a beam from AttachmentName attachment point to hit surface.
-- DotMat and DotSize are optional — omit for beam-only (no dot).
-- Beam is automatically hidden when: clip empty, reloading, during draw animation.
--
-- ── Suppressor ───────────────────────────────────────────────────────────────
-- Switches fire sound to FireSound when active.
-- Optionally toggles a bodygroup on the viewmodel.
-- SuppressTracer = true hides bullet tracers.
-- SuppressMuzzleFlash = true hides muzzle flash particles.

SWEP.Attachments = nil
--[[
SWEP.Attachments = {
    ["laser"] = {
        Enabled        = true,
        AttachmentName = "laser",              -- attachment point on viewmodel (.qc $attachment)
        Material       = Material("effects/blueblacklargebeam"),
        BeamSize       = 2,
        Color          = Color(255, 0, 0, 200),
        DotMat         = Material("sprites/light_glow02_add"), -- optional
        DotSize        = 4,                                    -- optional
        SoundOn        = "Weapon_RPG.LaserOn",
        SoundOff       = "Weapon_RPG.LaserOff",
    },

    ["suppressor"] = {
        Enabled             = true,
        Bodygroup           = 1,               -- viewmodel bodygroup index to toggle
        FireSound           = "path/to/suppressed_shot.wav",
        SuppressTracer      = true,
        SuppressMuzzleFlash = true,
    },
}
]]

-- ─── Throwing ────────────────────────────────────────────────────────────────
-- Three-phase thrown weapon: prep → cook → release.
-- Spawns a physics entity and launches it. Consumes Primary.Ammo.
-- After throwing, draw animation replays if ammo remains.
-- Runs on SERVER via HandleThrowing.
-- Set Throwing = nil to disable.
--
-- Three modes (automatic from key + crouch state):
--   Throw key (standing)   → mode 1: overhand throw
--   Lob key   (standing)   → mode 2: lob (high arc)
--   Lob key   (crouching)  → mode 3: roll (ground-hugging)
--
-- Required: Primary.ClipSize = -1, Primary.Ammo = your grenade ammo, CanReload = false
-- Required animations: throw_prep, throw_fire
-- Optional animations: lob_prep, lob_fire, roll_prep, roll_fire
--   (fall back to throw_prep/throw_fire if absent)

SWEP.Throwing = nil
--[[
SWEP.Throwing = {
    Entity   = "npc_grenade_frag",
    Timer    = 3.5,      -- fuse in seconds passed via ent:Input("settimer", ...) (nil = no input)
    HoldTime = 3.5,      -- max cook time before auto-release (0 = no limit)
    Sound    = "Grenade.Blip",

    Throw = {
        Key     = IN_ATTACK,
        Force   = 1200,
        ArcBias = 0.1,
        Spin    = Vector(600, 200, 0),
    },
    Lob = {
        Key     = IN_ATTACK2,
        Force   = 800,
        ArcBias = 50,
        Spin    = Vector(300, 200, 0),
    },
    Roll = {
        -- activates on Lob key when crouching
        Force = 600,
        Spin  = Vector(0, 0, 900),
    },
}
]]
