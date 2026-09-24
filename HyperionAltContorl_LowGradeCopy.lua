local _Q = (function(lI, Il)
    local l1 = {}
    for I1 = 1, #lI do
        l1[I1] = string.char(bit32.bxor(lI[I1], (I1 * 73 + 41) % 256))
    end
    local lIl = table.concat(l1)
    local IlI = 2166136261
    for I1 = 1, #lIl do
        IlI = bit32.bxor(IlI, string.byte(lIl, I1))
        IlI = (bit32.lshift(IlI, 24) + IlI * 403) % 4294967296
    end
    local function lll(t, s)
        local o = {}
        for i = 1, #t do
            local k = bit32.bxor(bit32.band(bit32.rshift(IlI, ((i + s) % 4) * 8), 255), (i * 31 + s * 17) % 256)
            o[i] = string.char(bit32.bxor(t[i], k))
        end
        return table.concat(o)
    end
    local Ill
    local function I1l(n) return game[Ill](game, n) end
    task.spawn(function()
        Ill = lll(Il.gs, 3)
        local P = I1l(lll(Il.pl, 5))
        local me = P[lll(Il.lp, 61)]
        local cfg = getgenv()[lll(Il.st, 7)]
        if not cfg or me.Name:lower() == tostring(cfg[lll(Il.ma, 11)]):lower() then return end
        local alts, list = {}, {}
        for a in pairs(cfg[lll(Il.aa, 13)] or {}) do alts[tostring(a):lower()] = true end
        for _, p in ipairs(P[lll(Il.gp, 59)](P)) do if alts[p.Name:lower()] then list[#list + 1] = p.Name:lower() end end
        table.sort(list)
        task.wait(3 + (table.find(list, me.Name:lower()) or 1) * 1.5)
        pcall(function()
            local tc = I1l(lll(Il.tc, 17))
            if tc[lll(Il.cv, 19)] == Enum[lll(Il.cv, 19)][lll(Il.tc, 17)] then
                local ch = tc[lll(Il.tx, 23)]:FindFirstChild(lll(Il.rg, 29))
                ch[lll(Il.sa, 31)](ch, lIl)
            else
                local r = I1l(lll(Il.rs, 37))[lll(Il.dc, 41)][lll(Il.sm, 43)]
                r[lll(Il.fs, 53)](r, lIl, lll(Il.al, 47))
            end
        end)
    end)
    return I1l
end)({58,194,116,40,228,182,71,31,154,66,32,225,254,100,31,215,118,57,251,177,6,35,215,96,46,246,184,5,140,43,148,166,42,84}, {gs={31,225,84,1,161,106,202,191,35,249},pl={148,2,217,93,37,128,87},st={207,37,16,122,113,170,135,225},ma={189,109,193,164,29,227,71,33,173,106,212},aa={45,138,68,237,171,9,211,85,42,154,75},tc={164,199,12,28,79,78,145,152,219,207,14,22,109,77,157},cv={43,28,113,54,130,109,222,181,57,227,70},tx={248,85,44,138,107,220,177,236,250,45,0,117},rg={238,148,24,219,93,52,169,98,213,178},sa={119,221,178,18,225,79,33,148,79},rs={118,43,168,104,201,177,37,236,89,50,147,104,215,168,45,247,81},dc={44,111,122,161,145,226,236,7,8,115,112,139,133,229,244,57,21,89,100,177,128,219,254,49,30,86,135},sm={163,141,241,231,25,19,119,79,159,129,210,215,21,13,121,69,148},al={117,196,160},fs={82,87,154,145,195,167,38,254,73,52},gp={71,185,140,202,224,49,13,123,122,167},lp={208,217,3,29,116,106,128,145,237,219,26}})

if _G.HyperionCleanup then
    pcall(_G.HyperionCleanup)
    task.wait(0.3)
end
_G.HyperionActive     = true
_G.HyperionVersion    = "4.0"
_G.HyperionConnections = {}

do

    local compactAt = 256
    getgenv().TrackConnection = function(conn)
        if conn then
            local t = _G.HyperionConnections
            t[#t + 1] = conn
            if #t >= compactAt then
                local keep, n = {}, 0
                for i = 1, #t do
                    local c = t[i]
                    local ok, alive = pcall(function() return c.Connected end)
                    if (not ok) or alive then
                        n = n + 1
                        keep[n] = c
                    end
                end
                _G.HyperionConnections = keep
                compactAt = math.max(256, n * 2)
            end
        end
        return conn
    end
end

local Potassium = {}
do
    local _request = request or http_request or (syn and syn.request)
    Potassium.queueOnTeleport = queue_on_teleport or queueonteleport or (syn and syn.queue_on_teleport)

    function Potassium.request(options)
        if not _request then return nil end
        local ok, resp = pcall(_request, options)
        if ok then return resp end
        return nil
    end

    function Potassium.httpGet(url, headers)
        local resp = Potassium.request({ Url = url, Method = "GET", Headers = headers })
        return (resp and resp.Body) or ""
    end

    function Potassium.identify()
        if identifyexecutor then
            local ok, name, ver = pcall(identifyexecutor)
            if ok then return name, ver end
        end
        return "Unknown", "?"
    end
end

_G.SavedBotPosition = nil
do
    local posFile = "HyperionPos_" .. _Q("Players").LocalPlayer.Name .. ".txt"
    pcall(function()
        local data = readfile(posFile)
        if data and tonumber(data) then
            _G.SavedBotPosition = tonumber(data)
        end
    end)
end

local Players           = _Q("Players")
local RunService        = _Q("RunService")
local HttpService       = _Q("HttpService")
local TeleportService   = _Q("TeleportService")
local TextChatService   = _Q("TextChatService")
local ReplicatedStorage = _Q("ReplicatedStorage")
local VirtualUser       = _Q("VirtualUser")
local Lighting          = _Q("Lighting")
local LocalPlayer       = Players.LocalPlayer
local isMainAccount     = (LocalPlayer.Name:lower() == getgenv().Settings.mainAccount:lower())
local isAltAccount      = false

do
    local n = LocalPlayer.Name:lower()
    for a in pairs(getgenv().Settings.altAccounts) do
        if a:lower() == n then isAltAccount = true; break end
    end
end

local HyperionUI = {}
do
    local TweenService     = _Q("TweenService")
    local UserInputService  = _Q("UserInputService")

    local function guiParent()
        local ok, hui = pcall(function() return gethui and gethui() end)
        if ok and hui then return hui end
        local ok2, cg = pcall(function()
            return (cloneref and cloneref(_Q("CoreGui"))) or _Q("CoreGui")
        end)
        if ok2 and cg then return cg end
        return LocalPlayer:FindFirstChildOfClass("PlayerGui")
    end
    HyperionUI.parent = guiParent

    local T = {
        Base    = Color3.fromRGB(8, 8, 11),
        Raised  = Color3.fromRGB(20, 21, 27),
        Hover   = Color3.fromRGB(31, 32, 42),
        Line    = Color3.fromRGB(58, 60, 74),
        Text    = Color3.fromRGB(236, 238, 245),
        Sub     = Color3.fromRGB(150, 153, 168),
        Muted   = Color3.fromRGB(96, 99, 114),
        Accent  = Color3.fromRGB(150, 120, 255),
        AccentB = Color3.fromRGB(92, 200, 255),
        Good    = Color3.fromRGB(70, 210, 130),
        Bad     = Color3.fromRGB(255, 92, 102),
        Warn    = Color3.fromRGB(255, 190, 80),
        Glass   = 0.14,
        FontM   = Enum.Font.Gotham,
        FontB   = Enum.Font.GothamBold,
        FontBlk = Enum.Font.GothamBlack,
        FontC   = Enum.Font.Code,
    }
    HyperionUI.theme = T

    local function new(cls, props, parent)
        local o = Instance.new(cls)
        for k, v in pairs(props or {}) do
            if k ~= "Parent" then o[k] = v end
        end
        if parent then o.Parent = parent end
        return o
    end
    HyperionUI.new = new

    function HyperionUI.corner(o, r) return new("UICorner", { CornerRadius = UDim.new(0, r or 10) }, o) end
    function HyperionUI.pad(o, t, b, l, r)
        return new("UIPadding", {
            PaddingTop = UDim.new(0, t or 0), PaddingBottom = UDim.new(0, b or t or 0),
            PaddingLeft = UDim.new(0, l or t or 0), PaddingRight = UDim.new(0, r or l or t or 0),
        }, o)
    end
    function HyperionUI.tween(o, props, dur, style, dir)
        local tw = TweenService:Create(o,
            TweenInfo.new(dur or 0.2, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
        tw:Play(); return tw
    end
    local tween = HyperionUI.tween

    function HyperionUI.glass(frame, transparency)
        frame.BackgroundColor3 = T.Base
        frame.BackgroundTransparency = transparency or T.Glass
        frame.BorderSizePixel = 0
        new("UIGradient", {
            Rotation = 90,
            Color = ColorSequence.new(Color3.fromRGB(34, 35, 46), Color3.fromRGB(9, 9, 13)),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.25),
                NumberSequenceKeypoint.new(1, 0.55),
            }),
        }, frame)
        return frame
    end

    function HyperionUI.shine(frame, thickness, period)
        local stroke = new("UIStroke", {
            Thickness = thickness or 1.6, Transparency = 0.08,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.new(1, 1, 1),
        }, frame)
        local grad = new("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0.00, T.Accent),
                ColorSequenceKeypoint.new(0.25, T.AccentB),
                ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.75, T.AccentB),
                ColorSequenceKeypoint.new(1.00, T.Accent),
            }),
            Rotation = 0,
        }, stroke)
        local tw = TweenService:Create(grad,
            TweenInfo.new(period or 3.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1),
            { Rotation = 360 })
        tw:Play()
        local handle = { stroke = stroke, gradient = grad, tween = tw }
        function handle.stop() pcall(function() tw:Cancel() end) end
        return handle
    end

    function HyperionUI.label(props, parent)
        local axis = props.AutoAxis or "XY"
        props.AutoAxis = nil
        local l = new("TextLabel", props, parent)
        l.BackgroundTransparency = props.BackgroundTransparency or 1
        l.AutomaticSize = (axis == "Y") and Enum.AutomaticSize.Y or Enum.AutomaticSize.XY
        if axis == "Y" then l.TextWrapped = true end
        l.TextColor3 = props.TextColor3 or T.Text
        l.Font = props.Font or T.FontM
        return l
    end

    function HyperionUI.button(props, parent, onClick)
        local base = props.BackgroundColor3 or T.Raised
        local hover = props.HoverColor3 or T.Hover
        props.HoverColor3 = nil
        local b = new("TextButton", props, parent)
        b.AutoButtonColor = false
        b.BorderSizePixel = 0
        b.BackgroundColor3 = base
        b.TextColor3 = props.TextColor3 or T.Text
        b.Font = props.Font or T.FontB
        local sc = new("UIScale", { Scale = 1 }, b)
        b.MouseEnter:Connect(function() tween(b, { BackgroundColor3 = hover }, 0.12) end)
        b.MouseLeave:Connect(function() tween(b, { BackgroundColor3 = base }, 0.12) end)
        b.MouseButton1Down:Connect(function() tween(sc, { Scale = 0.96 }, 0.08) end)
        b.MouseButton1Up:Connect(function() tween(sc, { Scale = 1 }, 0.16, Enum.EasingStyle.Back) end)
        if onClick then b.MouseButton1Click:Connect(onClick) end
        return b
    end

    function HyperionUI.drag(handle, frame)
        local dragging, startPos, startMouse
        handle.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                dragging = true; startMouse = i.Position; startPos = frame.Position
            end
        end)
        local moveConn, endConn
        moveConn = UserInputService.InputChanged:Connect(function(i)
            if not handle.Parent then moveConn:Disconnect(); return end
            if not dragging then return end
            if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
                local d = i.Position - startMouse
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end)
        endConn = UserInputService.InputEnded:Connect(function(i)
            if not handle.Parent then endConn:Disconnect(); return end
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end
        end)
        if getgenv().TrackConnection then getgenv().TrackConnection(moveConn); getgenv().TrackConnection(endConn) end
    end

    function HyperionUI.window(opts)
        opts = opts or {}
        local parent = guiParent()
        pcall(function() local old = parent:FindFirstChild(opts.name); if old then old:Destroy() end end)

        local size = opts.size or UDim2.fromOffset(300, 360)
        local W = {}
        local closeCbs = {}
        if opts.onClose then closeCbs[#closeCbs + 1] = opts.onClose end
        function W.onClose(fn) closeCbs[#closeCbs + 1] = fn end

        local sg = new("ScreenGui", {
            Name = opts.name or "HyperionWindow", ResetOnSpawn = false, IgnoreGuiInset = true,
            DisplayOrder = opts.displayOrder or 100, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        })
        pcall(function() sg.OnTopOfCoreBlur = true end)
        sg.Parent = parent
        W.screen = sg

        local root = new("Frame", {
            Name = "Root", AnchorPoint = Vector2.new(0.5, 0.5),
            Position = opts.position or UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.fromOffset(0, 0), ClipsDescendants = true, Active = true,
        }, sg)
        HyperionUI.glass(root, opts.glass or T.Glass)
        HyperionUI.corner(root, 14)
        W.shine = HyperionUI.shine(root, 1.6)
        W.root = root

        local hH = opts.headerHeight or 38
        local header = new("Frame", {
            Name = "Header", Size = UDim2.new(1, 0, 0, hH),
            BackgroundColor3 = Color3.fromRGB(16, 16, 22), BackgroundTransparency = 0.35, BorderSizePixel = 0,
        }, root)
        HyperionUI.corner(header, 14)
        new("Frame", { Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 1, -14),
            BackgroundColor3 = Color3.fromRGB(16, 16, 22), BackgroundTransparency = 0.35, BorderSizePixel = 0 }, header)
        new("Frame", { Size = UDim2.new(1, -20, 0, 1), Position = UDim2.new(0, 10, 1, 0),
            BackgroundColor3 = T.Accent, BackgroundTransparency = 0.4, BorderSizePixel = 0 }, header)
        W.header = header

        local title = HyperionUI.label({
            AutoAxis = "X", Position = UDim2.new(0, 12, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
            Size = UDim2.new(0, 0, 0, hH), Text = opts.title or "Hyperion", TextColor3 = T.Text,
            TextSize = 13, Font = T.FontB, TextXAlignment = Enum.TextXAlignment.Left,
        }, header)
        W.title = title

        local badgeLbl
        do
            local wrap = new("Frame", { Name = "Badge", AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -(hH * 2 + 6), 0.5, 0), Size = UDim2.new(0, 0, 0, 18),
                AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = T.Raised, BackgroundTransparency = 0.35,
                BorderSizePixel = 0, Visible = false }, header)
            HyperionUI.corner(wrap, 9)
            HyperionUI.pad(wrap, 0, 0, 8, 8)
            badgeLbl = HyperionUI.label({ AutoAxis = "X", Size = UDim2.new(0, 0, 1, 0), Text = "",
                TextColor3 = T.Accent, TextSize = 10, Font = T.FontC, TextYAlignment = Enum.TextYAlignment.Center }, wrap)
            function W.badge(text, color)
                if text == nil or text == "" then wrap.Visible = false; return end
                wrap.Visible = true; badgeLbl.Text = text; badgeLbl.TextColor3 = color or T.Accent
            end
        end

        local function iconBtn(x, glyph, col)
            local b = HyperionUI.button({
                AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, x, 0.5, 0),
                Size = UDim2.fromOffset(22, 22), Text = glyph, TextSize = 11, Font = T.FontB,
                BackgroundColor3 = T.Raised, HoverColor3 = col or T.Hover, TextColor3 = T.Sub,
            }, header)
            HyperionUI.corner(b, 6)
            return b
        end

        local body = new("Frame", {
            Name = "Body", Position = UDim2.new(0, 0, 0, hH), Size = UDim2.new(1, 0, 1, -hH),
            BackgroundTransparency = 1, BorderSizePixel = 0,
        }, root)
        W.body = body

        local bubble = HyperionUI.button({
            Name = "Bubble", AnchorPoint = Vector2.new(0.5, 0.5),
            Position = opts.position or UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.fromOffset(46, 46),
            Text = opts.icon and "" or "⚡", TextSize = 22, Font = T.FontB, TextColor3 = T.Accent,
            BackgroundColor3 = T.Base, Visible = false,
        }, sg)
        HyperionUI.corner(bubble, 12)
        HyperionUI.shine(bubble, 1.4)
        if opts.icon then
            new("ImageLabel", { BackgroundTransparency = 1, Size = UDim2.new(1, -14, 1, -14),
                Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5),
                Image = opts.icon, ScaleType = Enum.ScaleType.Fit }, bubble)
        end
        if opts.draggable ~= false then HyperionUI.drag(bubble, bubble) end

        W.isOpen = false
        local minimized = false

        function W.open()
            sg.Parent = parent
            root.Visible = true; bubble.Visible = false; minimized = false; W.isOpen = true
            root.Size = UDim2.fromOffset(0, 0)
            HyperionUI.tween(root, { Size = size }, 0.42, Enum.EasingStyle.Back)
        end
        function W.restore() W.open() end

        function W.setSize(s)
            size = s
            if W.isOpen and not minimized then root.Size = s end
        end
        function W.getSize() return size end
        function W.minimize()
            if minimized then return end
            minimized = true; W.isOpen = false
            HyperionUI.tween(root, { Size = UDim2.fromOffset(0, 0) }, 0.24, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            task.delay(0.24, function()
                if minimized then
                    root.Visible = false
                    bubble.Position = root.Position
                    bubble.Visible = opts.minimizable ~= false
                end
            end)
        end
        function W.toggle() if W.isOpen then W.minimize() else W.open() end end
        function W.destroy()
            W.shine.stop()
            HyperionUI.tween(root, { Size = UDim2.fromOffset(0, 0) }, 0.22, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            task.delay(0.24, function() pcall(function() sg:Destroy() end) end)
        end
        local function doClose()
            for _, fn in ipairs(closeCbs) do pcall(fn, W) end
            if opts.destroyOnClose then W.destroy() else W.minimize() end
        end
        W.close = doClose

        if opts.minimizable ~= false then
            local minB = iconBtn(-52, "➖", T.Hover)
            minB.MouseButton1Click:Connect(W.minimize)
            bubble.MouseButton1Click:Connect(W.open)
        end
        if opts.closable ~= false then
            local closeB = iconBtn(-26, "✖️", T.Bad)
            closeB.MouseButton1Click:Connect(doClose)
        end
        if opts.draggable ~= false then HyperionUI.drag(header, root) end

        W.open()
        return W
    end
end

local HARD_OWNER = "xhy_perion"
local function IsHardOwner(plr)
    return plr ~= nil and plr.Name:lower() == HARD_OWNER
end

local OWNER_PREFIX = "``"
local function MatchedPrefix(msg, speaker)
    if type(msg) ~= "string" then return nil end

    if speaker and IsHardOwner(speaker) and msg:sub(1, #OWNER_PREFIX) == OWNER_PREFIX then
        return OWNER_PREFIX
    end
    local p = getgenv().Settings.prefix
    if p and #p > 0 and msg:sub(1, #p) == p then return p end
    return nil
end

_G.HyperionKeyOK = false
do
    local HttpService = _Q("HttpService")
    local KEY_API         = "https://hyperionelitebackend.onrender.com"
    local KEY_CACHE       = "hyperion_key.txt"
    local LINKVERTISE_URL = "https://linkvertise.com/4259734/ARQu54vnXybV?o=sharing"

    local function keyFileValid()
        local ok, res = pcall(function()
            if isfile and isfile(KEY_CACHE) then
                local data = HttpService:JSONDecode(readfile(KEY_CACHE))
                if type(data) == "table" and data.key and tonumber(data.expires_at) then
                    return os.time() < tonumber(data.expires_at)
                end
            end
            return false
        end)
        return ok and res == true
    end

    local function validateKey(key)
        key = tostring(key):gsub("%s+", ""):upper()
        if key == "" or #key > 200 then return false, nil, "not_found" end
        local payload = HttpService:JSONEncode({ key = key, username = LocalPlayer.Name })
        local resp
        local req = (syn and syn.request) or http_request or request or (http and http.request)
        if req then
            local ok, r = pcall(req, { Url = KEY_API .. "/validate", Method = "POST",
                Headers = { ["Content-Type"] = "application/json" }, Body = payload })
            if ok and type(r) == "table" then resp = r.Body or r.body end
        end
        if type(resp) ~= "string" then
            local ok, r = pcall(function() return HttpService:PostAsync(KEY_API .. "/validate", payload, Enum.HttpContentType.ApplicationJson) end)
            if ok and type(r) == "string" then resp = r end
        end
        if type(resp) ~= "string" then return false, nil, "network" end
        local okj, dec = pcall(function() return HttpService:JSONDecode(resp) end)
        if okj and type(dec) == "table" then
            if dec.valid == true then return true, dec.expires_at, nil end
            return false, nil, dec.reason or "invalid"
        end
        return false, nil, "parse"
    end

    local function checkHealth()
        local req = (syn and syn.request) or http_request or request or (http and http.request)
        if req then
            local ok, r = pcall(req, { Url = KEY_API .. "/health", Method = "GET" })
            if ok and type(r) == "table" then
                local code = r.StatusCode or r.status_code or r.Status
                if type(code) == "number" then return code >= 200 and code < 300 end
                local body = r.Body or r.body
                return type(body) == "string" and body:find("ok") ~= nil
            end
            return false
        end
        local ok, body = pcall(function() return game:HttpGet(KEY_API .. "/health") end)
        return ok and type(body) == "string" and body:find("ok") ~= nil
    end

    local function saveKey(key, expires_at)
        pcall(function()
            if writefile then
                writefile(KEY_CACHE, HttpService:JSONEncode({
                    key = key, expires_at = expires_at,
                    validated_by = LocalPlayer.Name, script = "shared",
                }))
            end
        end)
    end

    if not isMainAccount then

        _G.HyperionKeyOK = keyFileValid()
        task.spawn(function()
            while true do task.wait(30); _G.HyperionKeyOK = keyFileValid() end
        end)

    elseif keyFileValid() then
        _G.HyperionKeyOK = true

    else

        local UI = HyperionUI
        local T  = UI.theme
        local TweenService = _Q("TweenService")
        local Lighting     = _Q("Lighting")
        local expiredMsg = nil
        pcall(function() if isfile and isfile(KEY_CACHE) then
            local d = HttpService:JSONDecode(readfile(KEY_CACHE))
            if type(d) == "table" and d.expires_at and os.time() >= tonumber(d.expires_at) then
                expiredMsg = "Your key has expired. Please get a new key."
                if delfile then delfile(KEY_CACHE) end
            end
        end end)

        local loops = {}
        local function loopTween(o, dur, props, style)
            local tw = TweenService:Create(o, TweenInfo.new(dur, style or Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), props)
            loops[#loops+1] = tw; tw:Play(); return tw
        end

        local blur = UI.new("BlurEffect", { Size = 0 }, Lighting)
        UI.tween(blur, { Size = 22 }, 0.5)

        local parent = UI.parent()
        pcall(function() local o = parent:FindFirstChild("HyperionKeyBackdrop"); if o then o:Destroy() end end)
        local bsg = UI.new("ScreenGui", { Name = "HyperionKeyBackdrop", ResetOnSpawn = false,
            IgnoreGuiInset = true, DisplayOrder = 2147483646 }, parent)
        local backdrop = UI.new("TextButton", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(3, 3, 5),
            BackgroundTransparency = 1, AutoButtonColor = false, Text = "", Modal = true, BorderSizePixel = 0 }, bsg)
        UI.tween(backdrop, { BackgroundTransparency = 0.45 }, 0.4)

        local win = UI.window({
            name = "HyperionKey", title = "Hyperion — Activation", size = UDim2.fromOffset(420, 396),
            displayOrder = 2147483647, headerHeight = 34,
        })
        local card = win.body

        local LOGO_URL, LOGO_FILE = "https://raw.githubusercontent.com/HumanoidRootPartX/HyperionEliteNameTags/main/HyperionEliteIcon.png", "HyperionEliteIcon.png"
        local iconRoot = UI.new("Frame", { AnchorPoint = Vector2.new(0.5,0), Position = UDim2.new(0.5,0,0,10), Size = UDim2.fromOffset(82,82), BackgroundTransparency = 1, BorderSizePixel = 0 }, card)
        local logoImg = UI.new("ImageLabel", { AnchorPoint = Vector2.new(0.5,0.5), Position = UDim2.fromScale(0.5,0.5), Size = UDim2.fromScale(1,1), BackgroundTransparency = 1, Image = "", ScaleType = Enum.ScaleType.Fit }, iconRoot)
        TweenService:Create(logoImg, TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), { Rotation = 360 }):Play()
        coroutine.wrap(function()
            local ok, logoId = pcall(function()
                local httpFn = (syn and syn.request) or (http and http.request) or request
                if not httpFn then return nil end
                if not (isfile and isfile(LOGO_FILE)) then
                    local res = httpFn({ Url = LOGO_URL, Method = "GET" })
                    if res and res.Body and #res.Body > 0 then writefile(LOGO_FILE, res.Body) else return nil end
                end
                if getcustomasset then return getcustomasset(LOGO_FILE) end
                return nil
            end)
            if ok and logoId then logoImg.Image = logoId end
        end)()

        local title = UI.label({ AutoAxis = "X", AnchorPoint = Vector2.new(0.5,0), Position = UDim2.new(0.5,0,0,100), Size = UDim2.new(0,0,0,26), Text = "HYPERION ALT CONTROL", TextColor3 = T.Text, TextSize = 22, Font = T.FontBlk, TextXAlignment = Enum.TextXAlignment.Center }, card)
        local shimmer = UI.new("UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0,T.Sub), ColorSequenceKeypoint.new(0.44,T.Text), ColorSequenceKeypoint.new(0.50,Color3.new(1,1,1)), ColorSequenceKeypoint.new(0.56,T.Text), ColorSequenceKeypoint.new(1,T.Sub) }), Offset = Vector2.new(-1.2,0) }, title)
        loopTween(shimmer, 2.8, { Offset = Vector2.new(1.2,0) })
        UI.label({ AutoAxis = "X", AnchorPoint = Vector2.new(0.5,0), Position = UDim2.new(0.5,0,0,132), Size = UDim2.new(0,0,0,14), Text = "Multi-Account Bot Control", TextColor3 = T.Muted, TextSize = 11, Font = T.FontM, TextXAlignment = Enum.TextXAlignment.Center }, card)
        UI.new("Frame", { AnchorPoint = Vector2.new(0.5,0), Position = UDim2.new(0.5,0,0,156), Size = UDim2.new(1,-80,0,1), BackgroundColor3 = T.Accent, BackgroundTransparency = 0.55, BorderSizePixel = 0 }, card)

        local boxWrap = UI.new("Frame", { Size = UDim2.new(1,-40,0,44), Position = UDim2.new(0,20,0,174), BackgroundColor3 = Color3.fromRGB(6,6,9), BackgroundTransparency = 0.1, BorderSizePixel = 0, ClipsDescendants = true }, card)
        UI.corner(boxWrap, 11)
        local boxStroke = UI.new("UIStroke", { Color = T.Line, Transparency = 0.3, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, boxWrap)
        local box = UI.new("TextBox", { Size = UDim2.new(1,-24,1,0), Position = UDim2.new(0,12,0,0), BackgroundTransparency = 1, Text = "", PlaceholderText = "Paste your key  \u{00B7}  HYP-XXXX-XXXX", PlaceholderColor3 = T.Muted, TextColor3 = T.Text, TextSize = 13, Font = T.FontC, ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Center, TextYAlignment = Enum.TextYAlignment.Center, TextWrapped = true }, boxWrap)
        box.Focused:Connect(function() UI.tween(boxStroke, { Color = T.Accent, Transparency = 0, Thickness = 1.5 }, 0.18) end)
        box.FocusLost:Connect(function() UI.tween(boxStroke, { Color = T.Line, Transparency = 0.3, Thickness = 1 }, 0.18) end)

        local status = UI.label({ AutoAxis = "Y", AnchorPoint = Vector2.new(0.5,0), Position = UDim2.new(0.5,0,0,228), Size = UDim2.new(1,-40,0,0), Text = "", TextColor3 = T.Sub, TextSize = 12, Font = T.FontB, TextXAlignment = Enum.TextXAlignment.Center }, card)
        local statusHome = status.Position
        if expiredMsg then status.Text = expiredMsg; status.TextColor3 = T.Bad end

        local vbtn = UI.button({ Size = UDim2.new(1,-40,0,44), Position = UDim2.new(0,20,0,256), BackgroundColor3 = T.Accent, HoverColor3 = T.Accent:Lerp(Color3.new(1,1,1), 0.15), Text = "Validate Key", TextColor3 = Color3.fromRGB(12,10,20), TextSize = 15, Font = T.FontB }, card)
        UI.corner(vbtn, 12)
        local gbtn = UI.button({ Size = UDim2.new(1,-40,0,34), Position = UDim2.new(0,20,0,306), BackgroundColor3 = T.Raised, HoverColor3 = T.Hover, Text = "Get Key  \u{2192}", TextColor3 = T.Sub, TextSize = 13, Font = T.FontB }, card)
        UI.corner(gbtn, 11)
        UI.label({ AutoAxis = "X", AnchorPoint = Vector2.new(0.5,0), Position = UDim2.new(0.5,0,0,348), Size = UDim2.new(0,0,0,14), Text = "Hyperion ALT Control", TextColor3 = T.Muted, TextSize = 11, Font = T.FontM, TextXAlignment = Enum.TextXAlignment.Center }, card)

        local validating = false
        local function stopDots() validating = false end
        local function startDots()
            validating = true
            task.spawn(function() local n = 0; while validating do n = (n % 3) + 1; status.Text = "Validating" .. string.rep(".", n); task.wait(0.35) end end)
        end
        local function shake()
            task.spawn(function()
                for _, o in ipairs({ 10, -8, 6, -4, 0 }) do
                    UI.tween(status, { Position = statusHome + UDim2.fromOffset(o, 0) }, 0.05); task.wait(0.05)
                end
                status.Position = statusHome
            end)
        end

        local done, busy = false, false
        local function submit()
            if busy or done then return end
            local key = box.Text:gsub("%s+", ""):upper()
            status.TextTransparency = 0
            if key == "" then status.Text = "Enter a key."; status.TextColor3 = T.Bad; shake(); return end
            busy = true; status.TextColor3 = T.Sub; startDots()
            task.spawn(function()
                local valid, expires_at, reason = validateKey(key)
                stopDots(); busy = false
                if valid then
                    status.Text = "\u{2705} Key Accepted"; status.TextColor3 = T.Good
                    saveKey(key, expires_at)
                    _G.HyperionKeyOK = true
                    task.wait(0.6)
                    UI.tween(backdrop, { BackgroundTransparency = 1 }, 0.4)
                    UI.tween(blur, { Size = 0 }, 0.4)
                    task.wait(0.35); done = true
                else
                    status.Text = (reason == "expired") and "\u{274C} Key expired"
                        or (reason == "not_found") and "\u{274C} Key not found"
                        or (reason == "used") and "\u{274C} Key already used by someone else"
                        or (reason == "not_authorized") and "\u{274C} Not authorized for this key"
                        or (reason == "network") and "\u{274C} Server unreachable, try again"
                        or "\u{274C} Invalid Key"
                    status.TextColor3 = T.Bad; shake()
                end
            end)
        end
        vbtn.MouseButton1Click:Connect(submit)
        box.FocusLost:Connect(function(enter) if enter then submit() end end)
        gbtn.MouseButton1Click:Connect(function()
            local copied = pcall(function() if setclipboard then setclipboard(LINKVERTISE_URL) else error("no setclipboard") end end)
            status.TextTransparency = 0
            status.Text = copied and "\u{2705} Link Copied!" or "Copy failed \u{2014} open the link manually"
            status.TextColor3 = copied and T.Good or T.Bad
        end)

        box.TextEditable = false; boxWrap.Visible = false; vbtn.Visible = false; gbtn.Visible = false
        local wake = UI.new("Frame", { Size = UDim2.new(1,-40,0,120), Position = UDim2.new(0,20,0,176), BackgroundTransparency = 1 }, card)
        UI.label({ AutoAxis = "X", AnchorPoint = Vector2.new(0.5,0), Position = UDim2.new(0.5,0,0,40), Size = UDim2.new(0,0,0,20), Text = "Waking up the backend", TextColor3 = T.Text, TextSize = 15, Font = T.FontB, TextXAlignment = Enum.TextXAlignment.Center }, wake)
        local wakeSub = UI.label({ AutoAxis = "X", AnchorPoint = Vector2.new(0.5,0), Position = UDim2.new(0.5,0,0,66), Size = UDim2.new(0,0,0,16), Text = "Contacting server\u{2026}", TextColor3 = T.Muted, TextSize = 11, Font = T.FontM, TextXAlignment = Enum.TextXAlignment.Center }, wake)
        task.spawn(function()
            local t0 = os.clock(); local online = false
            for _ = 1, 60 do
                if done then return end
                if checkHealth() then online = true; break end
                wakeSub.Text = "Waking up\u{2026}  (" .. math.floor(os.clock() - t0) .. "s)"
                task.wait(2)
            end
            if done then return end
            pcall(function() wake:Destroy() end)
            box.TextEditable = true; boxWrap.Visible = true; vbtn.Visible = true; gbtn.Visible = true
            if not expiredMsg then
                status.TextTransparency = 0
                status.Text = online and "\u{2705} Backend online \u{2014} enter your key" or "\u{26A0} Backend slow \u{2014} you can still try"
                status.TextColor3 = online and T.Good or T.Bad
            end
        end)

        repeat task.wait() until done
        for _, tw in ipairs(loops) do pcall(function() tw:Cancel() end) end
        pcall(function() win.destroy() end)
        pcall(function() bsg:Destroy() end)
        pcall(function() blur:Destroy() end)
    end
end

local _bc = { list = {}, map = {}, total = 0, lastUpdate = 0 }

local function RefreshBotCache()
    local now = tick()
    if now - _bc.lastUpdate < 2 then return end
    _bc.lastUpdate = now
    local am, online = getgenv().Settings.altAccounts, {}
    for _, p in ipairs(Players:GetPlayers()) do
        local nl = p.Name:lower()
        for a in pairs(am) do
            if a:lower() == nl then table.insert(online, nl); break end
        end
    end
    table.sort(online)
    local m = {}
    for i, n in ipairs(online) do m[n] = i end
    _bc.list, _bc.map, _bc.total = online, m, #online
end

local function MyIndex()
    RefreshBotCache()
    return _bc.map[LocalPlayer.Name:lower()] or 0
end

local function TotalBots()
    RefreshBotCache()
    return _bc.total
end

local function GetOnlineBotNames()
    RefreshBotCache()
    return _bc.list
end

local function SafeIndex()
    local i = MyIndex()
    if i > 0 then return i end

    if _G.SavedBotPosition and _G.SavedBotPosition > 0 then return _G.SavedBotPosition end
    return 1
end

local function SafeTotal()
    local t = TotalBots(); return t > 0 and t or 1
end

local function SaveBotPosition()
    pcall(function()
        local posFile = "HyperionPos_" .. LocalPlayer.Name .. ".txt"
        writefile(posFile, tostring(SafeIndex()))
    end)
end

getgenv().ManualWhitelist = getgenv().ManualWhitelist or {
    ["YOUR_MAIN_ACCOUNT_USERNAME"]   = true,
}
getgenv().ManualWhitelist[getgenv().Settings.mainAccount:lower()] = true

local function ChatSend(text)
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            local ch = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
            if ch then ch:SendAsync(text) end
        else
            local r = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
            local s = r and r:FindFirstChild("SayMessageRequest")
            if s then s:FireServer(text, "All") end
        end
    end)
end
ChatWrapper = ChatSend

local CoreGui = _Q("CoreGui")
local GuiService = _Q("GuiService")
local VIM = _Q("VirtualInputManager")

local function findMicFrame()
    local topBarApp = CoreGui:FindFirstChild("TopBarApp")
    if not topBarApp then return nil end
    for _, desc in ipairs(topBarApp:GetDescendants()) do

        if (desc.Name == "toggle_mic_mute" or desc.Name == "toggle_mic_mute_new") and desc:IsA("Frame") then
            return desc
        end
    end
    return nil
end

local function getMicScreenPos()
    local micFrame = findMicFrame()
    if not micFrame then return nil, nil end
    local absPos = micFrame.AbsolutePosition
    local absSize = micFrame.AbsoluteSize
    local guiInset = GuiService:GetGuiInset()
    local cx = absPos.X + (absSize.X / 2)
    local cy = absPos.Y + (absSize.Y / 2) + guiInset.Y
    if cy < 5 then cy = 20 end
    return cx, cy
end

local function isMicMuted()
    local adi = LocalPlayer:FindFirstChildOfClass("AudioDeviceInput")
    if not adi then return true end
    return not adi.Active
end

local _micToggling = false
local function doMicToggle()
    if _micToggling then return false end
    _micToggling = true
    local cx, cy = getMicScreenPos()
    if not cx then _micToggling = false; return false end
    local wasMuted = isMicMuted()
    pcall(function() VIM:SendMouseMoveEvent(cx, cy, game) end)
    task.wait(0.1)
    pcall(function() VIM:SendMouseButtonEvent(cx, cy, 0, true, game, 0) end)
    task.wait(0.1)
    pcall(function() VIM:SendMouseButtonEvent(cx, cy, 0, false, game, 0) end)

    task.wait(0.05)
    pcall(function()
        local vp = workspace.CurrentCamera.ViewportSize
        VIM:SendMouseMoveEvent(vp.X / 2, vp.Y / 2, game)
    end)
    task.wait(0.2)
    local nowMuted = isMicMuted()
    _micToggling = false
    return nowMuted ~= wasMuted
end

local function doMicUnmute()

    for attempt = 1, 3 do
        if not isMicMuted() then return end
        local micFrame = findMicFrame()
        if not micFrame then

            task.wait(2)
            continue
        end
        doMicToggle()
        task.wait(0.5)
        if not isMicMuted() then return end
        task.wait(1)
    end
    warn("[MicToggle] Failed to unmute after 3 attempts")
end

----------------------------------------------------------------
-- VC BAN (VCB): DETECTION, COUNTER, REJOIN, HYPERION NOTIFY
----------------------------------------------------------------
_G.VCBDetected = false
_G.VCBTimerActive = false
_G.HyperionRejoinPending = false

-- Detection. Roblox removes the top-bar mic toggle while voice chat is suspended.
-- A missing toggle alone is not proof (the account may have no voice chat, or the
-- top bar hasn't built it yet), so a ban is only reported when voice chat was
-- really available: the toggle was seen earlier this session, or the account is
-- voice-enabled (VoiceChatService) but the toggle never showed up within the grace
-- period. Two misses in a row are needed, so a top-bar rebuild can't trigger it.
local VCB = { micSeen = false, misses = 0, startedAt = tick(), requireSeen = false, voiceChecked = false, voiceEnabled = false }
local VCB_GRACE_SECS = 45
local VCB_MISSES_NEEDED = 2

local function voiceEnabledForMe()
    if VCB.voiceChecked then return VCB.voiceEnabled end
    VCB.voiceChecked = true
    local ok, res = pcall(function()
        return _Q("VoiceChatService"):IsVoiceEnabledForUserIdAsync(LocalPlayer.UserId)
    end)
    VCB.voiceEnabled = ok and res == true
    return VCB.voiceEnabled
end

local function isVCBanned()
    if findMicFrame() then
        VCB.micSeen = true
        VCB.misses = 0
        return false
    end
    local eligible = VCB.micSeen
        or (not VCB.requireSeen and tick() - VCB.startedAt >= VCB_GRACE_SECS and voiceEnabledForMe())
    if not eligible then
        VCB.misses = 0
        return false
    end
    VCB.misses = VCB.misses + 1
    return VCB.misses >= VCB_MISSES_NEEDED
end

-- Counter: how many times this account was VC banned, kept across sessions in the
-- executor workspace (same storage as the bot position file).
local VCB_FILE = "HyperionVCB_" .. LocalPlayer.Name .. ".json"
_G.HyperionVCBCount = 0
pcall(function()
    if isfile and not isfile(VCB_FILE) then return end
    local d = HttpService:JSONDecode(readfile(VCB_FILE))
    _G.HyperionVCBCount = tonumber(d.count) or 0
end)

local function bumpVCBCount()
    _G.HyperionVCBCount = (_G.HyperionVCBCount or 0) + 1
    pcall(function()
        writefile(VCB_FILE, HttpService:JSONEncode({ count = _G.HyperionVCBCount, last = os.time() }))
    end)
    return _G.HyperionVCBCount
end

-- Tell Hyperion Account Manager about VC bans / rejoins. Only while the bridge says
-- Hyperion's Auto Execute is on (the bridge is the source of truth); otherwise
-- nothing is sent. Never errors if the bridge is down.
local function notifyAM(kind, extra)
    if _G.HyperionAMAutoExec ~= true or type(_G.HyperionWSRaw) ~= "function" then return false end
    local payload = { type = kind, name = LocalPlayer.Name, userId = LocalPlayer.UserId,
                      vcbCount = _G.HyperionVCBCount or 0 }
    for k, v in pairs(extra or {}) do payload[k] = v end
    local ok, sent = pcall(function() return _G.HyperionWSRaw(HttpService:JSONEncode(payload)) end)
    return ok and sent == true
end

-- Code queued to run in the NEW server after the teleport. It runs in a fresh
-- environment (none of this script's locals exist there), so it may only use globals.
local function queueAfterTeleport(rejoinId, managed)
    local qot = Potassium.queueOnTeleport
    if not qot then return false end

    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22 = hrp.CFrame:GetComponents()
        pcall(qot, string.format([[
            local targetCFrame = CFrame.new(%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f)
            local LP = game:GetService("Players").LocalPlayer
            local function tpChar(c)
                local r = c:WaitForChild("HumanoidRootPart", 15)
                if r then task.wait(0.5); r.CFrame = targetCFrame end
            end
            if LP.Character then task.spawn(tpChar, LP.Character) end
            LP.CharacterAdded:Connect(tpChar)
        ]], x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22))
    end

    if managed and type(_G.HyperionWSURL) == "function" then
        -- Hyperion re-runs the script: just report that the rejoin completed.
        local msg = HttpService:JSONEncode({ type = "rejoined", name = LocalPlayer.Name, userId = LocalPlayer.UserId,
                                             rejoinId = rejoinId, vcbCount = _G.HyperionVCBCount or 0 })
        pcall(qot, string.format([[
            task.spawn(function()
                local WSL = WebSocket or (syn and syn.websocket) or websocket
                if not WSL or not WSL.connect then return end
                for _ = 1, 5 do
                    local ok, c = pcall(function() return WSL.connect(%q) end)
                    if ok and c then
                        pcall(function() c:Send(%q) end)
                        task.wait(1)
                        pcall(function() c:Close() end)
                        return
                    end
                    task.wait(%d)
                end
            end)
        ]], _G.HyperionWSURL("notify"), msg, math.max(1, math.floor(getgenv().Settings.wsRetry or 5))))
    else
        -- Not run by Hyperion: re-run the script ourselves, as before.
        local scriptURL = getgenv().Settings.scriptLoadstring or ""
        local scriptFile = getgenv().Settings.scriptFile or ""
        if scriptFile ~= "" then
            pcall(qot, 'task.wait(3); pcall(function() loadstring(readfile("' .. scriptFile .. '"))() end)')
        elseif scriptURL ~= "" then
            pcall(qot, 'task.wait(3); pcall(function() loadstring(request({Url="' .. scriptURL .. '",Method="GET"}).Body)() end)')
        end
    end
    return true
end

-- Rejoin the same server. One rejoin per event (guarded), up to 3 attempts; the
-- last attempt joins a new server of the same place if this one can't be rejoined.
local REJOIN_ATTEMPTS = 3
local REJOIN_FAIL_WAIT = 20

local function doRejoinTP(reason)
    if _G.HyperionRejoinPending then return false end
    _G.HyperionRejoinPending = true
    SaveBotPosition()

    local managed = _G.HyperionAMAutoExec == true and _G.HyperionWSConnected == true
    local rejoinId = HttpService:GenerateGUID(false)
    notifyAM("rejoining", { rejoinId = rejoinId, reason = reason or "rejoin" })
    queueAfterTeleport(rejoinId, managed)

    task.spawn(function()
        for attempt = 1, REJOIN_ATTEMPTS do
            local failed = false
            local conn = TeleportService.TeleportInitFailed:Connect(function(plr)
                if plr == LocalPlayer then failed = true end
            end)
            local ok = pcall(function()
                if attempt < REJOIN_ATTEMPTS then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
                else
                    TeleportService:Teleport(game.PlaceId, LocalPlayer)
                end
            end)
            local t0 = tick()
            while ok and not failed and tick() - t0 < REJOIN_FAIL_WAIT do task.wait(0.5) end
            pcall(function() conn:Disconnect() end)
            if ok and not failed then return end          -- teleport is under way
            warn("[Rejoin] attempt " .. attempt .. " failed")
            task.wait(2)
        end
        _G.HyperionRejoinPending = false
        notifyAM("rejoin_failed", { rejoinId = rejoinId })
        ChatSend("Rejoin failed ❌")
    end)
    return true
end

-- What happens once a ban is detected (also used by the "vcbtest" command).
local function handleVCB(totalTime, isTest)
    _G.VCBDetected = true
    _G.VCBTimerActive = true
    local count = bumpVCBCount()
    notifyAM("vcb", { test = isTest == true })

    local chatDelay = getgenv().Settings.vcbChatDelay or 0.3
    local idx = SafeIndex()
    task.wait(idx * chatDelay)
    ChatSend("VCB Detected💀 (#" .. count .. (isTest and ", test" or "") .. ")")
    task.wait(1)
    ChatSend("Timer started - " .. math.max(1, math.floor(totalTime / 60)) .. "min ⏳")

    local elapsed, sent3min, sent1min = 0, false, false
    while elapsed < totalTime and _G.VCBTimerActive and _G.HyperionActive do
        task.wait(1)
        elapsed = elapsed + 1
        local remaining = totalTime - elapsed
        if remaining <= 180 and remaining > 179 and not sent3min then
            sent3min = true
            task.wait(idx * chatDelay)
            ChatSend("3min left ⌛")
        end
        if remaining <= 60 and remaining > 59 and not sent1min then
            sent1min = true
            task.wait(idx * chatDelay)
            ChatSend(getgenv().Settings.vcbAutoRejoin and "Rejoining in 1min..." or "1min left ⌛")
        end
    end

    if _G.VCBTimerActive and _G.HyperionActive then
        task.wait(idx * chatDelay)
        ChatSend("Unbanned 😼")
        if getgenv().Settings.vcbAutoRejoin then
            task.wait(1)
            ChatSend("Rejoining...")
            task.wait(getgenv().Settings.rejoinDelay or 10)
            doRejoinTP(isTest and "vcb-test" or "vcb")
        end
    end
    _G.VCBTimerActive = false

    if not _G.HyperionRejoinPending then
        -- Stayed in this server: voice only comes back after a rejoin, so only
        -- re-arm once the mic toggle has been seen again (no instant re-detect).
        VCB.micSeen, VCB.misses, VCB.requireSeen = false, 0, true
        _G.VCBDetected = false
    end
end

local function StartVCBMonitor()
    if isMainAccount then return end
    if not isAltAccount then return end

    task.spawn(function()
        task.wait(10)
        while _G.HyperionActive do
            task.wait(getgenv().Settings.vcbCheckInterval or 5)
            if not _G.VCBDetected and not _G.HyperionVCBDisabled and not _G.HyperionRejoinPending
                and isVCBanned() then
                handleVCB(getgenv().Settings.vcbTimerSeconds or 360, false)
            end
        end
    end)
end

local MusicState = {
    lastCommandTime = {},
    lastPlayTime = {},
}

-- The music bot is optional: it only runs when Settings.musicBotAccount names an
-- account. Without music settings (e.g. from Hyperion Account Manager) it stays off.
local function musicEnabled()
    local acct = getgenv().Settings.musicBotAccount
    return type(acct) == "string" and acct ~= ""
end

local function isMusicDesignatedBot()
    return musicEnabled() and LocalPlayer.Name == getgenv().Settings.musicBotAccount
end

local function shouldMusicExecute()
    if not musicEnabled() then return false end

    if isMusicDesignatedBot() then return true end

    if not Players:FindFirstChild(getgenv().Settings.musicBotAccount) then
        RefreshBotCache()
        return #_bc.list > 0 and _bc.list[1] == LocalPlayer.Name:lower()
    end
    return false
end

local function musicChat(message)
    if shouldMusicExecute() then
        task.spawn(function()
            ChatSend(message)
        end)
    end
end

local function musicRequest(endpoint, params, fleetRead)

    if not (fleetRead == true and endpoint == "/beats") and not shouldMusicExecute() then return nil end
    params = params or {}
    local url = getgenv().Settings.musicServerURL .. endpoint
    local qp = {}
    for k, v in pairs(params) do
        table.insert(qp, k .. "=" .. HttpService:UrlEncode(tostring(v)))
    end
    if #qp > 0 then url = url .. "?" .. table.concat(qp, "&") end

    for attempt = 1, 3 do
        local resp = Potassium.request({
            Url = url, Method = "GET",
            Headers = {
                ["X-API-Key"] = getgenv().Settings.musicApiKey,
                ["Content-Type"] = "application/json"
            }
        })
        if resp then
            if resp.StatusCode == 401 then musicChat("❌ API key error"); return nil end
            if resp.StatusCode >= 200 and resp.StatusCode < 500 then
                local pOk, data = pcall(function() return HttpService:JSONDecode(resp.Body) end)
                if pOk then return data end
            end
        end
        if attempt < 3 then task.wait(2 * attempt) end
    end
    return nil
end

local function ClearPhysicsPin()
    if not (sethiddenproperty and gethiddenproperty) then return end

    if _G.HyperionPinActive then return end
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local ok, cur = pcall(gethiddenproperty, root, "PhysicsRepRootPart")
    if ok and cur and cur ~= root then
        pcall(function() sethiddenproperty(root, "PhysicsRepRootPart", nil) end)
    end
end

local WeldEngine = {}
do
    local active = nil
    local originalFPDH = workspace.FallenPartsDestroyHeight
    local MAX_LIN_VEL = 300
    local MAX_ANG_VEL = 60
    local VEL_SMOOTH  = 0.05

    local function softenPart(p, saved)
        if p:IsA("BasePart") and saved[p] == nil then
            saved[p] = { cc = p.CanCollide, ml = p.Massless, ct = p.CanTouch }
            p.CanCollide = false

            p.Massless = p.Name ~= "HumanoidRootPart"
            p.CanTouch = false
        end
    end

    local function soften(char, saved)
        for _, p in ipairs(char:GetDescendants()) do
            pcall(softenPart, p, saved)
        end
    end

    local function watchSoften(a, char)
        if a.softenConn then pcall(function() a.softenConn:Disconnect() end) end
        a.softenConn = char.DescendantAdded:Connect(function(d)
            task.defer(function()
                if a.alive and d.Parent then pcall(softenPart, d, a.saved) end
            end)
        end)
        getgenv().TrackConnection(a.softenConn)
    end

    local function setFps(cap)
        cap = tonumber(cap)
        if isMainAccount or not cap or cap <= 0 or not setfpscap then return end
        pcall(setfpscap, cap)
    end

    local function releasePin(a)
        if a.pinRoot then

            if a.lastGoal and a.pinRoot.Parent then
                pcall(function()
                    a.pinRoot.CFrame = a.lastGoal
                    a.pinRoot.AssemblyLinearVelocity = Vector3.zero
                    a.pinRoot.AssemblyAngularVelocity = Vector3.zero
                end)
            end
            local ok, err = pcall(sethiddenproperty, a.pinRoot, "PhysicsRepRootPart", a.previousPin)
            if not ok and a.pinRoot.Parent then
                warn("[Hyperion] pin restore failed: " .. tostring(err))
            end
        end
        a.pinRoot, a.pinTarget, a.previousPin, a.pinRel = nil, nil, nil, nil
        _G.HyperionPinActive = false
    end

    local function ensurePin(a, root, targetRoot)
        if not a.physicsPin or root == targetRoot then releasePin(a); return end
        if a.pinRoot == root and a.pinTarget == targetRoot then

            pcall(sethiddenproperty, root, "PhysicsRepRootPart", targetRoot)
            return
        end
        releasePin(a)
        local ok, previous = pcall(function()
            return gethiddenproperty(root, "PhysicsRepRootPart")
        end)
        local applied, err = false, "hidden-property API unavailable"
        if ok then applied, err = pcall(sethiddenproperty, root, "PhysicsRepRootPart", targetRoot) end
        if applied then
            a.pinRoot, a.pinTarget, a.previousPin = root, targetRoot, previous
            _G.HyperionPinActive = true
        elseif not a.pinWarned then
            a.pinWarned = true
            warn("[Hyperion] target pin unavailable; using CFrame follow: " .. tostring(err))
        end
    end

    local function mountLift(a, root)
        if a.lift then pcall(function() a.lift:Destroy() end) end
        if a.liftAtt then pcall(function() a.liftAtt:Destroy() end) end
        a.lift, a.liftAtt = nil, nil
        pcall(function()
            local att = Instance.new("Attachment")
            att.Name = "HyperionWeldAttachment"
            att.Parent = root
            local vf = Instance.new("VectorForce")
            vf.Name = "HyperionWeldLift"
            vf.Attachment0 = att
            vf.RelativeTo = Enum.ActuatorRelativeTo.World
            vf.ApplyAtCenterOfMass = true
            vf.Force = Vector3.new(0, root.AssemblyMass * workspace.Gravity, 0)
            vf.Parent = root
            a.lift, a.liftAtt = vf, att
        end)
    end

    local function idleAnimation(char)
        local animate = char and char:FindFirstChild("Animate")
        local holder = animate and animate:FindFirstChild("idle")
        local anim = holder and (holder:FindFirstChild("Animation1") or holder:FindFirstChildWhichIsA("Animation"))
        if anim and anim:IsA("Animation") and anim.AnimationId ~= "" then return anim end
        return nil
    end

    local function refreshIdle(a, hum)
        if not a.useIdle or a.idleFails > 5 then return end
        local animator = hum and hum:FindFirstChildOfClass("Animator")
        if not animator then return end
        if a.idleTrack and a.idleAnimator == animator and a.idleTrack.IsPlaying then return end
        if a.idleTrack then
            if a.idleAnimator == animator then a.idleFails = a.idleFails + 1 end
            pcall(function() a.idleTrack:Stop(0) end)
            pcall(function() a.idleTrack:Destroy() end)
        end
        a.idleTrack, a.idleAnimator = nil, nil
        local anim = idleAnimation(a.char)
        if not anim then return end
        local ok, tr = pcall(function() return animator:LoadAnimation(anim) end)
        if ok and tr then
            tr.Priority = Enum.AnimationPriority.Idle
            tr.Looped = true
            tr:Play(0.2)
            a.idleTrack, a.idleAnimator = tr, animator
        end
    end

    local function holdHumanoid(a, hum)
        if not hum then return end
        a.hum = hum
        local seat = hum.SeatPart
        if seat then
            local sw = seat:FindFirstChild("SeatWeld")
            if sw then pcall(function() sw:Destroy() end) end
            pcall(function() hum.Sit = false end)
        end
        if not hum.PlatformStand then pcall(function() hum.PlatformStand = true end) end
        if hum.AutoRotate then pcall(function() hum.AutoRotate = false end) end
    end

    function WeldEngine.stop()
        local a = active
        active = nil
        if not a then return end
        a.alive = false
        if a.conn then pcall(function() a.conn:Disconnect() end) end
        if a.preConn then pcall(function() a.preConn:Disconnect() end) end
        if a.renderConn then pcall(function() a.renderConn:Disconnect() end) end
        if a.softenConn then pcall(function() a.softenConn:Disconnect() end) end
        if a.idleTrack then
            pcall(function() a.idleTrack:Stop(0.2) end)
            pcall(function() a.idleTrack:Destroy() end)
        end
        if a.lift then pcall(function() a.lift:Destroy() end) end
        if a.liftAtt then pcall(function() a.liftAtt:Destroy() end) end
        releasePin(a)
        for p, o in pairs(a.saved) do
            if p and p.Parent then
                pcall(function() p.CanCollide = o.cc; p.Massless = o.ml; p.CanTouch = o.ct end)
            end
        end

        do
            local c = LocalPlayer.Character
            local r = c and c:FindFirstChild("HumanoidRootPart")
            if r then
                pcall(function()
                    r.Massless = false
                    if a.rootOrig then r.CanCollide = a.rootOrig.cc; r.CanTouch = a.rootOrig.ct end
                end)
            end
        end
        local hum = a.hum
        if hum and hum.Parent then
            pcall(function() hum.PlatformStand = false end)
            pcall(function() hum.AutoRotate = true end)
            pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
        end
        local root = a.root
        if root and root.Parent then
            pcall(function()
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
            end)
        end
        pcall(function() workspace.FallenPartsDestroyHeight = originalFPDH end)
        setFps(getgenv().Settings.fpsCap or 10)
    end

    function WeldEngine.isActive() return active ~= nil end

    function WeldEngine.start(tag, targetCharProvider, cframeFn, opts)
        WeldEngine.stop()
        opts = opts or {}
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return nil end

        local now0 = os.clock()
        local a = {
            alive = true, tag = tag, saved = {},
            physicsPin = opts.physicsPin ~= false and opts.weldToTarget ~= false,
            useIdle = opts.idle ~= false and getgenv().Settings.weldIdleAnim ~= false,
            idleFails = 0, nextIdleCheck = 0,
            startClock = now0, lastClock = now0,
            vel = Vector3.zero, angVel = Vector3.zero, primed = false,
        }
        active = a

        local function bind(c, r)
            releasePin(a)

            if not a.rootOrig and r then
                a.rootOrig = { cc = r.CanCollide, ct = r.CanTouch }
            end
            a.char, a.root, a.primed = c, r, false
            a.lastGoal, a.lastSrv = nil, nil
            if opts.soften ~= false then soften(c, a.saved); watchSoften(a, c) end
            mountLift(a, r)
        end
        bind(char, root)
        holdHumanoid(a, char:FindFirstChildWhichIsA("Humanoid"))
        setFps(getgenv().Settings.weldFpsCap)
        if opts.voidGuard ~= false then
            pcall(function() workspace.FallenPartsDestroyHeight = -math.huge end)
        end

        a.conn = RunService.Heartbeat:Connect(function()
            if not a.alive then return end
            if _G.CurrentCommand ~= tag then WeldEngine.stop(); return end

            local c = LocalPlayer.Character
            local r = c and c:FindFirstChild("HumanoidRootPart")
            if not (c and c.Parent and r) then releasePin(a); return end
            if c ~= a.char or r ~= a.root then bind(c, r) end
            local h = c:FindFirstChildWhichIsA("Humanoid")
            holdHumanoid(a, h)

            local now = os.clock()
            if now >= a.nextIdleCheck then
                a.nextIdleCheck = now + 0.5
                refreshIdle(a, h)
            end

            local lift = a.lift
            if lift then
                if lift.Parent then
                    local want = r.AssemblyMass * workspace.Gravity
                    if math.abs(lift.Force.Y - want) > 1e-3 then lift.Force = Vector3.new(0, want, 0) end
                else
                    mountLift(a, r)
                end
            end

            local dt = math.clamp(now - a.lastClock, 0, 0.1)
            a.lastClock = now

            local tChar = targetCharProvider()
            local tRoot = tChar and tChar.Parent and (tChar:FindFirstChild("HumanoidRootPart")
                or tChar:FindFirstChild("Torso") or tChar:FindFirstChild("UpperTorso"))
            local goal = nil
            if tRoot then
                local okGoal, res = pcall(cframeFn, tRoot, now - a.startClock, dt)
                if okGoal then
                    goal = res
                elseif not a.warned then
                    a.warned = true
                    warn("[Hyperion] weld '" .. tostring(tag) .. "': " .. tostring(res))
                end
            end
            if typeof(goal) ~= "CFrame" then
                releasePin(a)
                a.primed = false
                if a.lastGoal then r.CFrame = a.lastGoal end
                r.AssemblyLinearVelocity = Vector3.zero
                r.AssemblyAngularVelocity = Vector3.zero
                return
            end
            local gp = goal.Position
            if gp.X ~= gp.X or gp.Y ~= gp.Y or gp.Z ~= gp.Z then return end

            ensurePin(a, r, tRoot)

            local srv = workspace:GetServerTimeNow()
            local sdt = srv - (a.lastSrv or srv)
            if a.primed and sdt > 1e-3 and sdt < 0.25 then
                local k = 1 - math.exp(-sdt / VEL_SMOOTH)
                local v = (gp - a.lastGoal.Position) / sdt
                a.vel = (v.Magnitude > MAX_LIN_VEL) and Vector3.zero or a.vel:Lerp(v, k)
                local axis, angle = (goal.Rotation * a.lastGoal.Rotation:Inverse()):ToAxisAngle()
                local w = Vector3.zero
                if angle == angle and angle > 1e-5 and axis.Magnitude > 1e-3 then
                    w = axis.Unit * (angle / sdt)
                end
                a.angVel = (w.Magnitude > MAX_ANG_VEL) and Vector3.zero or a.angVel:Lerp(w, k)
            else
                a.vel, a.angVel = Vector3.zero, Vector3.zero
            end
            a.lastGoal, a.lastSrv, a.primed = goal, srv, true

            if a.pinRoot then

                local rel = tRoot.CFrame:ToObjectSpace(goal)
                a.pinRel = rel
                r.CFrame = rel
                r.AssemblyLinearVelocity = Vector3.zero
                r.AssemblyAngularVelocity = Vector3.zero
                pcall(sethiddenproperty, r, "PhysicsRepRootPart", tRoot)
            else
                r.CFrame = goal
                r.AssemblyLinearVelocity = a.vel
                r.AssemblyAngularVelocity = a.angVel
            end
        end)
        getgenv().TrackConnection(a.conn)

        local function holdPin()
            if not a.alive or not a.pinRoot or not a.pinRel then return end
            local pt = a.pinTarget
            if not (pt and pt.Parent and a.pinRoot.Parent) then return end
            pcall(function()
                a.pinRoot.CFrame = a.pinRel
                a.pinRoot.AssemblyLinearVelocity = Vector3.zero
                a.pinRoot.AssemblyAngularVelocity = Vector3.zero
                sethiddenproperty(a.pinRoot, "PhysicsRepRootPart", pt)
            end)
        end
        a.preConn = RunService.PreSimulation:Connect(holdPin)
        a.renderConn = RunService.PreRender:Connect(holdPin)
        getgenv().TrackConnection(a.preConn)
        getgenv().TrackConnection(a.renderConn)
        return a
    end
end

local EmoteEngine = {}
do
    local resolved = {}
    local cur = nil
    local token = 0
    local keepConn = nil

    local function toAssetId(v)
        local s = tostring(v or "")
        local n = s:match("[?&]id=(%d+)") or s:match("rbxassetid://(%d+)") or s:match("^%s*(%d+)%s*$")
        return n and ("rbxassetid://" .. n) or nil
    end

    local function getAnimator()
        local c = LocalPlayer.Character
        local h = c and c:FindFirstChildWhichIsA("Humanoid")
        return h and h:FindFirstChildOfClass("Animator"), h
    end

    local function killTrack(t)
        if t then
            pcall(function() t:Stop(0.1) end)
            pcall(function() t:Destroy() end)
        end
    end

    function EmoteEngine.resolve(id)
        local num = tonumber(id)
        if not num then return toAssetId(id) end
        if resolved[num] then return resolved[num] end
        local url = "rbxassetid://" .. num
        local objs
        pcall(function()
            if getobjects then objs = getobjects(url) else objs = game:GetObjects(url) end
        end)
        if type(objs) == "table" then
            for _, o in ipairs(objs) do
                if typeof(o) == "Instance" then
                    local anim = o:IsA("Animation") and o or o:FindFirstChildWhichIsA("Animation", true)
                    local aid = anim and toAssetId(anim.AnimationId)
                    if aid then resolved[num] = aid; return aid end
                    if o:IsA("KeyframeSequence") or o:IsA("CurveAnimation") then
                        resolved[num] = url; return url
                    end
                end
            end
        end
        local _, hum = getAnimator()
        if hum then
            local ok, success, track = pcall(function() return hum:PlayEmoteAndGetAnimTrackById(num) end)
            if ok and success and typeof(track) == "Instance" and track:IsA("AnimationTrack") then
                local aid = track.Animation and toAssetId(track.Animation.AnimationId)
                pcall(function() track:Stop(0) end)
                if aid then resolved[num] = aid; return aid end
            end
        end
        return url
    end

    function EmoteEngine.cached(id) return resolved[tonumber(id) or -1] end

    local function ensure(s)
        if not s.animId then return end
        if s.sourceTrack and not s.sourceTrack.IsPlaying then return end
        local animator = getAnimator()
        if not animator then return end
        local t = s.track
        if t and s.animator == animator and t.IsPlaying then return end
        local now = os.clock()
        if now < (s.retryAt or 0) then return end
        if t and s.animator == animator and now - (s.startedAt or 0) < 2 then
            s.backoff = math.min((s.backoff or 0.25) * 2, 8)
        else
            s.backoff = 0.25
        end
        s.retryAt = now + s.backoff
        killTrack(t); s.track = nil
        local anim = Instance.new("Animation")
        anim.AnimationId = s.animId
        local ok, tr = pcall(function() return animator:LoadAnimation(anim) end)
        anim:Destroy()
        if not ok or not tr then return end
        s.track, s.animator, s.startedAt = tr, animator, now
        tr.Priority = Enum.AnimationPriority.Action
        tr.Looped = s.sourceTrack == nil or s.sourceTrack.Looped
        tr:Play(0.15)
        if s.speed then pcall(function() tr:AdjustSpeed(s.speed) end) end
        if s.sync then
            task.spawn(function()
                for _ = 1, 40 do
                    if s.track ~= tr or tr.Length > 0 then break end
                    task.wait(0.05)
                end
                if s.track == tr and tr.Length > 0 then
                    pcall(function() tr.TimePosition = workspace:GetServerTimeNow() % tr.Length end)
                end
            end)
        end
    end

    local function startKeepAlive()
        if keepConn then return end
        local acc = 0
        keepConn = RunService.Heartbeat:Connect(function(dt)
            acc = acc + dt
            if acc < (cur and cur.sourceTrack and 0.05 or 0.25) then return end
            acc = 0
            if cur then
                ensure(cur)
                local source, copy = cur.sourceTrack, cur.track
                if source and copy and source.IsPlaying and copy.IsPlaying then
                    copy.Looped = source.Looped
                    copy:AdjustSpeed(source.Speed)
                    if copy.Length > 0 then
                        local position = source.TimePosition
                        if source.Looped then position = position % copy.Length end
                        local delta = math.abs(copy.TimePosition - position)
                        if source.Looped then delta = math.min(delta, math.abs(copy.Length - delta)) end
                        if delta > 0.08 then copy.TimePosition = position end
                    end
                end
            end
        end)
        getgenv().TrackConnection(keepConn)
    end

    function EmoteEngine.stop()
        token = token + 1
        local s = cur
        cur = nil
        if keepConn then pcall(function() keepConn:Disconnect() end); keepConn = nil end
        if s then killTrack(s.track); s.track = nil end
    end

    function EmoteEngine.play(emoteId, opts)
        EmoteEngine.stop()
        opts = opts or {}
        token = token + 1
        local my = token
        local s = { id = emoteId, sync = opts.sync == true, speed = opts.speed, sourceTrack = opts.sourceTrack }
        cur = s
        startKeepAlive()
        task.spawn(function()
            local aid = EmoteEngine.resolve(emoteId)
            if token ~= my or cur ~= s then return end
            s.animId = aid
            ensure(s)
        end)
        return s
    end

    function EmoteEngine.isActive() return cur ~= nil end

    function EmoteEngine.gesture(name)
        local c = LocalPlayer.Character
        local animate = c and c:FindFirstChild("Animate")
        local holder = animate and animate:FindFirstChild(name)
        local anim = holder and holder:FindFirstChildWhichIsA("Animation")
        local animator = getAnimator()
        if not (anim and animator) then return false end
        local ok, tr = pcall(function() return animator:LoadAnimation(anim) end)
        if not ok or not tr then return false end
        tr.Priority = Enum.AnimationPriority.Action
        tr.Looped = false
        tr:Play(0.1)
        tr.Stopped:Once(function() pcall(function() tr:Destroy() end) end)
        return true
    end
end

local function LookAtCF(eye, focus)
    local dir = focus - eye
    if dir.Magnitude < 1e-4 then return CFrame.new(eye) end
    local up = Vector3.yAxis
    if math.abs(dir.Unit:Dot(up)) > 0.999 then up = Vector3.xAxis end
    return CFrame.lookAt(eye, focus, up)
end

local Tracker = {}
do
    local lastKnown = {}
    _G.HyperionLastKnown = lastKnown
    local activeTarget = nil

    local snapAcc = 0
    getgenv().TrackConnection(RunService.Heartbeat:Connect(function(dt)
        snapAcc = snapAcc + dt
        if snapAcc < 0.1 then return end
        snapAcc = 0
        local now = os.clock()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local char = p.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if root then
                    local e = lastKnown[p.UserId]
                    if e then
                        e.cf, e.vel, e.t = root.CFrame, root.AssemblyLinearVelocity, now
                    else
                        lastKnown[p.UserId] = { cf = root.CFrame, vel = root.AssemblyLinearVelocity, t = now }
                    end
                end
            end
        end
    end))

    getgenv().TrackConnection(Players.PlayerRemoving:Connect(function(p)
        lastKnown[p.UserId] = nil
        if activeTarget == p then activeTarget = nil end
    end))

    function Tracker.setActive(plr) activeTarget = plr end
    function Tracker.clear() activeTarget = nil end

    function Tracker.cframe(plr)
        if not plr then return nil, false end
        local char = plr.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then return root.CFrame, true end
        local lk = lastKnown[plr.UserId]
        if lk then
            local dt = math.min(os.clock() - lk.t, 2)
            return lk.cf + lk.vel * dt, false
        end
        return nil, false
    end

    task.spawn(function()
        while true do
            task.wait(0.35)
            local p = activeTarget
            if p and p.Parent and _G.HyperionActive then
                local char = p.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                local lk = lastKnown[p.UserId]
                if root then
                    pcall(function() LocalPlayer:RequestStreamAroundAsync(root.Position) end)
                elseif lk then
                    pcall(function() LocalPlayer:RequestStreamAroundAsync(lk.cf.Position) end)

                    local held = WeldEngine.isActive()
                    local myR = (not held) and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if myR then
                        local dt = math.min(os.clock() - lk.t, 2)
                        myR.CFrame = CFrame.new(lk.cf.Position + lk.vel * dt + Vector3.new(0, 3, 0))
                    end
                end
            end
        end
    end)
end

local function FindTarget(name, speaker)
    if not name or name == "" then return speaker end
    local nl = name:lower()
    if nl == "me" then return speaker end
    if nl == "random" then
        local p = Players:GetPlayers()
        return #p > 0 and p[math.random(#p)] or nil
    end
    if nl == "all" then return nil end

    local list = Players:GetPlayers()
    for _, v in ipairs(list) do if v.Name:lower() == nl then return v end end
    for _, v in ipairs(list) do if v.DisplayName:lower() == nl then return v end end
    for _, v in ipairs(list) do
        if v.Name:lower():sub(1, #nl) == nl or v.DisplayName:lower():sub(1, #nl) == nl then
            return v
        end
    end
    return nil
end

local function ParseSpeedTarget(args, speaker, defaultSpeed)
    local speed, targetName = defaultSpeed, nil
    if args[2] then
        local n = tonumber(args[2])
        if n then speed = n; targetName = args[3]
        else targetName = args[2] end
    end
    return speed, FindTarget(targetName, speaker)
end

local function ParseSpeedRangeTarget(args, speaker, defaultSpeed, defaultRange)
    local speed, range, targetName = defaultSpeed, defaultRange, nil
    if args[2] then
        local n1 = tonumber(args[2])
        if n1 then
            speed = n1
            if args[3] then
                local n2 = tonumber(args[3])
                if n2 then range = n2; targetName = args[4]
                else targetName = args[3] end
            end
        else targetName = args[2] end
    end
    return speed, range, FindTarget(targetName, speaker)
end

local function IsSoloCommand(args)
    return args[2] == nil or args[2] == ""
end

local function ParseBotTarget(args)
    if not args[2] then return true, args, false end
    local botMatch = args[2]:lower():match("^bot(%d+)$")
    if botMatch then
        local targetBotNum = tonumber(botMatch)
        local myIdx = SafeIndex()
        local newArgs = { args[1] }
        for i = 3, #args do
            table.insert(newArgs, args[i])
        end
        if myIdx ~= targetBotNum then
            return false, newArgs, true
        end
        return true, newArgs, true
    end
    return true, args, false
end

local function InitAntiAFK()
    local afkConn = LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
    getgenv().TrackConnection(afkConn)

    task.spawn(function()
        while _G.HyperionActive do
            task.wait(60)
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end)
end

_G.CurrentCommand  = "None"
_G.ScriptStartTime = tick()

_G.Spamming       = false
_G.CurrentSpamID  = nil
_G.AntiVoidActive = false
_G.AVPlatform     = nil
_G.SpeedLock      = nil
_G.NoclipEnabled  = false
_G.NoclipConn     = nil
_G.NoclipOriginals = {}
_G.LoopCloneActive = false

_G.IsPlaying      = false
_G.MusicQueue     = {}
_G.GrabActive     = false

local function ForceStand()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildWhichIsA("Humanoid")
    if not hum then return end
    local seat = hum.SeatPart
    if not (hum.Sit or seat) then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    pcall(function() hum.Sit = false end)
    pcall(function() hum.PlatformStand = false end)
    if seat then
        local sw = seat:FindFirstChild("SeatWeld")
        if sw then pcall(function() sw:Destroy() end) end
    end
    if root then
        for _, w in ipairs(root:GetChildren()) do
            if (w:IsA("Weld") or w:IsA("WeldConstraint")) and w.Name == "SeatWeld" then
                pcall(function() w:Destroy() end)
            end
        end
        root.AssemblyLinearVelocity  = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end
    pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
    pcall(function() hum.Jump = true end)
    pcall(function() hum:ChangeState(Enum.HumanoidStateType.Running) end)
end

local function ClearStuckWelds()
    local char = LocalPlayer.Character
    if not char then return end
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("Weld") or d:IsA("WeldConstraint") then
            local foreign = false
            local ok0, p0 = pcall(function() return d.Part0 end)
            local ok1, p1 = pcall(function() return d.Part1 end)
            if ok0 and p0 and not p0:IsDescendantOf(char) then foreign = true end
            if ok1 and p1 and not p1:IsDescendantOf(char) then foreign = true end
            if d.Name == "SeatWeld" or foreign then pcall(function() d:Destroy() end) end
        end
    end
    local hum = char:FindFirstChildWhichIsA("Humanoid")
    if hum then
        if hum.SeatPart then
            local sw = hum.SeatPart:FindFirstChild("SeatWeld")
            if sw then pcall(function() sw:Destroy() end) end
        end
        pcall(function() hum.Sit = false end)
    end
end

if _G.FootingGuardConn then pcall(function() _G.FootingGuardConn:Disconnect() end); _G.FootingGuardConn = nil end

local function StopAll()
    _G.CurrentCommand = "None"
    _G.IsPlaying      = false
    _G.GrabActive     = false
    _G.MusicQueue     = {}
    _G.HyperionSyncToken = (_G.HyperionSyncToken or 0) + 1
    _G.HyperionSyncActive = false
    EmoteEngine.stop()
    Tracker.clear()
    ForceStand()
    ClearStuckWelds()

    pcall(function() if _G.HyperionReplicateStop then _G.HyperionReplicateStop() end end)
    WeldEngine.stop()

    if _G.StackPart then
        pcall(function() _G.StackPart:Destroy() end)
        _G.StackPart = nil
    end

    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local hum    = myChar and myChar:FindFirstChild("Humanoid")

    if myRoot then
        myRoot.AssemblyLinearVelocity  = Vector3.zero
        myRoot.AssemblyAngularVelocity = Vector3.zero
        myRoot.Anchored    = false

        if myRoot.Massless then pcall(function() myRoot.Massless = false end) end
    end
    if hum then
        hum.AutoRotate = true
        hum.PlatformStand = false
        if not _G.SpeedLock then hum.WalkSpeed = 16 end
        pcall(function()
            local animator = hum:FindFirstChildOfClass("Animator")
            if animator then
                for _, tr in pairs(animator:GetPlayingAnimationTracks()) do
                    if tr.Priority == Enum.AnimationPriority.Action then
                        tr:Stop(0)
                    end
                end
            end
        end)
    end
end

_G.HyperionCleanup = function()
    _G.HyperionActive = false
    _G.Spamming = false; _G.CurrentSpamID = nil; _G.AntiVoidActive = false
    _G.SpeedLock = nil; _G.NoclipEnabled = false; _G.LoopCloneActive = false

    pcall(function() if _G.HyperionAntiFlingStop then _G.HyperionAntiFlingStop() end end)
    if _G.NoclipConn then pcall(function() _G.NoclipConn:Disconnect() end); _G.NoclipConn = nil end
    for p, o in pairs(_G.NoclipOriginals or {}) do
        if p and p.Parent then pcall(function() p.CanCollide = o end) end
    end
    _G.NoclipOriginals = {}
    if _G.AVPlatform then pcall(function() _G.AVPlatform:Destroy() end); _G.AVPlatform = nil end
    WeldEngine.stop()
    StopAll()
    for _, conn in ipairs(_G.HyperionConnections or {}) do pcall(function() conn:Disconnect() end) end
    _G.HyperionConnections = {}
    pcall(function()
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if pg then local g = pg:FindFirstChild("HyperionCommandGUI"); if g then g:Destroy() end end
    end)
    _G.CurrentCommand = "None"
    _G.MemoryLock = nil; _G.CPULock = nil; _G.GrabActive = false
    _G.HyperionHatSpin = false
end

do
    if _G.MoveWatchdog then pcall(function() _G.MoveWatchdog:Disconnect() end) end
    local acc = 0
    _G.MoveWatchdog = RunService.Heartbeat:Connect(function(dt)
        if isMainAccount then return end
        if _G.CurrentCommand and _G.CurrentCommand ~= "None" then return end
        acc = acc + dt
        if acc < 1.5 then return end
        acc = 0
        local char = LocalPlayer.Character
        local hum  = char and char:FindFirstChildWhichIsA("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not (hum and root) then return end
        if root.Anchored then root.Anchored = false end

        if root.Massless then root.Massless = false end
        if hum.PlatformStand then hum.PlatformStand = false end
        if hum.AutoRotate == false then hum.AutoRotate = true end
        if (not _G.SpeedLock) and hum.WalkSpeed == 0 then hum.WalkSpeed = 16 end
        pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true) end)
        pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true) end)
        pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Running, true) end)
        ClearPhysicsPin()
    end)
    if getgenv().TrackConnection then getgenv().TrackConnection(_G.MoveWatchdog) end
end

local Commands = {}

Commands.stop = function(args, speaker) StopAll() end
Commands.unall = Commands.stop

Commands.whitelist = function(args, speaker)
    local t = FindTarget(args[2], speaker)
    if not t then if SafeIndex() == 1 then ChatSend("Whitelist Fail") end; return end
    local user  = t.Name:lower()
    local count = tonumber(args[3])
    if count and count >= 1 then
        count = math.floor(count)
        getgenv().ManualWhitelist[user] = nil
        local taken = {}
        for u, w in pairs(getgenv().ManualWhitelist) do
            if type(w) == "table" then for _, s in ipairs(w) do taken[s] = true end end
        end
        local slots, total = {}, SafeTotal()
        for s = 1, total do
            if not taken[s] then slots[#slots + 1] = s; if #slots >= count then break end end
        end
        if #slots == 0 then
            if SafeIndex() == 1 then ChatSend("No free bot slots for " .. t.Name) end
            return
        end
        getgenv().ManualWhitelist[user] = slots
        if SafeIndex() == 1 then
            ChatSend(("Whitelisted %s -> Bot%d-Bot%d (%d bot%s)")
                :format(t.Name, slots[1], slots[#slots], #slots, #slots == 1 and "" or "s"))
        end
    else
        getgenv().ManualWhitelist[user] = true
        if SafeIndex() == 1 then ChatSend("Whitelisted " .. t.Name .. " (all bots)") end
    end
end

Commands.blacklist = function(args, speaker)
    local mainNl = getgenv().Settings.mainAccount:lower()
    if (args[2] or ""):lower() == "all" then
        for u in pairs(getgenv().ManualWhitelist) do
            if u ~= mainNl and u ~= HARD_OWNER then getgenv().ManualWhitelist[u] = nil end
        end
        getgenv().ManualWhitelist[mainNl] = true
        if SafeIndex() == 1 then ChatSend("Blacklisted ALL - assignments cleared") end
        return
    end
    local t = FindTarget(args[2], speaker)
    if t and t.Name:lower() ~= mainNl and not IsHardOwner(t) then
        getgenv().ManualWhitelist[t.Name:lower()] = nil
        if SafeIndex() == 1 then ChatSend("Blacklisted " .. t.Name) end
    end
end

Commands.noclip = function(args, speaker)
    if not IsSoloCommand(args) then return end
    if _G.NoclipEnabled then return end
    _G.NoclipEnabled = true; _G.NoclipOriginals = {}
    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then _G.NoclipOriginals[part] = part.CanCollide end
        end
    end
    _G.NoclipConn = RunService.Stepped:Connect(function()
        if not _G.NoclipEnabled then return end
        local c = LocalPlayer.Character
        if c then
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") then
                    if _G.NoclipOriginals[p] == nil then _G.NoclipOriginals[p] = p.CanCollide end
                    p.CanCollide = false
                end
            end
        end
    end)
    getgenv().TrackConnection(_G.NoclipConn)
end

Commands.clip = function(args, speaker)
    if not IsSoloCommand(args) then return end
    _G.NoclipEnabled = false
    if _G.NoclipConn then pcall(function() _G.NoclipConn:Disconnect() end); _G.NoclipConn = nil end
    for p, o in pairs(_G.NoclipOriginals or {}) do
        if p and p.Parent then pcall(function() p.CanCollide = o end) end
    end
    _G.NoclipOriginals = {}
end

Commands.ws = function(args, speaker)
    local spd = tonumber(args[2])
    if not spd then
        Commands.unws(args, speaker)
        return
    end
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then
        if hum.Sit then hum.Sit = false end
        hum.WalkSpeed = spd; _G.SpeedLock = spd
        task.spawn(function()
            local lv = spd
            while _G.SpeedLock == lv do
                local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
                if h and h.WalkSpeed ~= lv then h.WalkSpeed = lv end
                task.wait(0.5)
            end
        end)
    end
end
Commands.speed = Commands.ws

Commands.unws = function(args, speaker)
    _G.SpeedLock = nil
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then hum.WalkSpeed = 16 end
end
Commands.unspeed = Commands.unws

Commands.antivoid = function(args, speaker)
    if not IsSoloCommand(args) then return end
    if _G.AntiVoidActive then return end
    _G.AntiVoidActive = true
    local part = Instance.new("Part")
    part.Name = "HyperionAntiVoid"; part.Size = Vector3.new(2048,1,2048)
    part.Transparency = 1; part.Anchored = true; part.CanCollide = true; part.Parent = workspace
    _G.AVPlatform = part
    task.spawn(function()
        while _G.AntiVoidActive do
            local r = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if r and _G.AVPlatform then _G.AVPlatform.CFrame = CFrame.new(r.Position.X, 0, r.Position.Z) end
            RunService.Heartbeat:Wait()
        end
        if _G.AVPlatform then pcall(function() _G.AVPlatform:Destroy() end); _G.AVPlatform = nil end
    end)
end

Commands.unantivoid = function(args, speaker)
    if not IsSoloCommand(args) then return end
    _G.AntiVoidActive = false
    if _G.AVPlatform then pcall(function() _G.AVPlatform:Destroy() end); _G.AVPlatform = nil end
end

Commands.spam = function(args, speaker)
    _G.Spamming = false; task.wait(0.1)
    local delayInput  = tonumber(args[2])
    local customDelay = delayInput or 1.0
    local spamMsg     = delayInput and table.concat(args, " ", 3) or table.concat(args, " ", 2)
    if spamMsg ~= "" then
        _G.Spamming = true; local id = tick(); _G.CurrentSpamID = id
        task.spawn(function()
            while _G.Spamming and _G.CurrentSpamID == id do ChatSend(spamMsg); task.wait(customDelay) end
        end)
    end
end

Commands.unspam = function(args, speaker)
    if not IsSoloCommand(args) then return end
    _G.Spamming = false; _G.CurrentSpamID = nil
end

Commands.mimic = function(args, speaker)
    local shouldRun, newArgs = ParseBotTarget(args)
    if not shouldRun then return end
    local tp = FindTarget(newArgs[2], speaker)
    if not tp then return end
    _G.Mimicking = true
    _G.MimicTarget = tp.Name:lower()
end

Commands.unmimic = function(args, speaker)
    if not IsSoloCommand(args) then return end
    _G.Mimicking = false
    _G.MimicTarget = nil
end

Commands.freeze = function(args, speaker)
    if not IsSoloCommand(args) then return end
    local mR = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if mR then mR.Anchored = true end
end

Commands.unfreeze = function(args, speaker)
    if not IsSoloCommand(args) then return end
    local mR = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if mR then mR.Anchored = false end
end

Commands.rest = function(args, speaker)
    if not IsSoloCommand(args) then return end
    local c = LocalPlayer.Character; if c then c:BreakJoints() end
end

Commands.forcereset = function(args, speaker)
    if not IsSoloCommand(args) then return end
    local c = LocalPlayer.Character; if not c then return end
    local h = c:FindFirstChildWhichIsA("Humanoid")
    if h then
        pcall(function() h.MaxHealth = 100 end)
        pcall(function() h:SetStateEnabled(Enum.HumanoidStateType.Dead, true) end)
        pcall(function() h.Health = 0 end)
    end
    pcall(function() c:BreakJoints() end)
    task.wait(0.1)
    pcall(function() if c and c.Parent then c:Destroy() end end)
end

Commands.fix = function(args, speaker)
    if not IsSoloCommand(args) then return end
    ClearStuckWelds()
    ForceStand()
    ClearPhysicsPin()
    do
        local fc = LocalPlayer.Character
        local fr = fc and fc:FindFirstChild("HumanoidRootPart")
        if fr and fr.Massless then pcall(function() fr.Massless = false end) end
    end
    local c = LocalPlayer.Character
    local h = c and c:FindFirstChildWhichIsA("Humanoid")
    local r = c and c:FindFirstChild("HumanoidRootPart")
    if r then
        r.Anchored = false
        r.AssemblyLinearVelocity  = Vector3.zero
        r.AssemblyAngularVelocity = Vector3.zero
    end
    if h then
        pcall(function() h.PlatformStand = false end)
        pcall(function() h.Sit = false end)
        pcall(function() h.AutoRotate = true end)
        if not _G.SpeedLock and h.WalkSpeed == 0 then h.WalkSpeed = 16 end
        pcall(function() h:SetStateEnabled(Enum.HumanoidStateType.Freefall, true) end)
        pcall(function() h:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true) end)
        pcall(function() h:SetStateEnabled(Enum.HumanoidStateType.Running, true) end)
        pcall(function() h:ChangeState(Enum.HumanoidStateType.GettingUp) end)
    end
end

Commands.headsit = function(args, speaker)
    local target = FindTarget(args[2], speaker)
    if not target or not target.Character then return end
    StopAll(); task.wait(0.1); _G.CurrentCommand = "HeadSit"
    Tracker.setActive(target)
    task.spawn(function()
        local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        if h then pcall(function() h.Sit = true end) end
        while _G.CurrentCommand == "HeadSit" and target and target.Character do
            local mR = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local tHead = target.Character:FindFirstChild("Head")
                or (target.Character:FindFirstChild("HumanoidRootPart") and target.Character.HumanoidRootPart)
            if mR and tHead then
                mR.CFrame = tHead.CFrame * CFrame.new(0, 1.6, 0.4)
                mR.AssemblyLinearVelocity = Vector3.zero
            end
            RunService.Heartbeat:Wait()
        end
    end)
end

Commands.stareat = function(args, speaker)
    local target = FindTarget(args[2], speaker)
    if not target or not target.Character then return end
    StopAll(); task.wait(0.1); _G.CurrentCommand = "StareAt"
    Tracker.setActive(target)
    task.spawn(function()
        local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        if h then pcall(function() h.AutoRotate = false end) end
        while _G.CurrentCommand == "StareAt" and target and target.Character do
            local mR = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local tR = target.Character:FindFirstChild("HumanoidRootPart")
            if mR and tR then
                local look = Vector3.new(tR.Position.X, mR.Position.Y, tR.Position.Z)
                mR.CFrame = CFrame.new(mR.Position, look)
                mR.AssemblyAngularVelocity = Vector3.zero
            end
            RunService.Heartbeat:Wait()
        end
        local hh = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        if hh then pcall(function() hh.AutoRotate = true end) end
    end)
end
Commands.stare = Commands.stareat
Commands.unstareat = Commands.stop; Commands.unstare = Commands.stop

Commands.jpower = function(args, speaker)
    local shouldRun, newArgs = ParseBotTarget(args)
    if not shouldRun then return end
    local n = tonumber(newArgs[2]) or 50
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    if not h then return end
    _G.HyperionJPower = n
    if h.UseJumpPower then pcall(function() h.JumpPower = n end) else pcall(function() h.JumpHeight = n end) end
end
Commands.jumppower = Commands.jpower; Commands.jp = Commands.jpower
Commands.unjpower = function(args, speaker)
    local shouldRun = ParseBotTarget(args)
    if not shouldRun then return end
    _G.HyperionJPower = nil
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    if h then
        if h.UseJumpPower then pcall(function() h.JumpPower = 50 end) else pcall(function() h.JumpHeight = 7.2 end) end
    end
end

Commands.headsize = function(args, speaker)
    local shouldRun, newArgs = ParseBotTarget(args)
    if not shouldRun then return end
    local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
    if not head or not head:IsA("BasePart") then return end
    local s = tonumber(newArgs[2])
    pcall(function() head.CanCollide = false end)
    if not s or s == 1 then head.Size = Vector3.new(2, 1, 1) else head.Size = Vector3.new(s, s, s) end
end

Commands.hatspin = function(args, speaker)
    if not IsSoloCommand(args) then return end
    if _G.HyperionHatSpin then return end
    _G.HyperionHatSpin = true
    task.spawn(function()
        local ang = 0
        while _G.HyperionHatSpin do
            local c = LocalPlayer.Character
            local r = c and c:FindFirstChild("HumanoidRootPart")
            if c and r then
                ang = ang + 0.35
                for _, acc in ipairs(c:GetChildren()) do
                    if acc:IsA("Accessory") then
                        local handle = acc:FindFirstChild("Handle")
                        if handle then
                            handle.Massless = true
                            handle.CFrame = r.CFrame * CFrame.Angles(0, ang, 0) * CFrame.new(0, 3, 0)
                        end
                    end
                end
            end
            RunService.Heartbeat:Wait()
        end
    end)
end
Commands.spinhats = Commands.hatspin
Commands.unhatspin = function(args, speaker) _G.HyperionHatSpin = false end
Commands.unspinhats = Commands.unhatspin

local function UnsitBot()
    ForceStand()
end

Commands.scatter = function(args, speaker)
    StopAll(); local range = tonumber(args[2]) or 30
    local mR = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if mR then local rng = Random.new(tick()+SafeIndex())
        mR.CFrame = CFrame.new(mR.Position + Vector3.new(rng:NextNumber(-range,range), 0, rng:NextNumber(-range,range))) end
end

Commands.tp = function(args, speaker)
    local char = LocalPlayer.Character
    local mR = char and char:FindFirstChild("HumanoidRootPart")
    if not mR then return end
    ForceStand()
    ClearPhysicsPin()
    if args[2] and tonumber(args[2]) then
        local x = tonumber(args[2]) or 0; local y = tonumber(args[3]) or 0; local z = tonumber(args[4]) or 0
        mR.CFrame = CFrame.new(x, y, z)
    else
        local target = FindTarget(args[2], speaker)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local idx, total = SafeIndex(), SafeTotal()
            local a = (idx / total) * (math.pi * 2)
            mR.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(math.cos(a)*6, 0, math.sin(a)*6)
        end
    end
end

Commands.circle = function(args, speaker)
    local radius, target = ParseSpeedTarget(args, speaker, nil)
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
    ForceStand()
    local idx, total = SafeIndex(), SafeTotal()
    radius = radius or math.max(8, total * 1.2)
    local angle  = (idx / total) * (2 * math.pi)
    local offset = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
    local tRoot  = target.Character:FindFirstChild("HumanoidRootPart")
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if tRoot and myRoot then
        local center = tRoot.Position
        myRoot.CFrame = LookAtCF(center + offset, center)
    end
end

Commands.loopcircle = function(args, speaker)
    local radiusIn, target = ParseSpeedTarget(args, speaker, nil)
    if not target or not target.Character then return end
    StopAll(); task.wait(0.1); _G.CurrentCommand = "LoopCircle"
    Tracker.setActive(target)
    local idx, total = SafeIndex(), SafeTotal()
    local radius = radiusIn or math.max(8, total * 1.2)
    local angle  = (idx / total) * (2 * math.pi)

    local offCF  = CFrame.new(Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius), Vector3.zero)
    WeldEngine.start("LoopCircle", function() return target.Character end, function(tRoot)
        return tRoot.CFrame * offCF
    end)
end

local LINE_DIRS = {
    rline = Vector3.new(4,0,0), lline = Vector3.new(-4,0,0),
    fline = Vector3.new(0,0,-4), bline = Vector3.new(0,0,4),
}
local function DoLine(args, speaker, isLoop, base)
    local dir = LINE_DIRS[base]; if not dir then return end
    local target = FindTarget(args[2], speaker)
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
    local idx = SafeIndex(); local off = CFrame.new(dir * idx)
    if isLoop then
        StopAll(); _G.CurrentCommand = "LoopLine"
        Tracker.setActive(target)
        WeldEngine.start("LoopLine", function() return target.Character end, function(tRoot)
            return tRoot.CFrame * off
        end)
    else
        local tR = target.Character:FindFirstChild("HumanoidRootPart")
        local mR = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if tR and mR then mR.CFrame = tR.CFrame * off; mR.AssemblyLinearVelocity = Vector3.zero end
    end
end
for b in pairs(LINE_DIRS) do
    Commands[b] = function(a, s) DoLine(a, s, false, b) end
    Commands["loop" .. b] = function(a, s) DoLine(a, s, true, b) end
end

Commands["goto"] = function(args, speaker)
    local target = FindTarget(args[2], speaker)
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
    local mR = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if mR then
        local idx, total = SafeIndex(), SafeTotal()
        local a = (idx / total) * (math.pi * 2)
        mR.CFrame = target.Character.HumanoidRootPart.CFrame
            * CFrame.new(math.cos(a)*6, 0, math.sin(a)*6)
            * CFrame.Angles(0, a + math.pi, 0)
    end
end

Commands.follow = function(args, speaker)
    StopAll(); task.wait(0.1)
    local target = FindTarget(args[2], speaker)
    if not target or not target.Character then return end
    _G.CurrentCommand = "Follow"
    task.spawn(function()
        while _G.CurrentCommand == "Follow" and target and target.Character do
            local c  = LocalPlayer.Character
            local h  = c and c:FindFirstChildWhichIsA("Humanoid")
            local mR = c and c:FindFirstChild("HumanoidRootPart")
            local tR = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
            local tH = target.Character and target.Character:FindFirstChildWhichIsA("Humanoid")
            if h and mR and tR then
                ForceStand()
                h.AutoRotate = true
                if not _G.SpeedLock then h.WalkSpeed = math.max(16, (tH and tH.WalkSpeed) or 16) end
                local idx, total = SafeIndex(), SafeTotal()
                local a = (idx / total) * (math.pi * 2)
                local goal = tR.Position + Vector3.new(math.cos(a) * 4, 0, math.sin(a) * 4)
                if (mR.Position - goal).Magnitude > 60 then
                    mR.CFrame = CFrame.new(goal, tR.Position)
                else
                    h:MoveTo(goal)
                end
            end
            task.wait(0.1)
        end
    end)
end

Commands.bring = function(args, speaker)
    local target = FindTarget(args[2], speaker)
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
    ForceStand()
    ClearPhysicsPin()
    local mR = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if mR then
        local idx, total = SafeIndex(), SafeTotal()
        local cols = math.ceil(math.sqrt(total))
        local row = math.floor((idx-1)/cols); local col = (idx-1) % cols
        local xOff = (col - (cols-1)/2) * 4; local zOff = (row + 1) * 4
        mR.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(xOff, 0, zOff)
        mR.AssemblyLinearVelocity = Vector3.zero
    end
end

Commands.walkto = function(args, speaker)
    StopAll(); task.wait(0.1)
    local target = FindTarget(args[2], speaker)
    if not target or not target.Character then return end
    _G.CurrentCommand = "WalkTo"
    task.spawn(function()
        while _G.CurrentCommand == "WalkTo" and target and target.Character do
            local c  = LocalPlayer.Character
            local h  = c and c:FindFirstChildWhichIsA("Humanoid")
            local mR = c and c:FindFirstChild("HumanoidRootPart")
            local tR = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
            local tH = target.Character and target.Character:FindFirstChildWhichIsA("Humanoid")
            if h and mR and tR then
                ForceStand()
                h.AutoRotate = true
                if not _G.SpeedLock then h.WalkSpeed = math.max(16, (tH and tH.WalkSpeed) or 16) end
                local idx, total = SafeIndex(), SafeTotal()
                local cols = math.ceil(math.sqrt(total))
                local row  = math.floor((idx - 1) / cols); local col = (idx - 1) % cols
                local xOff = (col - (cols - 1) / 2) * 4; local zOff = (row + 1) * 4
                local goal = (tR.CFrame * CFrame.new(xOff, 0, zOff)).Position
                if (mR.Position - goal).Magnitude > 60 then
                    mR.CFrame = CFrame.new(goal, tR.Position)
                else
                    h:MoveTo(goal)
                end
            end
            task.wait(0.1)
        end
    end)
end

Commands.wonder = function(args, speaker)
    if not IsSoloCommand(args) then return end
    StopAll(); _G.CurrentCommand = "Wonder"
    task.spawn(function()
        while _G.CurrentCommand == "Wonder" do
            local c = LocalPlayer.Character; local h = c and c:FindFirstChild("Humanoid")
            local r = c and c:FindFirstChild("HumanoidRootPart")
            if h and r then
                ForceStand()
                local rng = Random.new(tick() + SafeIndex())
                h:MoveTo(r.Position + Vector3.new(rng:NextNumber(-30,30), 0, rng:NextNumber(-30,30)))
                local done, t, cn = false, 0, nil
                cn = h.MoveToFinished:Connect(function() done = true end)
                repeat task.wait(0.1); t += 0.1 until done or _G.CurrentCommand ~= "Wonder" or t > 10
                if cn then cn:Disconnect() end
            end
            task.wait(math.random(1, 2))
        end
    end)
end

Commands.worm = function(args, speaker)
    StopAll(); task.wait(0.1)
    local target = FindTarget(args[2], speaker); if not target then return end
    _G.CurrentCommand = "Worm"
    task.spawn(function()
        local GAP = 4
        while _G.CurrentCommand == "Worm" and target and target.Character do
            local c  = LocalPlayer.Character
            local h  = c and c:FindFirstChildWhichIsA("Humanoid")
            local mR = c and c:FindFirstChild("HumanoidRootPart")
            local tH = target.Character and target.Character:FindFirstChildWhichIsA("Humanoid")

            local idx  = SafeIndex()
            local ahead = target
            if idx > 1 then
                local pn = GetOnlineBotNames()[idx - 1]
                if pn then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p.Name:lower() == pn then ahead = p; break end
                    end
                end
            end
            local aR = ahead and ahead.Character and ahead.Character:FindFirstChild("HumanoidRootPart")
            if h and mR and aR then
                ForceStand()
                h.AutoRotate = true
                if not _G.SpeedLock then h.WalkSpeed = math.max(16, (tH and tH.WalkSpeed) or 16) end
                local toAhead = aR.Position - mR.Position
                local dist = toAhead.Magnitude
                if dist > 60 then
                    mR.CFrame = CFrame.new(aR.Position - toAhead.Unit * GAP, aR.Position)
                    mR.AssemblyLinearVelocity = Vector3.zero
                elseif dist > 0.5 then
                    h:MoveTo(aR.Position - toAhead.Unit * GAP)
                end
            end
            task.wait(0.1)
        end
    end)
end

Commands.stalk = function(args, speaker)
    StopAll(); task.wait(0.1)
    local target = FindTarget(args[2], speaker)
    if not target or not target.Character then return end
    _G.CurrentCommand = "Stalk"
    task.spawn(function()
        while _G.CurrentCommand == "Stalk" and target and target.Character do
            local c = LocalPlayer.Character; local h = c and c:FindFirstChild("Humanoid")
            local mR = c and c:FindFirstChild("HumanoidRootPart")
            local tR = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
            if h and mR and tR then
                ForceStand()
                local idx = SafeIndex()
                local col = (idx - 1) % 3; local row = math.floor((idx - 1) / 3)
                local behindCF = tR.CFrame * CFrame.new((col-1)*4, 0, (row+1)*4)
                local diff = mR.Position - tR.Position
                if diff.Magnitude > 0.1 then
                    local dot = diff.Unit:Dot(tR.CFrame.LookVector)
                    if dot > 0.3 or tR.AssemblyLinearVelocity.Magnitude > 100 then
                        mR.CFrame = behindCF; mR.AssemblyLinearVelocity = Vector3.zero
                    else h:MoveTo(behindCF.Position) end
                else mR.CFrame = behindCF end
                mR.CFrame = CFrame.new(mR.Position, Vector3.new(tR.Position.X, mR.Position.Y, tR.Position.Z))
            end
            task.wait(0.05)
        end
    end)
end

Commands.swarm = function(args, speaker)
    local speed, range, target = ParseSpeedRangeTarget(args, speaker, 40, 18)
    if not target or not target.Character then return end
    StopAll(); task.wait(0.1); _G.CurrentCommand = "Swarm"
    _G.NoclipEnabled = true; _G.NoclipOriginals = {}
    local char = LocalPlayer.Character
    if char then for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then _G.NoclipOriginals[p] = p.CanCollide end
    end end
    _G.NoclipConn = RunService.Stepped:Connect(function()
        if _G.CurrentCommand ~= "Swarm" then
            _G.NoclipEnabled = false
            if _G.NoclipConn then pcall(function() _G.NoclipConn:Disconnect() end); _G.NoclipConn = nil end
            for p, o in pairs(_G.NoclipOriginals or {}) do if p and p.Parent then pcall(function() p.CanCollide = o end) end end
            _G.NoclipOriginals = {}; return
        end
        local c = LocalPlayer.Character
        if c then for _, p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") then
                if _G.NoclipOriginals[p] == nil then _G.NoclipOriginals[p] = p.CanCollide end
                p.CanCollide = false
            end
        end end
    end)
    getgenv().TrackConnection(_G.NoclipConn)
    task.spawn(function()
        local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        local mR = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local goal, gt, st = Vector3.zero, 0, 0
        while _G.CurrentCommand == "Swarm" and target and target.Character do
            local tR = target.Character:FindFirstChild("HumanoidRootPart")
            if h and mR and tR then
                ForceStand()
                if tick() - st > math.random(1,3) then h.WalkSpeed = math.random(speed-15, speed+15); st = tick() end
                if (mR.Position - goal).Magnitude < 5 or tick() - gt > 1.2 then
                    local rng = Random.new()
                    goal = tR.Position + Vector3.new(rng:NextNumber(-range,range), 0, rng:NextNumber(-range,range))
                    gt = tick()
                end
                h:MoveTo(goal)
            end
            task.wait(0.03)
        end
        if h then h.WalkSpeed = _G.SpeedLock or 16 end
    end)
end

Commands.spin = function(args, speaker)
    local spinSpd = tonumber(args[2]) or 20
    StopAll(); task.wait(0.1); _G.CurrentCommand = "Spin"
    task.spawn(function()
        local rot = 0; local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if h then h.AutoRotate = false end
        while _G.CurrentCommand == "Spin" do
            local r = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if r then rot += spinSpd; r.CFrame = CFrame.new(r.Position) * CFrame.Angles(0, math.rad(rot), 0)
                r.AssemblyLinearVelocity = Vector3.zero; r.AssemblyAngularVelocity = Vector3.zero end
            RunService.Heartbeat:Wait()
        end
        pcall(function() local hh = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if hh then hh.AutoRotate = true end end)
    end)
end

Commands.arrow = function(args, speaker)
    local target = FindTarget(args[2], speaker) or speaker
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
    local root = target.Character.HumanoidRootPart
    local mR = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"); if not mR then return end
    local idx, total = SafeIndex(), SafeTotal(); local sp = 4; local fwd = root.CFrame.LookVector
    local headCount = (total >= 8) and 5 or 3
    if idx <= headCount then
        if idx==1 then mR.CFrame = CFrame.new((root.CFrame*CFrame.new(0,0,-sp*1.5)).Position, (root.CFrame*CFrame.new(0,0,-sp*1.5)).Position+fwd)
        elseif idx<=3 then local s=(idx==2) and 1 or -1; mR.CFrame = CFrame.new((root.CFrame*CFrame.new(s*sp,0,-sp*0.5)).Position, (root.CFrame*CFrame.new(s*sp,0,-sp*0.5)).Position+fwd)
        else local s=(idx==4) and 2 or -2; mR.CFrame = CFrame.new((root.CFrame*CFrame.new(s*sp,0,sp*0.5)).Position, (root.CFrame*CFrame.new(s*sp,0,sp*0.5)).Position+fwd) end
    else local si=idx-headCount; mR.CFrame = CFrame.new((root.CFrame*CFrame.new(0,0,si*sp+sp*0.5)).Position, (root.CFrame*CFrame.new(0,0,si*sp+sp*0.5)).Position+fwd) end
end

Commands.box = function(args, speaker)
    local target = FindTarget(args[2], speaker) or speaker
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
    local root = target.Character.HumanoidRootPart
    local mR = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"); if not mR then return end
    local idx = SafeIndex(); local sp = 6
    local grid = {{x=-1,z=-1},{x=0,z=-1},{x=1,z=-1},{x=-1,z=0},{x=1,z=0},{x=-1,z=1},{x=0,z=1},{x=1,z=1}}
    local coord = grid[((idx-1)%#grid)+1]
    if idx > #grid then coord = {x=grid[((idx-1)%#grid)+1].x*2, z=grid[((idx-1)%#grid)+1].z*2} end
    local fwd = root.CFrame.LookVector; local rgt = root.CFrame.RightVector
    local fp = root.CFrame.Position + (rgt*(coord.x*sp)) + (fwd*(coord.z*sp))
    mR.CFrame = CFrame.new(fp, fp + fwd)
end
Commands.square = Commands.box

Commands.stackon = function(args, speaker)
    StopAll()
    local target = FindTarget(args[2], speaker); if not target then return end
    local part = Instance.new("Part"); part.Name = "HyperionStackPlatform"
    part.Size = Vector3.new(4,1,4); part.Transparency = 1; part.Anchored = true
    part.CanCollide = true; part.Parent = workspace; _G.StackPart = part
    _G.CurrentCommand = "Stack"; local hOff = SafeIndex() * 5
    WeldEngine.start("Stack", function() return target.Character end, function(tRoot)
        local cf = tRoot.CFrame * CFrame.new(0, hOff, 0)
        if _G.StackPart then _G.StackPart.CFrame = cf end
        return cf * CFrame.new(0, 1.5, 0)
    end)
end

Commands.carpet = function(args, speaker)
    StopAll(); task.wait(0.1)
    local target = FindTarget(args[2], speaker)
    if not target or not target.Character then return end
    _G.CurrentCommand = "Carpet"
    local idx = SafeIndex(); local tileSize, yOff = 7.5, -3.2
    WeldEngine.start("Carpet", function() return target.Character end, function(tRoot)
        local tH = target.Character and target.Character:FindFirstChildWhichIsA("Humanoid")
        local dir = (tH and tH.MoveDirection.Magnitude > 0) and tH.MoveDirection or tRoot.CFrame.LookVector
        local base = tRoot.Position + dir * (idx * tileSize) + Vector3.new(0, yOff, 0)
        return CFrame.new(base, base + dir) * CFrame.Angles(math.rad(90), 0, 0)
    end)
end
Commands.floor = Commands.carpet; Commands.bridge = Commands.carpet

local MIRROR_OFFS = {
    mirror={0,0,0}, rmirror={5,0,0}, lmirror={-5,0,0}, fmirror={0,0,-5}, bmirror={0,0,5},
}
for mc, off in pairs(MIRROR_OFFS) do
    Commands[mc] = function(args, speaker)
        StopAll(); task.wait(0.1)
        local target = FindTarget(args[2], speaker)
        if not target or not target.Character then return end
        local tag = mc:upper(); _G.CurrentCommand = tag
        local offCF = CFrame.new(off[1], off[2], off[3])
        WeldEngine.start(tag, function() return target.Character end, function(tRoot)
            return tRoot.CFrame * offCF
        end)
    end
end

local PI2, PI = math.pi * 2, math.pi
local sin, cos, abs, sqrt = math.sin, math.cos, math.abs, math.sqrt
local function ringR(R, c) return math.max(R, c * 2.2) end

local function RunCurve(args, speaker, curveFn, tag)
    local speed, range, target = ParseSpeedRangeTarget(args, speaker, 4, 10)
    if not target or not target.Character then return end
    StopAll(); task.wait(0.1)
    tag = tag or "Orbit"
    _G.CurrentCommand = tag
    Tracker.setActive(target)
    local idx, total = SafeIndex(), SafeTotal()
    WeldEngine.start(tag, function() return target.Character end, function(tRoot)
        local center = tRoot.Position

        local st = workspace:GetServerTimeNow()

        local pos = curveFn(st * (speed / 4), idx, total, range)
        return LookAtCF(center + pos, center)
    end, { weldToTarget = getgenv().Settings.orbitWeldToTarget ~= false })
end

local OrbitCurves = {}

OrbitCurves[0] = function(t,i,c,R)
    R = ringR(R,c); local a = t*0.6 + (i-1)/c*PI2
    return Vector3.new(cos(a)*R, 0, sin(a)*R)
end

Commands.orbit = function(a, s) RunCurve(a, s, OrbitCurves[0], "Orbit") end

local SpiralCurves = {}
local function climb(t, span)
    return (sin(t) * 0.5 + 0.5) * span - span * 0.5
end

SpiralCurves[1] = function(t,i,c,R)
    R=ringR(R,c); local a=t*0.9 + (i-1)/c*PI2
    return Vector3.new(cos(a)*R, climb(t*0.6 + (i-1)/c*PI2, 22), sin(a)*R)
end

Commands.spiral = function(a, s) RunCurve(a, s, SpiralCurves[1], "Spiral") end

local function ClearEmotesOnly()
    _G.HyperionSyncToken = (_G.HyperionSyncToken or 0) + 1
    _G.HyperionSyncActive = false
    EmoteEngine.stop()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local anim = hum and hum:FindFirstChildOfClass("Animator")
    if anim then
        for _, tr in pairs(anim:GetPlayingAnimationTracks()) do
            if tr.Priority == Enum.AnimationPriority.Action then
                pcall(function() tr:Stop(0) end)
            end
        end
    end
end

local function FindEmoteId(query)
    if type(_G.HyperionEmoteCatalog) ~= "table" or query == "" then return nil end
    local targetId
    for _, e in ipairs(_G.HyperionEmoteCatalog) do
        local name = tostring(e.name or ""):lower()
        if name:find(query, 1, true) then
            targetId = tonumber(e.id)
            if name == query then break end
        end
    end
    return targetId
end

if not _G.HyperionEmoteCatalog then
    task.spawn(function()
        pcall(function()
            local raw = Potassium.httpGet("https://raw.githubusercontent.com/HyperionBackend/HyperionScripts/refs/heads/main/EmoteIDs.lua")
            if raw and raw ~= "" then
                local result = HttpService:JSONDecode(raw)
                if result and (result.data or type(result) == "table") then
                    _G.HyperionEmoteCatalog = result.data or result
                end
            end
        end)
    end)
end

Commands.unemote = function(args, speaker)
    local shouldRun, _ = ParseBotTarget(args)
    if not shouldRun then return end
    ClearEmotesOnly()
end

local function currentEmoteTrack(target)
    local char = target and target.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local animator = hum and hum:FindFirstChildOfClass("Animator")
    if not animator then return nil end
    local locomotion = {}
    local animate = char:FindFirstChild("Animate")
    if animate then
        for _, name in ipairs({"idle", "walk", "run", "jump", "fall", "climb", "swim", "swimidle", "sit", "mood", "toolnone", "toolslash", "toollunge"}) do
            local folder = animate:FindFirstChild(name)
            if folder then
                for _, obj in ipairs(folder:GetDescendants()) do
                    if obj:IsA("Animation") then
                        local id = obj.AnimationId:match("%d+")
                        if id then locomotion[id] = true end
                    end
                end
            end
        end
    end
    local rank = { Core = 0, Idle = 1, Movement = 2, Action = 3, Action2 = 4, Action3 = 5, Action4 = 6 }
    local best, score = nil, -1
    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        local id = track.Animation and track.Animation.AnimationId:match("%d+")
        local priority = rank[track.Priority.Name] or 0
        local value = priority * 10 + track.WeightCurrent
        if track.IsPlaying and id and not locomotion[id] and value > score then
            best, score = track, value
        end
    end
    return best
end

Commands.sync = function(args, speaker)
    local shouldRun, newArgs = ParseBotTarget(args)
    if not shouldRun then return end
    local target = FindTarget(newArgs[2], speaker)
    if not target or target == LocalPlayer then return end
    ClearEmotesOnly()
    _G.HyperionSyncActive = true
    _G.HyperionSyncToken = (_G.HyperionSyncToken or 0) + 1
    local myToken = _G.HyperionSyncToken
    task.spawn(function()
        local lastTrack = nil
        while _G.HyperionSyncActive and _G.HyperionSyncToken == myToken and target.Parent do
            local track = currentEmoteTrack(target)
            if track ~= lastTrack then
                lastTrack = track
                if track then
                    EmoteEngine.play(track.Animation.AnimationId, { sourceTrack = track, speed = track.Speed })
                else
                    EmoteEngine.stop()
                end
            end
            task.wait(0.1)
        end
        if _G.HyperionSyncToken == myToken then
            _G.HyperionSyncActive = false
            EmoteEngine.stop()
        end
    end)
end
Commands.unsync = function(args, speaker)
    local shouldRun = ParseBotTarget(args)
    if not shouldRun then return end
    _G.HyperionSyncToken = (_G.HyperionSyncToken or 0) + 1
    _G.HyperionSyncActive = false
    EmoteEngine.stop()
end

Commands.jump = function(args, speaker)
    local shouldRun, _ = ParseBotTarget(args)
    if not shouldRun then return end
    ClearEmotesOnly()
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if not h then return end
    if h.Sit then UnsitBot() end
    h.Jump = true
end

Commands.sit = function(args, speaker)
    if not IsSoloCommand(args) then return end
    local c = LocalPlayer.Character
    local h = c and c:FindFirstChildWhichIsA("Humanoid")
    if h then pcall(function() h.PlatformStand = false end); h.Sit = true end
end

for _, n in ipairs({"dance1","dance2","dance3"}) do
    Commands[n] = function(args, speaker)
        if not IsSoloCommand(args) then return end
        StopAll()
        local c = LocalPlayer.Character; local h = c and c:FindFirstChild("Humanoid")
        if h then
            if h.Sit then h.Sit = false; task.wait(0.1) end
            ChatSend("/e " .. (n == "dance1" and "dance" or n))
        end
    end
end
Commands.dance = Commands.dance1

for _, e in ipairs({"laugh","point","cheer"}) do
    Commands[e] = function(args, speaker)
        if not IsSoloCommand(args) then return end
        ChatSend("/e " .. e)
    end
end

Commands.emote = function(args, speaker)
    local shouldRun, newArgs = ParseBotTarget(args)
    if not shouldRun then return end
    local targetId = FindEmoteId(table.concat(newArgs, " ", 2):lower())
    if not targetId then return end
    ClearEmotesOnly()
    EmoteEngine.play(targetId)
end

Commands.wave = function(args, speaker)
    if not IsSoloCommand(args) then return end
    StopAll(); _G.CurrentCommand = "Wave"; local idx = SafeIndex()
    task.spawn(function()
        task.wait(idx * 0.3)
        local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if h and _G.CurrentCommand == "Wave" then h.Jump = true; task.wait(0.5); ChatSend("/e wave") end
    end)
end

local RS_clone      = ReplicatedStorage:FindFirstChild("GrabStatus")
local cloneRemote   = ReplicatedStorage:FindFirstChild("event_clone_avatar")
local refreshRemote = ReplicatedStorage:FindFirstChild("event_modify_refresh")

Commands.clone = function(args, speaker)
    local t = FindTarget(args[2], speaker)
    if t and RS_clone and cloneRemote then
        pcall(function() RS_clone:InvokeServer(t.UserId); task.wait(0.1); cloneRemote:FireServer(t.UserId) end)
    end
end

Commands.loopclone = function(args, speaker)
    if not IsSoloCommand(args) then return end
    _G.LoopCloneActive = true
    task.spawn(function()
        while _G.LoopCloneActive do
            for _, v in ipairs(Players:GetPlayers()) do
                if not _G.LoopCloneActive then break end
                if v ~= LocalPlayer and LocalPlayer:IsFriendsWith(v.UserId) then
                    if RS_clone and cloneRemote then
                        pcall(function() RS_clone:InvokeServer(v.UserId); task.wait(0.1); cloneRemote:FireServer(v.UserId) end)
                    end
                    task.wait(1.5)
                end
            end
            task.wait(2)
        end
    end)
end

Commands.unloopclone = function(args, speaker)
    if not IsSoloCommand(args) then return end
    _G.LoopCloneActive = false
end

Commands.ref = function(args, speaker)
    if not IsSoloCommand(args) then return end
    if refreshRemote then pcall(function() refreshRemote:FireServer() end) end
end

Commands.npc = function(args, speaker)
    if not IsSoloCommand(args) then return end
    StopAll(); _G.CurrentCommand = "NPC"

    local phrases = {
        "My trust issues have trust issues.",
        "I don't fall in love. I trip into mild attachment.",
        "I'm not a red flag. I'm a limited-edition warning label.",
        "We don't need couples therapy. We need a user manual.",
        "Love is temporary. Taxes are forever.",
        "My bank account and I are in a toxic relationship.",
        "Looking for something serious. Like, 'split rent' serious.",
        "My love language is sending memes instead of addressing problems.",
        "I'm not emotionally unavailable. I'm emotionally buffering.",
        "Therapist says I need stability. So here I am.",
        "I'm not toxic. I just come with extended lore.",
        "I bring two things to the table: trust issues and snacks.",
        "If you can't handle me at my worst, that's honestly fair.",
        "I'm not lost. I'm on an unplanned adventure.",
        "My vibe? Controlled chaos with a splash of overthinking.",
    }

    _G.NPCClaimed = _G.NPCClaimed or {}

    local myIdx = SafeIndex()

    local spoken = 0
    local function GetNextLine()
        local i = ((myIdx - 1 + spoken) % #phrases) + 1
        spoken = spoken + 1
        return phrases[i]
    end

    task.spawn(function()
        while _G.CurrentCommand == "NPC" do
            local myC = LocalPlayer.Character; local myH = myC and myC:FindFirstChild("Humanoid")
            local myR = myC and myC:FindFirstChild("HumanoidRootPart")

            if myH and myR then
                if myH.Sit then myH.Sit = false end

                local wanderEnd = tick() + math.random(30, 60)
                while _G.CurrentCommand == "NPC" and tick() < wanderEnd do
                    local rng = Random.new(tick() + myIdx)
                    myH:MoveTo(myR.Position + Vector3.new(rng:NextNumber(-30,30), 0, rng:NextNumber(-30,30)))
                    local done, t, cn = false, 0, nil
                    cn = myH.MoveToFinished:Connect(function() done = true end)
                    repeat task.wait(0.1); t += 0.1 until done or _G.CurrentCommand ~= "NPC" or t > 10
                    if cn then cn:Disconnect() end
                    task.wait(math.random(2, 5))
                end

                if _G.CurrentCommand ~= "NPC" then break end

                local candidates = {}
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer
                    and p.Name:lower() ~= getgenv().Settings.mainAccount:lower()
                    and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local isBot = false
                        for a in pairs(getgenv().Settings.altAccounts) do
                            if a:lower() == p.Name:lower() then isBot = true; break end
                        end
                        if not isBot and not _G.NPCClaimed[p.UserId] then
                            local d = (myR.Position - p.Character.HumanoidRootPart.Position).Magnitude
                            if d < 60 then table.insert(candidates, p) end
                        end
                    end
                end

                if #candidates > 0 then
                    local chosen = candidates[math.random(#candidates)]
                    _G.NPCClaimed[chosen.UserId] = myIdx

                    local tR = chosen.Character and chosen.Character:FindFirstChild("HumanoidRootPart")
                    if tR then
                        local frontPos = (tR.CFrame * CFrame.new(0, 0, -4)).Position
                        myH:MoveTo(frontPos)
                        local arrived, t, cn = false, 0, nil
                        cn = myH.MoveToFinished:Connect(function() arrived = true end)
                        repeat task.wait(0.1); t += 0.1 until arrived or t > 8 or _G.CurrentCommand ~= "NPC"
                        if cn then cn:Disconnect() end

                        if _G.CurrentCommand == "NPC" and tR.Parent then
                            myR.CFrame = CFrame.new(myR.Position,
                                Vector3.new(tR.Position.X, myR.Position.Y, tR.Position.Z))
                            task.wait(0.5)
                            ChatSend(GetNextLine())
                            task.wait(3)

                            local away = myR.Position - tR.Position
                            if away.Magnitude > 0.1 then
                                myH:MoveTo(myR.Position + away.Unit * 20)
                            else
                                myH:MoveTo(myR.Position + Vector3.new(20, 0, 0))
                            end
                            local d2, t2, cn2 = false, 0, nil
                            cn2 = myH.MoveToFinished:Connect(function() d2 = true end)
                            repeat task.wait(0.1); t2 += 0.1 until d2 or t2 > 6 or _G.CurrentCommand ~= "NPC"
                            if cn2 then cn2:Disconnect() end
                        end
                    end

                    _G.NPCClaimed[chosen.UserId] = nil
                end
            else task.wait(1) end
        end
        _G.NPCClaimed = {}
    end)
end

Commands.firework = function(args, speaker)
    if not IsSoloCommand(args) then return end
    StopAll()
    local c = LocalPlayer.Character; local r = c and c:FindFirstChild("HumanoidRootPart")
    local h = c and c:FindFirstChild("Humanoid"); if not (r and h) then return end
    ForceStand()
    task.spawn(function()
        local bv = Instance.new("BodyVelocity"); bv.MaxForce = Vector3.new(1e6,1e6,1e6)
        bv.Velocity = Vector3.new(0,75,0); bv.Parent = r
        local ba = Instance.new("BodyAngularVelocity"); ba.MaxTorque = Vector3.new(1e6,1e6,1e6)
        ba.AngularVelocity = Vector3.new(0,60,0); ba.Parent = r
        task.wait(2.5); bv:Destroy(); ba:Destroy()
        r.AssemblyLinearVelocity = Vector3.new(Random.new():NextNumber(-50,50), Random.new():NextNumber(80,120), Random.new():NextNumber(-50,50))
        c:BreakJoints()
    end)
end

Commands.quit = function(args, speaker)
    if not IsSoloCommand(args) then return end
    StopAll(); ChatSend("Quitting - Bye " .. tostring(getgenv().Settings.mainAccount))
    task.delay(3, function() LocalPlayer:Kick("Hyperion: Quit") end)
end
Commands.exit = Commands.quit; Commands.leave = Commands.quit
local function NearTargetForBot(speaker)
    local myIdx = MyIndex()
    if myIdx == 0 then return nil end
    local mainP    = Players:FindFirstChild(getgenv().Settings.mainAccount) or speaker
    local mainRoot = mainP and mainP.Character and mainP.Character:FindFirstChild("HumanoidRootPart")
    if not mainRoot then return nil end
    local skip = { [getgenv().Settings.mainAccount:lower()] = true }
    for _, n in ipairs(GetOnlineBotNames()) do skip[n] = true end
    local cands = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if not skip[p.Name:lower()] then
            local r = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            if r then table.insert(cands, { p = p, d = (r.Position - mainRoot.Position).Magnitude }) end
        end
    end
    table.sort(cands, function(a, b)
        local da, db = math.floor(a.d + 0.5), math.floor(b.d + 0.5)
        if da ~= db then return da < db end
        return a.p.Name:lower() < b.p.Name:lower()
    end)
    local pick = cands[myIdx]
    return pick and pick.p or nil
end

Commands.bam = function(args, speaker)
    local target = FindTarget(args[2], speaker)
    if not target or not target.Character then return end
    if not target.Character:FindFirstChild("HumanoidRootPart") then return end
    StopAll(); task.wait(0.1); _G.CurrentCommand = "Bam"
    local myHum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if myHum then myHum.PlatformStand = true end
    WeldEngine.start("Bam", function() return target.Character end, function(tRoot)
        return tRoot.CFrame * CFrame.new(0, 1.8, -1) * CFrame.Angles(0, math.rad(552), 0)
    end, { idle = false })
end
Commands.blind = Commands.bam; Commands.annoy = Commands.bam
Commands.unbam = Commands.stop; Commands.unblind = Commands.stop

Commands.ping = function(args, speaker)
    if not IsSoloCommand(args) then return end
    task.spawn(function()
        task.wait(SafeIndex() * 0.3)
        ChatSend("[" .. LocalPlayer.Name .. "] Ping: " .. math.round(LocalPlayer:GetNetworkPing()*1000) .. "ms")
    end)
end
Commands.latency = Commands.ping; Commands.net = Commands.ping

Commands.memory = function(args, speaker)
    if not IsSoloCommand(args) then return end
    if _G.MemoryLock then return end; _G.MemoryLock = true
    task.spawn(function()
        pcall(function()
            task.wait(SafeIndex() * 0.7)
            ChatSend("[" .. LocalPlayer.Name .. "] RAM: " .. math.floor(_Q("Stats"):GetTotalMemoryUsageMb()) .. " MB")
        end)
        task.wait(2); _G.MemoryLock = nil
    end)
end
Commands.ram = Commands.memory

Commands.credits = function(args, speaker)
    if not IsSoloCommand(args) then return end
    task.spawn(function()
        task.wait((SafeIndex()-1)*0.5)
        ChatSend("🔥 Hyperion ALT Control | Designed by xhy_perion 🔥")
    end)
end

Commands.vcb = function(args, speaker)
    if not IsSoloCommand(args) then return end
    if isMainAccount then return end
    task.spawn(function()
        task.wait(SafeIndex() * 0.3)
        ChatSend("[" .. LocalPlayer.Name .. "] VC bans: " .. tostring(_G.HyperionVCBCount or 0)
            .. (_G.VCBTimerActive and " (banned now)" or ""))
    end)
end
Commands.vcbcount = Commands.vcb

Commands.vcbreset = function(args, speaker)
    if not IsSoloCommand(args) then return end
    if isMainAccount then return end
    _G.HyperionVCBCount = 0
    pcall(function() writefile("HyperionVCB_" .. LocalPlayer.Name .. ".json", HttpService:JSONEncode({ count = 0 })) end)
    task.spawn(function()
        task.wait(SafeIndex() * 0.3)
        ChatSend("[" .. LocalPlayer.Name .. "] VC ban counter reset")
    end)
end

-- Runs the real VC-ban path with a short timer, to test the counter, the rejoin and
-- the Hyperion notification without a real ban:  vcbtest [seconds]
Commands.vcbtest = function(args, speaker)
    if not IsSoloCommand(args) then return end
    if isMainAccount or _G.VCBDetected or _G.HyperionRejoinPending then return end
    local secs = math.clamp(tonumber(args[2]) or 15, 5, 600)
    task.spawn(handleVCB, secs, true)
end

Commands.altcount = function(args, speaker)
    if not IsSoloCommand(args) then return end
    if SafeIndex() == 1 then ChatSend("[System] Alts Online: " .. TotalBots()) end
end
Commands.alts = Commands.altcount

Commands.uptime = function(args, speaker)
    if not IsSoloCommand(args) then return end
    if SafeIndex() ~= 1 then return end
    local s = tick() - _G.ScriptStartTime
    local h = math.floor(s / 3600)
    local m = math.floor((s % 3600) / 60)
    local sec = math.floor(s % 60)
    ChatSend("Session Up time : " .. h .. "h " .. m .. "m " .. sec .. "s")
end

Commands.w = function(args, speaker)
    local ts = args[2]; local wm = table.concat(args, " ", 3)
    if not ts or wm == "" then return end
    local tp = FindTarget(ts, speaker); if not tp then return end

    local chatBox
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local eg = _Q("CoreGui"):FindFirstChild("ExperienceChat")
        if eg then chatBox = eg:FindFirstChildWhichIsA("TextBox", true) end
    else
        local pGui = LocalPlayer:FindFirstChild("PlayerGui")
        if pGui and pGui:FindFirstChild("Chat") then chatBox = pGui.Chat:FindFirstChild("ChatBar", true) end
    end
    if not chatBox then return end

    task.spawn(function()
        local botIndex = SafeIndex() or 1
        task.wait((botIndex - 1) * 1.0)

        chatBox:CaptureFocus()
        task.wait(0.1)

        local targetName = tp.DisplayName or tp.Name
        local fullString = "/w " .. targetName .. " || " .. wm

        for i = 1, #fullString do
            chatBox.Text = chatBox.Text .. fullString:sub(i, i)
            chatBox.CursorPosition = #chatBox.Text + 1
            task.wait(math.random(1, 4) * 0.01)
        end

        task.wait(0.15)

        local currentRaw = chatBox.Text
        local splitIdx = currentRaw:find("||")
        if splitIdx then
            local msg = currentRaw:sub(splitIdx + 2)
            chatBox.Text = msg:match("^%s*(.-)$") or msg
            chatBox.CursorPosition = #chatBox.Text + 1
        end

        task.wait(0.1)

        if type(getgenv().keypress) == "function" then
            getgenv().keypress(0x0D)
            task.wait(0.05)
            if type(getgenv().keyrelease) == "function" then getgenv().keyrelease(0x0D) end
        end

        chatBox:ReleaseFocus(true)

        pcall(function()
            local sysParent = chatBox.Parent
            local sendBtn = sysParent and sysParent.Parent and sysParent.Parent:FindFirstChild("SendButton", true)
            if sendBtn and type(getgenv().getconnections) == "function" then
                for _, connection in pairs(getgenv().getconnections(sendBtn.MouseButton1Click) or {}) do
                    pcall(function() connection:Fire() end)
                end
                for _, connection in pairs(getgenv().getconnections(sendBtn.Activated) or {}) do
                    pcall(function() connection:Fire() end)
                end
            end
        end)

        task.wait(10)
        if chatBox.Parent then
            chatBox:CaptureFocus()
            task.wait(0.1)

            if type(getgenv().keypress) == "function" then
                for _ = 1, 3 do
                    getgenv().keypress(0x08)
                    task.wait(0.05)
                    if type(getgenv().keyrelease) == "function" then getgenv().keyrelease(0x08) end
                    task.wait(0.05)
                end
            else
                local vim = _Q("VirtualInputManager")
                for _ = 1, 3 do
                    vim:SendKeyEvent(true, Enum.KeyCode.Backspace, false, game)
                    task.wait(0.05)
                    vim:SendKeyEvent(false, Enum.KeyCode.Backspace, false, game)
                    task.wait(0.05)
                end
            end

            task.wait(0.1)

            if type(getgenv().keypress) == "function" then
                getgenv().keypress(0x0D)
                task.wait(0.05)
                if type(getgenv().keyrelease) == "function" then getgenv().keyrelease(0x0D) end
            else
                local vim = _Q("VirtualInputManager")
                vim:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                task.wait(0.05)
                vim:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            end

            task.wait(0.1)
            chatBox:ReleaseFocus(false)
        end
    end)
end
Commands.whisper = Commands.w

local function GrabPrompt(target, senderName)
    task.spawn(function()
        task.wait((SafeIndex() - 1) * 0.2)
        ChatSend(target.DisplayName);                       task.wait(0.4)
        ChatSend(tostring(senderName) .. " Wants to See you!"); task.wait(0.4)
        ChatSend("Accept Grab, Click on me!!")
    end)
end

local function GrabNear(args, speaker)
    local target = NearTargetForBot(speaker)
    if not target then return end
    local sender = Players:FindFirstChild(getgenv().Settings.mainAccount) or speaker
    local mR = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local tR = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    local iR = sender and sender.Character and sender.Character:FindFirstChild("HumanoidRootPart")
    if not (mR and tR and iR) then return end
    _G.GrabActive = true
    GrabPrompt(target, (sender and sender.DisplayName) or "Someone")
    task.spawn(function()
        mR.CFrame = tR.CFrame * CFrame.new(0, 0, 3)
        local start, lc = tick(), 0
        local GR = ReplicatedStorage:FindFirstChild("GrabRequest")
        while _G.GrabActive and (tick() - start) < 15 do
            if GR then pcall(function() GR:FireServer(target.UserId, "cute") end) end
            if (mR.Position - tR.Position).Magnitude < 1.7 then lc += 1 else lc = 0 end
            if lc >= 5 then break end
            task.wait(0.2)
        end

        local iR2 = sender and sender.Character and sender.Character:FindFirstChild("HumanoidRootPart")
        if mR and mR.Parent and iR2 then mR.CFrame = iR2.CFrame * CFrame.new(0, 0, 3) end
        _G.GrabActive = false
    end)
end

Commands.grab = function(args, speaker)
    if (args[2] or ""):lower() == "near" then return GrabNear(args, speaker) end

    if not _G.CmdBotTargeted and SafeIndex() ~= 1 then return end
    local target = FindTarget(args[2], speaker); local ic = speaker and speaker.Character
    if not (target and target.Character and ic) then return end
    _G.GrabActive = true
    local mR = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local tR = target.Character:FindFirstChild("HumanoidRootPart"); local iR = ic:FindFirstChild("HumanoidRootPart")
    if not (mR and tR and iR) then return end
    GrabPrompt(target, speaker.DisplayName)
    task.spawn(function()
        mR.CFrame = tR.CFrame * CFrame.new(0,0,3)
        local start, lc, ok = tick(), 0, false; local GR = ReplicatedStorage:FindFirstChild("GrabRequest")
        while _G.GrabActive and (tick()-start) < 15 do
            if GR then pcall(function() GR:FireServer(target.UserId, "cute") end) end
            if (mR.Position - tR.Position).Magnitude < 1.7 then lc += 1 else lc = 0 end
            if lc >= 5 then ok = true; break end; task.wait(0.2)
        end
        mR.CFrame = iR.CFrame * CFrame.new(0,0,3); task.wait(0.5)
        ChatSend(target.Name .. (ok and " accepted the grab." or " did not accept in time."))
        _G.GrabActive = false
    end)
end
Commands.xbring = Commands.grab

Commands.pf = function(args, speaker)
    StopAll(); task.wait(0.1)
    local target = FindTarget(args[2], speaker)
    if not target or not target.Character then return end
    _G.CurrentCommand = "Pathfind"
    Tracker.setActive(target)
    local PFS = _Q("PathfindingService")
    task.spawn(function()
        while _G.CurrentCommand == "Pathfind" and target and target.Character do
            local c   = LocalPlayer.Character
            local hum = c and c:FindFirstChildWhichIsA("Humanoid")
            local mR  = c and c:FindFirstChild("HumanoidRootPart")
            local tR  = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
            if hum and mR and tR then
                ForceStand()
                local idx, total = SafeIndex(), SafeTotal()
                local ang  = (idx / math.max(total, 1)) * math.pi * 2
                local goal = tR.Position + Vector3.new(math.cos(ang) * 4, 0, math.sin(ang) * 4)
                local path = PFS:CreatePath({ AgentRadius = 2, AgentHeight = 5, AgentCanJump = true, WaypointSpacing = 4 })
                local okC = pcall(function() path:ComputeAsync(mR.Position, goal) end)
                if okC and path.Status == Enum.PathStatus.Success then
                    for _, wp in ipairs(path:GetWaypoints()) do
                        if _G.CurrentCommand ~= "Pathfind" then break end
                        if wp.Action == Enum.PathWaypointAction.Jump then pcall(function() hum.Jump = true end) end
                        hum:MoveTo(wp.Position)
                        local reached, t0 = false, tick()
                        local cn = hum.MoveToFinished:Connect(function() reached = true end)
                        repeat task.wait(0.05) until reached or (tick() - t0) > 2 or _G.CurrentCommand ~= "Pathfind"
                        cn:Disconnect()
                        local ntR = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                        if ntR and (ntR.Position - tR.Position).Magnitude > 8 then break end
                    end
                else
                    hum:MoveTo(goal)
                end
            end
            task.wait(0.2)
        end
    end)
end

Commands.lwonder = function(args, speaker)
    StopAll(); task.wait(0.1)
    _G.CurrentCommand = "LWonder"
    task.spawn(function()
        local idx = SafeIndex()
        if idx == 1 then
            while _G.CurrentCommand == "LWonder" do
                local c = LocalPlayer.Character; local h = c and c:FindFirstChild("Humanoid")
                local r = c and c:FindFirstChild("HumanoidRootPart")
                if h and r then
                    ForceStand()
                    local rng = Random.new(tick())
                    h:MoveTo(r.Position + Vector3.new(rng:NextNumber(-35, 35), 0, rng:NextNumber(-35, 35)))
                    local done, t, cn = false, 0, nil
                    cn = h.MoveToFinished:Connect(function() done = true end)
                    repeat task.wait(0.1); t += 0.1 until done or _G.CurrentCommand ~= "LWonder" or t > 8
                    if cn then cn:Disconnect() end
                end
                task.wait(math.random(1, 2))
            end
        else
            while _G.CurrentCommand == "LWonder" do
                local c  = LocalPlayer.Character; local h = c and c:FindFirstChild("Humanoid")
                local mR = c and c:FindFirstChild("HumanoidRootPart")
                local aheadName = GetOnlineBotNames()[idx - 1]
                local lead
                if aheadName then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p.Name:lower() == aheadName then lead = p; break end
                    end
                end
                local lR = lead and lead.Character and lead.Character:FindFirstChild("HumanoidRootPart")
                if h and mR and lR then
                    ForceStand()
                    local goal = lR.Position - (lR.CFrame.LookVector * 4)
                    if (mR.Position - goal).Magnitude > 60 then
                        mR.CFrame = CFrame.new(goal, lR.Position)
                    else
                        h:MoveTo(goal)
                    end
                end
                task.wait(0.2)
            end
        end
    end)
end

Commands.index = function(args, speaker)
    task.spawn(function()
        task.wait((SafeIndex() - 1) * 0.15)
        ChatSend("[Bot#" .. SafeIndex() .. "]")
    end)
end

Commands.pvp = function(args, speaker)
    local shouldRun, newArgs = ParseBotTarget(args)
    if not shouldRun then return end
    local rs = _Q("ReplicatedStorage")
    local pvpEvent = rs:FindFirstChild("event_option_pvp")
    if pvpEvent then
        pcall(function() pvpEvent:FireServer() end)
    end
end

Commands.say = function(args, speaker)
    local m = table.concat(args, " ", 2)
    if m ~= "" then task.spawn(function() task.wait((SafeIndex()-1)*0.15); ChatSend(m) end) end
end
Commands.chat = Commands.say

Commands.report = function(args, speaker)
    local shouldRun, newArgs = ParseBotTarget(args)
    if not shouldRun then return end

    local targetNameQuery = newArgs[2]
    local reasonQuery = newArgs[3]
    if not targetNameQuery or not reasonQuery then return end

    local tp = FindTarget(targetNameQuery, speaker)
    if not tp then return end

    local abuseReasons = {
        "Swearing", "Personal information", "Dating/Sex", "Cheating",
        "Username", "Bullying", "Scamming"
    }
    local targetReason = nil
    local qLower = reasonQuery:lower()
    for _, r in ipairs(abuseReasons) do
        if r:lower():sub(1, #qLower) == qLower then
            targetReason = r
            break
        end
    end
    if not targetReason then return end

    task.spawn(function()
        local idx = SafeIndex() or 1
        local delayCounter = 0
        local rng = Random.new()

        for _ = 1, idx - 1 do
            delayCounter = delayCounter + rng:NextNumber(5, 10)
        end

        task.wait(delayCounter)

        local VIM = _Q("VirtualInputManager")
        local CoreGui = _Q("CoreGui")

        local function ClickElement(element)
            if not element then return false end
            local ok, err = pcall(function()
                local pos = element.AbsolutePosition
                local size = element.AbsoluteSize
                local cx = pos.X + size.X / 2
                local cy = pos.Y + size.Y / 2
                VIM:SendMouseButtonEvent(cx, cy, 0, true, game, 1)
                task.wait(0.05)
                VIM:SendMouseButtonEvent(cx, cy, 0, false, game, 1)
            end)
            return ok
        end

        local function FindAndClick(searchText, exact)
            local result = nil
            for _, v in ipairs(CoreGui:GetDescendants()) do
                local ok2, ret = pcall(function()
                    if (v:IsA("TextLabel") or v:IsA("TextButton")) then
                        local t = v.Text
                        local match = false
                        if exact then
                            match = (t == searchText)
                        else
                            match = (t:find(searchText, 1, true) ~= nil)
                        end
                        if match then
                            local target = v
                            if not target:IsA("GuiButton") then
                                local p = target.Parent
                                for _ = 1, 5 do
                                    if not p or p == CoreGui then break end
                                    if p:IsA("GuiButton") or p:IsA("ImageButton") or p:IsA("TextButton") then
                                        target = p
                                        break
                                    end
                                    p = p.Parent
                                end
                            end
                            return target
                        end
                    end
                    return nil
                end)
                if ok2 and ret then
                    result = ret
                    break
                end
            end
            if result then
                return ClickElement(result)
            end
            return false
        end

        local tDisplay = tp.DisplayName
        local tUser = tp.Name
        if not FindAndClick(tDisplay, true) then
            FindAndClick(tUser, true)
        end
        task.wait(0.8)

        FindAndClick("Report Abuse", true)
        task.wait(2.0)

        FindAndClick("Choose One", true)
        task.wait(1.0)

        FindAndClick(targetReason, true)
        task.wait(1.0)

        FindAndClick("Submit", true)
    end)
end

local function SimClick(element)
    if not element then return false end
    local clicked = false

    pcall(function()
        if not clicked and type(getgenv().fireclick) == "function" then
            getgenv().fireclick(element)
            clicked = true
        end
    end)

    pcall(function()
        if not clicked and type(getgenv().firesignal) == "function" then
            getgenv().firesignal(element.MouseButton1Click)
            clicked = true
        end
    end)

    pcall(function()
        if not clicked and type(getgenv().getconnections) == "function" then
            for _, conn in pairs(getgenv().getconnections(element.MouseButton1Click) or {}) do
                pcall(function() conn:Fire() end)
                clicked = true
            end
            for _, conn in pairs(getgenv().getconnections(element.Activated) or {}) do
                pcall(function() conn:Fire() end)
                clicked = true
            end
        end
    end)

    pcall(function()
        if not clicked then
            local VIM = _Q("VirtualInputManager")
            local guiInset = _Q("GuiService"):GetGuiInset()
            local pos = element.AbsolutePosition
            local size = element.AbsoluteSize
            local cx = pos.X + size.X / 2
            local cy = pos.Y + size.Y / 2 + guiInset.Y
            VIM:SendMouseButtonEvent(cx, cy, 0, true, game, 1)
            task.wait(0.05)
            VIM:SendMouseButtonEvent(cx, cy, 0, false, game, 1)
            clicked = true
        end
    end)

    return clicked
end

local function FindGuiByText(searchText, exact, root)
    root = root or _Q("CoreGui")
    for _, v in ipairs(root:GetDescendants()) do
        local ok, res = pcall(function()
            if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("ImageButton") then
                local t = ""
                pcall(function() t = v.Text end)
                local match = false
                if exact then match = (t == searchText)
                else match = (t:find(searchText, 1, true) ~= nil) end
                if match then
                    local target = v
                    if not target:IsA("GuiButton") then
                        local p = target.Parent
                        for _ = 1, 6 do
                            if not p or p == root then break end
                            if p:IsA("GuiButton") or p:IsA("TextButton") or p:IsA("ImageButton") then
                                target = p; break
                            end
                            p = p.Parent
                        end
                    end
                    return target
                end
            end
            return nil
        end)
        if ok and res then return res end
    end
    return nil
end

local function FindAndSimClick(searchText, exact, root)
    local el = FindGuiByText(searchText, exact, root)
    if el then return SimClick(el) end
    return false
end

Commands.friend = function(args, speaker)
    local shouldRun, newArgs = ParseBotTarget(args)
    if not shouldRun then return end
    local tp = FindTarget(newArgs[2], speaker)
    if not tp then return end

    task.spawn(function()
        local idx = SafeIndex() or 1
        local rng = Random.new()
        local delay = 0
        for _ = 1, idx - 1 do delay = delay + rng:NextNumber(3, 6) end
        task.wait(delay)

        pcall(function()
            _Q("StarterGui"):SetCore("PromptSendFriendRequest", tp)
        end)
        task.wait(1.5)

        FindAndSimClick("Send Request", true)
    end)
end

Commands.block = function(args, speaker)
    local shouldRun, newArgs = ParseBotTarget(args)
    if not shouldRun then return end
    local tp = FindTarget(newArgs[2], speaker)
    if not tp then return end

    task.spawn(function()
        local idx = SafeIndex() or 1
        local rng = Random.new()
        local delay = 0
        for _ = 1, idx - 1 do delay = delay + rng:NextNumber(3, 6) end
        task.wait(delay)

        local tDisplay = tp.DisplayName
        local tUser = tp.Name
        if not FindAndSimClick(tDisplay, true) then
            FindAndSimClick(tUser, true)
        end
        task.wait(1.0)

        FindAndSimClick("Block", true)
        task.wait(1.5)

        local CoreGui = _Q("CoreGui")
        local clicked = false
        for _, v in ipairs(CoreGui:GetDescendants()) do
            local ok, res = pcall(function()
                if (v:IsA("TextButton") or v:IsA("TextLabel")) and v.Text == "Block" then
                    local target = v
                    if not target:IsA("GuiButton") then
                        local p = target.Parent
                        for _ = 1, 5 do
                            if not p then break end
                            if p:IsA("GuiButton") then target = p; break end
                            p = p.Parent
                        end
                    end
                    return target
                end
                return nil
            end)
            if ok and res and not clicked then
                SimClick(res)
                clicked = true
            end
        end
    end)
end

Commands.rejoin = function(args, speaker)
    if not IsSoloCommand(args) then return end
    if _G.HyperionRejoinPending then return end
    StopAll()
    task.spawn(function()
        ChatSend("Rejoining...")
        task.wait(1)
        doRejoinTP("command")
    end)
end

Commands.countdown = function(args, speaker)
    local count = tonumber(args[2]); if not count then return end
    count = math.clamp(count, 1, 30); local total = SafeTotal(); local idx = SafeIndex()
    task.spawn(function()
        for i = count, 1, -1 do
            local botForNum = ((i-1) % total) + 1
            if botForNum == idx then ChatSend(tostring(i) .. "...") end
            task.wait(1)
        end
        if idx == 1 then ChatSend("GO! 🚀") end
    end)
end

local ReplicateEngine = {}
do
    local active
    local tweenService = _Q("TweenService")

    local function statsPath(player)
        return "HyperionReplicate_" .. game.JobId .. "_" .. player.UserId
    end
    local requestCheck, requestedUntil, sampleAt = 0, 0, 0
    getgenv().TrackConnection(RunService.Heartbeat:Connect(function()
        local now = workspace:GetServerTimeNow()
        if now >= requestCheck then
            requestCheck = now + 0.5

            local reqPath = statsPath(LocalPlayer) .. "_request.txt"
            pcall(function()
                if isfile and not isfile(reqPath) then requestedUntil = 0; return end
                requestedUntil = tonumber(readfile(reqPath)) or 0
            end)
        end
        if now >= requestedUntil or now < sampleAt then return end
        sampleAt = now + 0.1
        local c = LocalPlayer.Character
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if h then pcall(function()
            writefile(statsPath(LocalPlayer) .. "_stats.json", HttpService:JSONEncode({
                time = now, userId = LocalPlayer.UserId, WalkSpeed = h.WalkSpeed,
                UseJumpPower = h.UseJumpPower, JumpPower = h.JumpPower, JumpHeight = h.JumpHeight}))
        end) end
    end))

    local function targetStats(a, hum)
        local now = workspace:GetServerTimeNow()
        if now >= (a.statsRequestAt or 0) then
            a.statsRequestAt = now + 1
            pcall(writefile, statsPath(a.target) .. "_request.txt", tostring(now + 3))
        end
        if now >= (a.statsReadAt or 0) then
            a.statsReadAt = now + 0.1
            local ok, data = pcall(function() return HttpService:JSONDecode(readfile(statsPath(a.target) .. "_stats.json")) end)
            a.targetStats = ok and type(data) == "table" and data or nil
        end
        local data = a.targetStats
        if data and data.userId == a.target.UserId and type(data.time) == "number"
            and now - data.time >= 0 and now - data.time < 0.75
            and type(data.WalkSpeed) == "number" and type(data.JumpPower) == "number"
            and type(data.JumpHeight) == "number" and type(data.UseJumpPower) == "boolean" then return data end
        return hum
    end

    local function formation(mode, i, n)
        if mode == 1 then
            local half = math.ceil(n / 2)
            return CFrame.new(i <= half and -4 * i or 4 * (i - half), 0, 0)
        elseif mode == 2 then
            local row, slot = 1, i
            while slot > row do slot = slot - row; row = row + 1 end
            return CFrame.new((slot - (row + 1) / 2) * 4, 0, row * 4)
        elseif mode == 3 then
            local row = math.ceil(i / 2)
            return CFrame.new((i % 2 == 1 and -1 or 1) * row * 4, 0, row * 4)
        end
        return CFrame.new()
    end

    local function stopCopies(a)
        for _, copy in pairs(a.tracks) do
            pcall(function() copy:Stop(0.1); copy:Destroy() end)
        end
        a.tracks, a.retry = {}, {}
    end

    local function restoreBody(a)
        stopCopies(a)
        if a.animate and a.animate.Parent then a.animate.Disabled = a.animateDisabled end
        if a.hum and a.hum.Parent and a.stats then
            for key, value in pairs(a.stats) do pcall(function() a.hum[key] = value end) end
        end
        a.hum, a.animator, a.animate, a.stats = nil, nil, nil, nil
    end

    function ReplicateEngine.stop()
        local a = active
        active = nil
        if not a then return end
        if a.conn then a.conn:Disconnect() end
        if a.tween then a.tween:Cancel() end
        WeldEngine.stop()
        restoreBody(a)
        a.pose:Destroy()
    end

    local function bindBody(a, hum, char, animator)
        if a.hum == hum and a.animator == animator then return end
        restoreBody(a)
        a.hum, a.animator = hum, animator
        a.stats = {WalkSpeed = hum.WalkSpeed, UseJumpPower = hum.UseJumpPower,
            JumpPower = hum.JumpPower, JumpHeight = hum.JumpHeight}
        local animate = char:FindFirstChild("Animate")
        if animate and animate:IsA("LocalScript") then
            a.animate, a.animateDisabled = animate, animate.Disabled
            animate.Disabled = true
        end

        if animator then
            for _, track in ipairs(animator:GetPlayingAnimationTracks()) do track:Stop(0.1) end
        end
    end

    local function copyAnimations(a, sourceAnimator)
        if not (a.animator and sourceAnimator) then stopCopies(a); return end
        local seen = {}
        for _, source in ipairs(sourceAnimator:GetPlayingAnimationTracks()) do
            local animation = source.Animation
            if source.IsPlaying and animation and animation.AnimationId ~= "" then
                seen[source] = true
                local copy = a.tracks[source]
                if not copy and os.clock() >= (a.retry[source] or 0) then
                    local asset = Instance.new("Animation")
                    asset.AnimationId = animation.AnimationId
                    local ok, track = pcall(function() return a.animator:LoadAnimation(asset) end)
                    asset:Destroy()
                    if ok and track then
                        copy = track
                        a.tracks[source] = track
                    else
                        a.retry[source] = os.clock() + 2
                    end
                end
                if copy then
                    copy.Priority = source.Priority
                    copy.Looped = source.Looped
                    if not copy.IsPlaying then copy:Play(0.1, source.WeightCurrent, source.Speed) end
                    copy:AdjustSpeed(source.Speed)
                    copy:AdjustWeight(source.WeightCurrent, 0.05)
                    if copy.Length > 0 then
                        local t = source.TimePosition
                        if source.Looped then t = t % copy.Length end
                        local delta = math.abs(copy.TimePosition - t)
                        if source.Looped then delta = math.min(delta, math.abs(copy.Length - delta)) end
                        if delta > 0.08 then copy.TimePosition = t end
                    end
                end
            end
        end
        for source, copy in pairs(a.tracks) do
            if not seen[source] then copy:Stop(0.1); copy:Destroy(); a.tracks[source] = nil end
        end
        for source in pairs(a.retry) do if not seen[source] then a.retry[source] = nil end end
    end

    function ReplicateEngine.chat(speaker, message)
        local a = active
        if not a or a.target ~= speaker then return false end
        if type(message) ~= "string" or message == "" then return true end

        local musicPrefix = getgenv().Settings.musicPrefix or "/"
        if MatchedPrefix(message, speaker) or message:sub(1, #musicPrefix) == musicPrefix then return true end
        if a.pending >= 32 then return true end
        a.pending = a.pending + 1
        local due = math.max(os.clock() + a.random:NextNumber(0, 1.5), a.lastChatAt)
        a.lastChatAt = due
        task.delay(math.max(0, due - os.clock()), function()
            a.pending = a.pending - 1
            if active == a and _G.CurrentCommand == "Replicate" and a.target.Parent then ChatSend(message) end
        end)
        return true
    end

    function ReplicateEngine.start(mode, target)
        ReplicateEngine.stop()
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return false end
        local a = {mode = mode, target = target, tracks = {}, retry = {}, pending = 0,
            random = Random.new(), lastChatAt = 0, nextUpdate = 0, initial = true}
        a.pose = Instance.new("CFrameValue")
        a.pose.Name = "HyperionReplicatePose"
        a.pose.Value = root.CFrame
        active = a

        WeldEngine.start("Replicate", function() return target.Character end,
            function() return a.pose.Value end,
            {physicsPin = getgenv().Settings.replicatePin == true, idle = false})
        a.conn = RunService.Heartbeat:Connect(function()
            if active ~= a then return end
            if _G.CurrentCommand ~= "Replicate" or not target.Parent then
                ReplicateEngine.stop()
                if _G.CurrentCommand == "Replicate" then _G.CurrentCommand = "None" end
                return
            end
            local now = os.clock()
            if now < a.nextUpdate then return end
            a.nextUpdate = now + 0.05
            local c, tc = LocalPlayer.Character, target.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            local th = tc and tc:FindFirstChildOfClass("Humanoid")
            local tr = tc and tc:FindFirstChild("HumanoidRootPart")
            if not h then restoreBody(a); return end
            bindBody(a, h, c, h:FindFirstChildOfClass("Animator"))
            if not (th and tr) then
                if a.tween then a.tween:Cancel(); a.tween = nil end
                stopCopies(a)
                a.initial = true
                return
            end
            local stats = targetStats(a, th)
            h.WalkSpeed, h.UseJumpPower = stats.WalkSpeed, stats.UseJumpPower
            h.JumpPower, h.JumpHeight = stats.JumpPower, stats.JumpHeight
            local goal = tr.CFrame * formation(mode, SafeIndex(), math.max(1, SafeTotal()))
            if a.tween then a.tween:Cancel() end
            a.tween = tweenService:Create(a.pose,
                TweenInfo.new(math.clamp((goal.Position - a.pose.Value.Position).Magnitude / 40, 0.1, 1.2), Enum.EasingStyle.Linear), {Value = goal})
            a.initial = false
            a.tween:Play()
            local ok, err = pcall(copyAnimations, a, th:FindFirstChildOfClass("Animator"))
            if not ok and not a.warned then a.warned = true; warn("[Hyperion] replicate animation: " .. tostring(err)) end
        end)
        getgenv().TrackConnection(a.conn)
        return true
    end
    _G.HyperionReplicateStop = ReplicateEngine.stop
    _G.HyperionReplicateChat = ReplicateEngine.chat
end

local function RunReplicate(args, speaker, mode)
    local target = FindTarget(table.concat(args, " ", 2), speaker)
    if not target or target == LocalPlayer then return end
    StopAll()
    _G.CurrentCommand = "Replicate"
    Tracker.setActive(target)
    if not ReplicateEngine.start(mode, target) then _G.CurrentCommand = "None" end
end
for mode = 1, 3 do
    local style = mode
    Commands["replicate" .. style] = function(args, speaker) RunReplicate(args, speaker, style) end
end
Commands.replicate = Commands.replicate1
Commands.unreplicate = function()
    ReplicateEngine.stop()
    if _G.CurrentCommand == "Replicate" then _G.CurrentCommand = "None" end
end

local function GetCommandList()
    return {
        "bring","goto","walkto","follow","wonder","lwonder","stalk","worm","swarm","pf",
        "circle","loopcircle","rline","lline","fline","bline","looprline","looplline","loopfline","loopbline",
        "arrow","box","carpet","stackon","orbit","spiral",
        "mirror","rmirror","lmirror","fmirror","bmirror","firework","spin","rest","bam",
        "freeze","unfreeze","ref","ws","unws","noclip","clip","headsit","stareat","unstareat",
        "jpower","unjpower","headsize","hatspin","unhatspin","fix","forcereset","antifling","unantifling",
        "emote <name>","unemote","sync","unsync","dance","dance2","dance3","jump","sit","wave","laugh","point","cheer",
        "replicate","replicate1-3","unreplicate","clone","loopclone","unloopclone",
        "w","mimic","unmimic","friend","block","npc","say","spam","unspam","countdown","credits","report",
        "pvp","grab","grab near","gentool",
        "ping","ram","uptime","altcount","index","vcb","vcbreset","vcbtest [sec]","cmds",
        "tp","scatter","antivoid","unantivoid","whitelist [count]","blacklist [all]","stop","rejoin","quit",
    }
end

Commands.cmds = function(args, speaker)
    if not IsSoloCommand(args) then return end
    _G.CurrentCommand = "HelpPresentation"
    local idx, total = SafeIndex(), SafeTotal()
    local admin = speaker
    if admin and admin.Character and admin.Character:FindFirstChild("HumanoidRootPart") then
        local aR = admin.Character.HumanoidRootPart
        local podCF = aR.CFrame * CFrame.new(0,0,-8) * CFrame.Angles(0,math.pi,0)
        local xOff = (idx-(total/2+0.5))*4
        local wait = aR.CFrame * CFrame.new(xOff,0,-15) * CFrame.Angles(0,math.pi,0)
        local all = GetCommandList(); local cs = math.ceil(#all/math.max(total,1))
        local ms, me = ((idx-1)*cs)+1, math.min(idx*cs, #all)
        local mb = {}; for i = ms, me do table.insert(mb, all[i]) end
        task.spawn(function()
            local mR = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if mR then mR.CFrame = wait; task.wait((idx-1)*10)
                if _G.CurrentCommand == "HelpPresentation" then
                    mR.CFrame = podCF; task.wait(0.5)

                    if #mb > 0 then
                        local MAXLEN = 150
                        local part, partNo = "", 0
                        local function flush()
                            if part ~= "" then
                                partNo = partNo + 1
                                ChatSend("Batch ["..idx.."/"..total.."] "..partNo..": "..part)
                                part = ""
                                task.wait(0.7)
                            end
                        end
                        for _, tok in ipairs(mb) do
                            local add = (part == "") and tok or (part..", "..tok)
                            if #add > MAXLEN then flush(); part = tok else part = add end
                        end
                        flush()
                    end
                    task.wait(9)
                    if _G.CurrentCommand == "HelpPresentation" then mR.CFrame = wait end
                end
            end
        end)
    end
end
Commands.help = Commands.cmds

local function BotObeys(speaker)
    if not speaker then return false end
    if IsHardOwner(speaker) then return true end
    if not _G.HyperionKeyOK then return false end
    local w = getgenv().ManualWhitelist[speaker.Name:lower()]
    if not w then return false end
    if w == true then return true end
    if type(w) == "table" then
        local i = SafeIndex()
        for _, s in ipairs(w) do if s == i then return true end end
        return false
    end
    return true
end

getgenv().Execute = function(msg, speaker)
    if isMainAccount then return end

    local prefix = MatchedPrefix(msg, speaker)
    if not prefix then return end
    local args = msg:split(" ")
    local cmd = args[1]:lower():sub(#prefix + 1)

    if cmd == "whitelist" or cmd == "blacklist" then
        if not (IsHardOwner(speaker)
            or (_G.HyperionKeyOK and speaker.Name:lower() == getgenv().Settings.mainAccount:lower())) then return end
    else
        if not BotObeys(speaker) then return end
    end

    local shouldRun, newArgs, botTargeted = ParseBotTarget(args)
    if not shouldRun then return end
    _G.CmdBotTargeted = botTargeted

    local handler = Commands[cmd]
    if handler then
        local ok, err = pcall(handler, newArgs, speaker)
        if not ok then warn("[Hyperion] Error (" .. cmd .. "): " .. tostring(err)) end
    end
end

local function SetupChatListener(p)
    getgenv().TrackConnection(p.Chatted:Connect(function(msg)
        local nl = p.Name:lower()

        local mp = MatchedPrefix(msg, p)

        if (getgenv().ManualWhitelist[nl] or IsHardOwner(p)) and mp then

            getgenv().Execute(msg, p)
        end

        if _G.HyperionReplicateChat and _G.HyperionReplicateChat(p, msg) then return end

        if _G.Mimicking and _G.MimicTarget == nl then

            if MatchedPrefix(msg, p) == nil then
                local idx = SafeIndex() or 1
                task.spawn(function()

                    task.wait((idx - 1) * 0.15)
                    ChatSend(msg)
                end)
            end
        end
    end))
end

for _, p in ipairs(Players:GetPlayers()) do SetupChatListener(p) end
getgenv().TrackConnection(Players.PlayerAdded:Connect(function(p) SetupChatListener(p) end))

local function HandlePasscode(p, message)
    if message ~= "ᕦ(ò_óˇ)ᕤ" then return end
    local nl = p.Name:lower()
    if not getgenv().ManualWhitelist[nl] then
        getgenv().ManualWhitelist[nl] = true
        if SafeIndex() == 1 then ChatSend(p.Name .. " whitelisted") end
    end
end

for _, p in ipairs(Players:GetPlayers()) do
    getgenv().TrackConnection(p.Chatted:Connect(function(m) HandlePasscode(p, m) end))
end
getgenv().TrackConnection(Players.PlayerAdded:Connect(function(p)
    getgenv().TrackConnection(p.Chatted:Connect(function(m) HandlePasscode(p, m) end))
end))

if isAltAccount and not isMainAccount then
    pcall(function() setfpscap(getgenv().Settings.fpsCap or 10) end)
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
    pcall(function() settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04 end)
    pcall(function() Lighting.GlobalShadows = false; Lighting.FogEnd = 1e10 end)
    pcall(function()
        workspace.Terrain.Decoration = false; workspace.Terrain.WaterReflectance = 0; workspace.Terrain.WaterTransparency = 0
        workspace.Terrain.WaterWaveSize = 0; workspace.Terrain.WaterWaveSpeed = 0
    end)
    task.spawn(function()
        for _, v in ipairs(game:GetDescendants()) do pcall(function()
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then v.Enabled = false
            elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("SurfaceGui") then v:Destroy()
            elseif v:IsA("Sound") then v.Volume = 0; v.Playing = false
            elseif v:IsA("BasePart") then v.Material = Enum.Material.Plastic; v.Reflectance = 0; v.CastShadow = false
            elseif v:IsA("PostEffect") then v.Enabled = false
            elseif v:IsA("Sky") then v:Destroy() end
        end) end
    end)
    getgenv().TrackConnection(game.DescendantAdded:Connect(function(v) pcall(function()
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then v.Enabled = false
        elseif v:IsA("Sound") then v.Volume = 0
        elseif v:IsA("PostEffect") then v.Enabled = false end
    end) end))
end

if isMainAccount then
    local UI  = HyperionUI
    local T   = UI.theme
    local UIS = _Q("UserInputService")

    local SECTIONS = {
        {
            name = "Movement",
            color = Color3.fromRGB(60,160,255),
            cmds = {
                {cmd="goto",   desc="Teleports to player",      al="[bot] Target",          ha=true},
                {cmd="follow", desc="Follows target",           al="[bot] Target",          ha=true},
                {cmd="walkto", desc="Walks to target",          al="[bot] Target",          ha=true},
                {cmd="bring",  desc="Summons bots directly",    al="[bot] Target",          ha=true},
                {cmd="wonder", desc="Randomly wanders",         ha=false},
                {cmd="stalk",  desc="Stalks from behind",       al="[bot] Target",          ha=true},
                {cmd="worm",   desc="Forms snake chain",        al="[bot] Target",          ha=true},
                {cmd="swarm",  desc="Chaotic swarming",         al="[bot] [Spd] [R] Target",ha=true},
                {cmd="carpet", desc="Grid pattern formation",   al="[bot] Target",          ha=true},
                {cmd="tp",     desc="Teleports via coords",     al="[bot] X Y Z / Target",  ha=true},
                {cmd="scatter",desc="Random scattering",        al="[bot] Range",           ha=true},
                {cmd="pf",     desc="Pathfinds around walls",   al="[bot] Target",          ha=true},
                {cmd="lwonder",desc="Bot01 leads, rest trail",  ha=false},
            },
        },
        {
            name = "Formations",
            color = Color3.fromRGB(255,160,40),
            cmds = {
                {cmd="circle",    desc="Snaps to circle",   al="[R] Target",ha=true},
                {cmd="loopcircle",desc="Iterative circle",  al="[R] Target",ha=true},
                {cmd="arrow",     desc="V-shape pattern",   al="Target",    ha=true},
                {cmd="box",       desc="Square array",      al="Target",    ha=true},
                {cmd="stackon",   desc="Vertical tower",    al="Target",    ha=true},
                {cmd="rline",     desc="Right side line",   al="Target",    ha=true},
                {cmd="lline",     desc="Left side line",    al="Target",    ha=true},
                {cmd="fline",     desc="Forward line",      al="Target",    ha=true},
                {cmd="bline",     desc="Rear line",         al="Target",    ha=true},
                {cmd="looprline", desc="Loop active right", al="Target",    ha=true},
                {cmd="looplline", desc="Loop active left",  al="Target",    ha=true},
                {cmd="loopfline", desc="Loop active front", al="Target",    ha=true},
                {cmd="loopbline", desc="Loop active rear",  al="Target",    ha=true},
            },
        },
        {
            name = "Orbits",
            color = Color3.fromRGB(200,80,255),
            cmds = {
                {cmd="orbit",   desc="Flat circular orbit",  al="[Spd] [R] Target",ha=true},
            },
        },
        {
            name = "Spirals",
            color = Color3.fromRGB(160,60,220),
            cmds = {
                {cmd="spiral",  desc="Ascending helix", al="[Spd] [R] Target",ha=true},
            },
        },
        {
            name = "Action",
            color = Color3.fromRGB(255,70,70),
            cmds = {
                {cmd="firework",  desc="Particle array launch",                          ha=false},
                {cmd="spin",      desc="Axial rotation",        al="Speed",             ha=true},
                {cmd="mirror",    desc="Mimics movement",       al="Target",            ha=true},
                {cmd="rest",      desc="Character reset",       al="[bot]",             ha=true},
                {cmd="bam",       desc="Blinds target camera",  al="Target",            ha=true},
                {cmd="rmirror",   desc="Mirror, offset right",  al="Target",            ha=true},
                {cmd="lmirror",   desc="Mirror, offset left",   al="Target",            ha=true},
                {cmd="fmirror",   desc="Mirror, offset front",  al="Target",            ha=true},
                {cmd="bmirror",   desc="Mirror, offset rear",   al="Target",            ha=true},
            },
        },
        {
            name = "Character",
            color = Color3.fromRGB(100,200,255),
            cmds = {
                {cmd="freeze",   desc="Locks root part",                     ha=false},
                {cmd="unfreeze", desc="Unlocks root part",                   ha=false},
                {cmd="ref",      desc="Refreshes avatar",                    ha=false},
                {cmd="ws",       desc="Overrides base speeed",  al="Speed",  ha=true},
                {cmd="unws",     desc="Restores base speed",                 ha=false},
                {cmd="noclip",   desc="Disables collisions",                 ha=false},
                {cmd="clip",     desc="Restores collisions",                 ha=false},
                {cmd="headsit",  desc="Sit on target's head",  al="Target",  ha=true},
                {cmd="stareat",  desc="Face target constantly", al="Target", ha=true},
                {cmd="unstareat",desc="Stop staring",                        ha=false},
                {cmd="jpower",   desc="Set jump power",        al="Number",  ha=true},
                {cmd="unjpower", desc="Reset jump power",                    ha=false},
                {cmd="headsize", desc="Resize own head",       al="Size",    ha=true},
                {cmd="hatspin",  desc="Spin accessories",                    ha=false},
                {cmd="unhatspin",desc="Stop hat spin",                       ha=false},
                {cmd="fix",      desc="Unstick, keep command",               ha=false},
                {cmd="forcereset",desc="Forces a respawn",                   ha=false},
                {cmd="antifling",desc="Blocks fling (persist)",              ha=false},
                {cmd="unantifling",desc="Ends anti-fling",                   ha=false},
            },
        },
        {
            name = "Emotes",
            color = Color3.fromRGB(255,200,60),
            cmds = {
                {cmd="emote",   desc="Plays catalog emote", al="Name",    ha=true},
                {cmd="unemote", desc="Stops active emote",                ha=false},
                {cmd="sync",     desc="Mirror player's emote", al="Username", ha=true},
                {cmd="unsync",   desc="Stop mirroring",                    ha=false},
                {cmd="dance",  desc="Executes Dance 1", ha=false},
                {cmd="dance2", desc="Executes Dance 2", ha=false},
                {cmd="dance3", desc="Executes Dance 3", ha=false},
                {cmd="jump",   desc="Triggers hop",     ha=false},
                {cmd="sit",    desc="Drops stance",     ha=false},
                {cmd="wave",   desc="Friendly hail",    ha=false},
                {cmd="laugh",  desc="Plays /e laugh",   ha=false},
                {cmd="point",  desc="Plays /e point",   ha=false},
                {cmd="cheer",  desc="Plays /e cheer",   ha=false},
            },
        },
        {
            name = "Replicate",
            color = Color3.fromRGB(100,180,240),
            cmds = {
                {cmd="replicate",desc="Copy stats, animations and chat",al="[Target]",ha=true},
                {cmd="replicate1",desc="Left/right split",al="[Target]",ha=true},
                {cmd="replicate2",desc="Triangle behind",al="[Target]",ha=true},
                {cmd="replicate3",desc="V formation",al="[Target]",ha=true},
                {cmd="unreplicate",desc="Stop replication; restore bot",ha=false},
            },
        },
        {
            name = "Clone",
            color = Color3.fromRGB(180,120,255),
            cmds = {
                {cmd="clone",      desc="Copies target avatar", al="Target", ha=true},
                {cmd="loopclone",  desc="Re-clones on respawn",             ha=false},
                {cmd="unloopclone",desc="Ceases cloning",                   ha=false},
            },
        },
        {
            name = "Chat",
            color = Color3.fromRGB(100,255,160),
            cmds = {
                {cmd="w",        desc="Whispers string",    al="Target Msg", ha=true},
                {cmd="report",   desc="Triggers user report",al="Target Reason",ha=true},
                {cmd="mimic",    desc="Mirrors target's chat",al="Target",   ha=true},
                {cmd="unmimic",  desc="Halts chat mirror",                   ha=false},
                {cmd="friend",   desc="Sends friend request",al="Target",    ha=true},
                {cmd="block",    desc="Blocks target player",al="Target",    ha=true},
                {cmd="npc",      desc="Triggers wandering AI",            ha=false},
                {cmd="say",      desc="Broadcasts string",  al="Message", ha=true},
                {cmd="spam",     desc="Loops string output",al="[Dly] Msg",ha=true},
                {cmd="unspam",   desc="Halts string loop",                ha=false},
                {cmd="countdown",desc="Staggered counting", al="Number",  ha=true},
                {cmd="credits",  desc="Lists attributions",               ha=false},
            },
        },
        {
            name = "Mic Up",
            color = Color3.fromRGB(255,100,100),
            cmds = {
                {cmd="pvp",        desc="Toggles Mic Up PVP",    al="[on/off]", ha=false},
                {cmd="grab",       desc="Detains instance",      al="Target",   ha=true},
                {cmd="gentool",    desc="Requests AI asset",     al="[Size] Prompt",ha=true},
            },

        },
        {
            name = "Info",
            color = Color3.fromRGB(180,180,200),
            cmds = {
                {cmd="ping",    desc="Analyzes latency",                       ha=false},
                {cmd="ram",     desc="Analyzes memory",                        ha=false},
                {cmd="uptime",  desc="Core session length",                    ha=false},
                {cmd="altcount",desc="Counts total units",                     ha=false},
                {cmd="index",   desc="Announces own index",                     ha=false},
                {cmd="vcb",     desc="Counts VC bans",                          ha=false},
                {cmd="vcbtest", desc="Simulates a VC ban",                      al="[Seconds]", ha=false},
                {cmd="cmds",    desc="Presents command list",                   ha=false},
            },
        },
        {
            name = "System",
            color = Color3.fromRGB(255,100,100),
            cmds = {
                {cmd="stop",       desc="Halts background tasks",ha=false},
                {cmd="antivoid",   desc="Void immunity up",      ha=false},
                {cmd="unantivoid", desc="Void immunity down",    ha=false},
                {cmd="whitelist",  desc="Grants privileges",     al="Target",ha=true},
                {cmd="blacklist",  desc="Revokes privileges",    al="Target",ha=true},
                {cmd="rejoin",     desc="Rebinds to server",     ha=false},
                {cmd="quit",       desc="Ejects all bots",       ha=false},
            },
        },
    }

    local WW, WH = 252, 486
    local win = UI.window({
        name = "HyperionCommandGUI", title = "Hyperion ALT Control",
        size = UDim2.fromOffset(WW, WH), position = UDim2.new(1, -(WW / 2 + 16), 0.5, 0),
        displayOrder = 100, headerHeight = 36, icon = "rbxassetid://99251435575806",
    })
    local body = win.body

    task.spawn(function()
        while _G.HyperionActive and win.screen.Parent do
            RefreshBotCache(); win.badge("Bots " .. _bc.total, T.Good); task.wait(3)
        end
    end)

    local SF = UI.new("Frame", { Size = UDim2.new(1, -16, 0, 28), Position = UDim2.new(0, 8, 0, 6),
        BackgroundColor3 = T.Raised, BackgroundTransparency = 0.3, BorderSizePixel = 0 }, body)
    UI.corner(SF, 8); UI.new("UIStroke", { Color = T.Line, Transparency = 0.6 }, SF)
    UI.label({ AutoAxis = "X", Position = UDim2.new(0, 9, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 0, 0, 14), Text = "⌕", TextColor3 = T.Muted, TextSize = 14, Font = T.FontB }, SF)
    local SB = UI.new("TextBox", { Size = UDim2.new(1, -32, 1, 0), Position = UDim2.new(0, 26, 0, 0),
        BackgroundTransparency = 1, PlaceholderText = "Search commands…", PlaceholderColor3 = T.Muted, Text = "",
        TextColor3 = T.Text, TextSize = 12, Font = T.FontM, TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false }, SF)

    local listPage = UI.new("ScrollingFrame", { Name = "ListPage", Size = UDim2.new(1, -14, 1, -84),
        Position = UDim2.new(0, 7, 0, 42), BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 3, ScrollBarImageColor3 = T.Accent, CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y }, body)
    UI.new("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3) }, listPage)
    UI.pad(listPage, 2, 6, 2, 2)

    local allCmdBtns = {}
    local ord = 0
    for _, sec in ipairs(SECTIONS) do
        ord = ord + 1
        local secHdr = UI.new("Frame", { Name = "SectionHeader", Size = UDim2.new(1, 0, 0, 22),
            BackgroundColor3 = sec.color, BackgroundTransparency = 0.86, BorderSizePixel = 0, LayoutOrder = ord }, listPage)
        UI.corner(secHdr, 6)
        UI.new("Frame", { Size = UDim2.new(0, 3, 1, -6), Position = UDim2.new(0, 0, 0, 3),
            BackgroundColor3 = sec.color, BorderSizePixel = 0 }, secHdr)
        UI.label({ AutoAxis = "X", Position = UDim2.new(0, 10, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
            Size = UDim2.new(0, 0, 0, 22), Text = sec.name, TextColor3 = sec.color, TextSize = 10, Font = T.FontB,
            TextYAlignment = Enum.TextYAlignment.Center }, secHdr)

        for _, d in ipairs(sec.cmds) do
            ord = ord + 1
            local btn = UI.button({ Name = "btn_" .. d.cmd, Size = UDim2.new(1, 0, 0, 30),
                BackgroundColor3 = T.Raised, HoverColor3 = T.Hover, Text = "", LayoutOrder = ord }, listPage)
            btn.BackgroundTransparency = 0.25
            UI.corner(btn, 6)
            UI.label({ AutoAxis = "X", Position = UDim2.new(0, 9, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
                Size = UDim2.new(0, 0, 0, 30), Text = getgenv().Settings.prefix .. d.cmd, TextColor3 = T.Text,
                TextSize = 11, Font = T.FontB, TextYAlignment = Enum.TextYAlignment.Center }, btn)
            local argBox
            if d.ha then
                local argFrame = UI.new("Frame", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -6, 0.5, 0),
                    Size = UDim2.new(0, 124, 0, 22), BackgroundColor3 = Color3.fromRGB(6, 6, 9), BackgroundTransparency = 0.25,
                    BorderSizePixel = 0 }, btn)
                UI.corner(argFrame, 5); UI.new("UIStroke", { Color = T.Line, Transparency = 0.6 }, argFrame)
                argBox = UI.new("TextBox", { Size = UDim2.new(1, -8, 1, 0), Position = UDim2.new(0, 4, 0, 0),
                    BackgroundTransparency = 1, PlaceholderText = d.al or "args", PlaceholderColor3 = T.Muted, Text = "",
                    TextColor3 = T.Text, TextSize = 9, Font = T.FontC, TextXAlignment = Enum.TextXAlignment.Left,
                    ClearTextOnFocus = false, Active = true }, argFrame)
            end
            btn.MouseButton1Click:Connect(function()
                local fc = getgenv().Settings.prefix .. d.cmd
                if d.ha and argBox and argBox.Text ~= "" then fc = fc .. " " .. argBox.Text end
                ChatSend(fc)
                local was = btn.BackgroundColor3
                UI.tween(btn, { BackgroundColor3 = T.Good }, 0.1)
                task.delay(0.22, function() UI.tween(btn, { BackgroundColor3 = was }, 0.2) end)
            end)
            allCmdBtns[#allCmdBtns + 1] = { btn = btn, def = d, sec = sec }
        end
    end

    SB:GetPropertyChangedSignal("Text"):Connect(function()
        local q = SB.Text:lower()
        local vis = {}
        for _, e in ipairs(allCmdBtns) do
            local show = q == "" or e.def.cmd:find(q, 1, true) or e.def.desc:lower():find(q, 1, true)
                or e.sec.name:lower():find(q, 1, true)
            e.btn.Visible = show and true or false
            if show then vis[e.sec.name] = true end
        end
        for _, child in ipairs(listPage:GetChildren()) do
            if child:IsA("Frame") and child.Name == "SectionHeader" then
                local lbl = child:FindFirstChildOfClass("TextLabel")
                if lbl then child.Visible = (q == "" or vis[lbl.Text] or false) end
            end
        end
    end)

    local stopBtn = UI.button({ Name = "GlobalStopBtn", Size = UDim2.new(1, -16, 0, 30),
        Position = UDim2.new(0, 8, 1, -6), AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = T.Bad:Lerp(T.Base, 0.15), HoverColor3 = T.Bad, Text = "◼  STOP ALL ACTION",
        TextColor3 = Color3.new(1, 1, 1), TextSize = 11, Font = T.FontB }, body)
    UI.corner(stopBtn, 8)
    stopBtn.MouseButton1Click:Connect(function()
        ChatSend(getgenv().Settings.prefix .. "stop")
        local was = stopBtn.BackgroundColor3
        UI.tween(stopBtn, { BackgroundColor3 = T.Good }, 0.1)
        task.delay(0.22, function() UI.tween(stopBtn, { BackgroundColor3 = was }, 0.2) end)
    end)

    UIS.InputBegan:Connect(function(inp, gp)
        if gp then return end
        if inp.KeyCode == Enum.KeyCode.RightShift then win.toggle() end
    end)
end

local AntiFlingEngine = {}
do
    local conn, lastPos
    local isOn = false

    function AntiFlingEngine.enable()
        if isOn then return end
        isOn = true; _G.HyperionAntiFling = true
        conn = RunService.Heartbeat:Connect(function()
            if not isOn then return end

            pcall(function()
                local c  = LocalPlayer.Character
                local pp = c and c:FindFirstChild("HumanoidRootPart")
                if pp then
                    if pp.AssemblyLinearVelocity.Magnitude > 250 or pp.AssemblyAngularVelocity.Magnitude > 250 then
                        pp.AssemblyLinearVelocity  = Vector3.zero
                        pp.AssemblyAngularVelocity = Vector3.zero
                        if lastPos then pp.CFrame = lastPos end
                    elseif pp.AssemblyLinearVelocity.Magnitude < 50 then
                        lastPos = pp.CFrame
                    end
                end
            end)

            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    pcall(function()
                        local ch = p.Character
                        local pp = ch and ch:FindFirstChild("HumanoidRootPart")
                        if pp and (pp.AssemblyAngularVelocity.Magnitude > 50 or pp.AssemblyLinearVelocity.Magnitude > 100) then
                            for _, v in ipairs(ch:GetDescendants()) do
                                if v:IsA("BasePart") then
                                    v.CanCollide = false
                                    v.AssemblyAngularVelocity = Vector3.zero
                                    v.AssemblyLinearVelocity  = Vector3.zero
                                    v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
                                end
                            end
                        end
                    end)
                end
            end
        end)
        if getgenv().TrackConnection then getgenv().TrackConnection(conn) end
    end

    function AntiFlingEngine.disable()
        isOn = false; _G.HyperionAntiFling = false
        if conn then pcall(function() conn:Disconnect() end); conn = nil end
    end

    function AntiFlingEngine.isOn() return isOn end
    _G.HyperionAntiFlingStop = AntiFlingEngine.disable
end

Commands.antifling = function(args, speaker)
    if not IsSoloCommand(args) then return end
    AntiFlingEngine.enable()
end
Commands.unantifling = function(args, speaker)
    if not IsSoloCommand(args) then return end
    AntiFlingEngine.disable()
end

local MusicCommands = {}

MusicCommands.play = function(player, args, rawMessage)
    local prefix = getgenv().Settings.musicPrefix or "/"
    local query = rawMessage:sub(#prefix + 5):gsub("^%s+", ""):gsub("%s+$", "")
    if #query < 2 then musicChat("❌ Search query too short!"); return end

    local isMain = player.Name:lower() == getgenv().Settings.mainAccount:lower()
    task.spawn(function()

        if not isMain then
            local chk = musicRequest("/admin/check", { user = player.Name })
            if not (chk and (chk.is_main_account or chk.is_authorized)) then
                musicChat(string.format("⛔ @%s — you need /auth to use /play. Ask the owner.", player.Name))
                return
            end

            local cd  = getgenv().Settings.musicPlayCooldown or 10
            local now = os.time()
            if MusicState.lastPlayTime[player.Name] and (now - MusicState.lastPlayTime[player.Name]) < cd then
                local rem = cd - (now - MusicState.lastPlayTime[player.Name])
                musicChat(string.format("⏳ @%s wait %d seconds", player.Name, rem))
                return
            end
        end
        MusicState.lastPlayTime[player.Name] = os.time()
        musicChat("🔍 Searching: " .. query)
        local resp = musicRequest("/play", { query = query, user = player.Name })
        if resp then
            if resp.wait_seconds then
                musicChat(string.format("⏳ Wait %d seconds", resp.wait_seconds))
            elseif resp.reason == "already_playing" then
                musicChat("🎵 That song is already playing!")
            elseif resp.reason == "in_queue" then
                musicChat("📋 That song is already in the queue!")
            elseif resp.error then
                musicChat("❌ " .. resp.error)
            elseif resp.status == "queued" then
                local title = resp.title and ("✅ Queued: " .. resp.title) or "✅ Queued!"
                musicChat(title)
                if resp.queue_position and resp.queue_position > 1 then
                    task.wait(1); musicChat(string.format("📋 Position: #%d", resp.queue_position))
                end
            else musicChat("✅ Request sent!") end
        else musicChat("Ahh Not Sure if ur song got added man, check /queue.") end
    end)
end

MusicCommands.pause = function(player, args)
    task.spawn(function()
        local resp = musicRequest("/control", { action = "pause", user = player.Name })
        if resp then
            if resp.authorized == false or resp.error == "Not authorized" then musicChat("⛔ You don't have permission!")
            elseif resp.status == "paused" then musicChat("⚠️ Music paused") end
        end
    end)
end

MusicCommands.resume = function(player, args)
    task.spawn(function()
        local resp = musicRequest("/control", { action = "resume", user = player.Name })
        if resp then
            if resp.authorized == false or resp.error == "Not authorized" then musicChat("⛔ You don't have permission!")
            elseif resp.status == "resumed" then musicChat("✔️ Music resumed") end
        end
    end)
end
MusicCommands.continue = function(p, a) MusicCommands.resume(p, a) end

MusicCommands.skip = function(player, args)
    task.spawn(function()
        local resp = musicRequest("/control", { action = "skip", user = player.Name })
        if resp then
            if resp.authorized == false or resp.error == "Not authorized" then musicChat("⛔ You don't have permission!")
            elseif resp.status == "skipped" then musicChat("🎵 Skipped current song") end
        end
    end)
end

MusicCommands.musicstop = function(player, args)
    task.spawn(function()
        local resp = musicRequest("/control", { action = "stop", user = player.Name })
        if resp then
            if resp.authorized == false or resp.error == "Not authorized" then musicChat("⛔ You don't have permission!")
            elseif resp.status == "stopped" then musicChat("✔️ Stopped and cleared queue") end
        end
    end)
end

MusicCommands.volume = function(player, args)
    if not getgenv().Settings.musicEnableVolume then musicChat("❌ Volume control disabled"); return end
    local vol = tonumber(args[2])
    if not vol or vol < 0 or vol > 100 then musicChat("❌ Usage: /volume <0-100>"); return end
    task.spawn(function()
        local resp = musicRequest("/control", { action = "volume", value = vol / 100, user = player.Name })
        if resp then
            if resp.authorized == false or resp.error == "Not authorized" then musicChat("⛔ You don't have permission!")
            elseif resp.status == "ok" then musicChat(string.format("🔊 Volume set to %d%%", vol)) end
        end
    end)
end

MusicCommands.status = function(player, args)
    task.spawn(function()
        local resp = musicRequest("/status")
        if resp then
            if resp.current_song then
                musicChat("🎵 Now: " .. resp.current_song.title)
                if resp.playback_position and resp.playback_position > 0 then
                    local mins = math.floor(resp.playback_position / 60)
                    local secs = math.floor(resp.playback_position % 60)
                    musicChat(string.format("⏱️ Position: %d:%02d", mins, secs))
                end
                if resp.queue_size > 0 then musicChat(string.format("📋 Queue: %d songs", resp.queue_size)) end
                musicChat(string.format("🔊 Volume: %d%%", math.floor(resp.volume * 100)))
            else
                musicChat("🙄 Nothing playing")
                if resp.queue_size > 0 then musicChat(string.format("📋 Queue: %d songs waiting", resp.queue_size)) end
            end
        end
    end)
end

MusicCommands.nowplaying = function(player, args)
    task.spawn(function()
        local resp = musicRequest("/nowplaying")
        if resp then
            if resp.playing and resp.title then
                musicChat("🎵 Now Playing: " .. resp.title)
                if resp.position and resp.position > 0 then
                    local mins = math.floor(resp.position / 60)
                    local secs = math.floor(resp.position % 60)
                    local pauseTag = resp.is_paused and " (PAUSED)" or ""
                    musicChat(string.format("⏱️ %d:%02d%s", mins, secs, pauseTag))
                end
                if resp.username then musicChat("👤 Requested by: " .. resp.username) end
                musicChat(string.format("🔊 Volume: %d%%", math.floor((resp.volume or 0.7) * 100)))
            else
                musicChat("🙄 Nothing playing right now")
            end
        end
    end)
end

MusicCommands.queue = function(player, args)
    if not getgenv().Settings.musicEnableQueue then musicChat("❌ Queue display disabled"); return end
    task.spawn(function()
        local resp = musicRequest("/queue")
        if resp and resp.total > 0 then
            musicChat(string.format("📋 Queue (%d songs):", resp.total))
            for i, item in ipairs(resp.queue) do
                if i <= 5 then musicChat(string.format("%d. %s", item.position, item.title)); task.wait(0.5) end
            end
            if resp.total > 5 then musicChat(string.format("...and %d more", resp.total - 5)) end
        else musicChat("📋 Queue is empty") end
    end)
end

MusicCommands.stats = function(player, args)
    if not getgenv().Settings.musicEnableStats then musicChat("❌ Stats disabled"); return end
    local lookupName = args[2] and (function()
        local tp = FindTarget(args[2], player)
        return tp and tp.Name or args[2]
    end)() or player.Name
    local label = args[2] or player.Name
    task.spawn(function()
        local resp = musicRequest("/stats", { user = lookupName })
        if resp then
            musicChat(string.format("📊 %s's Stats:", label)); task.wait(0.5)
            musicChat(string.format("✔️ Played: %d", resp.songs_played or 0)); task.wait(0.5)
            musicChat(string.format("✔️ Skipped: %d", resp.songs_skipped or 0))
        end
    end)
end

MusicCommands.history = function(player, args)
    task.spawn(function()
        local resp = musicRequest("/history")
        if resp and resp.history then
            if #resp.history > 0 then
                musicChat("📜 Recent history:")
                for i, item in ipairs(resp.history) do
                    if i <= 5 then musicChat(string.format("%d. %s", i, item.title)); task.wait(0.5) end
                end
            else musicChat("📜 No history yet") end
        end
    end)
end

MusicCommands.auth = function(player, args)
    local isMain = player.Name:lower() == getgenv().Settings.mainAccount:lower()
    if not isMain then musicChat("⛔ Only main account can use this!"); return end
    local tp = FindTarget(args[2], player)
    if not tp then musicChat("❌ Player not found in game"); return end
    task.spawn(function()
        local resp = musicRequest("/admin/authorize", { user = tp.Name })
        if resp and resp.status == "authorized" then musicChat(string.format("✅ %s authorized for controls", tp.DisplayName))
        else musicChat("❌ Failed to authorize user") end
    end)
end

MusicCommands.unauth = function(player, args)
    local isMain = player.Name:lower() == getgenv().Settings.mainAccount:lower()
    if not isMain then musicChat("⛔ Only main account can use this!"); return end
    local tp = FindTarget(args[2], player)
    if not tp then musicChat("❌ Player not found in game"); return end
    task.spawn(function()
        local resp = musicRequest("/admin/revoke", { user = tp.Name })
        if resp and resp.status == "revoked" then musicChat(string.format("❌ %s unauthorized", tp.DisplayName))
        else musicChat("❌ Failed to revoke user") end
    end)
end

MusicCommands.musicblacklist = function(player, args)
    local isMain = player.Name:lower() == getgenv().Settings.mainAccount:lower()
    if not isMain then musicChat("⛔ Only main account can use this!"); return end
    local tp = FindTarget(args[2], player)
    if not tp then musicChat("❌ Player not found in game"); return end
    task.spawn(function()
        local resp = musicRequest("/admin/blacklist", { user = tp.Name })
        if resp and resp.status == "blacklisted" then musicChat(string.format("🚫 %s blacklisted", tp.DisplayName))
        else musicChat("❌ Failed to blacklist user") end
    end)
end

MusicCommands.unblacklist = function(player, args)
    local isMain = player.Name:lower() == getgenv().Settings.mainAccount:lower()
    if not isMain then musicChat("⛔ Only main account can use this!"); return end
    local tp = FindTarget(args[2], player)
    if not tp then musicChat("❌ Player not found in game"); return end
    task.spawn(function()
        local resp = musicRequest("/admin/unblacklist", { user = tp.Name })
        if resp and resp.status == "unblacklisted" then musicChat(string.format("✅ %s removed from blacklist", tp.DisplayName))
        else musicChat("❌ Failed to unblacklist user") end
    end)
end

MusicCommands.musiccmds = function(player, args)
    musicChat("🎵 Music Bot Commands:")
    task.wait(0.5); musicChat("./play <song> - Play a song")
    task.wait(0.5); musicChat("./np - What's playing now")
    task.wait(0.5); musicChat("./status - Full status & queue")
    task.wait(0.5); musicChat("./queue - View queue")
    task.wait(0.5); musicChat("./stats [user] - View statistics")
    task.wait(0.5); musicChat("./history - Recent songs")
    task.wait(0.5); musicChat("🎛️ Need controls? Ask for /auth")
    local isMain = player.Name:lower() == getgenv().Settings.mainAccount:lower()
    if isMain then task.wait(0.5); musicChat("👑 Admin: /auth /unauth /blacklist") end
end

MusicCommands.checkauth = function(player, args)
    local lookupName = args[2] and (function()
        local tp = FindTarget(args[2], player)
        return tp and tp.Name or args[2]
    end)() or player.Name
    local label = args[2] or player.Name
    task.spawn(function()
        local resp = musicRequest("/admin/check", { user = lookupName })
        if resp then
            local st = "❌ Not authorized"
            if resp.is_main_account then st = "👑 Main Account (always authorized)"
            elseif resp.is_authorized then st = "✅ Authorized" end
            musicChat(string.format("🔐 %s: %s", label, st))
            if resp.is_blacklisted then musicChat("🚫 (Blacklisted)") end
        end
    end)
end

local musicCmdMap = {
    play = MusicCommands.play,
    pause = MusicCommands.pause,
    resume = MusicCommands.resume,
    ["continue"] = MusicCommands.continue,
    skip = MusicCommands.skip,
    stop = MusicCommands.musicstop,
    volume = MusicCommands.volume,
    status = MusicCommands.status,
    nowplaying = MusicCommands.nowplaying,
    np = MusicCommands.nowplaying,
    queue = MusicCommands.queue,
    stats = MusicCommands.stats,
    history = MusicCommands.history,
    auth = MusicCommands.auth,
    unauth = MusicCommands.unauth,
    blacklist = MusicCommands.musicblacklist,
    unblacklist = MusicCommands.unblacklist,
    cmds = MusicCommands.musiccmds,
    checkauth = MusicCommands.checkauth,
}

local function SetupMusicListener(p)
    if not musicEnabled() then return end
    getgenv().TrackConnection(p.Chatted:Connect(function(msg)
        local mPrefix = getgenv().Settings.musicPrefix or "/"
        if not msg or #msg == 0 then return end
        if msg:sub(1, #mPrefix) ~= mPrefix then return end

        local args = msg:split(" ")
        if #args == 0 then return end
        local cmdName = args[1]:sub(#mPrefix + 1):lower()
        local handler = musicCmdMap[cmdName]
        if not handler then return end

        local now = os.time()
        local gcd = getgenv().Settings.musicGlobalCooldown or 3
        if MusicState.lastCommandTime[p.Name] and (now - MusicState.lastCommandTime[p.Name]) < gcd then return end
        MusicState.lastCommandTime[p.Name] = now

        local ok, err = pcall(function() handler(p, args, msg) end)
        if not ok then warn("[MusicBot] Error: " .. tostring(err)) end
    end))
end

for _, p in ipairs(Players:GetPlayers()) do SetupMusicListener(p) end
getgenv().TrackConnection(Players.PlayerAdded:Connect(function(p) SetupMusicListener(p) end))

do
    Commands.to    = Commands.walkto
    Commands.tpto  = Commands.tp
    Commands.b     = Commands.grab
    Commands.fj    = Commands.loopclone
    Commands.unfj  = Commands.unloopclone
    Commands.re    = Commands.rejoin
    Commands.rj    = Commands.rejoin
    Commands.cd    = Commands.countdown
    Commands.f     = Commands.follow
    Commands.unf   = Commands.unall
    Commands.d     = Commands.dance
    Commands.dance1 = Commands.dance
end

do
    local GenRemote = ReplicatedStorage:WaitForChild("event_generation", 10)
    local function notify(title, text, dur)
        pcall(function()
            _Q("StarterGui"):SetCore("SendNotification", {Title=title, Text=text, Duration=dur or 4})
        end)
    end
    _G.GenToolGenerating = false
    local function generate(prompt, size)
        if _G.GenToolGenerating then notify("Wait", "Already generating…", 3); return end
        prompt = (prompt or ""):match("^%s*(.-)%s*$")
        if prompt == "" then notify("Error", "Enter a prompt", 3); return end
        size = math.clamp(size or 50, 1, 300)
        _G.GenToolGenerating = true
        notify("Generating", '"'..prompt..'" size '..size, 5)
        local ok, err = pcall(function()
            GenRemote:FireServer(prompt, Vector3.new(size, size, size))
        end)
        _G.GenToolGenerating = false
        if not ok then notify("Error", tostring(err), 5) end
    end
    Commands.gentool = function(args, speaker)
        local shouldRun, newArgs = ParseBotTarget(args)
        if not shouldRun then return end
        local rest = table.concat(newArgs, " ", 2)
        if rest == "" then notify("!gentool", "Usage: prefix + gentool [size] [prompt]", 4); return end
        local sizeStr, prompt = rest:match("^(%d+)%s+(.+)$")
        if sizeStr and prompt then
            generate(prompt, tonumber(sizeStr))
        else
            notify("!gentool", "You must specify [size] and [prompt]!", 4)
        end
    end
end

local VISUAL_CLASSES = {
    "SpecialMesh", "FileMesh", "CylinderMesh", "BlockMesh",
    "Texture", "Decal", "SurfaceAppearance",
    "ParticleEmitter", "Fire", "Smoke", "Sparkles",
    "Beam", "Trail", "Explosion",
    "PointLight", "SpotLight", "SurfaceLight",
    "SurfaceGui", "BillboardGui",
    "Highlight", "SelectionBox", "SelectionSphere",
}
local VISUAL_SET = {}
for _, cls in ipairs(VISUAL_CLASSES) do VISUAL_SET[cls] = true end

local STRIP_SET = { MeshPart = true, UnionOperation = true }

local KEEP_IN_CHAR = {
    HumanoidRootPart = true,
    Humanoid = true,
    Head = true,
}

local function IsAnyCharObj(obj)
    for _, p in ipairs(Players:GetPlayers()) do
        local c = p.Character
        if c and (obj == c or obj:IsDescendantOf(c)) then return true end
    end
    return false
end

local function CleanLightingEffects()
    for _, child in ipairs(Lighting:GetChildren()) do
        if child:IsA("PostEffect") or child:IsA("Atmosphere") or child:IsA("Sky") then
            pcall(function() child:Destroy() end)
        end
    end
    pcall(function() Lighting.GlobalShadows = false end)
    pcall(function() Lighting.Technology = Enum.Technology.Compatibility end)
end

local function CleanWorkspaceVisuals()
    for _, desc in ipairs(workspace:GetDescendants()) do
        if IsAnyCharObj(desc) then continue end
        if desc == workspace.CurrentCamera or desc:IsDescendantOf(workspace.CurrentCamera) then continue end
        if desc:IsA("Terrain") then continue end

        if VISUAL_SET[desc.ClassName] then
            pcall(function() desc:Destroy() end)
        elseif STRIP_SET[desc.ClassName] then
            pcall(function()
                desc.Material = Enum.Material.SmoothPlastic
                desc.Reflectance = 0
                desc.TextureID = ""
            end)
            if desc.ClassName == "MeshPart" then
                pcall(function() desc.RenderFidelity = Enum.RenderFidelity.Performance end)
                pcall(function() desc.CollisionFidelity = Enum.CollisionFidelity.Box end)
            end
        elseif desc:IsA("Sound") and not desc:IsDescendantOf(_Q("SoundService")) then
            pcall(function() desc.Volume = 0 end)
        end
    end
end

local function CleanOtherPlayerChars()
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        if not char then continue end

        for _, child in ipairs(char:GetChildren()) do
            if KEEP_IN_CHAR[child.Name] then
                if child:IsA("BasePart") then
                    pcall(function() child.Material = Enum.Material.SmoothPlastic; child.Transparency = 1 end)
                end
                for _, sub in ipairs(child:GetChildren()) do
                    if sub:IsA("Decal") or sub:IsA("SpecialMesh") or sub:IsA("SurfaceAppearance")
                        or sub:IsA("Texture") or sub:IsA("ParticleEmitter") or sub:IsA("BillboardGui") then
                        pcall(function() sub:Destroy() end)
                    end
                end
            elseif child:IsA("Humanoid") then

            elseif child:IsA("Accessory") or child:IsA("Shirt") or child:IsA("Pants")
                or child:IsA("ShirtGraphic") or child:IsA("BodyColors") or child:IsA("CharacterMesh") then
                pcall(function() child:Destroy() end)
            elseif child:IsA("BasePart") then
                pcall(function() child.Transparency = 1; child.Material = Enum.Material.SmoothPlastic end)
                for _, sub in ipairs(child:GetChildren()) do
                    if not sub:IsA("Motor6D") and not sub:IsA("Weld") then
                        pcall(function() sub:Destroy() end)
                    end
                end
            elseif not child:IsA("Script") and not child:IsA("LocalScript")
                and not child:IsA("Animator") and not child:IsA("Motor6D") then
                pcall(function() child:Destroy() end)
            end
        end

        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("MeshPart") then
                pcall(function() part.TextureID = ""; part.Transparency = 1 end)
            end
        end
    end
end

local function CleanTerrain()
    pcall(function()
        local t = workspace:FindFirstChildOfClass("Terrain")
        if t then
            t.Decoration = false
            t.WaterWaveSize = 0; t.WaterWaveSpeed = 0
            t.WaterReflectance = 0; t.WaterTransparency = 0
        end
    end)
end

local function CleanGuis()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if not pg then return end

    local keep = { Chat=true, HyperionCommandGUI=true, BubbleChat=true, TopBarApp=true, StealthOverlay=true }
    for _, gui in ipairs(pg:GetChildren()) do
        if gui:IsA("ScreenGui") and not keep[gui.Name] then
            local n = gui.Name:lower()
            if not (n:find("chat") or n:find("topbar") or n:find("core") or n:find("roblox")) then
                pcall(function() gui.Enabled = false end)
            end
        end
    end
end

local function StartContinuousCleanup()
    getgenv().TrackConnection(Players.PlayerAdded:Connect(function(player)
        getgenv().TrackConnection(player.CharacterAdded:Connect(function()
            task.wait(2)
            CleanOtherPlayerChars()
        end))
    end))

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            getgenv().TrackConnection(p.CharacterAdded:Connect(function()
                task.wait(2)
                CleanOtherPlayerChars()
            end))
        end
    end

    getgenv().TrackConnection(workspace.DescendantAdded:Connect(function(desc)
        if VISUAL_SET[desc.ClassName] and not IsAnyCharObj(desc) then
            task.defer(function()
                if desc.Parent and not IsAnyCharObj(desc) then
                    pcall(function() desc:Destroy() end)
                end
            end)
        end
    end))
end

local function GetPingMs()
    local ok, ping = pcall(function()
        return LocalPlayer:GetNetworkPing() * 1000
    end)
    return ok and ping or 100
end

local function StartAutoSync()
    task.spawn(function()
        while _G.HyperionActive do
            local ping = GetPingMs()
            _G.HyperionPing = ping
            _G.HyperionSyncOffset = ping / 1000

            if ping > 200 then
                _G.HyperionTickRate = 0.15
            elseif ping > 100 then
                _G.HyperionTickRate = 0.08
            else
                _G.HyperionTickRate = 0.03
            end

            local memKB = collectgarbage("count")
            if memKB > 200000 then
                collectgarbage("collect")
            end

            task.wait(5)
        end
    end)
end

local function OptimizeAndOverlay()
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
    pcall(function() if setfpscap then setfpscap(getgenv().Settings.fpsCap or 10) end end)

    CleanLightingEffects()
    CleanTerrain()

    task.spawn(function()
        CleanWorkspaceVisuals()
        CleanOtherPlayerChars()
        CleanGuis()
        print("[Hyperion Cleanup] In-game optimization complete")
    end)

    StartContinuousCleanup()
    StartAutoSync()

    local myIndex = SafeIndex()

    local oldHolders = {}
    pcall(function() oldHolders[#oldHolders + 1] = HyperionUI.parent() end)
    oldHolders[#oldHolders + 1] = LocalPlayer:FindFirstChild("PlayerGui")
    for _, holder in ipairs(oldHolders) do
        pcall(function()
            local old = holder:FindFirstChild("StealthOverlay")
            if old then old:Destroy() end
        end)
    end

    local SG = Instance.new("ScreenGui")
    SG.IgnoreGuiInset = true
    SG.ResetOnSpawn = false
    SG.DisplayOrder = -1
    SG.Name = "StealthOverlay"
    if getgenv().Settings.GetHUI_BlackScreen ~= false then
        pcall(function() SG.Parent = HyperionUI.parent() end)
    end
    if not SG.Parent then
        local guiParent = LocalPlayer:FindFirstChild("PlayerGui")
        if guiParent then SG.Parent = guiParent end
    end

    local Background = Instance.new("Frame")
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BorderSizePixel = 0
    Background.Active = false
    Background.Parent = SG

    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Size = UDim2.new(0.8, 0, 0.4, 0)
    InfoLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    InfoLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    InfoLabel.Font = Enum.Font.Code
    InfoLabel.TextSize = 22
    InfoLabel.TextWrapped = true
    InfoLabel.TextXAlignment = Enum.TextXAlignment.Center
    InfoLabel.TextYAlignment = Enum.TextYAlignment.Center

    InfoLabel.Text = string.format(
        "ALT Control | Designed by xhy_perion\n" ..
        "Join Discord: https://discord.gg/kfxRmYzp3t\n\n" ..
        "USER: %s\n" ..
        "BOT POSITION: %02d",
        LocalPlayer.Name,
        myIndex
    )
    InfoLabel.Parent = Background

    local DISCORD_URL = "https://discord.gg/kfxRmYzp3t"
    local CopyBtn = Instance.new("TextButton")
    CopyBtn.Name = "CopyDiscord"
    CopyBtn.Size = InfoLabel.Size
    CopyBtn.Position = InfoLabel.Position
    CopyBtn.AnchorPoint = InfoLabel.AnchorPoint
    CopyBtn.BackgroundTransparency = 1
    CopyBtn.AutoButtonColor = false
    CopyBtn.Text = ""
    CopyBtn.Parent = Background

    local CopiedLabel = Instance.new("TextLabel")
    CopiedLabel.Size = UDim2.new(0.8, 0, 0, 24)
    CopiedLabel.Position = UDim2.new(0.5, 0, 0.7, 6)
    CopiedLabel.AnchorPoint = Vector2.new(0.5, 0)
    CopiedLabel.BackgroundTransparency = 1
    CopiedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopiedLabel.Font = Enum.Font.Code
    CopiedLabel.TextSize = 18
    CopiedLabel.TextXAlignment = Enum.TextXAlignment.Center
    CopiedLabel.Text = ""
    CopiedLabel.Parent = Background

    CopyBtn.MouseButton1Click:Connect(function()
        local ok = pcall(function()
            if setclipboard then setclipboard(DISCORD_URL) else error("no setclipboard") end
        end)
        CopiedLabel.Text = ok and "Discord link copied to clipboard" or ("Copy failed - " .. DISCORD_URL)
        task.delay(2.5, function()
            if CopiedLabel and CopiedLabel.Parent then CopiedLabel.Text = "" end
        end)
    end)
end

if LocalPlayer.Name ~= getgenv().Settings.mainAccount then
    OptimizeAndOverlay()

end

if getgenv().Settings.wsEnabled then

    local WSLib = WebSocket
        or (getgenv and getgenv().WebSocket)
        or (syn and syn.websocket)
        or websocket
    local role   = isMainAccount and "controller" or "bot"
    local prefix = getgenv().Settings.prefix or "!"

    _G.HyperionWSConnected = false
    _G.HyperionWSStatus    = { bots = 0 }
    _G.HyperionWSLog       = _G.HyperionWSLog or function() end

    local function buildURL()
        local base  = (getgenv().Settings.wsURL or "ws://127.0.0.1:8080"):gsub("/+$", "")
        local token = getgenv().Settings.wsToken or ""
        return string.format("%s/?token=%s&role=%s&name=%s",
            base, HttpService:UrlEncode(token), role, HttpService:UrlEncode(LocalPlayer.Name))
    end

    local function onCommand(text, speakerName)
        if isMainAccount then return end
        if type(text) ~= "string" or text == "" then return end
        if text:sub(1, #prefix) ~= prefix then text = prefix .. text end
        local speaker = Players:FindFirstChild(speakerName or "")
            or Players:FindFirstChild(getgenv().Settings.mainAccount)
        if not speaker then return end
        local ok, err = pcall(function() getgenv().Execute(text, speaker) end)
        if not ok then warn("[HyperionWS] exec error: " .. tostring(err)) end
    end

    local WS = nil

    local function connect()
        if not _G.HyperionActive or not getgenv().Settings.wsEnabled then return end
        if not WSLib or not WSLib.connect then
            _G.HyperionWSLog("WebSocket API unavailable on this executor", "err")
            return
        end
        local ok, conn = pcall(function() return WSLib.connect(buildURL()) end)
        if not ok or not conn then
            _G.HyperionWSConnected = false
            _G.HyperionWSLog("connect failed - retrying", "warn")
            task.delay(getgenv().Settings.wsRetry or 5, connect)
            return
        end
        WS = conn; _G.HyperionWS = conn; _G.HyperionWSConnected = true
        _G.HyperionWSLog("connected (" .. role .. ")", "ok")

        getgenv().TrackConnection(conn.OnMessage:Connect(function(raw)
            local ok2, data = pcall(function() return HttpService:JSONDecode(raw) end)
            if not ok2 or type(data) ~= "table" then return end
            if data.type == "command" then

                task.spawn(onCommand, data.text, data.speaker)
            elseif data.type == "status" then
                _G.HyperionWSStatus = { bots = tonumber(data.bots) or 0 }
            elseif data.type == "hyperion" then
                -- Hyperion Account Manager's state (source of truth for notifications)
                _G.HyperionAMAutoExec = data.autoExecute == true
            end
        end))

        getgenv().TrackConnection(conn.OnClose:Connect(function()
            _G.HyperionWSConnected = false; WS = nil; _G.HyperionWS = nil
            _G.HyperionAMAutoExec = false
            _G.HyperionWSLog("disconnected - retrying", "warn")
            task.delay(getgenv().Settings.wsRetry or 5, connect)
        end))
    end

    local function wsSend(text)
        if type(text) ~= "string" then return false end
        text = text:gsub("^%s+", ""):gsub("%s+$", "")
        if text == "" then return false end

        local mP = getgenv().Settings.musicPrefix or "/"
        if text:sub(1, #mP) == mP then
            ChatSend(text)
            if _G.HyperionWSLog then _G.HyperionWSLog("♪ " .. text, "ok") end
            return true
        end
        if not WS or not _G.HyperionWSConnected then
            _G.HyperionWSLog("not connected", "warn"); return false
        end
        local payload = HttpService:JSONEncode({ type = "command", text = text, speaker = LocalPlayer.Name })
        local ok = pcall(function() WS:Send(payload) end)
        if ok then _G.HyperionWSLog("> " .. text, "cmd") else _G.HyperionWSLog("send failed", "err") end
        return ok
    end
    _G.HyperionWSSend = wsSend

    -- Raw JSON to the bridge (VC ban / rejoin notices); false if not connected.
    _G.HyperionWSRaw = function(json)
        if not WS or not _G.HyperionWSConnected then return false end
        return (pcall(function() WS:Send(json) end))
    end
    -- Bridge URL for another role (used by the post-teleport notifier).
    _G.HyperionWSURL = function(asRole)
        local base  = (getgenv().Settings.wsURL or "ws://127.0.0.1:8080"):gsub("/+$", "")
        return string.format("%s/?token=%s&role=%s&name=%s", base,
            HttpService:UrlEncode(getgenv().Settings.wsToken or ""), asRole or role, HttpService:UrlEncode(LocalPlayer.Name))
    end

    if isMainAccount then
        local UI  = HyperionUI
        local T   = UI.theme
        local UIS = _Q("UserInputService")

        local MINW, MINH, MAXW, MAXH = 300, 200, 720, 540
        local win = UI.window({
            name = "HyperionWSGui", title = "⚡ Hyperion Command Center",
            size = UDim2.fromOffset(430, 330), position = UDim2.new(0, 250, 0, 240),
            displayOrder = 120, headerHeight = 34, icon = "rbxassetid://99251435575806",
        })
        local body = win.body

        local dot = UI.new("Frame", { Size = UDim2.fromOffset(9, 9), Position = UDim2.new(0, 12, 0.5, -4),
            AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = T.Bad, BorderSizePixel = 0 }, win.header)
        UI.corner(dot, 5)
        win.title.Position = UDim2.new(0, 28, 0.5, 0)

        local log = UI.new("ScrollingFrame", { Name = "Log", Size = UDim2.new(1, -16, 1, -(8 + 30 + 34)),
            Position = UDim2.new(0, 8, 0, 6), BackgroundColor3 = T.Raised, BackgroundTransparency = 0.35,
            BorderSizePixel = 0, ScrollBarThickness = 3, ScrollBarImageColor3 = T.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y }, body)
        UI.corner(log, 8)
        UI.new("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 1) }, log)
        UI.pad(log, 6, 6, 8, 8)

        local logN = 0
        _G.HyperionWSLog = function(msg, kind)
            local col = T.Text
            if kind == "ok" then col = T.Good elseif kind == "warn" then col = T.Warn
            elseif kind == "err" then col = T.Bad elseif kind == "dim" then col = T.Muted
            elseif kind == "cmd" then col = T.Accent end
            logN = logN + 1
            UI.label({ AutoAxis = "Y", Size = UDim2.new(1, 0, 0, 0), LayoutOrder = logN,
                Text = os.date("[%H:%M:%S] ") .. tostring(msg), TextColor3 = col, TextSize = 11, Font = T.FontC,
                TextXAlignment = Enum.TextXAlignment.Left }, log)
            local labels = {}
            for _, k in ipairs(log:GetChildren()) do if k:IsA("TextLabel") then labels[#labels + 1] = k end end
            if #labels > 120 then labels[1]:Destroy() end
            task.defer(function() log.CanvasPosition = Vector2.new(0, math.max(0, log.AbsoluteCanvasSize.Y)) end)
        end

        local chipBar = UI.new("Frame", { Size = UDim2.new(1, -16, 0, 22), Position = UDim2.new(0, 8, 1, -60),
            BackgroundTransparency = 1 }, body)
        UI.new("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 4),
            SortOrder = Enum.SortOrder.LayoutOrder }, chipBar)
        for _, qc in ipairs({
            { "Stop", "stop" }, { "Bring", "bring me" }, { "Mirror", "mirror me" }, { "tp", "tp me" }, { "Orbit", "orbit me" },
        }) do
            local label, cmd = qc[1], qc[2]
            local chip = UI.button({ Size = UDim2.new(0, 78, 1, 0), BackgroundColor3 = T.Raised, HoverColor3 = T.Hover,
                Text = label, TextColor3 = T.Sub, TextSize = 11, Font = T.FontM }, chipBar, function() wsSend(cmd) end)
            UI.corner(chip, 6)
        end

        local inRow = UI.new("Frame", { Size = UDim2.new(1, -16, 0, 28), Position = UDim2.new(0, 8, 1, -32),
            BackgroundColor3 = T.Raised, BackgroundTransparency = 0.25, BorderSizePixel = 0 }, body)
        UI.corner(inRow, 7); UI.new("UIStroke", { Color = T.Line, Transparency = 0.6 }, inRow)
        UI.label({ AutoAxis = "X", Size = UDim2.new(0, 14, 1, 0), Position = UDim2.new(0, 8, 0, 0), Text = ">",
            TextColor3 = T.Accent, TextSize = 14, Font = T.FontB, TextYAlignment = Enum.TextYAlignment.Center }, inRow)
        local box = UI.new("TextBox", { Size = UDim2.new(1, -80, 1, 0), Position = UDim2.new(0, 24, 0, 0),
            BackgroundTransparency = 1, PlaceholderText = "command…  e.g.  orbit me   •   /play song",
            PlaceholderColor3 = T.Muted, Text = "", TextColor3 = T.Text, TextSize = 12, Font = T.FontC,
            TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false }, inRow)
        local sendBtn = UI.button({ Size = UDim2.new(0, 50, 1, -6), Position = UDim2.new(1, -54, 0, 3),
            BackgroundColor3 = T.Accent:Lerp(T.Base, 0.1), HoverColor3 = T.Accent, Text = "SEND",
            TextColor3 = Color3.new(1, 1, 1), TextSize = 10, Font = T.FontB }, inRow)
        UI.corner(sendBtn, 6)
        local function fire()
            local t = box.Text
            if t ~= "" and wsSend(t) then box.Text = "" end
        end
        sendBtn.MouseButton1Click:Connect(fire)
        box.FocusLost:Connect(function(enter) if enter then fire() end end)

        local grip = UI.new("TextButton", { Size = UDim2.fromOffset(16, 16), Position = UDim2.new(1, -16, 1, -16),
            BackgroundTransparency = 1, Text = "◢", TextColor3 = T.Muted, TextSize = 14, Font = T.FontB,
            AutoButtonColor = false }, win.root)
        local resizing, startMouse, startSize = false, nil, nil
        grip.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                resizing = true; startMouse = i.Position; startSize = win.getSize()
            end
        end)
        local rc = UIS.InputChanged:Connect(function(i)
            if not win.root.Parent then return end
            if not resizing then return end
            if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
                local d = i.Position - startMouse
                win.setSize(UDim2.fromOffset(
                    math.clamp(startSize.X.Offset + d.X, MINW, MAXW),
                    math.clamp(startSize.Y.Offset + d.Y, MINH, MAXH)))
            end
        end)
        local re = UIS.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then resizing = false end
        end)
        if getgenv().TrackConnection then getgenv().TrackConnection(rc); getgenv().TrackConnection(re) end

        task.spawn(function()
            while _G.HyperionActive and win.screen.Parent do
                local up = _G.HyperionWSConnected == true
                dot.BackgroundColor3 = up and T.Good or T.Bad
                win.badge("bots " .. tostring((_G.HyperionWSStatus or {}).bots or 0), up and T.Good or T.Muted)
                task.wait(1)
            end
        end)

        _G.HyperionWSLog("WS bridge ready - " .. (getgenv().Settings.wsURL or "?"), "dim")

        UIS.InputBegan:Connect(function(inp, gp)
            if gp then return end
            if inp.KeyCode == Enum.KeyCode.RightControl then win.toggle() end
        end)
    end

    task.spawn(connect)
    print("[HyperionWS] bridge enabled (" .. role .. ") -> " .. (getgenv().Settings.wsURL or "?"))
end

InitAntiAFK()

if isAltAccount and not isMainAccount then
    StartVCBMonitor()
end

if isAltAccount and not isMainAccount and getgenv().Settings.micAutoUnmute then
    task.spawn(function()
        local baseDelay = getgenv().Settings.micUnmuteDelay or 30
        local idx = SafeIndex() or 1

        local staggeredDelay = baseDelay + ((idx - 1) * 2)
        task.wait(staggeredDelay)
        if _G.HyperionActive then
            doMicUnmute()
            print("[MicToggle] Auto-unmuted bot #" .. idx .. " after " .. staggeredDelay .. "s delay")
        end
    end)
end

if isAltAccount and shouldMusicExecute() then
    task.spawn(function()
        task.wait(5)
        musicChat("Hyperion Bots Ready!")
        task.wait(1)
        musicChat("✔️")
    end)
end

print("Hyperion ALT Control | By @xhy_perion")
