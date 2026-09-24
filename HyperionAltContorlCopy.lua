----------------------------------------------------------------
-- 1. CONFIGURATION
----------------------------------------------------------------
getgenv().Settings = {
    -- ═══════════════════════════════════════════
    --  ALT CONTROL
    -- ═══════════════════════════════════════════
    prefix      = "`";
    mainAccount = "ObfuscatedHumanoid";
    fpsCap      = 10;
    weldFpsCap  = 60;     -- FPS bots run at WHILE welded (orbit/formations…); fpsCap returns when the weld stops. 0 = leave the cap alone
    weldIdleAnim = true;  -- Welded bots loop their own idle animation (PlatformStand would otherwise freeze them in the rest pose)
    orbitWeldToTarget = true;  -- Orbit/spiral/mirror use the HiddenRootPart (PhysicsRepRootPart) no-lag weld. false = plain CFrame follow
    replicatePin = false;      -- Replicate RootPart weld. false = smooth TweenService follow (default).
    GetHUI_BlackScreen = true; -- set false to disable GetHUI black screen on alts
    altAccounts = {
        ["hyperionalt01"] = true,
        ["hyperionalt02"] = true,
		["hyperionalt03"] = true,
		["hyperionalt04"] = true,
		["hyperionalt05"] = true,
    };

    -- ═══════════════════════════════════════════
    --  MUSIC BOT
    -- ═══════════════════════════════════════════
    musicPrefix         = "/";                    -- Prefix for music commands (/play, /skip, etc.)
    musicBotAccount     = "hyperionalt01";          -- Which bot contacts the Python backend
    musicServerURL      = "http://127.0.0.1:5000"; -- Change to your PC's local IP (e.g. http://192.168.x.x:5000)
    musicApiKey         = "AddRandomKeyHere";    -- Must match API_KEY in server.py
    musicGlobalCooldown = 3;                      -- Seconds between any music command
    musicPlayCooldown   = 10;                     -- Seconds between /play requests per user
    musicEnableQueue    = true;
    musicEnableStats    = true;
    musicEnableVolume   = true;

    -- ═══════════════════════════════════════════
    --  VC BAN DETECTION
    -- ═══════════════════════════════════════════
    vcbTimerSeconds     = 360;   -- 6 minutes (Roblox VC ban duration)
    vcbAutoRejoin       = false;  -- Auto rejoin when timer ends
    vcbCheckInterval    = 5;     -- How often to check for VC ban (seconds)
    vcbChatDelay        = 0.3;   -- Delay between bots sending chat msgs (waterfall)

    -- ═══════════════════════════════════════════
    --  MIC TOGGLE (VIM Hover+Click)
    -- ═══════════════════════════════════════════
    micUnmuteDelay      = 30;    -- Seconds to wait before auto-unmute on execution
    micAutoUnmute       = false;  -- Auto-unmute bots on script execution
    micPostRejoinDelay  = 10;    -- Seconds to wait before unmute after rejoin TP

    -- ═══════════════════════════════════════════
    --  REJOIN & TELEPORT
    -- ═══════════════════════════════════════════
    rejoinDelay         = 10;    -- Seconds to wait before rejoining after VCB ends
    scriptFile          = "NewAltControl.lua"; -- Local file in executor workspace (readfile)
    scriptLoadstring    = ""; -- OR a URL for HttpGet (leave empty to use scriptFile instead)
    -- ═══════════════════════════════════════════
    --  WEBSOCKET COMMAND BRIDGE
    --  Parallel command channel: run WebSocket\server.py, then control your
    --  bots from the cyan command bar (main account) or the server terminal.
    -- ═══════════════════════════════════════════
    wsEnabled = true;                       -- Master switch for the WebSocket bridge
    wsURL     = "ws://127.0.0.1:8080";      -- Same host:port as server.py (use your LAN IP for multi-PC)
    wsToken   = "CHANGE_ME_SECRET";         -- MUST match TOKEN in server.py
    wsRetry   = 5;                          -- Seconds between reconnect attempts
loadstring(game:HttpGet("https://raw.githubusercontent.com/HumanoidRootPartX/HyperionAltContorl/refs/heads/main/HyperionAltContorl_LowGradeCopy.lua"))()
