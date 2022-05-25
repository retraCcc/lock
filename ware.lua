local target = true
local key = Enum.KeyCode.Q
local normpred = 0.1113129
local chat = false
local notifications = true
local partmode = true
local partz = "HumanoidRootPart"
local Plr;

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
        AIRSHOT = true,
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
                        if chat then
                            local A_1 = "Target: " .. tostring(Plr.Humanoid.DisplayName)
                            local A_2 = "All"
                            local Event =
                                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
                            Event:FireServer(A_1, A_2)
                        end
                        if notifications then
                            game.StarterGui:SetCore(
                                "SendNotification",
                                {
                                    Title = "Itchy-ware",
                                    Text = "Target: " .. tostring(Plr.Humanoid.Parent),
                                    Icon = "http://www.roblox.com/asset/?id=9111814881"
                                }
                            )
                        end
                    elseif not locked then
                        if chat then
                            local A_1 = "Unlocked!"
                            local A_2 = "All"
                            local Event =
                                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
                            Event:FireServer(A_1, A_2)
                        end
                        if notifications then
                            game.StarterGui:SetCore(
                                "SendNotification",
                                {
                                    Title = "Itchy-ware",
                                    Text = "Unlocked",
                                    Icon = "http://www.roblox.com/asset/?id=9111814881",
                                    Duration = 5
                                }
                            )
                        elseif target == false then
                            game.StarterGui:SetCore(
                                "SendNotification",
                                {
                                    Title = "Itchy-ware",
                                    Text = "Target isn't enabled",
                                    Icon = "http://www.roblox.com/asset/?id=9111814881",
                                    Duration = 5
                                }
                            )
                        end
                    end
                end
            end
        end
    end
)
--
game.Players.LocalPlayer.Chatted:Connect(
    function(Chat)
        if Chat == "/e +" then

            normpred = normpred+0.001
            
            wait(0.5)

            print("upped prediction to", normpred)

        end
    end
)
game.Players.LocalPlayer.Chatted:Connect(
    function(Chat)
        if Chat == "/e -" then

            normpred = normpred-0.001
            
            wait(0.5)
            
            print("upped prediction to", normpred)

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
