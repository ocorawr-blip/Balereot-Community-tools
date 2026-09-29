-- BALEREOT COMMUNITY • DELTA LOADSTRING
-- Upload this file to GitHub/Gist/Cloudflare Pages as balereot.lua
-- Then run:
-- loadstring(game:HttpGet("RAW_URL"))()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local Player = Players.LocalPlayer
if not Player then return end
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ============================================================
-- CONFIG
-- ============================================================
-- After uploading your Balereot image to Roblox, put its asset ID here.
local BACKGROUND_IMAGE = "rbxassetid://YOUR_IMAGE_ID"

local PURPLE = Color3.fromRGB(170,45,255)
local BRIGHT = Color3.fromRGB(235,120,255)
local DARK = Color3.fromRGB(20,4,30)

local old = PlayerGui:FindFirstChild("BalereotCommunity")
if old then old:Destroy() end

local function corner(p,r)
    local c=Instance.new("UICorner")
    c.CornerRadius=UDim.new(0,r or 10)
    c.Parent=p
    return c
end

local function stroke(p,color,thickness,transparency)
    local s=Instance.new("UIStroke")
    s.Color=color or PURPLE
    s.Thickness=thickness or 1
    s.Transparency=transparency or 0
    s.Parent=p
    return s
end

local Gui=Instance.new("ScreenGui")
Gui.Name="BalereotCommunity"
Gui.ResetOnSpawn=false
Gui.IgnoreGuiInset=true
Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
Gui.Parent=PlayerGui

local Main=Instance.new("Frame")
Main.Name="Main"
Main.AnchorPoint=Vector2.new(.5,.5)
Main.Position=UDim2.fromScale(.5,.5)
Main.Size=UDim2.fromOffset(330,315)
Main.BackgroundColor3=Color3.fromRGB(5,2,9)
Main.BorderSizePixel=0
Main.ClipsDescendants=true
Main.Parent=Gui
corner(Main,20)
stroke(Main,PURPLE,2,.1)

local BG=Instance.new("ImageLabel")
BG.Name="BalereotBackground"
BG.Size=UDim2.fromScale(1,1)
BG.BackgroundTransparency=1
BG.Image=BACKGROUND_IMAGE
BG.ImageTransparency=.18
BG.ScaleType=Enum.ScaleType.Crop
BG.ZIndex=1
BG.Parent=Main
corner(BG,20)

local Overlay=Instance.new("Frame")
Overlay.Size=UDim2.fromScale(1,1)
Overlay.BackgroundColor3=Color3.fromRGB(4,0,9)
Overlay.BackgroundTransparency=.48
Overlay.BorderSizePixel=0
Overlay.ZIndex=2
Overlay.Parent=Main
corner(Overlay,20)

local Atmos=Instance.new("Frame")
Atmos.Size=UDim2.fromScale(1,1)
Atmos.BackgroundColor3=PURPLE
Atmos.BackgroundTransparency=.9
Atmos.BorderSizePixel=0
Atmos.ZIndex=3
Atmos.Parent=Main
corner(Atmos,20)

-- Running lights around all four sides
local lights={}
local folder=Instance.new("Folder")
folder.Name="RunningLights"
folder.Parent=Main

for i=1,24 do
    local l=Instance.new("Frame")
    l.Size=UDim2.fromOffset(5,5)
    l.BackgroundColor3=BRIGHT
    l.BorderSizePixel=0
    l.ZIndex=20
    l.Parent=folder
    corner(l,3)
    stroke(l,PURPLE,2,0)
    lights[i]=l
end

