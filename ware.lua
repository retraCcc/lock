local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Blissful4992/Kinetic/main/src.lua"))()

local Overrides = {
    Background = Color3.fromRGB(30, 30, 30),
    Section_Background = Color3.fromRGB(25, 25, 25),

    Dark_Borders = Color3.fromRGB(25, 25, 25),
    Light_Borders = Color3.fromRGB(255, 255, 255),

    Text_Color = Color3.fromRGB(255, 255, 255),

    Accent = Color3.fromRGB(0, 255, 0),
    Dark_Accent = Color3.fromRGB(0, 100, 0),
}

local Window = Library.NewWindow({
    Text = "Fairy-Ware",

    WindowSize = Vector2.new(550, 450),     -- Initial Size of the Window
    WindowPosition = Vector2.new(400, 200), -- Initial Position of the Window

    ThemeOverrides = Overrides,
    Scalable = true, -- Default : True
    
    CloseCallback = function()
        print("You closed the script !")
    end
})


local Page = Window.NewPage({Text = "Rage"})

local Section = Page.NewSection({Text = "Rage"})

local target = true
local key = Enum.KeyCode.Q
local chat = false
local notifications = true
local partmode = true
local partz = "HumanoidRootPart"
local Plr;

getgenv().normpred = 0

getgenv().filltrans = 0 --Change fill transparency
getgenv().outlinetrans = 0 --Change outine transparency

local pred = true

local anchor = 0
local anchormax = 50

local espfolder = Instance.new("Folder", game.Workspace)

espfolder.Name = "Barshem"

local types = {
    Ball = Enum.PartType.Ball,
    Block = Enum.PartType.Block,
    Cylinder = Enum.PartType.Cylinder
}

local sets = {
    itchysets = {
        Enabled = true,
        AIRSHOT = false,
        AUTOPRED = false,
        RESOVLER = false
    }
}

local Tracer = Instance.new("Highlight", game.Workspace.Barshem)
Tracer.Name = "paigeisbest"
Tracer.Parent = game.Workspace.Barshem
Tracer.FillColor = Color3.new(87, 15, 83)
Tracer.OutlineColor = Color3.new(87, 15, 83)
Tracer.FillTransparency = filltrans
Tracer.OutlineTransparency = outlinetrans
Tracer.Adornee = Adornee
Tracer.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

local lp = game.Players.LocalPlayer
local mouse = lp:GetMouse()
local Runserv = game:GetService("RunService")

local circle = Drawing.new("Circle")
circle.Color = Color3.fromRGB(255, 255, 255)
circle.Thickness = 1
circle.NumSides = 732
circle.Radius = 120
circle.Transparency = 0
circle.Visible = true
circle.Filled = false
circle.Position = Vector2.new(mouse.X, mouse.Y + 35)

local guimain = Instance.new("Folder", game.CoreGui)
local CC = game:GetService "Workspace".CurrentCamera
local LocalMouse = game.Players.LocalPlayer:GetMouse()
local locked = false

function getClosestPlayerToCursor()
    local closestPlayer
    local shortestDistance = circle.Radius

    for i, v in pairs(game:GetService("Workspace").Players:GetDescendants()) do
        if
            v ~= game.Players.LocalPlayer and v and v:FindFirstChild("Humanoid") and
                v.Humanoid.Health ~= 0 and
                v:FindFirstChild("LowerTorso")
         then
            local pos = CC:WorldToViewportPoint(v.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(LocalMouse.X, LocalMouse.Y)).magnitude
            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end
    return closestPlayer
end

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(
    function(keygo, ok)
        if (not ok) then
            if (keygo.KeyCode == key) then
                if target == true then
                    locked = not locked

                    if locked then
                        Plr = getClosestPlayerToCursor()
                        for i = 1, 1 do
                        Window.NewNotification({
                        Title = "Locked",
                        Body = "Locked",
                        Time = math.random(1, 3)
                        })
                        task.wait(0.2)
                        end
                    elseif not locked then
                    for i = 1, 1 do
                    Window.NewNotification({
                    Title = "Unlocked",
                    Body = "Unlocked",
                    Time = math.random(1, 3)
                    })
                    task.wait(0.2)
                        end
                    end
                end
            end
        end
    end
)
--
local function rainbowa()
            Tracer.FillColor = Color3.fromHSV(tick()%5/5,0.5,1)
            Tracer.OutlineColor = Color3.fromHSV(tick()%5/5,0.5,1)
        end
--
if partmode then
    game:GetService "RunService".Stepped:connect(
        function()
            if locked and Plr and Plr:FindFirstChild("LowerTorso") then
                Tracer.Parent = Plr
                rainbowa()
            else
                Tracer.Parent = game.Workspace.Barshem
            end
        end
    )
