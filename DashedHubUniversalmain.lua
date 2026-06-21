-- Cargamos la librería de interfaz visual Orion
local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()

-- CONFIGURACIÓN DE TU KEY Y LINKVERTISE
-- Cambia lo que está entre comillas cada día según tu Linkvertise
local LlaveCorrecta = "KEY_DIARIA_2026" 
-- Reemplaza este enlace por tu URL real de Linkvertise
local EnlaceLinkvertise = "https://linkvertise.com" 

-- Crear ventana del Key System
local Window = OrionLib:MakeWindow({
    Name = "Sistema de Key | Delta", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "DeltaFijaKey"
})

local KeyTab = Window:MakeTab({
    Name = "Verificación",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

KeyTab:AddLabel("Para usar el script debes obtener la llave actual.")

-- Botón para copiar el enlace de Linkvertise
KeyTab:AddButton({
    Name = "Copiar Enlace de Linkvertise",
    Callback = function()
        setclipboard(EnlaceLinkvertise)
        OrionLib:MakeNotification({
            Name = "¡Copiado!",
            Content = "Enlace copiado. Pégalo en tu navegador para ver la llave.",
            Image = "rbxassetid://4483345998",
            Duration = 5
        })
    end
})

-- Cuadro de texto para validar la llave ingresada por el usuario
KeyTab:AddTextbox({
    Name = "Ingresa la Key Aquí",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        if Value == LlaveCorrecta then
            OrionLib:MakeNotification({
                Name = "Acceso Concedido",
                Content = "¡Llave correcta! Cargando menú...",
                Image = "rbxassetid://4483345998",
                Duration = 4
            })
            
            -- Cerramos el validador y abrimos el script principal
            task.wait(1)
            OrionLib:Destroy()
            EjecutarScriptPrincipal()
        else
            OrionLib:MakeNotification({
                Name = "Llave Incorrecta",
                Content = "Esa llave no es válida o ya expiró.",
                Image = "rbxassetid://4483345998",
                Duration = 4
            })
        end
    end
})

-- SCRIPT PRINCIPAL DESBLOQUEADO (Aquí pones tu menú real)
function EjecutarScriptPrincipal()
    local MainWin = OrionLib:MakeWindow({Name = "Script Premium Desbloqueado", HidePremium = false, SaveConfig = true, ConfigFolder = "MainDelta"})
    local MainTab = MainWin:MakeTab({Name = "Funciones", Icon = "rbxassetid://4483345998", PremiumOnly = false})
    
    MainTab:AddLabel("¡Bienvenido! Script activo con éxito.")
    
    -- Ejemplo de una función dentro de tu menú
    MainTab:AddButton({
        Name = "Aumentar Velocidad (Ejemplo)",
        Callback = function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
        end
    })
    
    OrionLib:Init()
end

OrionLib:Init()
