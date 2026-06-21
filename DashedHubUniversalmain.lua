local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

-- Notificación de activación para Delta
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Anti-AFK Activo",
    Text = "Farmea tranquilo, Roblox no te sacará.",
    Duration = 5
})

-- Captura el error de inactividad antes de que te desconecte
Players.LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0, 0))
end)
