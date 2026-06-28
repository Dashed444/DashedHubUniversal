local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Variables de Control Integradas
local AimlockEnabled, AimbotEnabled, EspEnabled, FpsBoostEnabled = false, false, false, false
local Smoothness, TargetPart, ActiveCharacters, OriginalMaterials = 0.25, "Head", {}, {}
local FOVRadius = 100 -- Tamaño medio por defecto

local Themes = {
    {Name = "Rojo Neón", Color = Color3.fromRGB(200, 40, 60)},
    {Name = "Azul Eléctrico", Color = Color3.fromRGB(0, 160, 255)},
    {Name = "Verde Matrix", Color = Color3.fromRGB(0, 215, 100)}
}
local CurrentThemeIndex = 1

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YantoProPanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.58, 0, 0.72, 0) -- Ajustado alto para los nuevos controles de FOV
MainFrame.Position = UDim2.new(0.21, 0, 0.14, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 14, 14)
MainFrame.ClipsDescendants = true
MainFrame.Active, MainFrame.Visible = true, true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner") MainCorner.CornerRadius = UDim.new(0, 12) MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke") MainStroke.Thickness = 1.2 MainStroke.Color = Themes[CurrentThemeIndex].Color MainStroke.Parent = MainFrame

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0.28, 0, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(11, 9, 9)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SideCorner = Instance.new("UICorner") SideCorner.CornerRadius = UDim.new(0, 12) SideCorner.Parent = Sidebar

local HubTitle = Instance.new("TextLabel")
HubTitle.Size = UDim2.new(1, 0, 0.12, 0)
HubTitle.BackgroundTransparency = 1
HubTitle.Text = "YANTO HUB VIP"
HubTitle.TextColor3 = Color3.fromRGB(220, 50, 70)
HubTitle.TextScaled, HubTitle.Font = true, Enum.Font.GothamBold
HubTitle.Parent = Sidebar

-- 🟢 CÍRCULO DE FOV PARA EL AIMBOT (NATIVO Y OPTIMIZADO)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Thickness = 1
FOVCircle.NumSides = 48
FOVCircle.Radius = FOVRadius
FOVCircle.Filled = false
FOVCircle.Visible = false -- Se encenderá solo cuando actives el Aimbot
local PerfFrame = Instance.new("Frame")
PerfFrame.Size = UDim2.new(0.68, 0, 0.08, 0)
PerfFrame.Position = UDim2.new(0.3, 0, 0.03, 0)
PerfFrame.BackgroundTransparency = 1
PerfFrame.Parent = MainFrame

local PerfLayout = Instance.new("UIListLayout")
PerfLayout.Padding, PerfLayout.FillDirection, PerfLayout.SortOrder = UDim.new(0.03, 0), Enum.FillDirection.Horizontal, Enum.SortOrder.LayoutOrder
PerfLayout.Parent = PerfFrame

local function createPerfLabel(color, order)
    local lbl = Instance.new("TextLabel")
    lbl.Size, lbl.BackgroundColor3, lbl.TextColor3 = UDim2.new(0.42, 0, 0.9, 0), color, Color3.fromRGB(255, 255, 255)
    lbl.TextScaled, lbl.Font, lbl.LayoutOrder = true, Enum.Font.GothamSemibold, order
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 10) c.Parent = lbl
    lbl.Parent = PerfFrame
    return lbl
end
local PingLabel = createPerfLabel(Color3.fromRGB(40, 180, 100), 1)
local FpsLabel = createPerfLabel(Color3.fromRGB(50, 160, 90), 2)

local fpsCount = 0
RunService.Heartbeat:Connect(function(dt) fpsCount = math.round(1 / dt) end)
task.spawn(function()
    while task.wait(0.5) do
        FpsLabel.Text = " FPS: " .. tostring(fpsCount)
        PingLabel.Text = " Ping: " .. tostring(math.round(Stats.Network.ServerPing:GetValue())) .. "ms "
    end
end)

