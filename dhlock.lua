local target = true
local key = Enum.KeyCode.Q
local pred = 0.131
local chat = false
local notifications = true
local partmode = true
local airfunc = true
local partz = "UpperTorso"
local Plr


local types = {
    Ball = Enum.PartType.Ball,
    Block = Enum.PartType.Block,
    Cylinder = Enum.PartType.Cylinder
}

local Tracer = Instance.new("Part", game.Workspace)
Tracer.Name = "paigeisbest"
Tracer.Anchored = true
Tracer.CanCollide = false
Tracer.Transparency = 0.65
Tracer.Parent = game.Workspace
Tracer.Shape = types.Block
Tracer.Size = Vector3.new(8, 8, 8)
Tracer.Color = Color3.fromRGB(222, 222, 222)

local lp = game.Players.LocalPlayer
local mouse = lp:GetMouse()
local Runserv = game:GetService("RunService")

circle = Drawing.new("Circle")
circle.Color = Color3.fromRGB(255, 255, 255)
circle.Thickness = 0
circle.NumSides = 732
circle.Radius = 120
circle.Thickness = 0
circle.Transparency = 0
circle.Visible = true
circle.Filled = false

Runserv.RenderStepped:Connect(
    function()
        circle.Position = Vector2.new(mouse.X, mouse.Y + 35)
    end
)

local guimain = Instance.new("Folder", game.CoreGui)
local CC = game:GetService "Workspace".CurrentCamera
local LocalMouse = game.Players.LocalPlayer:GetMouse()
local locked = false

function getClosestPlayerToCursor()
    local closestPlayer
    local shortestDistance = circle.Radius

    for i, v in pairs(game.Players:GetPlayers()) do
        if
            v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and
                v.Character.Humanoid.Health ~= 0 and
                v.Character:FindFirstChild("LowerTorso")
         then
            local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
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
                            local A_1 = "Target: " .. tostring(Plr.Character.Humanoid.DisplayName)
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
                                    Text = "Target: " .. tostring(Plr.Character.Humanoid.DisplayName)
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
                                    Duration = 5
                                }
                            )
                        elseif target == false then
                            game.StarterGui:SetCore(
                                "SendNotification",
                                {
                                    Title = "Itchy-ware",
                                    Text = "Target isn't enabled",
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
local function rainbowa()
    local Brick = workspace.paigeisbest
            Brick.Color = Color3.fromHSV(tick()%5/5,0.5,1)
        end
--
if partmode then
    game:GetService "RunService".Stepped:connect(
        function()
            if locked and Plr.Character and Plr.Character:FindFirstChild("LowerTorso") then
                Tracer.CFrame =
                    CFrame.new(Plr.Character.LowerTorso.Position + (Plr.Character.LowerTorso.Velocity * pred))
                    rainbowa()
            else
                Tracer.CFrame = CFrame.new(0, 9999, 0)
            end
        end
    )
end

--
local rawmetatable = getrawmetatable(game)
local old = rawmetatable.__namecall
setreadonly(rawmetatable, false)
rawmetatable.__namecall =
    newcclosure(
    function(...)
        local args = {...}
        if locked and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
            args[3] = Plr.Character[partz].Position + (Plr.Character[partz].Velocity * pred)
            return old(unpack(args))
        end
        return old(...)
    end
)
if airfunc then
    if Plr.Character.Humanoid.Jump == true and Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
        partz = "RightFoot"
    else
        partz = "LowerTorso"
    end
end

