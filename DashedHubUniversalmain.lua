local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- ========================================================
-- CONFIGURACIÓN DE TU LLAVE MONETIZADA (Linkvertise)
-- ========================================================
local LLAVE_CORRECTA = "DashedUniversal" -- Contraseña para tus seguidores
local LINK_PARA_LLAVE = "https://linkvertise.com" -- Tu link corto

-- 1. PANTALLA DE BLOQUEO (KEY SYSTEM UI)
local KeyGui = Instance.new("ScreenGui", game.CoreGui)
KeyGui.ResetOnSpawn = false

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
KeyFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
KeyFrame.Size = UDim2.new(0, 300, 0, 180)
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)
local KStrok = Instance.new("UIStroke", KeyFrame)
KStrok.Color = Color3.fromRGB(140, 60, 200)
KStrok.Thickness = 1.5

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
KeyTitle.Size = UDim2.new(1, 0, 0, 35)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Text = "🔑 DASHED HUB | INGRESA KEY"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 13
Instance.new("UICorner", KeyTitle).CornerRadius = UDim.new(0, 12)

local TextBox = Instance.new("TextBox", KeyFrame)
TextBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
TextBox.Position = UDim2.new(0.05, 0, 0.3, 0)
TextBox.Size = UDim2.new(0.9, 0, 0, 35)
TextBox.Font = Enum.Font.Gotham
TextBox.PlaceholderText = "Pega la llave aquí..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 12
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)

local CheckButton = Instance.new("TextButton", KeyFrame)
CheckButton.BackgroundColor3 = Color3.fromRGB(140, 60, 200)
CheckButton.Position = UDim2.new(0.05, 0, 0.6, 0)
CheckButton.Size = UDim2.new(0.42, 0, 0, 35)
CheckButton.Font = Enum.Font.GothamBold
CheckButton.Text = "VERIFICAR"
CheckButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckButton.TextSize = 12
Instance.new("UICorner", CheckButton).CornerRadius = UDim.new(0, 6)

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
GetKeyBtn.Position = UDim2.new(0.53, 0, 0.6, 0)
GetKeyBtn.Size = UDim2.new(0.42, 0, 0, 35)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Text = "🏆 OBTENER KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
GetKeyBtn.TextSize = 11
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 6)

GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(LINK_PARA_LLAVE)
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Copiado", Text = "Linkvertise copiado al portapapeles.", Duration = 3})
    end
end)

-- ========================================================
-- 2. MENÚ PRINCIPAL UNIVERSAL (DASHED HUB)
-- ========================================================
local function AbrirMenuPrincipal()
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
    MainFrame.Size = UDim2.new(0, 330, 0, 260)
    MainFrame.Active = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(140, 60, 200)
    MainStroke.Thickness = 1.5

    local Title = Instance.new("TextLabel", MainFrame)
    Title.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "   ⚡ DASHED HUB UNIVERSAL"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextSize = 14
    Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 16)

    local CloseButton = Instance.new("TextButton", MainFrame)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(0.85, 0, 0, 0)
    CloseButton.Size = UDim2.new(0, 40, 0, 45)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseButton.TextSize = 16
    CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- CONTENEDOR DE CONTENIDO (LISTA DE JUEGOS)
    local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
    ScrollFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    ScrollFrame.BackgroundTransparency = 0.4
    ScrollFrame.Position = UDim2.new(0.05, 0, 0.22, 0)
    ScrollFrame.Size = UDim2.new(0, 295, 0, 160)
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
    ScrollFrame.ScrollBarThickness = 3
    ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(140, 60, 200)
    Instance.new("UICorner", ScrollFrame).CornerRadius = UDim.new(0, 8)
    local ListLayout = Instance.new("UIListLayout", ScrollFrame)
    ListLayout.Padding = UDim.new(0, 8)
    ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    -- MENSAJE DE ESPERA DE JUEGOS
    local PlaceholderText = Instance.new("TextLabel", ScrollFrame)
    PlaceholderText.BackgroundTransparency = 1
    PlaceholderText.Size = UDim2.new(0.9, 0, 0, 40)
    PlaceholderText.Font = Enum.Font.Gotham
    PlaceholderText.Text = "Módulos listos. Esperando configuraciones de mapas..."
    PlaceholderText.TextColor3 = Color3.fromRGB(140, 140, 150)
    PlaceholderText.TextSize = 11
    PlaceholderText.TextWrapped = true

    -- PIE DE PÁGINA (CRÉDITOS FIJOS)
    local Credits = Instance.new("TextLabel", MainFrame)
    Credits.BackgroundTransparency = 1
    Credits.Position = UDim2.new(0, 0, 0.88, 0)
    Credits.Size = UDim2.new(1, 0, 0, 25)
    Credits.Font = Enum.Font.GothamSemibold
    Credits.Text = "Creado por DASHED ✨ | Listo para TikTok"
    Credits.TextColor3 = Color3.fromRGB(255, 215, 0)
    Credits.TextSize = 12
end

-- LÓGICA DE VERIFICACIÓN
CheckButton.MouseButton1Click:Connect(function()
    if TextBox.Text == LLAVE_CORRECTA then
        KeyGui:Destroy()
        AbrirMenuPrincipal()
    else
        TextBox.Text = ""
        TextBox.PlaceholderText = "❌ LLAVE INCORRECTA"
        task.wait(1.5)
        TextBox.PlaceholderText = "Pega la llave aquí..."
    end
end)
