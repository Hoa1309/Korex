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
local skyAsset = "rbxassetid://911025794"
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
main.Size = UDim2.new(0, 260, 0, 410)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
main.BackgroundTransparency = 0.1
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Transparency = 0.1

local gradient = Instance.new("UIGradient", stroke)
gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 90, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 210, 255))
})

local minIcon = Instance.new("ImageButton", sg)
minIcon.Size = UDim2.new(0, 46, 0, 46)
minIcon.Position = main.Position
minIcon.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
minIcon.BorderSizePixel = 0
minIcon.Visible = false
minIcon.Active = true
minIcon.Draggable = true
minIcon.Image = "https://cdn.phototourl.com/free/2026-09-20-5411e855-3e4e-45b3-ab74-2d65a5319269.jpg"
Instance.new("UICorner", minIcon).CornerRadius = UDim.new(0, 10)

local minStroke = Instance.new("UIStroke", minIcon)
minStroke.Thickness = 1.5
minStroke.Color = Color3.fromRGB(120, 90, 255)

local iconText = Instance.new("TextLabel", minIcon)
iconText.Size = UDim2.new(1, 0, 1, 0)
iconText.BackgroundTransparency = 1
iconText.Text = "Unknown"
iconText.TextColor3 = Color3.fromRGB(255, 255, 255)
iconText.TextSize = 9
iconText.TextWrapped = true
iconText.TextScaled = true
iconText.ZIndex = 2
applyCustomFont(iconText)

local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.Text = "Unknown ∞"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.TextSize = 19
applyCustomFont(title)

local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -66, 0, 8)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(200, 205, 220)
minBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 48)
minBtn.TextSize = 18
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 8)
applyCustomFont(minBtn)

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -34, 0, 8)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(235, 55, 75)
closeBtn.TextSize = 20
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
applyCustomFont(closeBtn)

local line = Instance.new("Frame", main)
line.Size = UDim2.new(1, -24, 0, 1)
line.Position = UDim2.new(0, 12, 0, 45)
line.BackgroundColor3 = Color3.fromRGB(40, 45, 65)
line.BorderSizePixel = 0

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -24, 1, -55)
content.Position = UDim2.new(0, 12, 0, 52)
content.BackgroundTransparency = 1

local listLayout = Instance.new("UIListLayout", content)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 8)

local function createButton(order, text)
	local container = Instance.new("Frame", content)
	container.Size = UDim2.new(1, 0, 0, 44)
	container.BackgroundColor3 = Color3.fromRGB(22, 25, 38)
	container.LayoutOrder = order

	Instance.new("UICorner", container).CornerRadius = UDim.new(0, 10)

	local btnStroke = Instance.new("UIStroke", container)
	btnStroke.Color = Color3.fromRGB(38, 44, 65)
	btnStroke.Thickness = 1.2

	local label = Instance.new("TextLabel", container)
	label.Size = UDim2.new(1, -55, 1, 0)
	label.Position = UDim2.new(0, 14, 0, 0)
	label.Text = text
	label.TextColor3 = Color3.fromRGB(170, 175, 200)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.BackgroundTransparency = 1
	label.TextSize = 15
	applyCustomFont(label)

	local toggleBg = Instance.new("Frame", container)
	toggleBg.Size = UDim2.new(0, 38, 0, 22)
	toggleBg.Position = UDim2.new(1, -48, 0.5, -11)
	toggleBg.BackgroundColor3 = Color3.fromRGB(35, 40, 58)
	Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1, 0)

	local toggleCircle = Instance.new("Frame", toggleBg)
	toggleCircle.Size = UDim2.new(0, 16, 0, 16)
	toggleCircle.Position = UDim2.new(0, 3, 0.5, -8)
	toggleCircle.BackgroundColor3 = Color3.fromRGB(140, 145, 170)
	Instance.new("UICorner", toggleCircle).CornerRadius = UDim.new(1, 0)

	local clickBtn = Instance.new("TextButton", container)
	clickBtn.Size = UDim2.new(1, 0, 1, 0)
	clickBtn.BackgroundTransparency = 1
	clickBtn.Text = ""

	clickBtn.MouseEnter:Connect(function()
		TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(28, 32, 50)}):Play()
	end)
	clickBtn.MouseLeave:Connect(function()
		TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 25, 38)}):Play()
	end)

	return clickBtn, label, toggleBg, toggleCircle, btnStroke