local TabContainer = Instance.new("Frame")
TabContainer.Size, TabContainer.Position, TabContainer.BackgroundTransparency = UDim2.new(1, 0, 0.85, 0), UDim2.new(0, 0, 0.15, 0), 1
TabContainer.Parent = Sidebar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Padding, TabListLayout.HorizontalAlignment, TabListLayout.SortOrder = UDim.new(0.03, 0), Enum.HorizontalAlignment.Center, Enum.SortOrder.LayoutOrder
TabListLayout.Parent = TabContainer

local PagesFrame = Instance.new("Frame")
PagesFrame.Size, PagesFrame.Position, PagesFrame.BackgroundTransparency = UDim2.new(0.68, 0, 0.82, 0), UDim2.new(0.3, 0, 0.15, 0), 1
PagesFrame.Parent = MainFrame

local function createPage()
    local pg = Instance.new("ScrollingFrame")
    pg.Size, pg.BackgroundTransparency, pg.CanvasSize, pg.ScrollBarThickness, pg.Visible = UDim2.new(1, 0, 1, 0), 1, UDim2.new(0, 0, 1.8, 0), 2, false
    pg.Parent = PagesFrame
    local lay = Instance.new("UIListLayout") lay.Padding, lay.HorizontalAlignment, lay.SortOrder = UDim.new(0.04, 0), Enum.HorizontalAlignment.Center, Enum.SortOrder.LayoutOrder lay.Parent = pg
    return pg
end
local CombatPage = createPage() CombatPage.Visible = true
local VisualPage = createPage()
local CreditsPage = createPage()

local SavedMinBarPosition = UDim2.new(0.05, 0, 0.05, 0)
local MinBar = Instance.new("Frame")
MinBar.Size, MinBar.Position, MinBar.BackgroundColor3 = UDim2.new(0, 180, 0, 42), SavedMinBarPosition, Color3.fromRGB(15, 35, 30)
MinBar.Active, MinBar.Draggable, MinBar.Visible = true, true, false
MinBar.Parent = ScreenGui

MinBar:GetPropertyChangedSignal("Position"):Connect(function()
    if MinBar.Visible then SavedMinBarPosition = MinBar.Position end
end)

local BarCorner = Instance.new("UICorner") BarCorner.CornerRadius = UDim.new(1, 0) BarCorner.Parent = MinBar
local BarStroke = Instance.new("UIStroke") BarStroke.Thickness = 1.5 BarStroke.Color = Themes[CurrentThemeIndex].Color BarStroke.Parent = MinBar

local DragIcon = Instance.new("TextLabel")
DragIcon.Size, DragIcon.BackgroundTransparency, DragIcon.Text, DragIcon.TextColor3, DragIcon.TextSize, DragIcon.Font = UDim2.new(0.25, 0, 1, 0), 1, "✛", Color3.fromRGB(230, 150, 40), 22, Enum.Font.GothamBold
DragIcon.Parent = MinBar

local OpenButton = Instance.new("TextButton")
OpenButton.Size, OpenButton.Position, OpenButton.BackgroundTransparency = UDim2.new(0.75, 0, 1, 0), UDim2.new(0.25, 0, 0, 0), 1
OpenButton.Text, OpenButton.TextColor3, OpenButton.TextSize, OpenButton.Font = "🖥️  AUTOFARM", Color3.fromRGB(240, 240, 245), 14, Enum.Font.GothamBold
OpenButton.Parent = MinBar

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible, MainFrame.Size, MainFrame.BackgroundTransparency, MinBar.Visible = true, UDim2.new(0, 0, 0, 0), 1, false
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0.58, 0, 0.68, 0)}):Play()
    TweenService:Create(MainFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
end)

