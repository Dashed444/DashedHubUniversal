local P=game:GetService("Players").LocalPlayer;local K,L="DashedUniversal","https://linkvertise.com"
local G=Instance.new("ScreenGui",game.CoreGui);G.ResetOnSpawn=false
local KF=Instance.new("Frame",G);KF.BackgroundColor3=Color3.fromRGB(25,25,30);KF.Position=UDim2.new(0.35,0,0.35,0);KF.Size=UDim2.new(0,300,0,180);KF.Active,KF.Draggable=true,true
Instance.new("UICorner",KF).CornerRadius=UDim.new(0,12);local S=Instance.new("UIStroke",KF);S.Color,S.Thickness=Color3.fromRGB(140,60,200),1.5
local KT=Instance.new("TextLabel",KF);KT.BackgroundColor3,KT.Size,KT.Font,KT.Text,KT.TextColor3,KT.TextSize=Color3.fromRGB(35,35,45),UDim2.new(1,0,0,35),Enum.Font.GothamBold,"🔑 DASHED HUB | INGRESA KEY",Color3.fromRGB(255,255,255),13
Instance.new("UICorner",KT).CornerRadius=UDim.new(0,12)
local TB=Instance.new("TextBox",KF);TB.BackgroundColor3,TB.Position,TB.Size,TB.Font,TB.PlaceholderText,TB.Text,TB.TextColor3,TB.TextSize=Color3.fromRGB(15,15,20),UDim2.new(0.05,0,0.3,0),UDim2.new(0.9,0,0,35),Enum.Font.Gotham,"Pega la llave aquí...","",Color3.fromRGB(255,255,255),12
Instance.new("UICorner",TB).CornerRadius=UDim.new(0,6)
local CB=Instance.new("TextButton",KF);CB.BackgroundColor3,CB.Position,CB.Size,CB.Font,CB.Text,CB.TextColor3,CB.TextSize=Color3.fromRGB(140,60,200),UDim2.new(0.05,0,0.6,0),UDim2.new(0.42,0,0,35),Enum.Font.GothamBold,"VERIFICAR",Color3.fromRGB(255,255,255),12
Instance.new("UICorner",CB).CornerRadius=UDim.new(0,6)
local GB=Instance.new("TextButton",KF);GB.BackgroundColor3,GB.Position,GB.Size,GB.Font,GB.Text,GB.TextColor3,GB.TextSize=Color3.fromRGB(40,40,50),UDim2.new(0.53,0,0.6,0),UDim2.new(0.42,0,0,35),Enum.Font.GothamBold,"🏆 OBTENER KEY",Color3.fromRGB(200,200,200),11
Instance.new("UICorner",GB).CornerRadius=UDim.new(0,6)
GB.MouseButton1Click:Connect(function() if setclipboard then setclipboard(L) game:GetService("StarterGui"):SetCore("SendNotification",{Title="Copiado",Text="Linkvertise copiado.",Duration=3}) end end)

