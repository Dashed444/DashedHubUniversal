local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local AimlockEnabled, EspEnabled, FpsBoostEnabled = false, false, false
local Smoothness, TargetPart, ActiveCharacters, OriginalMaterials = 0.25, "Head", {}, {}

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
MainFrame.Size = UDim2.new(0.58, 0, 0.68, 0)
MainFrame.Position = UDim2.new(0.21, 0, 0.16, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 14, 14)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.2
MainStroke.Color = Themes[CurrentThemeIndex].Color
MainStroke.Parent = MainFrame

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0.28, 0, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(11, 9, 9)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 12)
SideCorner.Parent = Sidebar

local HubTitle = Instance.new("TextLabel")
HubTitle.Size = UDim2.new(1, 0, 0.12, 0)
HubTitle.BackgroundTransparency = 1
HubTitle.Text = "YANTO HUB VIP"
HubTitle.TextColor3 = Color3.fromRGB(220, 50, 70)
HubTitle.TextScaled = true
HubTitle.Font = Enum.Font.GothamBold
HubTitle.Parent = Sidebar
local PerfFrame = Instance.new("Frame")
PerfFrame.Size = UDim2.new(0.68, 0, 0.08, 0)
PerfFrame.Position = UDim2.new(0.3, 0, 0.03, 0)
PerfFrame.BackgroundTransparency = 1
PerfFrame.Parent = MainFrame

local PerfLayout = Instance.new("UIListLayout")
PerfLayout.Padding = UDim.new(0.03, 0)
PerfLayout.FillDirection = Enum.FillDirection.Horizontal
PerfLayout.SortOrder = Enum.SortOrder.LayoutOrder
PerfLayout.Parent = PerfFrame

local function createPerfLabel(color, order)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.42, 0, 0.9, 0)
    lbl.BackgroundColor3 = color
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextScaled = true
    lbl.Font = Enum.Font.GothamSemibold
    lbl.LayoutOrder = order
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
TabContainer.Size = UDim2.new(1, 0, 0.85, 0)
TabContainer.Position = UDim2.new(0, 0, 0.15, 0)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = Sidebar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Padding = UDim.new(0.03, 0)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Parent = TabContainer

local PagesFrame = Instance.new("Frame")
PagesFrame.Size = UDim2.new(0.68, 0, 0.82, 0)
PagesFrame.Position = UDim2.new(0.3, 0, 0.15, 0)
PagesFrame.BackgroundTransparency = 1
PagesFrame.Parent = MainFrame

local function createPage()
    local pg = Instance.new("ScrollingFrame")
    pg.Size = UDim2.new(1, 0, 1, 0)
    pg.BackgroundTransparency = 1
    pg.CanvasSize = UDim2.new(0, 0, 1.6, 0)
    pg.ScrollBarThickness = 2
    pg.Visible = false
    pg.Parent = PagesFrame
    local lay = Instance.new("UIListLayout")
    lay.Padding = UDim.new(0.04, 0)
    lay.HorizontalAlignment = Enum.HorizontalAlignment.Center
    lay.SortOrder = Enum.SortOrder.LayoutOrder
    lay.Parent = pg
    return pg
end
local CombatPage = createPage() CombatPage.Visible = true
local VisualPage = createPage()
local CreditsPage = createPage()

local SavedMinBarPosition = UDim2.new(0.05, 0, 0.05, 0)

local MinBar = Instance.new("Frame")
MinBar.Size = UDim2.new(0, 180, 0, 42)
MinBar.Position = SavedMinBarPosition
MinBar.BackgroundColor3 = Color3.fromRGB(15, 35, 30)
MinBar.Active, MinBar.Draggable = true, true
MinBar.Visible = false
MinBar.Parent = ScreenGui

MinBar:GetPropertyChangedSignal("Position"):Connect(function()
    if MinBar.Visible then SavedMinBarPosition = MinBar.Position end
end)

local BarCorner = Instance.new("UICorner") BarCorner.CornerRadius = UDim.new(1, 0) BarCorner.Parent = MinBar
local BarStroke = Instance.new("UIStroke") BarStroke.Thickness = 1.5 BarStroke.Color = Themes[CurrentThemeIndex].Color BarStroke.Parent = MinBar