end

    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(...)
        local args = {...}
        if locked and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" and sets.itchysets.Enabled and Plr ~= nil then

            if pred == true then
                
            args[3] = Plr[partz].Position+(Plr[partz].Velocity*normpred)

            else

            args[3] = Plr[partz].Position

            end

            return old(unpack(args))
        end
        return old(...)
    end)

    game:GetService("RunService").RenderStepped:Connect(function()
        if sets.itchysets.RESOVLER == true and Plr ~= nil and locked and sets.itchysets.Enabled then
        if sets.itchysets.AIRSHOT == true and locked and Plr ~= nil then
            
            if game.Workspace.Players[Plr.Name].Humanoid:GetState() == Enum.HumanoidStateType.Freefall then -- Plr:WaitForChild("Humanoid"):GetState() == Enum.HumanoidStateType.Freefall
                
                --// Airshot

                --// Anchor Check

                if Plr ~= nil and Plr.HumanoidRootPart.Anchored == true then
                    anchor = anchor + 1
                    if anchor >= anchormax then
                        pred = false
                        wait(2)
                        anchor = 0;
                    end
                else
                    pred = true
                    anchor = 0;
                end

                partz = "LeftFoot"

            else
                --// Anchor Check

                if Plr ~= nil and Plr.HumanoidRootPart.Anchored == true then
                    anchor = anchor + 1
                    if anchor >= anchormax then
                        pred = false
                        wait(2)
                        anchor = 0;
                    end
                else
                    pred = true
                    anchor = 0;
                end

                partz = "HumanoidRootPart"

            end
            else

                --// Anchor Check

                if Plr ~= nil and Plr.HumanoidRootPart.Anchored == true then
                    anchor = anchor + 1
                    if anchor >= anchormax then
                        pred = false
                        wait(2)
                        anchor = 0;
                    end
                else
                    pred = true
                    anchor = 0;
                end

                partz = "HumanoidRootPart"
            end

        else
                partz = "HumanoidRootPart"
        end
    end)
    
        if sets.itchysets.AUTOPRED == true then
        local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        local split = string.split(pingvalue,'(')
        local ping = tonumber(split[1])
        if ping < 130 then
            getgenv().Prediction = 0.151
        elseif ping < 125 then
            getgenv().Prediction = 0.149
        elseif ping < 110 then
            getgenv().Prediction = 0.146
        elseif ping < 105 then
            getgenv().Prediction = 0.138
        elseif ping < 90 then
            getgenv().Prediction = 0.136
        elseif ping < 80 then
            getgenv().Prediction = 0.134
        elseif ping < 70 then
            getgenv().Prediction = 0.131
        elseif ping < 60 then
            getgenv().Prediction = 0.1229
        elseif ping < 50 then
            getgenv().Prediction = 0.1225
        elseif ping < 40 then
            getgenv().Prediction = 0.1256
        end
end


local Slider = Section.NewSlider({
    Text = "Prediction - Slider",
    Callback = function(value)
    normpred = value
    end,
    Default = 0,
    Min = 0, Max = 1,
    Decimals = 2, -- Number of decimal numbers to show after the period/comma
    Description = "You can slide me with your mouse to change the value !"
})

local Keybind = Section.NewKeybind({
    Text = "Press Me", 
    Callback = function()
        print("You pressed the right key !")
    end, 
    KeyCallback = function(new)
        print("You changed the key to: " .. string.sub(tostring(new), 14, #tostring(new)))
    end, 
    Default = Enum.KeyCode.X,
    Description = "Press the key to activate this !",
})

for i = 1, 1 do
Window.NewNotification({
Title = "! Welcome !",
Body = "Welcome to Fairy-Ware",
Time = math.random(2, 10)
   
})
task.wait(0.2)
end

local Page2 = Window.NewPage({Text = "Settings"})

local Section2 = Page2.NewSection({Text = "Settings"})

local Overrides = {}

Section2.NewColorPicker({
    Text = "Background", 
    Callback = function(color)
        Overrides.Background = color
    end, 
    Default = Window.WinTheme.Background
})

Section2.NewColorPicker({
    Text = "Section Background", 
    Callback = function(color)
        Overrides.Section_Background = color
    end, 
    Default = Window.WinTheme.Section_Background
})

Section2.NewColorPicker({
    Text = "Accent", 
    Callback = function(color)
        Overrides.Accent = color
    end, 
    Default = Window.WinTheme.Accent
})

Section2.NewColorPicker({
    Text = "Dark Accent", 
    Callback = function(color)
        Overrides.Dark_Accent = color
    end, 
    Default = Window.WinTheme.Dark_Accent
})

Section2.NewColorPicker({
    Text = "Light Borders", 
    Callback = function(color)
        Overrides.Light_Borders = color
    end, 
    Default = Window.WinTheme.Light_Borders
})

Section2.NewColorPicker({
    Text = "Dark Borders", 
    Callback = function(color)
        Overrides.Dark_Borders = color
    end, 
    Default = Window.WinTheme.Dark_Borders
})

Section2.NewButton({
    Text = "Update Theme", 
    Callback = function()
        Window.OverrideTheme(Overrides)
    end
})

local ResetThemeButton = Window.NewUniversalButton({
    Text = "Reset Theme", 
    Callback = function()
        print("Resetted !")
        Window.ResetTheme()
    end, 
    Description = "This can be clicked multiple times !"
})
