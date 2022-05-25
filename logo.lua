--// Service Handler \\--
local GetService = setmetatable({}, {
    __index = function(self, key)
        return game:GetService(key)
    end
})
--// Services \\--
local RunService = GetService.RunService
local Players = GetService.Players
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = workspace.CurrentCamera
local UserInputService = GetService.UserInputService
local Unpack = table.unpack
local GuiInset = GetService.GuiService:GetGuiInset()
local Insert = table.insert
local Network = GetService.NetworkClient
local StarterGui = GetService.StarterGui
local tweenService = GetService.TweenService
local ReplicatedStorage = GetService.ReplicatedStorage
local http = GetService.HttpService
local lighting = GetService.Lighting
local check_exploit = (syn and "Synapse") or (KRNL_LOADED and "Krnl") or (isourclosure and "ScriptWare") or nil
local http_request = (check_exploit == "Synapse" and syn.request) or (check_exploit == "Krnl" and request) or (check_exploit == "ScriptWare" and request)
local char = (Players.LocalPlayer and (Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait())or nil)
local hrp = Players.LocalPlayer and (char:WaitForChild('HumanoidRootPart'))or nil 
local hum = Players.LocalPlayer and (char:WaitForChild('Humanoid')) or nil 
if Players.LocalPlayer then 
	Players.LocalPlayer.CharacterAdded:Connect(function(c)
		char = c 
		hrp = c:WaitForChild'HumanoidRootPart' 
		hum = c:WaitForChild('Humanoid')
	end)
end 
local function create(class,parent,props,children)
	if not class then 
		return 
	end 
	props = props or{}
	children = children or{}
	local obj = Instance.new(class,parent)
	for prop,name in pairs(props) do 
		obj[prop] = name 
	end 
	for _,child in pairs(children) do 
		child.Parent = obj 
	end 
	return obj 
end 
local function tween(obj,props,duration)
	duration = duration or 1
	local tweenInfo = TweenInfo.new(duration)
	local t = tweenService:Create(obj,tweenInfo,props)
	t:Play()
	wait(duration)
	return true
end
local function fadeDrawing(obj,duration,direction,maxTransparency)
	maxTransparency = maxTransparency or 1
	spawn(function()
		local fr = create('Frame',nil,{Transparency=(direction=='in'and 0 or maxTransparency)})
		local tweenObj
		spawn(function()
			tweenObj = tween(fr,{Transparency=(direction=='in'and maxTransparency or 0)},duration)
		end)
		while not tweenObj do
			if obj then
				obj.Transparency = fr.Transparency
			end
			RunService.Stepped:wait()
		end
	end)
end
local function draw(type,props)
	local d = Drawing.new(type)
	for i,v in pairs(props) do
		local s,e = pcall(function()
			d[i] = v
		end)
		if not s then warn('Error when setting property "' .. i .. '": ' .. e) end
	end
	return d
end

local bg = Drawing.new('Square')
bg.Visible = true
bg.Filled = true
bg.Size = CurrentCamera.viewportSize + Vector2.new(5,0)
bg.Transparency = 0
bg.Color = Color3.fromRGB(3,3,3)
local images = {
	ezstatsLogo1 = 'https://i.vgy.me/sFSeR0.png',--[[ 
	ezstatsText1 = 'https://i.vgy.me/jaEKLk.png',
	ezstatsText2 = 'https://i.vgy.me/CzRGU0.png' ]]
}
local logo = draw('Image',{
	Transparency = 0,
	Size = Vector2.new(750,750),
	Position = Vector2.new((CurrentCamera.viewportSize.X/2)-(750/2),(CurrentCamera.viewportSize.Y/2)-(750/2)),
	Data = http_request({Url=images.ezstatsLogo1,Method="GET"}).Body
})
local Text = draw('Text',{
	Size = 50,
	Position = Vector2.new(CurrentCamera.viewportSize.X/2,CurrentCamera.viewportSize.Y/2),
	Center = true,
	Outline = true,
	OutlineColor = Color3.fromRGB(0,0,0),
	Color = Color3.fromRGB(255,255,255),
	Font = Drawing.Fonts['UI'],
	Text = text
})
Text.Position = Text.Position - Vector2.new(0,Text.TextBounds.Y/2)
local blur = create('BlurEffect',game.lighting)
logo.Visible = true
Text.Visible = true
Text.Transparency = 0
logo.Transparency = 0
spawn(function()tween(blur,{Size=50},.25*1.5)end) -- fade in blur
fadeDrawing(bg,1/1.5,'in',0.25) -- fade in background
wait(.1+1/1.5) -- wait for background to fade in
fadeDrawing(logo,1/1.5,'in') -- fade in logo
wait(0.55+1/1.5) -- wait for logo to fade in and then wait one second
spawn(function()tween(blur,{Size=0},1/1.5)end) -- fade out blur
fadeDrawing(logo,1/1.5,'out') -- fade out logo
wait(1/1.5) -- wait for logo to fade out
fadeDrawing(bg,1/1.5,'out',0.25) -- fade out background
wait(1+1/1.5) -- wait for background to fade out and then wait one second to make sure it's fully faded out
logo:Remove() -- remmove logo
bg:Remove() -- remove background