local CloseMenuBtn = Instance.new("TextButton")
CloseMenuBtn.Size, CloseMenuBtn.Position, CloseMenuBtn.BackgroundColor3 = UDim2.new(0, 26, 0, 26), UDim2.new(0.94, 0, 0.03, 0), Color3.fromRGB(35, 25, 25)
CloseMenuBtn.Text, CloseMenuBtn.TextColor3, CloseMenuBtn.Font, CloseMenuBtn.TextSize = "X", Color3.fromRGB(255, 90, 90), Enum.Font.GothamBold, 12
CloseMenuBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner") CloseCorner.CornerRadius = UDim.new(1, 0) CloseCorner.Parent = CloseMenuBtn

CloseMenuBtn.MouseButton1Click:Connect(function()
    local t1 = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
    local t2 = TweenService:Create(MainFrame, TweenInfo.new(0.2), {BackgroundTransparency = 1})
    t1:Play() t2:Play()
    t1.Completed:Connect(function()
        if not MainFrame.Visible then return end
        MainFrame.Visible = false
        MinBar.Position = SavedMinBarPosition
        MinBar.Visible = true
    end)
end)
local ActiveTabButton = nil
local function createTabSelection(name, order, targetPage)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.94, 0, 0, 30)
    btn.BackgroundColor3 = (order == 1) and Color3.fromRGB(35, 25, 25) or Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = (order == 1) and 0 or 1
    btn.Text, btn.TextColor3, btn.TextSize, btn.TextXAlignment, btn.Font, btn.LayoutOrder = "  " .. name, (order == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 165), 11, Enum.TextXAlignment.Left, Enum.Font.GothamSemibold, order
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = btn
    if order == 1 then ActiveTabButton = btn end
    
    btn.MouseButton1Click:Connect(function()
        if ActiveTabButton then ActiveTabButton.BackgroundTransparency, ActiveTabButton.TextColor3 = 1, Color3.fromRGB(160, 160, 165) end
        btn.BackgroundColor3, btn.BackgroundTransparency, btn.TextColor3, ActiveTabButton = Color3.fromRGB(35, 25, 25), 0, Color3.fromRGB(255, 255, 255), btn
        CombatPage.Visible = (targetPage == CombatPage)
        VisualPage.Visible = (targetPage == VisualPage)
        CreditsPage.Visible = (targetPage == CreditsPage)
    end)
    btn.Parent = TabContainer
end

createTabSelection("Combat System", 1, CombatPage)
createTabSelection("World Visual", 2, VisualPage)
createTabSelection("Credits & Info", 3, CreditsPage)

local function createSectionTitle(text, parentPage, order)
    local lbl = Instance.new("TextLabel")
    lbl.Size, lbl.BackgroundTransparency, lbl.Text, lbl.TextColor3, lbl.TextSize, lbl.Font, lbl.TextXAlignment, lbl.LayoutOrder = UDim2.new(0.94, 0, 0, 22), 1, text, Color3.fromRGB(180, 60, 80), 11, Enum.Font.GothamBold, Enum.TextXAlignment.Left, order
    lbl.Parent = parentPage
end

