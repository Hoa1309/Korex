getgenv().Resolution = { [".gg/scripters"] = 0.87 } 
local Camera = workspace.CurrentCamera 
if getgenv().gg_scripters == nil then 
	game:GetService("RunService").RenderStepped:Connect(function() 
		Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, getgenv().Resolution[".gg/scripters"], 0, 0, 0, 1) 
	end) 
end 
getgenv().gg_scripters = "Aori0001"

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local cam = workspace.CurrentCamera

if CoreGui:FindFirstChild("ModernUnknownUI") then
	CoreGui:FindFirstChild("ModernUnknownUI"):Destroy()
end

for _, v in pairs(Lighting:GetChildren()) do
	if v:IsA("Sky") then v:Destroy() end
end

local autoSky = Instance.new("Sky")
autoSky.Name = "CustomSky"
local skyAsset = "rbxassetid://136055162054954"
autoSky.SkyboxBk, autoSky.SkyboxDn, autoSky.SkyboxFt = skyAsset, skyAsset, skyAsset
autoSky.SkyboxLf, autoSky.SkyboxRt, autoSky.SkyboxUp = skyAsset, skyAsset, skyAsset
autoSky.Parent = Lighting

local function applyCustomFont(textLabel)
	pcall(function()
		textLabel.FontFace = Font.fromId(12187369046)
	end)
end

local sg = Instance.new("ScreenGui")
sg.Name = "ModernUnknownUI"
sg.ResetOnSpawn = false
sg.Parent = CoreGui:FindFirstChild("RobloxGui") or CoreGui

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 270, 0, 370)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
main.BackgroundTransparency = 0.05
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 1.5
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Transparency = 0.3

local gradient = Instance.new("UIGradient", stroke)
gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 80)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 40))
})

task.spawn(function()
	while sg and sg.Parent do
		gradient.Rotation = (gradient.Rotation + 1) % 360
		task.wait(0.03)
	end
end)

local minIcon = Instance.new("ImageButton", sg)
minIcon.Size = UDim2.new(0, 50, 0, 50)
minIcon.Position = main.Position
minIcon.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
minIcon.BorderSizePixel = 0
minIcon.Visible = false
minIcon.Active = true
minIcon.Draggable = true
minIcon.Image = "https://cdn.phototourl.com/member/2026-09-23-0b36f499-535a-4a27-8d29-0d42bf3b1dd9.jpg"
Instance.new("UICorner", minIcon).CornerRadius = UDim.new(0, 12)

local minStroke = Instance.new("UIStroke", minIcon)
minStroke.Thickness = 2
minStroke.Color = Color3.fromRGB(150, 150, 150)

local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 16, 0, 0)
title.Text = "PHANTOM CORE"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.TextSize = 17
applyCustomFont(title)

local titleGradient = Instance.new("UIGradient", title)
titleGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 120))
})

local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -66, 0, 10)
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
minBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
minBtn.TextSize = 16
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 8)
applyCustomFont(minBtn)

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -34, 0, 10)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
closeBtn.TextSize = 14
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
applyCustomFont(closeBtn)

local line = Instance.new("Frame", main)
line.Size = UDim2.new(1, -32, 0, 1)
line.Position = UDim2.new(0, 16, 0, 48)
line.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
line.BorderSizePixel = 0

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -24, 1, -58)
content.Position = UDim2.new(0, 12, 0, 54)
content.BackgroundTransparency = 1

local listLayout = Instance.new("UIListLayout", content)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 8)

