AddCSLuaFile()

SWEP.Base           = "weapon_base"
SWEP.Author         = "kenni"
SWEP.Category       = "Eaasy Weapons"
SWEP.Spawnable      = false
SWEP.AdminSpawnable = false
SWEP.DrawCrosshair  = true

SWEP.Animations = {
    draw                   = nil,
    draw_empty             = nil,
    idle                   = nil,
    idle_empty             = nil,
    fire                   = nil,
    fire_iron              = nil,
    fire_empty             = nil,
    ads                    = nil,
    ads_out                = nil,
    reload                 = nil,
    reload_empty           = nil,
    inspect                = nil,
    inspect_empty          = nil,
    walk                   = nil,
    walk_empty             = nil,
    sprint                 = nil,
    sprint_empty           = nil,
    secondary_fire         = nil,
    secondary_reload       = nil,
    secondary_fire_empty   = nil,
    secondary_reload_empty = nil,
    bolt                   = nil,
    throw_prep             = nil,
    throw_fire             = nil,
    lob_prep               = nil,
    lob_fire               = nil,
    roll_prep              = nil,
    roll_fire              = nil,
}

SWEP._ActionPriority = {
    charging         = 7,
    charge_firing    = 6,
    reloading        = 5,
    throwing         = 5,
    secondary_reload = 4,
    pl_reloading     = 4,
    pl_loading       = 4,
    pl_prep          = 3,
    bolting          = 3,
    pl_firing        = 3,
    melee            = 3,
    secondary_fire   = 2,
    inspecting       = 1,
    firing           = -1,
    lowered          = 1,
    idle             = -1,
}

SWEP.Sounds = {
    empty    = nil,
    enterads = nil,
    exitads  = nil,
}

SWEP.VMOffset  = Vector(0, 0, 0)
SWEP.ADSOffset = Vector(0, 0, 0)
SWEP.ADSMidDip = 0
SWEP.ADSSpeed  = 8

SWEP.ADSFOVMult = 1

SWEP._ADSProgress      = 0
SWEP._CurrentVMOffset  = Vector(0, 0, 0)
SWEP._ADSStrafeRoll  = 0
SWEP._ADSForwardShift = 0
SWEP._JumpBob        = 0
SWEP._JumpBobVel     = 0
SWEP._WasOnGround    = true
SWEP._WalkBobTime = 0
SWEP._WalkBobX    = 0
SWEP._WalkBobY    = 0

SWEP.PhasedReload = nil

SWEP.ProjectileLauncher = nil

SWEP.CanReload = true

SWEP.IsBoltAction = false
SWEP.BoltTime     = 0.68
SWEP.BoltSound    = nil

SWEP._DrawEndTime = 0
SWEP.FireMoveDelay = 0.5  

SWEP.ADSHoldToAim  = true

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

SWEP._StateDefaults = {
    _BoltAnimDone            = false,
    _ReloadEndTime           = 0,
    _ReloadGiven             = 0,
    _ReloadReserve           = 0,
    _LastFireTime            = 0,
    _LastMoveState           = nil,
    _WaitingForFireRelease   = false,
    _FireTapWindow           = 0,
    _FireAnimDur             = nil,
    _FireDurCache            = nil,
    _LastInspectTime         = 0,
    _PR_Phase                = 0,
    _PR_Timer                = 0,
    _PR_NoBolt               = false,
    _PR_InsertStartTime      = 0,
    _PR_InsertSoundPlayed    = false,
    _ChargePhase             = 0,
    _ChargeTimer             = 0,
    _ChargeSpinDone          = false,
    _ChargeSoundID           = nil,
    _SecReloadPending        = false,
    _SecReloadPendingAt      = 0,
    _SecReloadPendingAnim    = nil,
    _ADSStrafeRoll           = 0,
    _ADSForwardShift         = 0,
    _PL_Fired                = false,
    _PL_FireTime             = 0,
    _PL_Reloading            = false,
    _PL_ReloadEnd            = 0,
    _PL_Loaded               = true,
    _LastPLKey               = false,
    PL_IsReloading           = false,
    PL_LoadEnd               = 0,
    PL_SecCooldown           = 0,
    PL_PrepFire              = false,
    PL_FirePending           = false,
    PL_FireTime              = 0,
    _MousePressBuffer        = {},
    _NextEmptySound          = 0,
    _Burst_Active            = false,
    _Burst_ShotsLeft         = 0,
    _Burst_NextShot          = 0,
    MeleeHitFired            = false,
    MeleeHitTimer            = 0,
    MeleeEndTimer            = 0,
    _MeleeLastKey            = nil,
    _MeleeCombo              = {},
    LastMeleeTime            = 0,
    _PL_LastFireTime         = 0,
    _Throw_Phase             = 0,   
    _Throw_Mode              = 0,   
    _Throw_PrepEnd           = 0,   
    _Throw_ReleaseEnd        = 0, 
    _Throw_CookStart         = 0,
    _CurrentRecoil           = 0,  
}

SWEP.Throwing = nil

SWEP.PLFireMoveDelay = 2.0

SWEP.MuzzleFlash1 = nil

SWEP.ImpactEffect = nil

SWEP._ThinkHandlers = {
    server = {
        "FinishReload",
        "HandleFireTap",
        "HandleInspect",
        "PollINKeys",
        "TickMouseKeys",
        "HandleLowered",
        "HandleADS",
        "TickKeyboardKeys",
        "FinishSecondaryReload",
        "HandleBolt",
        "HandlePhasedReload",
        "HandleCharge",
        "HandleSecondaryReloadPending",
        "HandleProjectileLauncher",
        "HandleAltFire",
        "HandleBurstFire",
        "HandleMeleeLogic",
        "HandleMeleeKeys",
        "HandleWalkSprint",
        "HandleIdle",
        "HandleThrowing",
        "HandleRecoilDecay",     
    },
    client = {
        "PollMouseKeys",
        "PollKeyboardKeys",
        "DoMuzzleFlashLight",
    },
    shared = {},
}

local IN_MAX    = IN_GRENADE2
local MOUSE_MIN = MOUSE_FIRST
local MOUSE_MAX = MOUSE_LAST

local function IsINKey(k)
    if not k or k <= 0 then return false end
    return k <= IN_MAX and (bit.band(k, k - 1) == 0)
end

local function IsMouseKey(k)
    if not k then return false end
    return k >= MOUSE_MIN and k <= MOUSE_MAX
end

local function IsKeyboardKey(k)
    if not k then return false end
    return k >= KEY_FIRST and k <= KEY_LAST
        and not IsINKey(k)
        and not IsMouseKey(k)
end

local function GetOrCreateConVar(name, default, flags, desc)
    if ConVarExists(name) then return GetConVar(name) end
    return CreateConVar(name, default, flags, desc)
end

local function GetVM(swep)
    return IsValid(swep.Owner) and swep.Owner:GetViewModel() or nil
end

local function SendSeq(vm, name)
    if not IsValid(vm) or not name or name == "" then return end
    local seq = vm:LookupSequence(name)
    if seq and seq > -1 then vm:SendViewModelMatchingSequence(seq) end
end