local function createYantoToggle(name, parentPage, order, callback)
    local frame = Instance.new("Frame") frame.Size, frame.BackgroundTransparency, frame.LayoutOrder, frame.Parent = UDim2.new(0.94, 0, 0, 36), 1, order, parentPage
    local label = Instance.new("TextLabel") label.Size, label.BackgroundTransparency, label.Text, label.TextColor3, label.TextXAlignment, label.TextSize, label.Font = UDim2.new(0.7, 0, 1, 0), 1, "  " .. name, Color3.fromRGB(210, 210, 215), Enum.TextXAlignment.Left, 12, Enum.Font.GothamSemibold label.Parent = frame

    local switchBG = Instance.new("TextButton") switchBG.Size, switchBG.Position, switchBG.BackgroundColor3, switchBG.Text = UDim2.new(0, 38, 0, 20), UDim2.new(0.85, 0, 0.22, 0), Color3.fromRGB(45, 40, 40), ""
    local c1 = Instance.new("UICorner") c1.CornerRadius = UDim.new(1, 0) c1.Parent = switchBG
    local circle = Instance.new("Frame") circle.Size, circle.Position, circle.BackgroundColor3 = UDim2.new(0, 16, 0, 16), UDim2.new(0, 2, 0, 2), Color3.fromRGB(255, 255, 255)
    local c2 = Instance.new("UICorner") c2.CornerRadius = UDim.new(1, 0) c2.Parent = circle circle.Parent = switchBG

    local enabled = false
    switchBG.MouseButton1Click:Connect(function()
        enabled = not enabled
        TweenService:Create(circle, TweenInfo.new(0.15), {Position = enabled and UDim2.new(0, 20, 0, 2) or UDim2.new(0, 2, 0, 2)}):Play()
        TweenService:Create(switchBG, TweenInfo.new(0.15), {BackgroundColor3 = enabled and Color3.fromRGB(210, 50, 70) or Color3.fromRGB(45, 40, 40)}):Play()
        callback(enabled)
    end)
    switchBG.Parent = frame
end

createSectionTitle("Aimbot Settings", CombatPage, 1)
createYantoToggle("Aimbot (Silent/FOV)", CombatPage, 2, function(state) AimbotEnabled = state FOVCircle.Visible = state end)
createYantoToggle("Aimlock (Fijar Cámara)", CombatPage, 3, function(state) AimlockEnabled = state end)

-- Botón para configurar el radio del FOV
local FovSizeBtn = Instance.new("TextButton")
FovSizeBtn.Size, FovSizeBtn.BackgroundColor3 = UDim2.new(0.94, 0, 0, 32), Color3.fromRGB(26, 22, 22)
FovSizeBtn.Text, FovSizeBtn.TextColor3, FovSizeBtn.TextSize, FovSizeBtn.Font, FovSizeBtn.LayoutOrder = "  Radio FOV: MEDIO", Color3.fromRGB(240, 200, 100), 11, Enum.Font.GothamSemibold, 4
FovSizeBtn.TextXAlignment = Enum.TextXAlignment.Left
local fvc = Instance.new("UICorner") fvc.CornerRadius = UDim.new(0, 6) fvc.Parent = FovSizeBtn
FovSizeBtn.MouseButton1Click:Connect(function()
    if FOVRadius == 100 then FOVRadius, FovSizeBtn.Text = 180, "  Radio FOV: GRANDE"
    elseif FOVRadius == 180 then FOVRadius, FovSizeBtn.Text = 50, "  Radio FOV: PEQUEÑO"
    else FOVRadius, FovSizeBtn.Text = 100, "  Radio FOV: MEDIO" end
    FOVCircle.Radius = FOVRadius
end)
FovSizeBtn.Parent = CombatPage

local SmoothBtn = Instance.new("TextButton")
SmoothBtn.Size, SmoothBtn.BackgroundColor3 = UDim2.new(0.94, 0, 0, 32), Color3.fromRGB(26, 22, 22)
SmoothBtn.Text, SmoothBtn.TextColor3, SmoothBtn.TextSize, SmoothBtn.Font, SmoothBtn.LayoutOrder = "  Nivel Lock: MEDIO", Color3.fromRGB(180, 180, 185), 11, Enum.Font.GothamSemibold, 5
SmoothBtn.TextXAlignment = Enum.TextXAlignment.Left
local sc = Instance.new("UICorner") sc.CornerRadius = UDim.new(0, 6) sc.Parent = SmoothBtn
SmoothBtn.MouseButton1Click:Connect(function()
    if Smoothness == 0.25 then Smoothness, SmoothBtn.Text = 0.08, "  Nivel Lock: LENTO"
    elseif Smoothness == 0.08 then Smoothness, SmoothBtn.Text = 1.00, "  Nivel Lock: RÁPIDO"
    else Smoothness, SmoothBtn.Text = 0.25, "  Nivel Lock: MEDIO" end
end)
SmoothBtn.Parent = CombatPage