local DragIcon = Instance.new("TextLabel")
DragIcon.Size = UDim2.new(0.25, 0, 1, 0)
DragIcon.BackgroundTransparency = 1
DragIcon.Text = "✛"
DragIcon.TextColor3 = Color3.fromRGB(230, 150, 40)
DragIcon.TextSize = 22
DragIcon.Font = Enum.Font.GothamBold
DragIcon.Parent = MinBar

local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0.75, 0, 1, 0)
OpenButton.Position = UDim2.new(0.25, 0, 0, 0)
OpenButton.BackgroundTransparency = 1
OpenButton.Text = "🖥️  AUTOFARM"
OpenButton.TextColor3 = Color3.fromRGB(240, 240, 245)
OpenButton.TextSize = 14
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Parent = MinBar

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.BackgroundTransparency = 1
    MinBar.Visible = false
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0.58, 0, 0.68, 0)}):Play()
    TweenService:Create(MainFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
end)

local CloseMenuBtn = Instance.new("TextButton")
CloseMenuBtn.Size = UDim2.new(0, 26, 0, 26)
CloseMenuBtn.Position = UDim2.new(0.94, 0, 0.03, 0)
CloseMenuBtn.BackgroundColor3 = Color3.fromRGB(35, 25, 25)
CloseMenuBtn.Text = "X"
CloseMenuBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
CloseMenuBtn.Font = Enum.Font.GothamBold
CloseMenuBtn.TextSize = 12
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
    btn.Text = "  " .. name
    btn.TextColor3 = (order == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 165)
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Font, btn.LayoutOrder = Enum.Font.GothamSemibold, order
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = btn
    
    if order == 1 then ActiveTabButton = btn end
    
    btn.MouseButton1Click:Connect(function()
        if ActiveTabButton then
            ActiveTabButton.BackgroundTransparency = 1
            ActiveTabButton.TextColor3 = Color3.fromRGB(160, 160, 165)
        end
        btn.BackgroundColor3 = Color3.fromRGB(35, 25, 25)
        btn.BackgroundTransparency = 0
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        ActiveTabButton = btn
        
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
    lbl.Size = UDim2.new(0.94, 0, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(180, 60, 80)
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.LayoutOrder = order
    lbl.Parent = parentPage
end

local function createYantoToggle(name, parentPage, order, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.94, 0, 0, 36)
    frame.BackgroundTransparency = 1
    frame.LayoutOrder = order
    frame.Parent = parentPage

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "  " .. name
    label.TextColor3 = Color3.fromRGB(210, 210, 215)
    label.TextXAlignment, label.TextSize, label.Font = Enum.TextXAlignment.Left, 12, Enum.Font.GothamSemibold
    label.Parent = frame

    local switchBG = Instance.new("TextButton")
    switchBG.Size = UDim2.new(0, 38, 0, 20)
    switchBG.Position = UDim2.new(0.85, 0, 0.22, 0)
    switchBG.BackgroundColor3 = Color3.fromRGB(45, 40, 40)
    switchBG.Text = ""
    local c1 = Instance.new("UICorner") c1.CornerRadius = UDim.new(1, 0) c1.Parent = switchBG

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 16, 0, 16)
    circle.Position = UDim2.new(0, 2, 0, 2)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    local c2 = Instance.new("UICorner") c2.CornerRadius = UDim.new(1, 0) c2.Parent = circle
    circle.Parent = switchBG

    local enabled = false
    switchBG.MouseButton1Click:Connect(function()
        enabled = not enabled
        local targetX = enabled and UDim2.new(0, 20, 0, 2) or UDim2.new(0, 2, 0, 2)
        local targetColor = enabled and Color3.fromRGB(210, 50, 70) or Color3.fromRGB(45, 40, 40)
        
        TweenService:Create(circle, TweenInfo.new(0.15), {Position = targetX}):Play()
        TweenService:Create(switchBG, TweenInfo.new(0.15), {BackgroundColor3 = targetColor}):Play()
        callback(enabled)
    end)
    switchBG.Parent = frame
end

createSectionTitle("Aimbot Settings", CombatPage, 1)
createYantoToggle("Aimlock Activo", CombatPage, 2, function(state) AimlockEnabled = state end)

local SmoothBtn = Instance.new("TextButton")
SmoothBtn.Size = UDim2.new(0.94, 0, 0, 32)
SmoothBtn.BackgroundColor3 = Color3.fromRGB(26, 22, 22)
SmoothBtn.Text, SmoothBtn.TextColor3, SmoothBtn.TextSize, SmoothBtn.Font, SmoothBtn.LayoutOrder = "  Nivel Aim Lock: MEDIO", Color3.fromRGB(180, 180, 185), 11, Enum.Font.GothamSemibold, 3
SmoothBtn.TextXAlignment = Enum.TextXAlignment.Left
local sc = Instance.new("UICorner") sc.CornerRadius = UDim.new(0, 6) sc.Parent = SmoothBtn
SmoothBtn.MouseButton1Click:Connect(function()
    if Smoothness == 0.25 then Smoothness, SmoothBtn.Text = 0.08, "  Nivel Aim Lock: LENTO"
    elseif Smoothness == 0.08 then Smoothness, SmoothBtn.Text = 1.00, "  Nivel Aim Lock: RÁPIDO"
    else Smoothness, SmoothBtn.Text = 0.25, "  Nivel Aim Lock: MEDIO" end
end)
SmoothBtn.Parent = CombatPage

local TargetBtn = Instance.new("TextButton")
TargetBtn.Size = UDim2.new(0.94, 0, 0, 32)
TargetBtn.BackgroundColor3 = Color3.fromRGB(26, 22, 22)
TargetBtn.Text, TargetBtn.TextColor3, TargetBtn.TextSize, TargetBtn.Font, TargetBtn.LayoutOrder = "  Apuntar a: CABEZA", Color3.fromRGB(0, 180, 240), 11, Enum.Font.GothamSemibold, 4
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
        for obj, prop in pairs(OriginalMaterials) do
            if obj and obj.Parent then obj.Material, obj.Reflectance = prop.Material, prop.Reflectance end
        end
        for _, obj in ipairs(workspace:GetDescendants()) do if obj:IsA("Texture") or obj:IsA("Decal") then obj.Transparency = 0 end end
        OriginalMaterials = {}
    end
end)