task.spawn(function()
    local shift=0
    while Gui.Parent do
        shift=(shift+1)%#lights
        for i,l in ipairs(lights) do
            local p=((i+shift-1)%#lights)/(#lights)
            if p<.25 then
                local x=p/.25
                l.Position=UDim2.new(x,0,0,2)
            elseif p<.5 then
                local y=(p-.25)/.25
                l.Position=UDim2.new(1,-2,y,0)
            elseif p<.75 then
                local x=(p-.5)/.25
                l.Position=UDim2.new(1-x,0,1,-2)
            else
                local y=(p-.75)/.25
                l.Position=UDim2.new(0,2,1-y,0)
            end
        end
        task.wait(.055)
    end
end)

local Header=Instance.new("Frame")
Header.Size=UDim2.new(1,0,0,55)
Header.BackgroundTransparency=1
Header.Active=true
Header.ZIndex=30
Header.Parent=Main

local Title=Instance.new("TextLabel")
Title.BackgroundTransparency=1
Title.Position=UDim2.fromOffset(16,6)
Title.Size=UDim2.new(1,-125,0,24)
Title.Font=Enum.Font.GothamBlack
Title.Text="BALEREOT COMMUNITY"
Title.TextSize=15
Title.TextColor3=Color3.new(1,1,1)
Title.TextXAlignment=Enum.TextXAlignment.Left
Title.ZIndex=31
Title.Parent=Header

local tg=Instance.new("UIGradient")
tg.Color=ColorSequence.new({
    ColorSequenceKeypoint.new(0,PURPLE),
    ColorSequenceKeypoint.new(.5,Color3.new(1,1,1)),
    ColorSequenceKeypoint.new(1,BRIGHT)
})
tg.Parent=Title
task.spawn(function()
    while Gui.Parent do
        tg.Offset=Vector2.new(-1,0)
        TweenService:Create(tg,TweenInfo.new(1.8,Enum.EasingStyle.Linear),{Offset=Vector2.new(1,0)}):Play()
        task.wait(1.8)
    end
end)

local Sub=Instance.new("TextLabel")
Sub.BackgroundTransparency=1
Sub.Position=UDim2.fromOffset(17,30)
Sub.Size=UDim2.new(1,-100,0,14)
Sub.Font=Enum.Font.GothamMedium
Sub.Text="TERRAIN TOOLS  •  DELTA EDITION"
Sub.TextSize=8
Sub.TextColor3=Color3.fromRGB(190,165,215)
Sub.TextXAlignment=Enum.TextXAlignment.Left
Sub.ZIndex=31
Sub.Parent=Header

local Close=Instance.new("TextButton")
Close.AnchorPoint=Vector2.new(1,.5)
Close.Position=UDim2.new(1,-10,.5,0)
Close.Size=UDim2.fromOffset(25,25)
Close.BackgroundColor3=DARK
Close.BorderSizePixel=0
Close.Text="X"
Close.TextSize=11
Close.TextColor3=Color3.new(1,1,1)
Close.Font=Enum.Font.GothamBold
Close.AutoButtonColor=false
Close.ZIndex=40
Close.Parent=Header
corner(Close,8)
stroke(Close,PURPLE,1.5,.2)

local FPS=Instance.new("TextLabel")
FPS.BackgroundTransparency=1
FPS.AnchorPoint=Vector2.new(1,0)
FPS.Position=UDim2.new(1,-42,0,6)
FPS.Size=UDim2.fromOffset(55,12)
FPS.Font=Enum.Font.GothamBold
FPS.Text="FPS: --"
FPS.TextSize=8
FPS.TextColor3=Color3.fromRGB(120,255,180)
FPS.TextXAlignment=Enum.TextXAlignment.Right
FPS.ZIndex=35
FPS.Parent=Header

local Ping=FPS:Clone()
Ping.Name="Ping"
Ping.Position=UDim2.new(1,-42,0,20)
Ping.Text="PING: --"
Ping.Parent=Header

-- Drag
local dragging=false
local dragStart,startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        dragging=true
        dragStart=input.Position
        startPos=Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
        local d=input.Position-dragStart
        Main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        dragging=false
    end
end)

-- FPS / ping
local frames,last,fps=0,tick(),0
RunService.RenderStepped:Connect(function()
    frames+=1
    if tick()-last>=1 then fps=frames;frames=0;last=tick() end
end)
task.spawn(function()
    while Gui.Parent do
        FPS.Text="FPS: "..fps
        local p=0
        pcall(function()
            p=math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        Ping.Text="PING: "..p
        task.wait(.5)
    end
end)

-- Minimize / restore
local Open=Instance.new("TextButton")
Open.Name="BalereotOpen"
Open.Position=UDim2.fromOffset(30,155)
Open.Size=UDim2.fromOffset(36,36)
Open.BackgroundColor3=Color3.fromRGB(12,3,20)
Open.BorderSizePixel=0
Open.Text="✦"
Open.TextSize=20
Open.TextColor3=BRIGHT
Open.Font=Enum.Font.GothamBlack
Open.Visible=false
Open.ZIndex=100
Open.Parent=Gui
corner(Open,18)
stroke(Open,PURPLE,2,.1)

Close.MouseButton1Click:Connect(function()
    Main.Visible=false
    Open.Visible=true
end)
Open.MouseButton1Click:Connect(function()
    Main.Visible=true
    Open.Visible=false
end)

Gui:SetAttribute("BrushEnabled",false)
Gui:SetAttribute("SelectedShape","Box")
Gui:SetAttribute("SelectedMaterial","Grass")

print("[BALEREOT COMMUNITY] loaded")