local function Main()
    local SG=Instance.new("ScreenGui",game.CoreGui);SG.ResetOnSpawn=false
    local MF=Instance.new("Frame",SG);MF.BackgroundColor3,MF.Position,MF.Size,MF.Active,MF.Draggable=Color3.fromRGB(20,20,25),UDim2.new(0.3,0,0.25,0),UDim2.new(0,380,0,320),true,true
    Instance.new("UICorner",MF).CornerRadius=UDim.new(0,16);local MS=Instance.new("UIStroke",MF);MS.Color,MS.Thickness=Color3.fromRGB(140,60,200),1.5
    local T=Instance.new("TextLabel",MF);T.BackgroundColor3,T.Size,T.Font,T.Text,T.TextColor3,T.TextXAlignment,T.TextSize=Color3.fromRGB(30,30,40),UDim2.new(1,0,0,45),Enum.Font.GothamBold,"   ⚡ DASHED HUB | Universal",Color3.fromRGB(255,255,255),Enum.TextXAlignment.Left,14
    Instance.new("UICorner",T).CornerRadius=UDim.new(0,16)
    local Cl=Instance.new("TextButton",MF);Cl.BackgroundTransparency,Cl.Position,Cl.Size,Cl.Font,Cl.Text,Cl.TextColor3,Cl.TextSize=1,UDim2.new(0.88,0,0,0),UDim2.new(0,40,0,45),Enum.Font.GothamBold,"✕",Color3.fromRGB(255,100,100),16
    Cl.MouseButton1Click:Connect(function() SG:Destroy() end)
    local Mn=Instance.new("TextButton",MF);Mn.BackgroundTransparency,Mn.Position,Mn.Size,Mn.Font,Mn.Text,Mn.TextColor3,Mn.TextSize=1,UDim2.new(0.76,0,0,0),UDim2.new(0,40,0,45),Enum.Font.GothamBold,"—",Color3.fromRGB(200,200,200),14
    local Tg=Instance.new("TextButton",SG);Tg.BackgroundColor3,Tg.Position,Tg.Size,Tg.Font,Tg.Text,Tg.TextColor3,Tg.TextSize,Tg.Visible,Tg.Draggable=Color3.fromRGB(140,60,200),UDim2.new(0.05,0,0.4,0),UDim2.new(0,65,0,40),Enum.Font.GothamBold,"DASHED",Color3.fromRGB(255,255,255),11,false,true
    Instance.new("UICorner",Tg).CornerRadius=UDim.new(0,10)
    Mn.MouseButton1Click:Connect(function() MF.Visible,Tg.Visible=false,true end);Tg.MouseButton1Click:Connect(function() MF.Visible,Tg.Visible=true,false end)
    local TP=Instance.new("Frame",MF);TP.BackgroundColor3,TP.Position,TP.Size=Color3.fromRGB(15,15,18),UDim2.new(0,0,0,45),UDim2.new(0,110,1,-45)
    Instance.new("UICorner",TP).CornerRadius=UDim.new(0,16);local TL=Instance.new("UIListLayout",TP);TL.Padding,TL.HorizontalAlignment=UDim.new(0,6),Enum.HorizontalAlignment.Center
    local P1,P2,P3=Instance.new("ScrollingFrame",MF),Instance.new("Frame",MF),Instance.new("Frame",MF);local pgs={P1,P2,P3}
    for _,p in pairs(pgs) do p.BackgroundTransparency,p.Position,p.Size,p.Visible=1,UDim2.new(0,120,0,55),UDim2.new(1,-130,1,-65),false end;P1.Visible=true
    P1.CanvasSize,P1.ScrollBarThickness,P1.ScrollBarImageColor3=UDim2.new(0,0,0,400),2,Color3.fromRGB(140,60,200);Instance.new("UIListLayout",P1).Padding=UDim.new(0,6)
    local btns={}local function Tab(pg,b) for _,p in pairs(pgs) do p.Visible=false end for _,bt in pairs(btns) do bt.TextColor3,bt.BackgroundColor3=Color3.fromRGB(160,160,160),Color3.fromRGB(20,20,25) end pg.Visible=true b.TextColor3,b.BackgroundColor3=Color3.fromRGB(255,255,255),Color3.fromRGB(140,60,200) end
    local function CTab(t,pg) local b=Instance.new("TextButton",TP);b.Size,b.BackgroundColor3,b.Font,b.Text,b.TextColor3,b.TextSize=UDim2.new(0.9,0,0,36),Color3.fromRGB(20,20,25),Enum.Font.GothamSemibold,t,Color3.fromRGB(160,160,160),12 Instance.new("UICorner",b).CornerRadius=UDim.new(0,8) b.MouseButton1Click:Connect(function() Tab(pg,b) end) table.insert(btns,b) return b end
    local t1,t2,t3=CTab("🎮 Juegos",P1),CTab("⚙️ Config",P2),CTab("👑 Créditos",P3);t1.TextColor3,t1.BackgroundColor3=Color3.fromRGB(255,255,255),Color3.fromRGB(140,60,200)
    local l1=Instance.new("TextLabel",P1);l1.BackgroundTransparency,l1.Size,l1.Font,l1.Text,l1.TextColor3,l1.TextSize=1,UDim2.new(1,0,0,40),Enum.Font.Gotham,"Lista vacía...",Color3.fromRGB(130,130,140),11
    local l2=Instance.new("TextLabel",P2);l2.BackgroundTransparency,l2.Size,l2.Font,l2.Text,l2.TextColor3,l2.TextSize=1,UDim2.new(1,0,0,40),Enum.Font.Gotham,"Configuración...",Color3.fromRGB(130,130,140),11
    local cr=Instance.new("TextLabel",P3);cr.BackgroundTransparency,cr.Size,cr.Font,cr.Text,cr.TextColor3,cr.TextSize=1,UDim2.new(1,0,0,30),Enum.Font.GothamBold,"CREADO POR DASHED ✨",Color3.fromRGB(255,215,0),16
    local scr=Instance.new("TextLabel",P3);scr.BackgroundTransparency,scr.Position,scr.Size,scr.Font,scr.Text,scr.TextColor3,scr.TextWrapped,scr.TextSize=1,UDim2.new(0,0,0.2,0),UDim2.new(1,0,0,80),Enum.Font.Gotham,"Optimizado para Delta.",Color3.fromRGB(140,140,150),true,11
end

CB.MouseButton1Click:Connect(function() if TB.Text==K then KeyGui:Destroy() Main() else TB.Text="" TB.PlaceholderText="❌ KEY INCORRECTA" task.wait(1.5) TB.PlaceholderText="Pega la llave aquí..." end end)
