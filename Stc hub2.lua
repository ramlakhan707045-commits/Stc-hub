
-- STC HUB | Brookhaven UI
-- Place in a Roblox Studio LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "STC_HUB"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local purple = Color3.fromRGB(125, 0, 255)
local dark = Color3.fromRGB(10, 8, 25)
local white = Color3.fromRGB(235, 225, 255)

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(700, 430)
main.Position = UDim2.new(0.5, -350, 0.5, -215)
main.BackgroundColor3 = dark
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = purple
stroke.Thickness = 2
stroke.Parent = main

local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, -90, 0, 55)
header.Position = UDim2.fromOffset(15, 5)
header.BackgroundTransparency = 1
header.Text = "♛ STC HUB"
header.TextColor3 = Color3.fromRGB(190, 90, 255)
header.TextSize = 32
header.Font = Enum.Font.GothamBlack
header.TextXAlignment = Enum.TextXAlignment.Left
header.Parent = main

local function makeButton(text, parent, size, position)
    local b = Instance.new("TextButton")
    b.Size = size
    b.Position = position
    b.BackgroundColor3 = Color3.fromRGB(30, 18, 60)
    b.TextColor3 = white
    b.Text = text
    b.TextSize = 15
    b.Font = Enum.Font.GothamMedium
    b.BorderSizePixel = 0
    b.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b

    local s = Instance.new("UIStroke")
    s.Color = purple
    s.Transparency = 0.35
    s.Parent = b

    return b
end

local close = makeButton(
    "X", main, UDim2.fromOffset(35, 32),
    UDim2.new(1, -45, 0, 10)
)

local minimize = makeButton(
    "−", main, UDim2.fromOffset(35, 32),
    UDim2.new(1, -85, 0, 10)
)

local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.fromOffset(12, 65)
sidebar.Size = UDim2.fromOffset(145, 350)
sidebar.BackgroundTransparency = 1
sidebar.Parent = main

local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(170, 65)
content.Size = UDim2.new(1, -182, 1, -78)
content.BackgroundColor3 = Color3.fromRGB(15, 12, 35)
content.BorderSizePixel = 0
content.Parent = main

local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(0, 10)
cc.Parent = content

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.fromOffset(10, 5)
title.BackgroundTransparency = 1
title.Text = "Welcome to STC HUB!"
title.TextColor3 = white
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = content

local info = Instance.new("TextLabel")
info.Position = UDim2.fromOffset(12, 50)
info.Size = UDim2.new(1, -24, 0, 45)
info.BackgroundTransparency = 1
info.Text = "Brookhaven | STC Premium UI"
info.TextColor3 = Color3.fromRGB(185, 165, 220)
info.TextSize = 14
info.Parent = content

local selectedPlayer

local dropdown = Instance.new("TextButton")
dropdown.Position = UDim2.fromOffset(12, 105)
dropdown.Size = UDim2.new(1, -24, 0, 36)
dropdown.BackgroundColor3 = Color3.fromRGB(28, 20, 55)
dropdown.TextColor3 = white
dropdown.Text = "Select Player ▼"
dropdown.Font = Enum.Font.Gotham
dropdown.TextSize = 14
dropdown.Parent = content

local list = Instance.new("ScrollingFrame")
list.Position = UDim2.fromOffset(12, 146)
list.Size = UDim2.new(1, -24, 0, 125)
list.BackgroundColor3 = Color3.fromRGB(20, 15, 40)
list.BorderSizePixel = 0
list.ScrollBarThickness = 4
list.CanvasSize = UDim2.new()
list.AutomaticCanvasSize = Enum.AutomaticSize.Y
list.Visible = false
list.Parent = content

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 4)
layout.Parent = list

local function refreshPlayers()
    for _, item in ipairs(list:GetChildren()) do
        if item:IsA("TextButton") then item:Destroy() end
    end

    for _, target in ipairs(Players:GetPlayers()) do
        if target ~= player then
            local b = makeButton(
                target.Name, list,
                UDim2.new(1, -8, 0, 30),
                UDim2.new()
            )
            b.MouseButton1Click:Connect(function()
                selectedPlayer = target
                dropdown.Text = target.Name .. " ▼"
                list.Visible = false
            end)
        end
    end
end

dropdown.MouseButton1Click:Connect(function()
    refreshPlayers()
    list.Visible = not list.Visible
end)

Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(refreshPlayers)

local function addTab(name, y)
    local b = makeButton(
        name, sidebar,
        UDim2.new(1, 0, 0, 36),
        UDim2.fromOffset(0, y)
    )

    b.MouseButton1Click:Connect(function()
        title.Text = name
        info.Text = "STC HUB  |  " .. name
        list.Visible = false
    end)
end

addTab("⌂  Home", 0)
addTab("♟  Player", 42)
addTab("☻  Troll", 84)
addTab("◆  Items", 126)
addTab("🚗  Vehicle", 168)
addTab("◎  World", 210)
addTab("◉  Visual", 252)
addTab("⚙  Settings", 294)

local minimized = false

minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    sidebar.Visible = not minimized
    content.Visible = not minimized
    main.Size = minimized
        and UDim2.fromOffset(230, 50)
        or UDim2.fromOffset(700, 430)
    header.Size = UDim2.new(1, -100, 0, 45)
end)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Drag the GUI by its header
local dragging, dragStart, startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