local TargetBtn = Instance.new("TextButton")
TargetBtn.Size, TargetBtn.BackgroundColor3 = UDim2.new(0.94, 0, 0, 32), Color3.fromRGB(26, 22, 22)
TargetBtn.Text, TargetBtn.TextColor3, TargetBtn.TextSize, TargetBtn.Font, TargetBtn.LayoutOrder = "  Apuntar a: CABEZA", Color3.fromRGB(0, 180, 240), 11, Enum.Font.GothamSemibold, 6
TargetBtn.TextXAlignment = Enum.TextXAlignment.Left
local tc = Instance.new("UICorner") tc.CornerRadius = UDim.new(0, 6) tc.Parent = TargetBtn
TargetBtn.MouseButton1Click:Connect(function()
    if TargetPart == "Head" then TargetPart, TargetBtn.Text = "HumanoidRootPart", "  Apuntar a: TORSO"
    else TargetPart, TargetBtn.Text = "Head", "  Apuntar a: CABEZA" end
end)
TargetBtn.Parent = CombatPage
createSectionTitle("Visual & ESP Settings", VisualPage, 1)
createYantoToggle("ESP Visual", VisualPage, 2, function(state) EspEnabled = state end)
createYantoToggle("Optimizar FPS", VisualPage, 3, function(state)
    FpsBoostEnabled = state
    if FpsBoostEnabled then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        game.Lighting.GlobalShadows = false
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not obj:IsDescendantOf(Players) then
                OriginalMaterials[obj] = {Material = obj.Material, Reflectance = obj.Reflectance}
                obj.Material, obj.Reflectance = Enum.Material.SmoothPlastic, 0
            elseif obj:IsA("Texture") or obj:IsA("Decal") then obj.Transparency = 1 end
        end
    else
        game.Lighting.GlobalShadows = true
        for obj, prop in pairs(OriginalMaterials) do if obj and obj.Parent then obj.Material, obj.Reflectance = prop.Material, prop.Reflectance end end
        for _, obj in ipairs(workspace:GetDescendants()) do if obj:IsA("Texture") or obj:IsA("Decal") then obj.Transparency = 0 end end
        OriginalMaterials = {}
    end
end)

createSectionTitle("Panel Themes", CreditsPage, 1)
local AspectBtn = Instance.new("TextButton")
AspectBtn.Size, AspectBtn.BackgroundColor3 = UDim2.new(0.94, 0, 0, 32), Color3.fromRGB(26, 22, 22)
AspectBtn.Text, AspectBtn.TextColor3, AspectBtn.TextSize, AspectBtn.Font, AspectBtn.LayoutOrder = "  Cambiar Aspecto: " .. Themes[CurrentThemeIndex].Name, Color3.fromRGB(220, 220, 225), 11, Enum.Font.GothamSemibold, 2
AspectBtn.TextXAlignment = Enum.TextXAlignment.Left
local ac = Instance.new("UICorner") ac.CornerRadius = UDim.new(0, 6) ac.Parent = AspectBtn
AspectBtn.MouseButton1Click:Connect(function()
    CurrentThemeIndex = CurrentThemeIndex + 1 if CurrentThemeIndex > #Themes then CurrentThemeIndex = 1 end
    AspectBtn.Text = "  Cambiar Aspecto: " .. Themes[CurrentThemeIndex].Name
    MainStroke.Color = Themes[CurrentThemeIndex].Color BarStroke.Color = Themes[CurrentThemeIndex].Color
end)
AspectBtn.Parent = CreditsPage