local function GetAnimEntry(swep, name)
    local anim = swep.Animations[name]
    if not anim then return nil end
    if type(anim) == "table" and anim[1] and type(anim[1]) == "table" then
        return anim[math.random(#anim)]
    end
    return anim
end

local function GetAnimDuration(swep, entry)
    if not entry then return nil end
    if entry.dur then return entry.dur end
    local vm = GetVM(swep)
    if not IsValid(vm) then return nil end
    local seq = vm:LookupSequence(entry.seq)
    if not seq or seq == -1 then return nil end
    local rate = entry.rate or 1
    local dur = vm:SequenceDuration(seq)
    return dur / rate
end

local function GetAnimName(swep, base)
    local isEmpty = swep:Clip1() <= 0

    if swep:IsADS() then
        if isEmpty then
            local iron_empty = base .. "_iron_empty"
            if GetAnimEntry(swep, iron_empty) then return iron_empty end
        end
        local iron = base .. "_iron"
        if GetAnimEntry(swep, iron) then return iron end
    end

    if isEmpty then
        local empty = base .. "_empty"
        if GetAnimEntry(swep, empty) then return empty end
    end

    return base
end

local function PlayAnim(swep, name, raw)
    -- raw = true bypasses the resolver, plays exactly the name given
    -- default (raw nil/false): auto-resolves _empty/_iron/_iron_empty variants
    local resolved = (not raw) and GetAnimName(swep, name) or name
    local entry = GetAnimEntry(swep, resolved)
    -- fallback to base name if resolved variant has no entry defined
    if not entry and resolved ~= name then
        entry = GetAnimEntry(swep, name)
    end
    if not entry or not entry.seq or entry.seq == "" then return nil end
    local vm = GetVM(swep)
    if not IsValid(vm) then return nil end
    SendSeq(vm, entry.seq)
    vm:SetPlaybackRate(entry.rate or 1)
    return entry
end

function SWEP:SetupDataTables()
    self:NetworkVar("Float", "DrawEndTime")
    self:NetworkVar("Float", "IdleTime")
    self:NetworkVar("Float", "InspectEndTime")
    self:NetworkVar("Bool", "IsLowered")
    self:NetworkVar("Float", "LoweredTransitionEnd")
    self:NetworkVar("Float", "SecondaryFireEndTime")
    self:NetworkVar("Float", "SecondaryReloadEndTime")
    self:NetworkVar("Float", "BoltEndTime")
    self:NetworkVar("Float", "ChargeEndTime")
    self:NetworkVar("Bool", "IsCharging")
    self:NetworkVar("Bool", "IsADSActive")
    self:NetworkVar("Float", "LastFireTime")
    self:NetworkVar("Int",   "ThrowPhase")
    self:NetworkVar("Float", "ThrowPrepEnd")
    self:NetworkVar("Float", "ThrowReleaseEnd")
end

-- Key Scan

function SWEP:HandleMeleeKeys()
    if not SERVER then return end
    if not self.MeleeAttacks then return end

    local seen = {}
    for _, atk in ipairs(self.MeleeAttacks) do
        local key = atk.Key or IN_ATTACK
        if IsINKey(key) then continue end
        if seen[key] then continue end
        seen[key] = true

        local action = "_melee_" .. tostring(key)
        if self:KPressed(action) then
            self:DoMeleeAttack(key)
        end
    end
end

function SWEP:ScanKeys()
    self._KeyIsIN    = {}
    self._KeyIsMouse = {}
    self._KeyIsKeyboard = {}
    self._KeyState   = {}
    self._KeyLast    = {}
    self._MousePressBuffer = {}

    self._InspectSharesReload = self.Keys
        and self.Keys.inspect
        and self.Keys.reload
        and (self.Keys.inspect == self.Keys.reload)
        or false

    if not self.Keys then return end

    for action, key in pairs(self.Keys) do
        if IsINKey(key) then
            self._KeyIsIN[action] = true
        elseif IsMouseKey(key) then
            self._KeyIsMouse[action] = true
        elseif IsKeyboardKey(key) then
            self._KeyIsKeyboard[action] = true
        else
            ErrorNoHalt("[kenni_weapon_base] Unknown key type for action '" .. action .. "': " .. tostring(key) .. "\n")
        end
        self._KeyState[action] = false
        self._KeyLast[action]  = false
    end

    if self.MeleeAttacks then
        for _, atk in ipairs(self.MeleeAttacks) do
            local key = atk.Key or IN_ATTACK
            if not IsINKey(key) then
                local action = "_melee_" .. tostring(key)
                if not self.Keys then self.Keys = {} end
                self.Keys[action] = key
                if IsMouseKey(key) then
                    self._KeyIsMouse[action] = true
                elseif IsKeyboardKey(key) then
                    self._KeyIsKeyboard[action] = true
                end
                self._KeyState[action] = false
                self._KeyLast[action]  = false
            end
        end
    end

    if self.ProjectileLauncher and self.ProjectileLauncher.Enabled then
        local key = self.ProjectileLauncher.Key
        if key and not IsINKey(key) then
            local action = "_pl_fire"
            if not self.Keys then self.Keys = {} end
            self.Keys[action] = key
            if IsMouseKey(key) then
                self._KeyIsMouse[action] = true
            elseif IsKeyboardKey(key) then
                self._KeyIsKeyboard[action] = true
            end
            self._KeyState[action] = false
            self._KeyLast[action]  = false
        end
    end

    if self.Throwing then
        local T = self.Throwing
        local throwKey = T.Throw and T.Throw.Key or IN_ATTACK
        local lobKey   = T.Lob   and T.Lob.Key   or IN_ATTACK2

        if not IsINKey(throwKey) then
            self.Keys["_throw"] = throwKey
            if IsMouseKey(throwKey) then
                self._KeyIsMouse["_throw"] = true
            else
                self._KeyIsKeyboard["_throw"] = true
            end
            self._KeyState["_throw"] = false
            self._KeyLast["_throw"]  = false
        end

        if not IsINKey(lobKey) then
            self.Keys["_lob"] = lobKey
            if IsMouseKey(lobKey) then
                self._KeyIsMouse["_lob"] = true
            else
                self._KeyIsKeyboard["_lob"] = true
            end
            self._KeyState["_lob"] = false
            self._KeyLast["_lob"]  = false
        end
    end
end

-- Key Poll

function SWEP:PollINKeys()
    if not SERVER then return end
    if not IsValid(self.Owner) then return end

    for action, _ in pairs(self._KeyIsIN) do
        local key = self.Keys[action]
        self._KeyLast[action]  = self._KeyState[action]
        self._KeyState[action] = self.Owner:KeyDown(key)
    end
end

function SWEP:PollKeyboardKeys()
    if not CLIENT then return end

    for action, _ in pairs(self._KeyIsKeyboard) do
        local key     = self.Keys[action]
        local current = input.IsKeyDown(key)
        local last    = self._KeyLast[action]

        if current and not last then
            net.Start("kenni_mousekey")
                net.WriteString(action)
                net.WriteBool(true)
            net.SendToServer()
        elseif not current and last then
            net.Start("kenni_mousekey")
                net.WriteString(action)
                net.WriteBool(false)
            net.SendToServer()
        end

        self._KeyLast[action] = current
    end
end

function SWEP:TickMouseKeys()
    if not SERVER then return end
    for action, _ in pairs(self._KeyIsMouse) do
        self._KeyLast[action] = self._KeyState[action]
    end
end

function SWEP:PollMouseKeys()
    if not CLIENT then return end

    for action, _ in pairs(self._KeyIsMouse) do
        local key     = self.Keys[action]
        local current = input.IsMouseDown(key)
        local last    = self._KeyLast[action]

        if current and not last then
            net.Start("kenni_mousekey")
                net.WriteString(action)
                net.WriteBool(true)
            net.SendToServer()
        elseif not current and last then
            net.Start("kenni_mousekey")
                net.WriteString(action)
                net.WriteBool(false)
            net.SendToServer()
        end

        self._KeyLast[action] = current
    end
end

if SERVER then
    util.AddNetworkString("kenni_mousekey")

    net.Receive("kenni_mousekey", function(len, ply)
        local wep = ply:GetActiveWeapon()
        if not IsValid(wep) then return end

        local action = net.ReadString()
        local state  = net.ReadBool()

        if not wep._KeyIsMouse[action] and not wep._KeyIsKeyboard[action] then return end

        wep._KeyLast[action]  = wep._KeyState[action]
        wep._KeyState[action] = state

        if state and wep._KeyIsMouse[action] then
            wep._MousePressBuffer[action] = true
        end
    end)
end

-- Key API

function SWEP:TickKeyboardKeys()
    if not SERVER then return end
    for action, _ in pairs(self._KeyIsKeyboard) do
        self._KeyLast[action] = self._KeyState[action]
    end
end

function SWEP:KDown(action)
    if not self._KeyState then return false end
    return self._KeyState[action] == true
end

local function RawKeyPressed(wep, action)
    if wep._KeyIsMouse[action] then
        if wep._MousePressBuffer[action] then
            wep._MousePressBuffer[action] = false
            return true
        end
        return false
    end
    if wep._KeyIsIN[action] and IsValid(wep.Owner) then
        return wep.Owner:KeyPressed(wep.Keys[action])
    end
    if wep._KeyIsKeyboard[action] then
        return wep._KeyState[action] == true and wep._KeyLast[action] == false
    end
    return false
end

function SWEP:KPressed(action)
    if not self._KeyIsIN then return false end

    if self._InspectSharesReload and (action == "inspect" or action == "reload") then
        if not RawKeyPressed(self, action) then return false end
    
        -- if reload disabled, inspect always wins
        if not self.CanReload then
            if action == "inspect" then return true end
            if action == "reload"  then return false end
        end
    
        local clip        = self:Clip1()
        local hasReserves = IsValid(self.Owner) and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0
    
        if clip <= 0 and not hasReserves then
            local hasInspectAnim = GetAnimEntry(self, "inspect") ~= nil
            if action == "inspect" then return hasInspectAnim end
            if action == "reload"  then return false end
        end
    
        local clipFull      = clip >= self.Primary.ClipSize
        local shouldInspect = clipFull or not hasReserves
    
        if action == "inspect" then return shouldInspect     end
        if action == "reload"  then return not shouldInspect end
    end

    return RawKeyPressed(self, action)
end

function SWEP:KReleased(action)
    if not self._KeyIsIN then return false end
    if self._KeyIsMouse[action] then
        return self._KeyState[action] == false and self._KeyLast[action] == true
    end
    if self._KeyIsIN[action] and IsValid(self.Owner) then
        return self.Owner:KeyReleased(self.Keys[action])
    end
    if self._KeyIsKeyboard[action] then
        return self._KeyState[action] == false and self._KeyLast[action] == true
    end
    return false
end

-- Keys

function SWEP:ValidateKeys()
    if not self.Keys then
        ErrorNoHalt("[kenni_weapon_base] SWEP.Keys not defined on " .. tostring(self.ClassName) .. "\n")
        return
    end
    if not self.Keys.primary then
        ErrorNoHalt("[kenni_weapon_base] Keys.primary required on " .. tostring(self.ClassName) .. "\n")
    end
    if not self.Keys.reload then
        ErrorNoHalt("[kenni_weapon_base] Keys.reload required on " .. tostring(self.ClassName) .. "\n")
    end

    local seen = {}
    for action, key in pairs(self.Keys) do
        local existing = seen[key]
        if existing then
            local pair  = action .. "+" .. existing
            local legal = (pair == "inspect+reload" or pair == "reload+inspect")
            if not legal then
                ErrorNoHalt(string.format(
                    "[kenni_weapon_base] Key conflict on %s: '%s' and '%s' share key %d\n",
                    tostring(self.ClassName), action, existing, key
                ))
            end
        else
            seen[key] = action
        end
    end
end

-- Helpers

function SWEP:VM_TickMoveTilt()
    local targetRoll   = 0
    local targetShift  = 0

    if IsValid(self.Owner) then
        if self.Owner:KeyDown(IN_MOVELEFT)  then targetRoll  = targetRoll  - 0.8 end
        if self.Owner:KeyDown(IN_MOVERIGHT) then targetRoll  = targetRoll  + 0.8 end
        if self.Owner:KeyDown(IN_FORWARD)   then targetShift = targetShift - 0.5 end
        if self.Owner:KeyDown(IN_BACK)      then targetShift = targetShift + 0.5 end
    end

    self._ADSStrafeRoll  = Lerp(FrameTime() * 6, self._ADSStrafeRoll  or 0, targetRoll)
    self._ADSForwardShift = Lerp(FrameTime() * 6, self._ADSForwardShift or 0, targetShift)
end

function SWEP:VM_TickJumpBob()
    if not IsValid(self.Owner) then return end

    local mt       = self.Owner:GetMoveType()
    local grounded = mt == MOVETYPE_WALK or mt == MOVETYPE_STEP

    if not grounded then
        self._JumpBob     = Lerp(FrameTime() * 12, self._JumpBob, 0)
        self._JumpBobVel  = 0
        self._WasOnGround = true
        return
    end

    local onGround = self.Owner:IsOnGround()

    if not onGround and self._WasOnGround then
        self._JumpBobVel = 3.5
        self._JumpBob    = 0
    end

    if not onGround then
        self._JumpBobVel = self._JumpBobVel - (9.0 * FrameTime())
        self._JumpBob    = self._JumpBob + self._JumpBobVel * FrameTime()

        local cap      = -2.0
        local easeZone = 0.8
        if self._JumpBob < cap + easeZone then
            local ease = 1 - ((self._JumpBob - cap) / easeZone)
            ease = math.Clamp(ease, 0, 1)
            self._JumpBobVel = self._JumpBobVel * (1 - ease * FrameTime() * 18)
            self._JumpBob    = math.max(self._JumpBob, cap)
        end
    else
        if self._WasOnGround == false then
            self._JumpBobVel = self._JumpBobVel * 0.3
        end
        self._JumpBob    = Lerp(FrameTime() * 12, self._JumpBob, 0)
        self._JumpBobVel = 0
    end

    self._WasOnGround = onGround
end

function SWEP:VM_TickWalkBob()
    local bobFreq, bobAmpX, bobAmpY = 0, 0, 0

    if self:IsOwnerSprinting() then
        bobFreq = 9.0
        bobAmpX = 0.8
        bobAmpY = 0.4
    elseif self:IsOwnerWalking() then
        bobFreq = 5.5
        bobAmpX = 0.2
        bobAmpY = 0.1
    end

    if bobFreq > 0 then
        self._WalkBobTime = self._WalkBobTime + FrameTime() * bobFreq
    else
        self._WalkBobTime = self._WalkBobTime + FrameTime() * 2.0
    end

    self._WalkBobX = Lerp(FrameTime() * 10, self._WalkBobX, math.sin(self._WalkBobTime)           * bobAmpX)
    self._WalkBobY = Lerp(FrameTime() * 10, self._WalkBobY, math.abs(math.sin(self._WalkBobTime)) * bobAmpY)
end

function SWEP:VM_ApplyBreath(oldpos, oldang, ang)
    local t        = CurTime()
    local scale    = self.ADSFOVMult
    local breath_x = math.sin(t * 1.2) * 0.004 * scale
    local breath_y = math.sin(t * 0.8) * 0.006 * scale
    return self:GetViewModelPosition(
        oldpos + ang:Right() * breath_x + ang:Up() * breath_y,
        oldang
    )
end

function SWEP:VM_ApplyADSFx(ads_pos, ads_ang, ang)
    ads_pos = ads_pos + ang:Up()      * self._JumpBob
    ads_pos = ads_pos + ang:Right()   * self._WalkBobX * 0.15
    ads_pos = ads_pos + ang:Up()      * self._WalkBobY * 0.15
    ads_pos = ads_pos + ang:Forward() * self._ADSForwardShift
    ads_ang.r = ads_ang.r + self._ADSStrafeRoll
    return ads_pos, ads_ang
end

function SWEP:GetCurrentPriority()
    if self:IsCharging()           then return self._ActionPriority.charging         end
    if self:IsChargeFiring()       then return self._ActionPriority.charge_firing    end
    if self:IsReloading()          then return self._ActionPriority.reloading        end
    if self:IsSecondaryReloading() then return self._ActionPriority.secondary_reload end
    if self:IsPLFiringMove()       then return self._ActionPriority.pl_firing        end
    if self:IsPLReloading()        then return self._ActionPriority.pl_reloading     end
    if self:IsPLLoading()          then return self._ActionPriority.pl_loading       end
    if self:IsPLPrepping()         then return self._ActionPriority.pl_prep          end
    if self:IsBolting()            then return self._ActionPriority.bolting          end
    if self:IsPLFiring()           then return self._ActionPriority.pl_firing        end
    if self:IsSecondaryFiring()    then return self._ActionPriority.secondary_fire   end
    if self:IsInspecting()         then return self._ActionPriority.inspecting       end
    if self:IsFiring()             then return self._ActionPriority.firing           end
    if self:IsMeleeing()           then return self._ActionPriority.melee            end
    if self:IsThrowing()           then return self._ActionPriority.throwing         end
    return self._ActionPriority.idle
end

function SWEP:CanDo(action)
    local required = self._ActionPriority[action]
    if not required then return true end
    return self:GetCurrentPriority() < required
end

function SWEP:IsOwnerCrouching()
    if not IsValid(self.Owner) then return false end
    return self.Owner:Crouching()
end

function SWEP:IsOwnerWalking()
    if not IsValid(self.Owner) then return false end
    return self.Owner:IsOnGround()
        and self.Owner:GetVelocity():LengthSqr() > 2500
        and not self.Owner:KeyDown(IN_SPEED)
        and not self.Owner:Crouching()
end

function SWEP:IsOwnerSprinting()
    if not IsValid(self.Owner) then return false end
    return self.Owner:IsOnGround()
        and self.Owner:GetVelocity():LengthSqr() > 2500
        and self.Owner:KeyDown(IN_SPEED)
        and not self.Owner:Crouching()
end

function SWEP:IsPLFiringMove()
    return (CurTime() < self:GetNextSecondaryFire()) or (CurTime() < (self._PL_LastFireTime or 0) + (self.PLFireMoveDelay or 2.0))
end

function SWEP:IsPLLoading()
    return self.PL_IsReloading == true
end

function SWEP:IsPLPrepping()
    return self.PL_PrepFire == true
end

function SWEP:IsMeleeing()
    return self.MeleeEndTimer and self.MeleeEndTimer > 0 and CurTime() < self.MeleeEndTimer
end

function SWEP:IsReloading()
    return (self._ReloadEndTime and self._ReloadEndTime > 0) or (self._PR_Phase and self._PR_Phase > 0)
end

function SWEP:IsInspecting()
    return self:GetInspectEndTime() > 0
end

function SWEP:IsLowered()
    return self:GetIsLowered()
end

function SWEP:IsLoweringOrRaising()
    return self:GetLoweredTransitionEnd() > 0
end

function SWEP:IsFiring()
    return CurTime() < (self._LastFireTime or 0) + (self.FireMoveDelay or 0.5)
end

function SWEP:IsSecondaryFiring()
    return self:GetSecondaryFireEndTime() > 0 and CurTime() < self:GetSecondaryFireEndTime()
end

function SWEP:IsSecondaryReloading()
    return self:GetSecondaryReloadEndTime() > 0 and CurTime() < self:GetSecondaryReloadEndTime()
end

function SWEP:IsBolting()
    return CurTime() < self:GetBoltEndTime()
end

function SWEP:IsPostInspect()
    return CurTime() < (self._LastInspectTime or 0) + 0.1
end

function SWEP:IsCharging()
    return self:GetIsCharging()
end

function SWEP:IsChargeFiring()
    return CurTime() < self:GetChargeEndTime()
end

function SWEP:IsADS()
    return self:GetIsADSActive()
end

function SWEP:IsPLFiring()
    return self._PL_Fired == true
end

function SWEP:IsPLReloading()
    return self._PL_Reloading == true
end

function SWEP:IsThrowing()
    return self._Throw_Phase and self._Throw_Phase > 0
end

function SWEP:Initialize()
    self:SetWeaponHoldType(self.HoldType or "ar2")
    self:ValidateKeys()
    self:ScanKeys()

    self._convarADS = GetOrCreateConVar(
        "kenni_" .. self.ClassName .. "_ads_enable", "1",
        bit.bor(FCVAR_ARCHIVE, FCVAR_REPLICATED),
        "Enable ADS for " .. (self.PrintName or self.ClassName)
    )
    
    self._convarWalk = GetOrCreateConVar(
        "kenni_" .. self.ClassName .. "_walk_enable", "1",
        bit.bor(FCVAR_ARCHIVE, FCVAR_REPLICATED),
        "Enable walk animation for " .. (self.PrintName or self.ClassName)
    )
    
    self._convarSprint = GetOrCreateConVar(
        "kenni_" .. self.ClassName .. "_sprint_enable", "1",
        bit.bor(FCVAR_ARCHIVE, FCVAR_REPLICATED),
        "Enable sprint animation for " .. (self.PrintName or self.ClassName)
    )

    if CLIENT and self.ScopeOverlay and self.ScopeOverlay.Material and self.ScopeOverlay.Material ~= "" then
        self._scopeOverlayMat = Material(self.ScopeOverlay.Material)
    end
end

function SWEP:Holster()
    self:OnChargeEnd()
    self:ResetState()
    return true
end

function SWEP:ResetState()
    if self._KeyState then
        for action in pairs(self._KeyState) do
            self._KeyState[action] = false
            self._KeyLast[action]  = false
        end
    end

    if SERVER then
        self:SetDrawEndTime(0)
        self:SetInspectEndTime(0)
        self:SetIsLowered(false)
        self:SetLoweredTransitionEnd(0)
        self:SetSecondaryFireEndTime(0)
        self:SetSecondaryReloadEndTime(0)
        self:SetBoltEndTime(0)
        self:SetChargeEndTime(0)
        self:SetIsCharging(false)
        self:SetIsADSActive(false)
        self:SetThrowPhase(0)
        self:SetThrowPrepEnd(0)
        self:SetThrowReleaseEnd(0)
    end

    for k, v in pairs(self._StateDefaults) do
        if type(v) == "table" then
            self[k] = {}
        else
            self[k] = v
        end
    end
end

function SWEP:MuzzleLight()
    if not CLIENT then return end
    local cfg = self.MuzzleLightConfig
    if not cfg then return end
    local dl = DynamicLight(self.Owner:EntIndex())
    if not dl then return end
    dl.pos        = self.Owner:GetShootPos() + self.Owner:GetForward() * 20
    dl.r          = cfg.r             or 255
    dl.g          = cfg.g             or 200
    dl.b          = cfg.b             or 80
    dl.brightness = math.random(cfg.BrightnessMin or 5,   cfg.BrightnessMax or 10)
    dl.size       = math.random(cfg.SizeMin       or 100, cfg.SizeMax       or 150)
    dl.decay      = cfg.Decay         or 2500
    dl.dietime    = CurTime() + (cfg.DieTime or 0.1)
end

function SWEP:DoMuzzleFlashLight()
    if not CLIENT then return end
    local cfg = self.MuzzleLightConfig
    if not cfg then return end
    local lastFire = self:GetLastFireTime()
    if lastFire == self._LastFireTimeLocal then return end
    self._LastFireTimeLocal = lastFire
    if lastFire > 0 and CurTime() - lastFire < 0.5 then
        self:MuzzleLight()
    end
end

function SWEP:GetCurrentSpread()
    local spread = self.Primary.Spread or 0.01

    local mult
    if not IsValid(self.Owner) then
        mult = self.Primary.SpreadStand or 1.0
    elseif not self.Owner:IsOnGround() then
        mult = self.Primary.SpreadAir or 10.0
    elseif self:IsOwnerSprinting() then
        mult = self.Primary.SpreadSprint or 6.0
    elseif self:IsOwnerWalking() then
        mult = self.Primary.SpreadWalk or 2.5
    elseif self.Owner:Crouching() then
        mult = self.Primary.SpreadCrouch or 0.3
    else
        mult = self.Primary.SpreadStand or 1.0
    end

    if self:IsADS() then
        mult = mult * (self.Primary.SpreadADS or 0.25)
    end

    return spread * mult
end

function SWEP:Recoil()
    if not SERVER then return end
    if not self.Primary.Recoil or self.Primary.Recoil <= 0 then return end

    local adsMult = self:IsADS() and (self.Primary.ADSRecoilMult or 1.0) or 1.0

    -- build up recoil
    self._CurrentRecoil = math.min(
        (self._CurrentRecoil or 0) + (self.Primary.RecoilKick or self.Primary.Recoil),
        (self.Primary.RecoilMax or self.Primary.Recoil) * adsMult
    )

    local cur = self.Owner:EyeAngles()
    self.Owner:SetEyeAngles(Angle(
        cur.p - (self.Primary.EyeAngleRecoil or 0) * adsMult,
        cur.y + (self.Primary.EyeAngleRecoil or 0) * adsMult * math.Rand(-(self.Primary.EyeAngleRecoilSide or 0.5), (self.Primary.EyeAngleRecoilSide or 0.5)),
        cur.r
    ))

    self.Owner:ViewPunchReset(self.Primary.RecoilResetThreshold)
    self.Owner:ViewPunch(Angle(
        -self._CurrentRecoil * adsMult,
        self._CurrentRecoil * adsMult * math.Rand(-(self.Primary.RecoilSide or 0.5), (self.Primary.RecoilSide or 0.5)),
        self._CurrentRecoil * adsMult * math.Rand(-(self.Primary.RecoilRoll or 0), (self.Primary.RecoilRoll or 0))
    ))
end

function SWEP:HandleRecoilDecay()
    if not SERVER then return end
    if not self._CurrentRecoil or self._CurrentRecoil <= 0 then return end
    local decay = self.Primary.RecoilDecay or self.Primary.Recoil or 1.0
    self._CurrentRecoil = math.max(self._CurrentRecoil - decay * FrameTime(), 0)
end

function SWEP:PlayPrimarySound()
    if self.Primary.Sound and self.Primary.Sound ~= "" then
        self:EmitSound(self.Primary.Sound)
    end
end

function SWEP:PlayEmpty()
    if not SERVER then return end
    if not self.Sounds.empty or self.Sounds.empty == "" then return end
    if CurTime() < (self._NextEmptySound or 0) then return end
    self:EmitSound(self.Sounds.empty)
    self._NextEmptySound = CurTime() + 0.5
end

function SWEP:CreateBullets()
    if not IsValid(self.Owner) then return end
    if (self.Primary.NumShots or 1) <= 0 then return end

    local spread = self:GetCurrentSpread()

    self.Owner:FireBullets({
        Num        = self.Primary.NumShots   or 1,
        Src        = self.Owner:GetShootPos(),
        Dir        = self.Owner:GetAimVector()
            - self.Owner:EyeAngles():Right() * self.Owner:GetViewPunchAngles().y * 0.025
            - self.Owner:EyeAngles():Up()    * self.Owner:GetViewPunchAngles().x * 0.025,
        Spread = Vector(spread, spread, 0),
        Tracer     = 1,
        TracerName = self.Primary.TracerName or nil,
        Force      = self.Primary.Force      or 500,
        Damage     = self.Primary.Damage     or 10,
        AmmoType   = self.Primary.Ammo,
    })
end

function SWEP:PrimaryBullets()
    if not IsValid(self.Owner) then return end
    self:CreateBullets()
    self:PlayPrimarySound()
    self:Recoil()
    if SERVER then self:SetLastFireTime(CurTime()) end
end

function SWEP:Deploy()
    self:ResetState()

    local entry    = PlayAnim(self, "draw")
    local vm       = GetVM(self)
    local drawTime = GetAnimDuration(self, entry) or (IsValid(vm) and vm:SequenceDuration()) or 1.0
    if not entry then self.Weapon:SendWeaponAnim(ACT_VM_DRAW) end

    self:SetNextPrimaryFire(CurTime() + drawTime)
    self:SetNextSecondaryFire(CurTime() + drawTime)
    self:SetIdleTime(CurTime() + drawTime)
    self:SetDrawEndTime(CurTime() + drawTime)

    if CLIENT then
        self._LastFireTimeLocal = self:GetLastFireTime()
    end
    return true
end

function SWEP:OnChargeStart()
    if self.Sounds.charge and self.Sounds.charge ~= "" then
        self._ChargeSoundID = self:StartLoopingSound(self.Sounds.charge)
    end
end

function SWEP:OnChargeEnd()
    if self._ChargeSoundID then
        self:StopLoopingSound(self._ChargeSoundID)
        self._ChargeSoundID = nil
    end
end

function SWEP:HandleCharge()
    if not SERVER then return end
    local C = self.Charge
    if not C then return end

    local t   = CurTime()
    local key = C.Key or IN_ATTACK

    if self._ChargePhase == 0 then
        if not self:CanDo("charging") then return end 
        if self:GetIsLowered() or self:IsLoweringOrRaising() then return end  
        if self:Clip1() <= 0 then return end           
        if not self.Owner:KeyDown(key) then return end
        if not self.Owner:KeyPressed(key) then return end

        self._ChargePhase    = 1
        self._ChargeSpinDone = false
        self:SetIsCharging(true)
        self:SetInspectEndTime(0)
        self._LastMoveState = nil

        local entry  = PlayAnim(self, "charge_spinup")
        local vm     = GetVM(self)
        local dur    = GetAnimDuration(self, entry) or (IsValid(vm) and vm:SequenceDuration()) or 1.0
        self._ChargeTimer = t + dur

        self:SetNextPrimaryFire(t + dur)
        self:SetIdleTime(0)
        self:OnChargeStart()
        return
    end

    if self._ChargePhase == 1 then
        if not self.Owner:KeyDown(key) then
            if C.Mode == "hold" or C.Mode == "stream" then
                self:_CancelCharge()
                return
            end
        end
    
        if t < self._ChargeTimer then return end
    
        self._ChargePhase = 2
        local played = PlayAnim(self, "charge_fire")
        self:SetIdleTime(0)
        return
    end

    if self._ChargePhase == 2 then
        if C.Mode == "stream" then
            if not self.Owner:KeyDown(key) then
                self:_CancelCharge()
                return
            end
        elseif C.Mode == "hold" then
            if not self.Owner:KeyDown(key) then
                self:_FireCharge()
            end
        else
            self:_FireCharge()
        end
        return
    end

    if self._ChargePhase == 3 then
        if t < self._ChargeTimer then return end
        self._ChargePhase = 0
        self:SetIsCharging(false)
        self:SetChargeEndTime(0)
        self:SetIdleTime(t + 0.05)
    end
end

function SWEP:_FireCharge()
    self._ChargePhase = 3
    self:TakePrimaryAmmo(1)
    self.Owner:SetAnimation(PLAYER_ATTACK1)

    local entry = PlayAnim(self, "charge_fire")
    local vm    = GetVM(self)
    local dur   = GetAnimDuration(self, entry) or (IsValid(vm) and vm:SequenceDuration()) or 0.5

    self._ChargeTimer = CurTime() + dur
    self:SetChargeEndTime(CurTime() + dur)
    self:SetNextPrimaryFire(CurTime() + dur)
    self:SetIdleTime(0)
end

function SWEP:_CancelCharge()
    self:OnChargeEnd()
    self._ChargePhase = 0
    self._ChargeTimer = 0
    self:SetIsCharging(false)
    self:SetChargeEndTime(0)
    self:SetIdleTime(CurTime() + 0.05)
    self._LastMoveState = nil
end

function SWEP:EnterADS()
    self:SetIsADSActive(true)
    self:SetInspectEndTime(0)
    self._LastMoveState = nil  
    self:PlayIdle()            
    if self.Sounds.enterads and self.Sounds.enterads ~= "" then
        self:EmitSound(self.Sounds.enterads)
    end
    local entry = PlayAnim(self, "ads")
    if entry then
        local dur = GetAnimDuration(self, entry) or 0.3
        self:SetIdleTime(CurTime() + dur)
    end
end

function SWEP:ExitADS()
    self:SetIsADSActive(false)
    self._LastMoveState = nil
    if self.Sounds.exitads and self.Sounds.exitads ~= "" then
        self:EmitSound(self.Sounds.exitads)
    end
    local entry = PlayAnim(self, "ads_out")
    if entry then
        local dur = GetAnimDuration(self, entry) or 0.3
        self:SetIdleTime(CurTime() + dur)
    end
end

function SWEP:HandleADS()
    if not SERVER then return end
    if not self.Keys or not self.Keys.ads then return end
    if self._convarADS and not self._convarADS:GetBool() then return end
        
    if self.ADSHoldToAim then
        local held = self:KDown("ads")
        if held and not self:IsADS() then
            if self:IsReloading() then return end
            if self:IsPLReloading() then return end
            self:EnterADS()
        elseif not held and self:IsADS() then
            self:ExitADS()
        end
    else
        if not self:KPressed("ads") then return end
        if self:IsADS() then
            self:ExitADS()
        else
            if self:IsReloading() then return end
            if self:IsPLReloading() then return end
            self:EnterADS()
        end
    end
end

function SWEP:HandleThrowing()
    if not SERVER then return end
    local T = self.Throwing
    if not T then return end

    local t = CurTime()

    -- phase 1: prep anim playing, waiting for it to finish
    if self._Throw_Phase == 1 then
        if t >= self._Throw_PrepEnd then
            self._Throw_Phase = 2
            -- freeze on last frame of prep anim, cooking starts now
            self._Throw_CookStart = t
        end
        return
    end

    -- phase 2: cooked and ready, waiting for key release
    if self._Throw_Phase == 2 then
        local holdTime = T.HoldTime or 0
        local mode     = self._Throw_Mode

        local keyDown
        if mode == 1 then
            local key = T.Throw and T.Throw.Key or IN_ATTACK
            keyDown = IsINKey(key) and self.Owner:KeyDown(key) or self:KDown("_throw")
        else
            local key = T.Lob and T.Lob.Key or IN_ATTACK2
            keyDown = IsINKey(key) and self.Owner:KeyDown(key) or self:KDown("_lob")
        end

        -- auto release if cook time exceeded
        if holdTime > 0 and t >= self._Throw_CookStart + holdTime then
            keyDown = false
        end

        if not keyDown then
            -- release — play throw anim and spawn entity
            local animName
            if mode == 1 then
                animName = "throw_fire"
            elseif mode == 2 then
                animName = "lob_fire"
            else
                animName = "roll_fire"
            end

            local entry = PlayAnim(self, animName)
            local vm    = GetVM(self)
            local dur   = GetAnimDuration(self, entry) or (IsValid(vm) and vm:SequenceDuration()) or 0.5

            self._Throw_Phase      = 3
            self._Throw_ReleaseEnd = t + dur
            self:SetThrowReleaseEnd(t + dur)
            self:SetNextPrimaryFire(t + dur)
            self:SetNextSecondaryFire(t + dur)
            self:SetIdleTime(t + dur)
            self._LastMoveState = nil

            self:DoThrowEntity(mode)

            -- consume ammo
            if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
                self.Owner:RemoveAmmo(1, self.Primary.Ammo)
            end

            self.Owner:SetAnimation(PLAYER_ATTACK1)
        end
        return
    end

    -- phase 3: throw anim playing, waiting to finish
    if self._Throw_Phase == 3 then
        if t >= self._Throw_ReleaseEnd then
            if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
                local entry = PlayAnim(self, "draw")
                local vm    = GetVM(self)
                local dur   = GetAnimDuration(self, entry) or (IsValid(vm) and vm:SequenceDuration()) or 1.0
                self._Throw_Phase      = 4  -- stay locked during draw
                self._Throw_ReleaseEnd = t + dur
                self:SetThrowPhase(4)
                self:SetNextPrimaryFire(t + dur)
                self:SetNextSecondaryFire(t + dur)
                self:SetIdleTime(t + dur)
            else
                self._Throw_Phase = 0
                self:SetThrowPhase(0)
                self:SetIdleTime(t + 0.1)
            end
            self._LastMoveState = nil
        end
        return
    end

    -- phase 4: post-throw draw anim playing
    if self._Throw_Phase == 4 then
        if t >= self._Throw_ReleaseEnd then
            self._Throw_Phase = 0
            self:SetThrowPhase(0)
            self:SetIdleTime(t + 0.1)
            self._LastMoveState = nil
        end
        return
    end

    -- phase 0: idle, check for input
    if not self:CanDo("throwing") then return end
    if self:GetIsLowered() or self:IsLoweringOrRaising() then return end
    if CurTime() < self:GetDrawEndTime() then return end

    local throwKey = T.Throw and T.Throw.Key or IN_ATTACK
    local lobKey   = T.Lob   and T.Lob.Key   or IN_ATTACK2

    local throwPressed = IsINKey(throwKey)
        and self.Owner:KeyPressed(throwKey)
        or self:KPressed("_throw")

    local lobPressed = IsINKey(lobKey)
        and self.Owner:KeyPressed(lobKey)
        or self:KPressed("_lob")

    local mode = nil
    if throwPressed then
        mode = 1
    elseif lobPressed then
        -- roll if crouching, lob otherwise
        mode = self.Owner:Crouching() and 3 or 2
    end

    if not mode then return end

    -- check ammo before starting throw
    if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
        self:PlayEmpty()
        return
    end

    -- start prep phase
    self._Throw_Phase = 1
    self._Throw_Mode  = mode
    self:SetThrowPhase(1)

    local animName
    if mode == 1 then
        animName = "throw_prep"
    elseif mode == 2 then
        animName = "lob_prep"
    else
        animName = "roll_prep"
    end

    local entry = PlayAnim(self, animName)
    local vm    = GetVM(self)
    local dur   = GetAnimDuration(self, entry) or (IsValid(vm) and vm:SequenceDuration()) or 0.5

    self._Throw_PrepEnd = t + dur
    self:SetThrowPrepEnd(t + dur)
    self:SetNextPrimaryFire(t + dur)
    self:SetNextSecondaryFire(t + dur)
    self:SetIdleTime(0)
    self._LastMoveState = nil

    if T.Sound and T.Sound ~= "" then
        self:EmitSound(T.Sound)
    end
end

function SWEP:DoThrowEntity(mode)
    if not SERVER then return end
    local T   = self.Throwing
    local ply = self.Owner

    if not T.Entity or T.Entity == "" then return end

    local ent = ents.Create(T.Entity)
    if not IsValid(ent) then return end

    local cfg = (mode == 1 and T.Throw) or (mode == 2 and T.Lob) or T.Roll or {}

    -- hull trace to prevent spawning inside walls
    local spawnDir = (ply:GetForward() + Vector(0, 0, 0.1)):GetNormalized()
    local spawnPos = LocalToWorld(Vector(18, -8, 0), angle_zero, ply:GetShootPos(), ply:GetAimVector():Angle())
    local tr = util.TraceHull({
        start  = ply:EyePos(),
        endpos = spawnPos,
        mins   = Vector(-4, -4, -4),
        maxs   = Vector( 4,  4,  4),
        filter = ply,
    })
    spawnPos = tr.Hit and tr.HitPos or spawnPos

    ent:SetPos(spawnPos)
    ent:SetOwner(ply)
    ent:Spawn()
    ent:Activate()

    if T.Timer then
        ent:Input("settimer", ply, ply, tostring(T.Timer))
    end

    local phys = ent:GetPhysicsObject()
    if not IsValid(phys) then return end

    local force = cfg.Force or 1200
    local spin  = cfg.Spin  or Vector(600, 0, 0)

    if mode == 1 then
        -- throw: forward with slight upward bias
        local arcBias = cfg.ArcBias or 0.1
        phys:SetVelocity(ply:GetVelocity() + (ply:GetForward() + Vector(0, 0, arcBias)) * force)
        phys:AddAngleVelocity(Vector(spin.x, math.random(-spin.y, spin.y) ~= 0 and math.random(-spin.y, spin.y) or 0, spin.z))

    elseif mode == 2 then
        -- lob: reduced forward, more upward
        local arcBias = cfg.ArcBias or 50
        phys:SetVelocity(ply:GetVelocity() + (ply:GetForward() * force) + Vector(0, 0, arcBias))
        phys:AddAngleVelocity(Vector(spin.x, math.random(-200, 200), spin.z))

    elseif mode == 3 then
        -- roll: ground hugging with surface normal detection
        local pos    = ply:GetPos() + Vector(0, 0, 4)
        local facing = ply:GetAimVector()
        facing.z     = 0
        facing       = facing:GetNormalized()

        local groundTr = util.TraceLine({
            start  = pos,
            endpos = pos + Vector(0, 0, -16),
            filter = ply,
        })

        if groundTr.Fraction ~= 1 then
            local tan = facing:Cross(groundTr.Normal)
            facing    = groundTr.Normal:Cross(tan)
        end

        ent:SetPos(self:GetThrowPosition(ply:GetPos() + Vector(0, 0, 4) + facing * 18))
        ent:SetAngles(Angle(0, ply:GetAngles().y, -90))
        phys:SetVelocity(ply:GetVelocity() + facing * force)
        phys:AddAngleVelocity(Vector(0, 0, spin.z))
    end
end

function SWEP:GetThrowPosition(pos)
    local ply = self.Owner
    local tr  = util.TraceHull({
        start  = ply:EyePos(),
        endpos = pos,
        mins   = Vector(-4, -4, -4),
        maxs   = Vector( 4,  4,  4),
        filter = ply,
    })
    return tr.Hit and tr.HitPos or pos
end

function SWEP:HandleProjectileLauncher()
    local PL = self.ProjectileLauncher
    if not PL or not PL.Enabled then return end
    if PL.Type == "AR2Ball" then
        return self:HandleAR2BallLauncher()
    end
    if not SERVER then return end
    if CurTime() < self:GetDrawEndTime() then return end

    local key     = PL.Key or IN_ATTACK2
    local keyIsIN = IsINKey(key)

    local fired = keyIsIN
        and self.Owner:KeyPressed(key)
        or self:KPressed("_pl_fire")

    if fired then
        if self._PL_Reloading or self._PL_Fired then return end
        if CurTime() < self:GetNextSecondaryFire() then return end
        if not self._PL_Loaded then return end
        if not self:CanDo("secondary_fire") then return end
        if PL.AmmoType == self.Primary.Ammo and self:Clip1() <= 0 then return end
        if self:IsFiring() then return end
        if self:GetIsLowered() or self:IsLoweringOrRaising() then return end

        if PL.Sound and PL.Sound ~= "" then
            self:EmitSound(PL.Sound)
        end

        local shootDir = (self.Owner:EyeAngles() + self.Owner:GetViewPunchAngles()):Forward()
        local spawnPos = PL.Pos and PL.Pos(self) or self.Owner:GetShootPos() + shootDir * 32
        local spawnAng = PL.Ang and PL.Ang(self) or self.Owner:EyeAngles()
        local proj = ents.Create(PL.Entity)
        if IsValid(proj) then
            proj:SetPos(spawnPos)
            proj:SetAngles(spawnAng)
            proj:SetOwner(self.Owner)
            proj:SetVelocity(shootDir * (PL.Velocity or 800))
            proj:Spawn()
            proj:Activate()
        end

        self.Owner:RemoveAmmo(1, PL.AmmoType)

        local played = PlayAnim(self, "secondary_fire")
        if not played then self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK) end

        self.Owner:SetAnimation(PLAYER_ATTACK1)
        if PL.Recoil and PL.Recoil > 0 then
            self.Owner:ViewPunch(Angle(-PL.Recoil, 0, 0))
        end

        self._PL_Loaded   = false
        self._PL_Fired    = true
        self._PL_FireTime = CurTime()

        self._LastMoveState = nil

        local fireTime = PL.FireTime or 0.7
        self:SetNextSecondaryFire(CurTime() + fireTime)
        self:SetIdleTime(CurTime() + fireTime)
    end

    if self._PL_Fired then
        local fireTime = PL.FireTime or 0.7
        if CurTime() >= self._PL_FireTime + fireTime then
            self._PL_Fired = false
            if PL.ReloadTime and self.Owner:GetAmmoCount(PL.AmmoType) > 0 then
                local reloadEntry = PlayAnim(self, "secondary_reload")
                local reloadDur   = GetAnimDuration(self, reloadEntry) or PL.ReloadTime
                if self:IsADS() then self:ExitADS() end
                self._PL_Reloading = true
                self._PL_ReloadEnd = CurTime() + reloadDur
                self:SetIdleTime(CurTime() + reloadDur)
            end
        end
    end

    if self._PL_Reloading and CurTime() >= self._PL_ReloadEnd then
        self._PL_Reloading = false
        if IsValid(self.Owner) and self.Owner:GetAmmoCount(PL.AmmoType) > 0 then
            self._PL_Loaded = true
        end
        self:SetIdleTime(CurTime() + 0.1)
    end

    if not self._PL_Loaded and not self._PL_Reloading and not self._PL_Fired then
        if IsValid(self.Owner) and self.Owner:GetAmmoCount(PL.AmmoType) > 0 then
            self._PL_Loaded = true
        end
    end
end

function SWEP:HandleAR2BallLauncher()
    local PL = self.ProjectileLauncher
    if not PL or PL.Type ~= "AR2Ball" then return end
    if not SERVER then return end
    if CurTime() < self:GetDrawEndTime() then return end

    -- Timer: finish loading
    if self.PL_IsReloading and self.PL_LoadEnd and CurTime() >= self.PL_LoadEnd then
        self.PL_SecondaryLoad = true
        self.PL_IsReloading   = false
        self.PL_LoadEnd       = 0
        self._LastMoveState   = nil
    end

    -- Ammo depletion check
    if IsValid(self.Owner) and self.Owner:GetAmmoCount(PL.AmmoType or "AR2AltFire") <= 0 then
        self.PL_SecondaryLoad = false
    end

    -- Timer: fire pending
    if self.PL_FirePending and CurTime() >= self.PL_FireTime then
        self.PL_FirePending = false
        if not IsValid(self.Owner) then return end

        -- deduct ammo at actual fire time
        self.Owner:RemoveAmmo(1, PL.AmmoType or "AR2AltFire")  -- ADD HERE

        self.Owner:ViewPunch(Angle(PL.Recoil, 0, 0))
        self:EmitSound(PL.FireSound or "weapons/irifle/irifle_fire2.wav")
        local entry   = PlayAnim(self, "secondary_fire")
        local vm      = GetVM(self)
        local animDur = GetAnimDuration(self, entry) or (IsValid(vm) and vm:SequenceDuration()) or 1.0

        local cball = ents.Create("point_combine_ball_launcher")
        if IsValid(cball) then
            cball:SetPos(self.Owner:GetShootPos() + self.Owner:EyeAngles():Forward() * 64)
            cball:Spawn()
            local cfg = PL.BallConfig or {}
            cball:SetKeyValue("ballrespawntime", tostring(cfg.RespawnTime or -1))
            cball:SetKeyValue("maxballbounces",  tostring(cfg.MaxBounces  or 5))
            cball:SetKeyValue("maxspeed",        tostring(cfg.MaxSpeed    or 1000))
            cball:SetKeyValue("minspeed",        tostring(cfg.MinSpeed    or 1000))
            cball:SetKeyValue("angles",          tostring(self.Owner:EyeAngles()))
            cball:Fire("launchBall", "", 0)
        end

        self.PL_PrepFire      = false
        self.PL_SecondaryLoad = false
        self._LastMoveState   = nil
        self._PL_LastFireTime = CurTime()
        self:SetNextPrimaryFire(CurTime() + 2)
        self:SetNextSecondaryFire(CurTime() + 2)
        self.PL_SecCooldown   = 0
        self:SetIdleTime(CurTime() + animDur)
        return
    end

    -- Input handling
    local key     = PL.Key or MOUSE_MIDDLE
    local keyIsIN = IsINKey(key)
    local fired   = keyIsIN
        and self.Owner:KeyPressed(key)
        or self:KPressed("_pl_fire")

    if not fired then return end

    if not self:CanDo("secondary_fire") then return end
    if self.Owner:WaterLevel() >= 3 then return end

    local ammo = self.Owner:GetAmmoCount(PL.AmmoType or "AR2AltFire")

    -- Not loaded yet — start loading
    if not self.PL_SecondaryLoad and not self.PL_IsReloading and ammo > 0 then
        local entry   = PlayAnim(self, "secondary_reload")
        local vm      = GetVM(self)
        local animDur = GetAnimDuration(self, entry) or (IsValid(vm) and vm:SequenceDuration()) or 2.25

        -- if no reload anim, skip straight to loaded, NO ammo deduction yet
        if not entry then
            self.PL_SecondaryLoad = true
            self._LastMoveState   = nil
            return  -- removed RemoveAmmo from here
        end

        self.PL_IsReloading = true
        self._LastMoveState = nil
        self:SetNextPrimaryFire(CurTime() + animDur)
        self.PL_LoadEnd     = CurTime() + animDur
        self:SetIdleTime(CurTime() + animDur)
        return
    end

    -- Loaded and ready — prep fire
    if self.PL_SecondaryLoad and not self.PL_IsReloading and self.PL_SecCooldown == 0 then
        if not self.PL_PrepFire then
            local entry   = PlayAnim(self, "secondary_fire_prep")
            local vm      = GetVM(self)
            local animDur = GetAnimDuration(self, entry) or (IsValid(vm) and vm:SequenceDuration()) or 2.25
            self:SetNextPrimaryFire(CurTime() + animDur)
            self:SetIdleTime(CurTime() + animDur)
            self.PL_PrepFire    = true
            self.PL_SecCooldown = 1
            self.PL_FirePending = true
            self.PL_FireTime    = CurTime() + animDur
            self:EmitSound(PL.ChargeSound or "weapons/cguard/charging.wav")
        end
    end
end

function SWEP:HandleBolt()
    if not SERVER then return end
    if not self.IsBoltAction then return end
    if not self:IsBolting() then return end
    if self._BoltAnimDone then return end
    if self:Clip1() <= 0 then return end

    local fireAnimEnd = self:GetBoltEndTime() - self.BoltTime
    if CurTime() < fireAnimEnd then return end

    self._BoltAnimDone = true
    local played = PlayAnim(self, "bolt")
    if not played then self.Weapon:SendWeaponAnim(ACT_SHOTGUN_PUMP) end
    if self.BoltSound and self.BoltSound ~= "" then
        self:EmitSound(self.BoltSound)
    end
end

function SWEP:HandlePhasedReload()
    if not SERVER then return end
    local PR = self.PhasedReload
    if not PR then return end
    if self._PR_Phase == 0 then return end

    local t = CurTime()

    if self._PR_Phase == 2 and not self._PR_InsertSoundPlayed and PR.InsertSound and PR.InsertSound ~= "" then
        local delay = PR.InsertSoundDelay or 0
        if t >= self._PR_InsertStartTime + delay then
            self:EmitSound(PR.InsertSound)
            self._PR_InsertSoundPlayed = true
        end
    end

    if self._PR_Phase == 1 and t >= self._PR_Timer then
        self._PR_Phase = 2
        local insertEntry = PlayAnim(self, "reload_insert")
        local dur = GetAnimDuration(self, insertEntry) or PR.InsertTime or 1.0
        self._PR_Timer             = t + dur
        self._PR_InsertStartTime   = t
        self._PR_InsertSoundPlayed = false
        return
    end

    if self._PR_Phase == 2 and t >= self._PR_Timer then
        local reserve = self.Owner:GetAmmoCount(self.Primary.Ammo)
        if reserve > 0 and self:Clip1() < self.Primary.ClipSize then
            self:SetClip1(self:Clip1() + 1)
            self.Owner:SetAmmo(reserve - 1, self.Primary.Ammo)
            self.Owner:SetAnimation(PLAYER_RELOAD)
        end

        if self:Clip1() < self.Primary.ClipSize
        and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
            local insertEntry = PlayAnim(self, "reload_insert")
            local dur = GetAnimDuration(self, insertEntry) or PR.InsertTime or 1.0
            self._PR_Timer             = t + dur
            self._PR_InsertStartTime   = t
            self._PR_InsertSoundPlayed = false
        else
            self._PR_Phase = 3
            if self._PR_NoBolt and PR.NoBoltAnim then
                local noBoltEntry = PlayAnim(self, "reload_end_nobolt")
                local dur = GetAnimDuration(self, noBoltEntry) or PR.NoBoltTime or PR.FinishTime or 0.5
                self._PR_Timer = t + dur
            else
                local finishEntry = PlayAnim(self, "reload_end")
                if PR.FinishSound and PR.FinishSound ~= "" then
                    self:EmitSound(PR.FinishSound)
                end
                local dur = GetAnimDuration(self, finishEntry) or PR.FinishTime or 0.5
                self._PR_Timer = t + dur
            end
            self:SetNextPrimaryFire(t + (self._PR_Timer - t))
        end
        return
    end

    if self._PR_Phase == 3 and t >= self._PR_Timer then
        self._PR_Phase  = 0
        self._PR_Timer  = 0
        self._PR_NoBolt = false
        self:SetIdleTime(t + 0.1)
    end
end

function SWEP:HandleLowered()
    if not SERVER then return end

    if self:IsLoweringOrRaising() then
        if CurTime() < self:GetLoweredTransitionEnd() then return end
        self:SetLoweredTransitionEnd(0)
        if self:GetIsLowered() then
            local entry = PlayAnim(self, "lowered")
            if entry then self:SetIdleTime(0) end
        else
            self:SetIdleTime(CurTime() + 0.05)
        end
        return
    end

    if not self:CanDo("lowered") then return end
    if not self:KPressed("lowered") then return end
    if self:IsADS() then self:ExitADS() end

    if self:GetIsLowered() then
        self:SetIsLowered(false)
        self._LastMoveState = nil
        local entry = PlayAnim(self, "lowered_off")
        if entry then
            local vm       = GetVM(self)
            local duration = GetAnimDuration(self, entry) or (IsValid(vm) and vm:SequenceDuration()) or 0.5
            self:SetLoweredTransitionEnd(CurTime() + duration)
            self:SetIdleTime(0)
        end
    else
        self:SetIsLowered(true)
        self._LastMoveState = nil
        local entry = PlayAnim(self, "lowered_on")
        if entry then
            local vm       = GetVM(self)
            local duration = GetAnimDuration(self, entry) or (IsValid(vm) and vm:SequenceDuration()) or 0.5
            self:SetLoweredTransitionEnd(CurTime() + duration)
            self:SetIdleTime(0)
        end
    end
end

function SWEP:HandleInspect()
    if not SERVER then return end

    if self:IsInspecting() then
        if CurTime() >= self:GetInspectEndTime() then
            self:SetInspectEndTime(0)
            self._LastMoveState   = nil
            self._LastInspectTime = CurTime()
            self:SetIdleTime(CurTime() + 0.05)
        end
        return
    end

    if not self:CanDo("inspecting") then return end
    if self:IsADS() then return end
    if self:GetIsLowered() or self:IsLoweringOrRaising() then return end
    if not self.Keys or not self.Keys.inspect then return end
    if not self:KPressed("inspect") then return end

    if self:Clip1() <= 0 then
        local hasFireEmpty    = GetAnimEntry(self, "fire_empty") ~= nil
        local hasInspectEmpty = GetAnimEntry(self, "inspect_empty") ~= nil
        if hasFireEmpty and not hasInspectEmpty then return end
    end

    local entry    = PlayAnim(self, "inspect")  -- PlayAnim returns the entry it played
    if not entry then return end
    
    local vm       = GetVM(self)
    local duration = GetAnimDuration(self, entry) or (IsValid(vm) and vm:SequenceDuration()) or 1.0
    
    self:SetInspectEndTime(CurTime() + duration)
    self:SetIdleTime(0)
end

function SWEP:HandleIdle()
    if not SERVER then return end
    if self:GetIdleTime() == 0 then return end
    if CurTime() < self:GetIdleTime() then return end
    self:SetIdleTime(0)
    local entry = PlayAnim(self, "idle")
    if not entry then self.Weapon:SendWeaponAnim(ACT_VM_IDLE) end
end

function SWEP:HandleFireTap()
    if not SERVER then return end
    if not self._WaitingForFireRelease then return end

    if not self.Owner:KeyDown(IN_ATTACK) then
        self._WaitingForFireRelease = false
        if self._FireAnimDur then
            self:SetIdleTime(CurTime() + self._FireAnimDur)
            self._FireAnimDur = nil
        end
    elseif CurTime() > self._FireTapWindow then
        self._WaitingForFireRelease = false
        self._FireAnimDur = nil
    end
end

function SWEP:DoMeleeAttack(key)
    if not self.MeleeAttacks then return end
    if not self:CanDo("melee") then return end
    if self:GetIsLowered() or self:IsLoweringOrRaising() then return end

    if key == IN_ATTACK2 then
        if CurTime() < self:GetNextSecondaryFire() then return end
    else
        if CurTime() < self:GetNextPrimaryFire() then return end
    end

    local pool = {}
    for _, atk in ipairs(self.MeleeAttacks) do
        if (atk.Key or IN_ATTACK) == key then
            pool[#pool + 1] = atk
        end
    end
    if #pool == 0 then return end

    self._MeleeCombo      = self._MeleeCombo or {}
    self._MeleeCombo[key] = ((self._MeleeCombo[key] or 0) % #pool) + 1
    local atk             = pool[self._MeleeCombo[key]]

    local vm = GetVM(self)
    if IsValid(vm) and atk.Seq and vm:LookupSequence(atk.Seq) ~= -1 then
        SendSeq(vm, atk.Seq)
    else
        self.Weapon:SendWeaponAnim(atk.Act or ACT_VM_PRIMARYATTACK)
    end

    if SERVER then
        self.Owner:SetAnimation(PLAYER_ATTACK1)
        if self:IsADS() then self:ExitADS() end
    end

    if atk.Sound and atk.Sound ~= "" then
        self:EmitSound(atk.Sound)
    end

    if atk.ViewPunch then
        self.Owner:ViewPunch(atk.ViewPunch)
    end

    self._MeleeLastKey = key
    self.MeleeHitFired = false
    self.MeleeHitTimer = CurTime() + (atk.Delay or 0.2)
    self.MeleeEndTimer = CurTime() + (atk.End   or 0.5)
    self.LastMeleeTime = CurTime()
    self._LastMoveState = nil

    if key == IN_ATTACK2 then
        self:SetNextSecondaryFire(self.MeleeEndTimer)
    else
        self:SetNextPrimaryFire(self.MeleeEndTimer)
    end

    self:SetInspectEndTime(0)
    self._LastInspectTime = CurTime()
    self:SetIdleTime(self.MeleeEndTimer)
end

function SWEP:DoMeleeTrace(atk)
    if not SERVER then return end
    local owner     = self.Owner
    local src       = owner:GetShootPos()
    local fwd       = owner:EyeAngles():Forward()
    local right     = owner:EyeAngles():Right()
    local precision = 9
    local length    = atk.Length or 55
    local hull      = atk.Hull   or 10
    local scl       = hull / 2
    local traceSrc  = src - fwd * 5

    local centerTr = util.TraceLine({
        start  = src,
        endpos = src + fwd * length,
        filter = owner,
        mask   = MASK_SHOT_HULL,
    })

    local tr = {
        start  = traceSrc,
        mins   = Vector(-scl, -scl, -scl),
        maxs   = Vector( scl,  scl,  scl),
        filter = owner,
        mask   = MASK_SHOT_HULL,
    }

    local forceDir = fwd
    if atk.DamageDir then
        local eyeAng = owner:EyeAngles()
        forceDir = Angle(eyeAng.p + atk.DamageDir.p, eyeAng.y + atk.DamageDir.y, 0):Forward()
    elseif atk.ViewPunch then
        local eyeAng = owner:EyeAngles()
        forceDir = Angle(eyeAng.p + atk.ViewPunch.p, eyeAng.y + atk.ViewPunch.y, 0):Forward()
    end

    local dmginfo = DamageInfo()
    dmginfo:SetDamage(atk.Damage or 50)
    dmginfo:SetDamageType(atk.DmgType or DMG_SLASH)
    dmginfo:SetDamageForce(forceDir * (atk.Force or 5) * 500)
    dmginfo:SetAttacker(owner)
    dmginfo:SetInflictor(self)

    local results = {}
    for i = 1, precision do
        local t           = (i - 0.5) / precision
        local swingOffset = LerpVector(t, -right * hull, right * hull)
        tr.endpos         = traceSrc + fwd * (length + 5) + swingOffset
        local res         = util.TraceLine(tr)
        table.insert(results, res)
    end

    local function doDecal(res)
        local decalPos = (centerTr.Hit and centerTr.HitPos) or res.HitPos
        local decalNrm = (centerTr.Hit and centerTr.HitNormal) or res.HitNormal
        local ed = EffectData()
        ed:SetOrigin(decalPos)
        ed:SetStart(src)
        ed:SetSurfaceProp(res.SurfaceProps)
        ed:SetDamageType(atk.DmgType or DMG_SLASH)
        ed:SetHitBox(res.HitBox)
        ed:SetEntity(res.Entity)
        util.Effect("Impact", ed)
        if not (IsValid(res.Entity) and (res.Entity:IsNPC() or res.Entity:IsPlayer() or res.Entity:IsRagdoll())) then
            util.Decal(atk.HitDecal or "ManhackCut", decalPos + decalNrm, decalPos - decalNrm)
        end
    end

    local function isFlesh(res)
        return res.MatType == MAT_FLESH
            or res.MatType == MAT_ALIENFLESH
            or (IsValid(res.Entity) and (res.Entity:IsNPC() or res.Entity:IsPlayer() or res.Entity:IsRagdoll()))
    end

    local hitFlesh    = false
    local hitNonWorld = false
    local hitWorld    = false
    local fleshHits   = 0

    for _, res in ipairs(results) do
        if res.Hit and IsValid(res.Entity) and isFlesh(res) and not res.Entity._kenni_melee_hit then
            dmginfo:SetDamagePosition(res.HitPos)
            res.Entity:TakeDamageInfo(dmginfo)
            local ed = EffectData()
            ed:SetOrigin(res.HitPos)
            ed:SetNormal(res.HitNormal)
            ed:SetEntity(res.Entity)
            ed:SetDamageType(DMG_SLASH)
            util.Effect("BloodImpact", ed)
            res.Entity:SetVelocity(forceDir * (atk.Force or 5) * 10)
            res.Entity._kenni_melee_hit = true
            doDecal(res)
            fleshHits = fleshHits + 1
            hitFlesh  = true
            if atk.HitFlesh and atk.HitFlesh ~= "" then self:EmitSound(atk.HitFlesh) end
            if fleshHits >= 3 then break end
        end
    end

    if not hitFlesh then
        for _, res in ipairs(results) do
            if res.Hit and not res.HitWorld and IsValid(res.Entity) and not isFlesh(res) and not res.Entity._kenni_melee_hit then
                dmginfo:SetDamagePosition(res.HitPos)
                res.Entity:TakeDamageInfo(dmginfo)
                res.Entity._kenni_melee_hit = true
                doDecal(res)
                hitNonWorld = true
                if atk.HitWorld and atk.HitWorld ~= "" then self:EmitSound(atk.HitWorld) end
                break
            end
        end
    end

    if not hitFlesh and not hitNonWorld then
        for _, res in ipairs(results) do
            if res.Hit and res.HitWorld and not hitWorld then
                hitWorld = true
                doDecal(res)
                if atk.HitWorld and atk.HitWorld ~= "" then self:EmitSound(atk.HitWorld) end
                break
            end
        end
    end

    for _, res in ipairs(results) do
        if IsValid(res.Entity) then
            res.Entity._kenni_melee_hit = false
        end
    end
end

function SWEP:HandleMeleeLogic()
    if not self.MeleeAttacks then return end
    if not SERVER then return end
    if self.MeleeHitFired then return end
    if self.MeleeHitTimer == 0 then return end
    if CurTime() < self.MeleeHitTimer then return end

    self.MeleeHitFired = true

    local key  = self._MeleeLastKey or IN_ATTACK
    local idx  = (self._MeleeCombo or {})[key] or 1
    local pool = {}
    for _, a in ipairs(self.MeleeAttacks) do
        if (a.Key or IN_ATTACK) == key then
            pool[#pool + 1] = a
        end
    end

    local atk = pool[idx]
    if atk then self:DoMeleeTrace(atk) end

    if CurTime() >= self.MeleeEndTimer then
        self.MeleeEndTimer = 0
        self.MeleeHitTimer = 0
    end
end

function SWEP:PrimaryAttack()
    if self.MeleeAttacks then
        for _, atk in ipairs(self.MeleeAttacks) do
            if (atk.Key or IN_ATTACK) == IN_ATTACK then
                self:DoMeleeAttack(IN_ATTACK)
                return
            end
        end
    end

    if self:Clip1() <= 0 then
        self:PlayEmpty()
        return
    end
    if self.Charge then return end
    if self:GetIsLowered() or self:IsLoweringOrRaising() then return end

    local mode = self.Primary.FireMode or "semi"

    if mode == "burst" then
        if self._Burst_Active then return end
        if CurTime() < self:GetNextPrimaryFire() then return end
        if self._PR_Phase > 0 then
            self._PR_Phase  = 0
            self._PR_Timer  = 0
            self._PR_NoBolt = false
            self._PR_InsertStartTime   = 0
            self._PR_InsertSoundPlayed = false
            self:SetNextPrimaryFire(CurTime())
            self:SetNextSecondaryFire(CurTime())
        end
        self._Burst_Active    = true
        self._Burst_ShotsLeft = self.Primary.BurstCount or 3
        self._Burst_NextShot  = CurTime()
        return
    end

    if self._PR_Phase > 0 then
        self._PR_Phase  = 0
        self._PR_Timer  = 0
        self._PR_NoBolt = false
        self._PR_InsertStartTime   = 0
        self._PR_InsertSoundPlayed = false
        self:SetNextPrimaryFire(CurTime())
        self:SetNextSecondaryFire(CurTime())
    end

    self:SetInspectEndTime(0)

    local delay = self:IsADS() and (self.Primary.ADSDelay or self.Primary.Delay or 0.1) or (self.Primary.Delay or 0.1)

    self:TakePrimaryAmmo(1)
    self:SetNextPrimaryFire(CurTime() + delay)

    self._LastMoveState = nil
    self._LastFireTime  = CurTime()
    self:SetIdleTime(CurTime() + delay)

    if not IsFirstTimePredicted() then return end

    local entry    = PlayAnim(self, "fire")
    
    if SERVER then
        local vm          = GetVM(self)
        local fireDurLive = GetAnimDuration(self, entry) or (IsValid(vm) and vm:SequenceDuration()) or 0.5

        self:SetIdleTime(CurTime() + fireDurLive)

        if self.IsBoltAction then
            self:SetBoltEndTime(CurTime() + fireDurLive + self.BoltTime)
            self:SetNextPrimaryFire(CurTime() + fireDurLive + self.BoltTime)
            self:SetIdleTime(CurTime() + fireDurLive + self.BoltTime)
            self._BoltAnimDone = false
        end
        self.Owner:SetAnimation(PLAYER_ATTACK1)

        if self.ExitADSOnFire and self:IsADS() then
            self:ExitADS()
        end
    end
    self:PrimaryBullets()
end

function SWEP:HandleBurstFire()
    if not SERVER then return end
    if self.Primary.FireMode ~= "burst" then return end
    if not self._Burst_Active then return end

    if CurTime() < self._Burst_NextShot then return end

    if self:Clip1() <= 0 or self._Burst_ShotsLeft <= 0 then
        self._Burst_Active    = false
        self._Burst_ShotsLeft = 0
        local cooldown = self.Primary.BurstCooldown or 0.4
        self:SetNextPrimaryFire(CurTime() + cooldown)
        self:SetNextSecondaryFire(CurTime() + cooldown)
        self:SetIdleTime(CurTime() + cooldown)
        return
    end

    self:TakePrimaryAmmo(1)
    self._Burst_ShotsLeft = self._Burst_ShotsLeft - 1
    self._LastFireTime    = CurTime()
    self._LastMoveState   = nil

    local entry    = PlayAnim(self, "fire")
    local vm       = GetVM(self)
    local animDur  = GetAnimDuration(self, entry) or (IsValid(vm) and vm:SequenceDuration()) or 0.3

    self:SetLastFireTime(CurTime())
    self:SetIdleTime(CurTime() + animDur)
    self.Owner:SetAnimation(PLAYER_ATTACK1)

    self:PrimaryBullets()

    local delay = self.Primary.BurstDelay or 0.08
    self._Burst_NextShot = CurTime() + delay
    self:SetNextPrimaryFire(CurTime() + delay)
    self:SetNextSecondaryFire(CurTime() + delay)
    self:SetSecondaryFireEndTime(CurTime() + delay)
end

function SWEP:SecondaryAttack()
    if self.MeleeAttacks then
        for _, atk in ipairs(self.MeleeAttacks) do
            if (atk.Key or IN_ATTACK) == IN_ATTACK2 then
                self:DoMeleeAttack(IN_ATTACK2)
                return
            end
        end
    end
    if self.ProjectileLauncher and self.ProjectileLauncher.Enabled then return end
    if not self:CanDo("secondary_fire") then return end
    if self:Clip2() <= 0 then return end
    if not IsFirstTimePredicted() then return end

    local entry    = PlayAnim(self, "secondary_fire")
    if not entry then return end

    local vm       = GetVM(self)
    local duration = GetAnimDuration(self, entry) or (IsValid(vm) and vm:SequenceDuration()) or 0.5

    self:TakeSecondaryAmmo(1)
    self:SetNextPrimaryFire(CurTime() + duration)
    self:SetNextSecondaryFire(CurTime() + duration)
    self:SetIdleTime(CurTime() + duration)

    if SERVER then
        self:SetSecondaryFireEndTime(CurTime() + duration)
        self.Owner:SetAnimation(PLAYER_ATTACK1)

        if self:Clip2() >= 1 then
            self._LastMoveState = nil
            local reloadEntry = GetAnimEntry(self, "secondary_reload")

            if reloadEntry then
                local reloadDur = GetAnimDuration(self, reloadEntry) or 1.5
                self:SetSecondaryReloadEndTime(CurTime() + duration + reloadDur)
                self:SetNextPrimaryFire(CurTime() + duration + reloadDur)
                self:SetNextSecondaryFire(CurTime() + duration + reloadDur)
                self:SetIdleTime(CurTime() + duration + reloadDur)
                self._SecReloadPending     = true
                self._SecReloadPendingAt   = CurTime() + duration
                self._SecReloadPendingAnim = "secondary_reload"
            end
        end
    end
end

function SWEP:HandleAltFire()
    if not SERVER then return end
    local AF = self.AltFire
    if not AF then return end
    if not self:KPressed("altfire") then return end
    if not self:CanDo("secondary_fire") then return end
    if self:GetIsLowered() or self:IsLoweringOrRaising() then return end
    if self:Clip1() < AF.AmmoCost then
        self:PlayEmpty()
        return
    end

    self:TakePrimaryAmmo(AF.AmmoCost)
    self._LastMoveState = nil
    self._LastFireTime  = CurTime()

    local entry    = PlayAnim(self, "secondary_fire")
    local vm       = GetVM(self)
    local dur      = GetAnimDuration(self, entry) or (entry and IsValid(vm) and vm:SequenceDuration()) or AF.Cooldown or 0.5

    self:SetNextPrimaryFire(CurTime() + dur)
    self:SetNextSecondaryFire(CurTime() + dur)
    self:SetSecondaryFireEndTime(CurTime() + dur)
    self:SetIdleTime(CurTime() + dur)

    if self.IsBoltAction then
        self:SetBoltEndTime(CurTime() + dur + self.BoltTime)
        self:SetNextPrimaryFire(CurTime() + dur + self.BoltTime)
        self:SetNextSecondaryFire(CurTime() + dur + self.BoltTime)
        self:SetIdleTime(CurTime() + dur + self.BoltTime)
        self._BoltAnimDone = false
    end

    local spreadMult = AF.SpreadMult or 1.0
    local recoilMult = AF.RecoilMult or 1.0
    local eyeMult    = AF.EyeAngleRecoilMult or 1.0
    local spread     = self:GetCurrentSpread() * spreadMult

    self.Owner:FireBullets({
        Num        = AF.NumShots or self.Primary.NumShots or 1,
        Src        = self.Owner:GetShootPos(),
        Dir        = self.Owner:GetAimVector()
            - self.Owner:EyeAngles():Right() * self.Owner:GetViewPunchAngles().y * 0.025
            - self.Owner:EyeAngles():Up()    * self.Owner:GetViewPunchAngles().x * 0.025,
        Spread     = Vector(spread, spread, 0),
        Tracer     = 1,
        TracerName = self.Primary.TracerName or nil,
        Force      = self.Primary.Force or 500,
        Damage     = (self:IsADS() and self.Primary.ADSDamage or nil) or self.Primary.Damage or 10,
        AmmoType   = self.Primary.Ammo,
    })

    local sound = AF.Sound or self.Primary.Sound
    if sound and sound ~= "" then
        self:EmitSound(sound)
    end

    local adsMult = self:IsADS() and (self.Primary.ADSRecoilMult or 1.0) or 1.0
    if self.Primary.Recoil and self.Primary.Recoil > 0 then
        local cur = self.Owner:EyeAngles()
        self.Owner:SetEyeAngles(Angle(
            cur.p - self.Primary.EyeAngleRecoil * eyeMult * adsMult,
            cur.y + self.Primary.EyeAngleRecoil * eyeMult * adsMult * math.Rand(-0.5, 0.5),
            cur.r
        ))
        self.Owner:ViewPunchReset(15)
        self.Owner:ViewPunch(Angle(
            -self.Primary.Recoil * recoilMult * adsMult,
            self.Primary.Recoil * recoilMult * adsMult * math.Rand(-0.5, 0.5),
            0
        ))
    end

    self.Owner:SetAnimation(PLAYER_ATTACK1)
end

function SWEP:Reload()
    if not self.CanReload then return end
    if self:Clip1() >= self.Primary.ClipSize then return end
    if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then return end
    if not self:CanDo("reloading") then return end
    if self:GetIsLowered() or self:IsLoweringOrRaising() then return end
    if self:IsADS() then self:ExitADS() end
    if self:IsPLReloading() then return end

    self:SetInspectEndTime(0)
    self._LastMoveState = nil

    if self.PhasedReload then
        local PR         = self.PhasedReload
        local startEntry = PlayAnim(self, "reload_start")
        local dur        = GetAnimDuration(self, startEntry) or PR.StartTime or 0.5
        self._PR_Phase   = 1
        self._PR_Timer   = CurTime() + dur
        self._PR_NoBolt  = PR.TrackNoBolt and self:Clip1() > 0 or false
        self:SetNextPrimaryFire(CurTime() + dur)
        self:SetNextSecondaryFire(CurTime() + dur)
        self:SetIdleTime(0)
        if SERVER then self.Owner:SetAnimation(PLAYER_RELOAD) end
        return
    end

    local entry      = PlayAnim(self, "reload")
    if not entry then self.Weapon:SendWeaponAnim(ACT_VM_RELOAD) end
    local vm         = GetVM(self)
    local duration   = GetAnimDuration(self, entry) or (entry and IsValid(vm) and vm:SequenceDuration()) or 1.0

    self:SetNextPrimaryFire(CurTime() + duration)
    self:SetNextSecondaryFire(CurTime() + duration)
    self:SetIdleTime(CurTime() + duration)

    if SERVER then
        self._ReloadEndTime = CurTime() + duration
        self._ReloadGiven   = math.min(self.Owner:GetAmmoCount(self.Primary.Ammo), self.Primary.ClipSize - self:Clip1())
        self._ReloadReserve = self.Owner:GetAmmoCount(self.Primary.Ammo)
        self.Owner:SetAnimation(PLAYER_RELOAD)
    end
end

function SWEP:FinishReload()
    if not SERVER then return end
    if not self._ReloadEndTime or self._ReloadEndTime == 0 then return end
    if CurTime() < self._ReloadEndTime then return end

    self:SetClip1(self:Clip1() + self._ReloadGiven)
    self.Owner:SetAmmo(self._ReloadReserve - self._ReloadGiven, self.Primary.Ammo)
    self._ReloadEndTime = 0
    self._ReloadGiven   = 0
    self._ReloadReserve = 0
end

function SWEP:HandleSecondaryReloadPending()
    if not SERVER then return end
    if not self._SecReloadPending then return end
    if CurTime() < self._SecReloadPendingAt then return end

    self._SecReloadPending = false
    PlayAnim(self, self._SecReloadPendingAnim)
    self.Owner:SetAnimation(PLAYER_RELOAD)
    self._SecReloadPendingAnim = nil
end

function SWEP:FinishSecondaryReload()
    if not SERVER then return end
    if not self:IsSecondaryReloading() then return end
    if CurTime() < self:GetSecondaryReloadEndTime() then return end

    self:SetClip2(self.Secondary.ClipSize)
    self:SetSecondaryReloadEndTime(0)
end

function SWEP:PlayIdle()
    local entry = PlayAnim(self, "idle")
    if not entry then self.Weapon:SendWeaponAnim(ACT_VM_IDLE) end
    self:SetIdleTime(0)
end

function SWEP:HandleWalkSprint()
    if not SERVER then return end
    if CurTime() < self:GetDrawEndTime() then return end
    if self:GetIsLowered() or self:IsLoweringOrRaising() then return end
    if self:IsPostInspect() then return end
    if self:IsADS() then return end
    if self:GetCurrentPriority() > self._ActionPriority.idle then return end
    if self:IsFiring() then return end
    if self:IsPLReloading() then return end
    if self:IsPLFiringMove() then return end

    if self:IsOwnerSprinting() then
        if self._LastMoveState ~= "sprint" then
            local sprintEnabled = self._convarSprint == nil or self._convarSprint:GetBool()
            local entry = sprintEnabled and PlayAnim(self, "sprint") or nil
            if entry then
                self._LastMoveState = "sprint"
                self:SetIdleTime(0)
            else
                if self._LastMoveState ~= nil then
                    self._LastMoveState = nil
                    self:PlayIdle()
                end
            end
        end

    elseif self:IsOwnerWalking() then
        if self._LastMoveState ~= "walk" then
            local walkEnabled = self._convarWalk == nil or self._convarWalk:GetBool()
            local entry = walkEnabled and PlayAnim(self, "walk") or nil
            if entry then
                self._LastMoveState = "walk"
                self:SetIdleTime(0)
            else
                if self._LastMoveState ~= nil then
                    self._LastMoveState = nil
                    self:PlayIdle()
                end
            end
        end

    else
        if self._LastMoveState ~= nil then
            self._LastMoveState = nil
            self:PlayIdle()
        end
    end
end

function SWEP:Think()
    if not IsValid(self.Owner) then return end

    if SERVER then
        for _, name in ipairs(self._ThinkHandlers.server) do
            self[name](self)
        end
    end

    if CLIENT then
        for _, name in ipairs(self._ThinkHandlers.client) do
            self[name](self)
        end
    end

    for _, name in ipairs(self._ThinkHandlers.shared) do
        self[name](self)
    end
end

function SWEP:GetViewModelPosition(pos, ang)
    if not CLIENT then return pos, ang end

    local targetADS     = self:IsADS() and 1 or 0
    self._ADSProgress   = Lerp(FrameTime() * self.ADSSpeed, self._ADSProgress, targetADS)

    local dip             = math.sin(self._ADSProgress * math.pi) * self.ADSMidDip
    local targetOffset    = self:IsADS() and self.ADSOffset or self.VMOffset
    self._CurrentVMOffset = LerpVector(FrameTime() * self.ADSSpeed, self._CurrentVMOffset, targetOffset)

    pos = pos + ang:Right()   * self._CurrentVMOffset.x
    pos = pos + ang:Forward() * self._CurrentVMOffset.y
    pos = pos + ang:Up()      * (self._CurrentVMOffset.z + dip)

    return pos, ang
end

function SWEP:CalcViewModelView(vm, oldpos, oldang, pos, ang)
    if not CLIENT then return pos, ang end

    self:VM_TickMoveTilt()
    self:VM_TickJumpBob()
    self:VM_TickWalkBob()

    local angDiff = ang - (self._LastViewAng or ang)
    self._LastViewAng = Angle(ang.p, ang.y, ang.r)
    self._LaggedAngDiff = LerpAngle(FrameTime() * 5, self._LaggedAngDiff or Angle(0,0,0), angDiff)

    local swayScale = 0.4 * self._ADSProgress

    local normal_pos, normal_ang = self:GetViewModelPosition(pos, ang)

    local ads_pos, ads_ang = self:VM_ApplyBreath(oldpos, oldang, ang)
          ads_pos, ads_ang = self:VM_ApplyADSFx(ads_pos, ads_ang, ang)

    ads_ang.y = ads_ang.y - self._LaggedAngDiff.y * swayScale
    ads_ang.p = ads_ang.p - self._LaggedAngDiff.p * swayScale

    local final_pos = LerpVector(self._ADSProgress, normal_pos, ads_pos)
    local final_ang = LerpAngle(self._ADSProgress, normal_ang, ads_ang)

    return final_pos, final_ang
end

function SWEP:TranslateFOV(fov)
    if self._ADSProgress == 0 then return fov end
    return Lerp(self._ADSProgress, fov, fov * self.ADSFOVMult)
end

function SWEP:DoDrawCrosshair(x, y)
    if self:IsADS() then return true end
end

function SWEP:DrawHUD()
    if not CLIENT then return end
    if not self:IsADS() then return end
    if not self._scopeOverlayMat then return end

    render.SetMaterial(self._scopeOverlayMat)
    render.DrawScreenQuad()
end

function SWEP:FireAnimationEvent(pos, ang, event, options, source)
   local muzzleEvents = {
        [21] = true, 
        [5001] = true, 
        [5011] = true, 
        [5021] = true, 
        [5031] = true 
    }
    if not muzzleEvents[event] then return end

    local mf = self.MuzzleFlash1
    if mf == nil then return end

    if mf == false then return true end

    if type(mf) == "string" then
        local data = EffectData()
        data:SetFlags(0)
        data:SetEntity(self.Owner:GetViewModel())
        data:SetAttachment(math.floor((event - 4991) / 10))
        data:SetScale(1)
        util.Effect(mf, data)
        return true
    end

    if type(mf) == "table" then
        local vm = self.Owner:GetViewModel()
        if IsValid(vm) then
            ParticleEffectAttach(
                mf.particle,
                mf.attachType   or PATTACH_POINT_FOLLOW,
                vm,
                mf.attachmentID or 1
            )
        end
        return true
    end
end

function SWEP:DoImpactEffect(tr, damageType)
    if tr.HitSky then return end

    local ie = self.ImpactEffect
    if ie == nil then return end

    if ie == false then return true end

    if type(ie) == "string" then
        local data = EffectData()
        data:SetOrigin(tr.HitPos + tr.HitNormal)
        data:SetNormal(tr.HitNormal)
        util.Effect(ie, data)
    end

    if type(ie) == "table" then
        if ie.particle then
            ParticleEffect(ie.particle, tr.HitPos + tr.HitNormal, Angle(0, 0, 0))
        end

        if ie.effect then
            local data = EffectData()
            data:SetOrigin(tr.HitPos + tr.HitNormal)
            data:SetNormal(tr.HitNormal)
            if ie.scale  then data:SetScale(ie.scale)  end
            if ie.flags  then data:SetFlags(ie.flags)  end
            if ie.entity then data:SetEntity(ie.entity) end
            util.Effect(ie.effect, data)
        end

        if ie.override then return true end
    end
end