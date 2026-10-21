-- STC HUB | Brookhaven GUI Starter
-- Place in a Roblox Studio LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "STCHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local main = make("Frame", {
    Size = UDim2.fromOffset(440, 320),
    Position = UDim2.new(0.5, -220, 0.5, -160),
    BackgroundColor3 = Color3.fromRGB(18, 12, 48),
    BorderSizePixel = 0,
}, gui)

make("UICorner", {CornerRadius = UDim.new(0, 12)}, main)

local stroke = make("UIStroke", {
    Thickness = 2,
    Color = Color3.fromRGB(120, 50, 255),
}, main)

task.spawn(function()
    local hue = 0
    while gui.Parent do
        hue = (hue + 0.005) % 1
        stroke.Color = Color3.fromHSV(hue, 1, 1)
        task.wait(0.03)
    end
end)

local title = make("TextLabel", {
    Size = UDim2.new(1, -100, 0, 42),
    BackgroundTransparency = 1,
    Text = "STC HUB | Creator: STC",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 18,
    Font = Enum.Font.GothamBold,
}, main)

local function button(text, x, y, w, parent)
    local b = make("TextButton", {
        Position = UDim2.fromOffset(x, y),
        Size = UDim2.fromOffset(w, 34),
        BackgroundColor3 = Color3.fromRGB(48, 20, 160),
        TextColor3 = Color3.new(1, 1, 1),
        Text = text,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
    }, parent)
    make("UICorner", {CornerRadius = UDim.new(0, 6)}, b)
    return b
end

local minimized = false

local mini = button("-", 350, 5, 35, main)
local close = button("X", 390, 5, 35, main)

local reopen = button("⚡ STC", 12, 12, 90, gui)
reopen.Visible = false

mini.MouseButton1Click:Connect(function()
    minimized = not minimized
    for _, obj in ipairs(main:GetChildren()) do
        if obj ~= title and obj ~= mini
            and obj ~= close and obj ~= stroke then
            obj.Visible = not minimized
        end
    end
    main.Size = minimized
        and UDim2.fromOffset(440, 48)
        or UDim2.fromOffset(440, 320)
    reopen.Visible = minimized
end)

close.MouseButton1Click:Connect(function()
    main.Visible = false
    reopen.Visible = true
end)

reopen.MouseButton1Click:Connect(function()
    main.Visible = true
    minimized = false
    main.Size = UDim2.fromOffset(440, 320)
    for _, obj in ipairs(main:GetChildren()) do
        obj.Visible = true
    end
    reopen.Visible = false
end)

local content = make("Frame", {
    Position = UDim2.fromOffset(120, 55),
    Size = UDim2.new(1, -135, 1, -68),
    BackgroundTransparency = 1,
}, main)

local info = make("TextLabel", {
    Size = UDim2.new(1, 0, 0, 45),
    BackgroundTransparency = 1,
    Text = "Welcome to STC HUB",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 15,
    TextWrapped = true,
}, content)

local playerBox = make("TextBox", {
    Position = UDim2.fromOffset(0, 48),
    Size = UDim2.new(1, 0, 0, 34),
    BackgroundColor3 = Color3.fromRGB(35, 24, 90),
    TextColor3 = Color3.new(1, 1, 1),
    PlaceholderText = "Player username",
    Text = "",
    TextSize = 13,
}, content)

local function show(text)
    info.Text = text
end

local tabs = {
    "Home", "Troll", "Items", "Others"
}

for i, name in ipairs(tabs) do
    local b = button(name, 10, 55 + (i-1)*42, 100, main)
    b.MouseButton1Click:Connect(function()
        show(name .. " | STC HUB")
        if name == "Home" then
            show("Creator: STC\nRGB Brookhaven GUI")
        elseif name == "Troll" then
            show("Selected player: " ..
                (playerBox.Text ~= "" and playerBox.Text or "None"))
        elseif name == "Items" then
            show("Items menu\nUse authorized game items")
        elseif name == "Others" then
            show("Avatar preview and character options")
        end
    end)
end

-- Drag window using the title bar
local dragging = false
local dragStart, startPos

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

title.InputChanged:Connect(function(input)
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

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