local function createInfoCard(title, text, order)
    local card = Instance.new("TextLabel") card.Size, card.BackgroundColor3, card.Text, card.TextColor3, card.TextSize, card.Font, card.TextXAlignment, card.LayoutOrder = UDim2.new(0.94, 0, 0, 34), Color3.fromRGB(24, 20, 20), "  " .. title .. " " .. text, Color3.fromRGB(160, 160, 165), 11, Enum.Font.Gotham, Enum.TextXAlignment.Left, order
    local cc = Instance.new("UICorner") cc.CornerRadius = UDim.new(0, 6) cc.Parent = card card.Parent = CreditsPage
end
createInfoCard("Versión del Script:", "v5.0 Ultimate", 3)
createInfoCard("Desarrollador:", "Asistente AI", 4)

local function checkAlive(player)
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then return player.Character.Humanoid.Health > 0 end
    return false
end

local function isVisible(targetPart)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Head") then return false end
    local result = workspace:Raycast(Camera.CFrame.Position, (targetPart.Position - Camera.CFrame.Position), RaycastParams.new())
    if result and result.Instance then if result.Instance:IsDescendantOf(targetPart.Parent) then return true end return false end
    return true
end

task.spawn(function()
    while task.wait(0.3) do
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                if p.Character and p.Character:FindFirstChild("Humanoid") then if ActiveCharacters[p.UserId] ~= p.Character then ActiveCharacters[p.UserId] = p.Character end else ActiveCharacters[p.UserId] = nil end
            end
        end
    end
end)

-- Buscador unificado compatible con Aimlock (Toda la pantalla) y Aimbot (Filtro por radio de FOV)
local function getClosestTarget(useFOV)
    if not checkAlive(LocalPlayer) then return nil end
    local closest, shortest = nil, useFOV and FOVRadius or math.huge
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for id, char in pairs(ActiveCharacters) do
        local p = Players:GetPlayerByUserId(id)
        if p and checkAlive(p) and char:FindFirstChild(TargetPart) then
            local objPart = char[TargetPart]
            if isVisible(objPart) then
                local pos, onScreen = Camera:WorldToViewportPoint(objPart.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if dist < shortest then shortest, closest = dist, p end
                end
            end
        end
    end
    return closest
end

-- 🟥 SECCIÓN CRÍTICA: MOTOR DE REDIRECCIÓN SILENT AIM (AIMBOT)
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if AimbotEnabled and (method == "FindPartOnRayWithIgnoreList" or method == "FindPartOnRay" or method == "Raycast") then
        local t = getClosestTarget(true) -- Busca solo dentro del FOVRadius
        if t and t.Character and t.Character:FindFirstChild(TargetPart) then
            -- Redirige matemáticamente la bala hacia la cabeza/torso seleccionados
            local origin = Camera.CFrame.Position
            local targetPos = t.Character[TargetPart].Position
            if method == "Raycast" then
                args[2] = (targetPos - args[1]).Unit * 1000
            end
            return oldNamecall(self, unpack(args))
        end
    end
    return oldNamecall(self, ...)
end)

RunService.RenderStepped:Connect(function()
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FOVCircle.Position = center

    -- Aimlock Clásico (Fijado de Cámara completo)
    if AimlockEnabled and checkAlive(LocalPlayer) then
        local t = getClosestTarget(false)
        if t and t.Character and t.Character:FindFirstChild(TargetPart) then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, t.Character[TargetPart].Position), Smoothness)
        end
    end
    
    for id, char in pairs(ActiveCharacters) do
        local p = Players:GetPlayerByUserId(id)
        if p and char and char.Parent then
            local hl = char:FindFirstChild("MobESP")
            if EspEnabled and checkAlive(p) then
                if not hl then
                    hl = Instance.new("Highlight", char) hl.Name = "MobESP"
                    hl.FillColor = Color3.fromRGB(255, 40, 40) hl.FillTransparency, hl.OutlineTransparency = 0.55, 0.2
                end
            else if hl then hl:Destroy() end end
        end
    end
end)
