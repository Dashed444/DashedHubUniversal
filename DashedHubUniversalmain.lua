local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local LLAVE_CORRECTA = "DashedUniversal" 
local LINK_PARA_LLAVE = "https://linkvertise.com"

local KeyGui = Instance.new("ScreenGui")
KeyGui.Parent = game.CoreGui
KeyGui.ResetOnSpawn = false

local KeyFrame = Instance.new("Frame")
KeyFrame.Parent = KeyGui
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
KeyTitle.Text = "🔑 DASHED HUB | INGRESA LA KEY"
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

local function InicializarDashedHub()
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
    MainFrame.Size = UDim2.new(0, 380, 0, 320)
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
    Title.Text = "   ⚡ DASHED HUB | Universal Framework"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextSize = 14
    Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 16)

    local CloseButton = Instance.new("TextButton", MainFrame)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(0.88, 0, 0, 0)
    CloseButton.Size = UDim2.new(0, 40, 0, 45)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseButton.TextSize = 16
    CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local MinimizeButton = Instance.new("TextButton", MainFrame)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Position = UDim2.new(0.76, 0, 0, 0)
    MinimizeButton.Size = UDim2.new(0, 40, 0, 45)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "—"
    MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    MinimizeButton.TextSize = 14

    local ToggleButton = Instance.new("TextButton", ScreenGui)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(140, 60, 200)
    ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
    ToggleButton.Size = UDim2.new(0, 65, 0, 40)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Text = "DASHED"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 11
    ToggleButton.Visible = false
    ToggleButton.Draggable = true
    Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 10)

    MinimizeButton.MouseButton1Click:Connect(function() MainFrame.Visible = false ToggleButton.Visible = true end)
    ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = true ToggleButton.Visible = false end)

    local TabPanel = Instance.new("Frame", MainFrame)
    TabPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    TabPanel.Position = UDim2.new(0, 0, 0, 45)
    TabPanel.Size = UDim2.new(0, 110, 1, -45)
    Instance.new("UICorner", TabPanel).CornerRadius = UDim.new(0, 16)

    local TabList = Instance.new("UIListLayout", TabPanel)
    TabList.Padding = UDim.new(0, 6)
    TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local PageGames = Instance.new("ScrollingFrame", MainFrame)
    local PageConfig = Instance.new("Frame", MainFrame)
    local PageCredits = Instance.new("Frame", MainFrame)

    local paginas = {PageGames, PageConfig, PageCredits}
    for _, pag in pairs(paginas) do
        pag.BackgroundTransparency = 1
        pag.Position = UDim2.new(0, 120, 0, 55)
        pag.Size = UDim2.new(1, -130, 1, -65)
        pag.Visible = false
    end
    PageGames.Visible = true

    PageGames.CanvasSize = UDim2.new(0, 0, 0, 400) 
    PageGames.ScrollBarThickness = 2
    PageGames.ScrollBarImageColor3 = Color3.fromRGB(140, 60, 200)
    Instance.new("UIListLayout", PageGames).Padding = UDim.new(0, 6)

    local BotonesTab = {}
    local function CambiarPestaña(paginaActiva, botonActivo)
        for _, pag in pairs(paginas) do pag.Visible = false end
        for _, btn in pairs(BotonesTab) do btn.TextColor3 = Color3.fromRGB(160, 160, 160) btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25) end
        paginaActiva.Visible = true
        botonActivo.TextColor3 = Color3.fromRGB(255, 255, 255)
        botonActivo.BackgroundColor3 = Color3.fromRGB(140, 60, 200)
    end

    local function CrearBotonTab(texto, paginaAsociada)
        local btn = Instance.new("TextButton", TabPanel)
        btn.Size = UDim2.new(0.9, 0, 0, 36)
        btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        btn.Font = Enum.Font.GothamSemibold
        btn.Text = texto
        btn.TextColor3 = Color3.fromRGB(160, 160, 160)
        btn.TextSize = 12
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        btn.MouseButton1Click:Connect(function() CambiarPestaña(paginaAsociada, btn) end)
        table.insert(BotonesTab, btn)
        return btn
    end

    local Tab1 = CrearBotonTab("🎮 Juegos", PageGames)
    local Tab2 = CrearBotonTab("⚙️ Config", PageConfig)
    local Tab3 = CrearBotonTab("👑 Créditos", PageCredits)
    Tab1.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab1.BackgroundColor3 = Color3.fromRGB(140, 60, 200)

    local GLP = Instance.new("TextLabel", PageGames)
    GLP.BackgroundTransparency = 1; GLP.Size = UDim2.new(1, 0, 0, 40); GLP.Font = Enum.Font.Gotham
    GLP.Text = "Lista de juegos vacía. Listo para implementar módulos..."
    GLP.TextColor3 = Color3.fromRGB(130, 130, 140); GLP.TextSize = 11

    local CLP = Instance.new("TextLabel", PageConfig)
    CLP.BackgroundTransparency = 1; CLP.Size = UDim2.new(1, 0, 0, 40); CLP.Font = Enum.Font.Gotham
    CLP.Text = "Apartado de configuración global en desarrollo..."
    CLP.TextColor3 = Color3.fromRGB(130, 130, 140); CLP.TextSize = 11

    local CreditText = Instance.new("TextLabel", PageCredits)
    CreditText.BackgroundTransparency = 1; CreditText.Size = UDim2.new(1, 0, 0, 30); CreditText.Font = Enum.Font.GothamBold
    CreditText.Text = "CREADO POR DASHED ✨"; CreditText.TextColor3 = Color3.fromRGB(255, 215, 0); CreditText.TextSize = 16
    CreditText.TextXAlignment = Enum.TextXAlignment.Left

    local SubCreditText = Instance.new("TextLabel", PageCredits)
    SubCreditText.BackgroundTransparency = 1; SubCreditText.Position = UDim2.new(0, 0, 0.2, 0); SubCreditText.Size = UDim2.new(1, 0, 0, 80); SubCreditText.Font = Enum.Font.Gotham
    SubCreditText.Text = "Gracias por usar este script.\n\nEste HUB ha sido completamente diseñado, ordenado y optimizado de forma exclusiva para ejecutores móviles como Delta."
    SubCreditText.TextColor3 = Color3.fromRGB(140, 140, 150); SubCreditText.TextWrapped = true; SubCreditText.TextSize = 11
    SubCreditText.TextXAlignment = Enum.TextXAlignment.Left; SubCreditText.TextYAlignment = Enum.TextYAlignment.Top
    
    local Credits = Instance.new("TextLabel", MainFrame)
    Credits.BackgroundTransparency = 1; Credits.Position = UDim2.new(0, 0, 0.90, 0); Credits.Size = UDim2.new(1, 0, 0, 30); Credits.Font = Enum.Font.GothamSemibold
    Credits.Text = "Creado por DASHED ✨ | Universal Script"; Credits.TextColor3 = Color3.fromRGB(255, 215, 0); Credits.TextSize = 11
end

CheckButton.MouseButton1Click:Connect(function()
    if TextBox.Text == LLAVE_CORRECTA then
        KeyGui:Destroy()
        InicializarDashedHub()
    else
        TextBox.Text = ""
TextBox.PlaceholderText = "❌ LLAVE INCORRECTA"
task.wait(1.5)
TextBox.PlaceholderText = "Pega la llave aquí..."
end
end)