local function createButton(order, text)
	local container = Instance.new("Frame", content)
	container.Size = UDim2.new(1, 0, 0, 44)
	container.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	container.LayoutOrder = order

	Instance.new("UICorner", container).CornerRadius = UDim.new(0, 10)

	local btnStroke = Instance.new("UIStroke", container)
	btnStroke.Color = Color3.fromRGB(35, 35, 35)
	btnStroke.Thickness = 1

	local label = Instance.new("TextLabel", container)
	label.Size = UDim2.new(1, -60, 1, 0)
	label.Position = UDim2.new(0, 14, 0, 0)
	label.Text = text
	label.TextColor3 = Color3.fromRGB(150, 150, 150)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.BackgroundTransparency = 1
	label.TextSize = 14
	applyCustomFont(label)

	local toggleBg = Instance.new("Frame", container)
	toggleBg.Size = UDim2.new(0, 40, 0, 22)
	toggleBg.Position = UDim2.new(1, -50, 0.5, -11)
	toggleBg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1, 0)

	local toggleCircle = Instance.new("Frame", toggleBg)
	toggleCircle.Size = UDim2.new(0, 16, 0, 16)
	toggleCircle.Position = UDim2.new(0, 3, 0.5, -8)
	toggleCircle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	Instance.new("UICorner", toggleCircle).CornerRadius = UDim.new(1, 0)

	local clickBtn = Instance.new("TextButton", container)
	clickBtn.Size = UDim2.new(1, 0, 1, 0)
	clickBtn.BackgroundTransparency = 1
	clickBtn.Text = ""

	clickBtn.MouseEnter:Connect(function()
		TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}):Play()
	end)
	clickBtn.MouseLeave:Connect(function()
		TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(15, 15, 15)}):Play()
	end)

	return clickBtn, label, toggleBg, toggleCircle, btnStroke
end

local hbBtn, hbLabel, hbBg, hbCircle, hbStroke = createButton(1, "Hitbox Size 35")
local espBtn, espLabel, espBg, espCircle, espStroke = createButton(2, "ESP Highlight")
local speedBtn, speedLabel, speedBg, speedCircle, speedStroke = createButton(3, "Speed x1.5")
local noclipBtn, noclipLabel, noclipBg, noclipCircle, noclipStroke = createButton(4, "Noclip")
local glitchBtn, glitchLabel, glitchBg, glitchCircle, glitchStroke = createButton(5, "Glitch Speed")

local hbOn, espOn, speedOn, noclipOn, glitchOn = false, false, false, false, false
local defaultSize = Vector3.new(2, 2, 1)
local Highlights = {}
local flickConn, speedConn, noclipConn = nil, nil, nil

local power, moveBoost, idleBoost = 20, 6, 6
local toggleState = false