end

local hbBtn, hbLabel, hbBg, hbCircle, hbStroke = createButton(1, "Hitbox x7")
local espBtn, espLabel, espBg, espCircle, espStroke = createButton(2, "ESP Highlight")
local speedBtn, speedLabel, speedBg, speedCircle, speedStroke = createButton(3, "Speed x1.5")
local noclipBtn, noclipLabel, noclipBg, noclipCircle, noclipStroke = createButton(4, "Noclip")
local healthBtn, healthLabel, healthBg, healthCircle, healthStroke = createButton(5, "Inf Health UI")
local glitchBtn, glitchLabel, glitchBg, glitchCircle, glitchStroke = createButton(6, "Glitch Speed")

local hbOn, espOn, speedOn, noclipOn, infHealthOn, glitchOn = false, false, false, false, false, false
local defaultSize = Vector3.new(2, 2, 1)
local Highlights = {}
local healthConn, flickConn, speedConn, noclipConn = nil, nil, nil, nil

local power, moveBoost, idleBoost = 20, 6, 6
local toggleState = false

local function setToggleState(state, label, toggleBg, toggleCircle, stroke)
	local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	if state then
		TweenService:Create(label, tweenInfo, {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		TweenService:Create(toggleBg, tweenInfo, {BackgroundColor3 = Color3.fromRGB(120, 90, 255)}):Play()
		TweenService:Create(toggleCircle, tweenInfo, {Position = UDim2.new(1, -19, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		TweenService:Create(stroke, tweenInfo, {Color = Color3.fromRGB(120, 90, 255)}):Play()
	else
		TweenService:Create(label, tweenInfo, {TextColor3 = Color3.fromRGB(170, 175, 200)}):Play()
		TweenService:Create(toggleBg, tweenInfo, {BackgroundColor3 = Color3.fromRGB(35, 40, 58)}):Play()
		TweenService:Create(toggleCircle, tweenInfo, {Position = UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = Color3.fromRGB(140, 145, 170)}):Play()
		TweenService:Create(stroke, tweenInfo, {Color = Color3.fromRGB(38, 44, 65)}):Play()
	end
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

local function fixHealthUI()
	local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
	if not playerGui then return end
	local robloxGui = playerGui:FindFirstChild("RobloxGui") or playerGui
	for _, v in pairs(robloxGui:GetDescendants()) do
		if v:IsA("Frame") and (v.Name:lower():find("health") or v.Name:lower():find("bar")) then
			v.BackgroundColor3 = Color3.fromRGB(120, 90, 255)
		elseif v:IsA("TextLabel") and v.Name:lower():find("health") then
			v.Text = "inf/inf"
			v.TextColor3 = Color3.fromRGB(120, 90, 255)
		end
	end
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

healthBtn.MouseButton1Click:Connect(function()
	infHealthOn = not infHealthOn
	setToggleState(infHealthOn, healthLabel, healthBg, healthCircle, healthStroke)
	if infHealthOn then
		healthConn = RunService.RenderStepped:Connect(fixHealthUI)
	else
		if healthConn then healthConn:Disconnect(); healthConn = nil end
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
	hbOn, espOn, speedOn, noclipOn, infHealthOn, glitchOn = false, false, false, false, false, false
	if healthConn then healthConn:Disconnect() end
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
					local hum = v.Character:FindFirstChildOfClass("Humanoid")
					local hrp = v.Character:FindFirstChild("HumanoidRootPart")
					if hrp and hum then
						if hum.Health > 0 then
							hrp.Size = Vector3.new(25, 25, 20)
							hrp.Transparency = 0.8
							hrp.Color = Color3.fromRGB(120, 90, 255)
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
				Highlights[player].FillColor = Color3.fromRGB(120, 90, 255)
				Highlights[player].OutlineColor = Color3.fromRGB(255, 255, 255)
			end
		end
	end
end)