createSectionTitle("Panel Themes", CreditsPage, 1)
local AspectBtn = Instance.new("TextButton")
AspectBtn.Size = UDim2.new(0.94, 0, 0, 32)
AspectBtn.BackgroundColor3 = Color3.fromRGB(26, 22, 22)
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
    local card = Instance.new("TextLabel")
    card.Size, card.BackgroundColor3, card.Text, card.TextColor3, card.TextSize, card.Font, card.TextXAlignment, card.LayoutOrder = UDim2.new(0.94, 0, 0, 34), Color3.fromRGB(24, 20, 20), "  " .. title .. " " .. text, Color3.fromRGB(160, 160, 165), 11, Enum.Font.Gotham, Enum.TextXAlignment.Left, order
    local cc = Instance.new("UICorner") cc.CornerRadius = UDim.new(0, 6) cc.Parent = card card.Parent = CreditsPage
end
createInfoCard("Versión del Script:", "v4.5 Premium", 3)
createInfoCard("Desarrollador:", "Asistente AI", 4)

local function checkAlive(player)
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then return player.Character.Humanoid.Health > 0 end
    return false
end

local function isVisible(targetPart)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Head") then return false end
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    local result = workspace:Raycast(origin, direction, raycastParams)
    if result then if result.Instance:IsDescendantOf(targetPart.Parent) then return true end return false end
    return true
end

task.spawn(function()
    while task.wait(0.3) do
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                if p.Character and p.Character:FindFirstChild("Humanoid") then
                    if ActiveCharacters[p.UserId] ~= p.Character then ActiveCharacters[p.UserId] = p.Character end
                else ActiveCharacters[p.UserId] = nil end
            end
        end
        for id, _ in pairs(ActiveCharacters) do if not Players:GetPlayerByUserId(id) then ActiveCharacters[id] = nil end end
    end
end)

local function getClosestTarget()
    if not checkAlive(LocalPlayer) then return nil end
    local closest, shortest = nil, math.huge
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    for id, char in pairs(ActiveCharacters) do
        local p = Players:GetPlayerByUserId(id)
        if p and checkAlive(p) and char:FindFirstChild(TargetPart) then
            local targetObjPart = char[TargetPart]
            if isVisible(targetObjPart) then
                local pos, onScreen = Camera:WorldToViewportPoint(targetObjPart.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if dist < shortest then shortest, closest = dist, p end
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if AimlockEnabled and checkAlive(LocalPlayer) then
        local t = getClosestTarget()
        if t and t.Character and t.Character:FindFirstChild(TargetPart) then
            local targetCFrame = CFrame.new(Camera.CFrame.Position, t.Character[TargetPart].Position)
            Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, Smoothness)
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