local function setToggleState(state, label, toggleBg, toggleCircle, stroke)
	local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	if state then
		TweenService:Create(label, tweenInfo, {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		TweenService:Create(toggleBg, tweenInfo, {BackgroundColor3 = Color3.fromRGB(200, 200, 200)}):Play()
		TweenService:Create(toggleCircle, tweenInfo, {Position = UDim2.new(1, -19, 0.5, -8), BackgroundColor3 = Color3.fromRGB(10, 10, 10)}):Play()
		TweenService:Create(stroke, tweenInfo, {Color = Color3.fromRGB(200, 200, 200)}):Play()
	else
		TweenService:Create(label, tweenInfo, {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
		TweenService:Create(toggleBg, tweenInfo, {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
		TweenService:Create(toggleCircle, tweenInfo, {Position = UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
		TweenService:Create(stroke, tweenInfo, {Color = Color3.fromRGB(35, 35, 35)}):Play()
	end
end

local function isTeammate(player)
	if player == LocalPlayer then return true end
	if LocalPlayer.Team ~= nil and player.Team ~= nil then
		return LocalPlayer.Team == player.Team
	end
	return false
end

local function resetHitbox(char)
	if char then
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if hrp then hrp.Size = defaultSize; hrp.Transparency = 1 end
	end
end

local function clearESP()
	for _, hl in pairs(Highlights) do
		if hl and hl.Parent then hl:Destroy() end
	end
	Highlights = {}
end

hbBtn.MouseButton1Click:Connect(function()
	hbOn = not hbOn
	setToggleState(hbOn, hbLabel, hbBg, hbCircle, hbStroke)
	if not hbOn then
		for _, v in pairs(Players:GetPlayers()) do
			if v ~= LocalPlayer then resetHitbox(v.Character) end
		end
	end
end)

espBtn.MouseButton1Click:Connect(function()
	espOn = not espOn
	setToggleState(espOn, espLabel, espBg, espCircle, espStroke)
	if not espOn then clearESP() end
end)

speedBtn.MouseButton1Click:Connect(function()
	speedOn = not speedOn
	setToggleState(speedOn, speedLabel, speedBg, speedCircle, speedStroke)
	if speedOn then
		if speedConn then speedConn:Disconnect() end
		speedConn = RunService.RenderStepped:Connect(function()
			local char = LocalPlayer.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			if hum then hum.WalkSpeed = 16 * 1.5 end
		end)
	else
		if speedConn then speedConn:Disconnect(); speedConn = nil end
		local char = LocalPlayer.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = 16 end
	end
end)

noclipBtn.MouseButton1Click:Connect(function()
	noclipOn = not noclipOn
	setToggleState(noclipOn, noclipLabel, noclipBg, noclipCircle, noclipStroke)
	if noclipOn then
		if noclipConn then noclipConn:Disconnect() end
		noclipConn = RunService.Stepped:Connect(function()
			if noclipOn and LocalPlayer.Character then
				for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
					if part:IsA("BasePart") and part.CanCollide then
						part.CanCollide = false
					end
				end
			end
		end)
	else
		if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
	end
end)

glitchBtn.MouseButton1Click:Connect(function()
	glitchOn = not glitchOn
	setToggleState(glitchOn, glitchLabel, glitchBg, glitchCircle, glitchStroke)
	if glitchOn then
		if flickConn then flickConn:Disconnect() end
		flickConn = RunService.RenderStepped:Connect(function()
			local char = LocalPlayer.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			if hrp and hum then
				local state = hum:GetState()
				if state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall then
					local lookDir = cam.CFrame.LookVector
					local flatDir = Vector3.new(lookDir.X, 0, lookDir.Z).Unit
					local boostDir = (hum.MoveDirection.Magnitude > 0) and hum.MoveDirection or flatDir
					local boostAmount = (hum.MoveDirection.Magnitude > 0) and moveBoost or idleBoost

					toggleState = not toggleState
					local currentPower = toggleState and power or -power
					
					cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(currentPower), 0)
					hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity + (boostDir * boostAmount)
					cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(-currentPower), 0)
				end
			end
		end)
	else
		if flickConn then flickConn:Disconnect(); flickConn = nil end
	end
end)

minBtn.MouseButton1Click:Connect(function()
	minIcon.Position = main.Position
	main.Visible = false
	minIcon.Visible = true
end)

minIcon.MouseButton1Click:Connect(function()
	main.Position = minIcon.Position
	minIcon.Visible = false
	main.Visible = true
end)

closeBtn.MouseButton1Click:Connect(function()
	hbOn, espOn, speedOn, noclipOn, glitchOn = false, false, false, false, false
	if flickConn then flickConn:Disconnect() end
	if speedConn then speedConn:Disconnect() end
	if noclipConn then noclipConn:Disconnect() end
	
	local char = LocalPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = 16 end
	
	clearESP()
	for _, v in pairs(Players:GetPlayers()) do
		if v ~= LocalPlayer then resetHitbox(v.Character) end
	end
	sg:Destroy()
end)

task.spawn(function()
	while task.wait(0.1) do
		if hbOn then
			for _, v in pairs(Players:GetPlayers()) do
				if v ~= LocalPlayer and v.Character then
					if isTeammate(v) then
						resetHitbox(v.Character)
					else
						local hum = v.Character:FindFirstChildOfClass("Humanoid")
						local hrp = v.Character:FindFirstChild("HumanoidRootPart")
						if hrp and hum then
							if hum.Health > 0 then
								hrp.Size = Vector3.new(35, 35, 35)
								hrp.Transparency = 0.8
								hrp.Color = Color3.fromRGB(150, 150, 150)
								hrp.Material = Enum.Material.SmoothPlastic
								hrp.CanCollide = false
							else
								resetHitbox(v.Character)
							end
						end
					end
				end
			end
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if not espOn then return end
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			local char = player.Character
			if char:FindFirstChild("HumanoidRootPart") then
				if not Highlights[player] or Highlights[player].Parent ~= char then
					local hl = Instance.new("Highlight")
					hl.Name = "ESP_Highlight"
					hl.FillTransparency = 0.5
					hl.OutlineTransparency = 0
					hl.Parent = char
					Highlights[player] = hl
				end
				if isTeammate(player) then
					Highlights[player].FillColor = Color3.fromRGB(0, 255, 120)
				else
					Highlights[player].FillColor = Color3.fromRGB(150, 150, 150)
				end
				Highlights[player].OutlineColor = Color3.fromRGB(255, 255, 255)
			end
		end
	end
end)
