local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("KorexHitboxUI") then
	CoreGui:FindFirstChild("KorexHitboxUI"):Destroy()
end

local sg = Instance.new("ScreenGui")
sg.Name = "KorexHitboxUI"
sg.ResetOnSpawn = false
sg.Parent = CoreGui:FindFirstChild("RobloxGui") or CoreGui

-- State
local HitboxEnabled = false
local SpeedEnabled = false
local HitboxSize = 30
local CustomColor = Color3.fromRGB(35, 35, 40)
local NormalSpeed = 16
local SelectedPlayer = nil

-- Main Frame
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 260, 0, 315)
main.Position = UDim2.new(0.05, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
main.BackgroundTransparency = 0.05
main.Active = true
main.Draggable = true
main.ClipsDescendants = false
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 1.8
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local gradient = Instance.new("UIGradient", stroke)
gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 90, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 60))
})

-- Icon Thu Nhỏ (Chữ H)
local minIcon = Instance.new("TextButton", sg)
minIcon.Size = UDim2.new(0, 48, 0, 48)
minIcon.Position = main.Position
minIcon.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
minIcon.Text = "H"
minIcon.TextColor3 = Color3.fromRGB(140, 110, 255)
minIcon.TextSize = 22
minIcon.Font = Enum.Font.FredokaOne
minIcon.Visible = false
minIcon.Active = true
minIcon.Draggable = true
Instance.new("UICorner", minIcon).CornerRadius = UDim.new(0, 12)

local minStroke = Instance.new("UIStroke", minIcon)
minStroke.Thickness = 1.5
minStroke.Color = Color3.fromRGB(120, 90, 255)

-- Header
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 42)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 16, 0, 0)
title.Text = "KOREX HUB"
title.TextColor3 = Color3.fromRGB(240, 240, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.TextSize = 16
title.Font = Enum.Font.FredokaOne

-- Nút Thu Nhỏ
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -38, 0, 7)
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
minBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
minBtn.TextSize = 18
minBtn.Font = Enum.Font.FredokaOne
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 8)

local line = Instance.new("Frame", main)
line.Size = UDim2.new(1, -32, 0, 1)
line.Position = UDim2.new(0, 16, 0, 42)
line.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
line.BorderSizePixel = 0

-- Hitbox Toggle
local toggleBtn = Instance.new("TextButton", main)
toggleBtn.Size = UDim2.new(1, -32, 0, 45)
toggleBtn.Position = UDim2.new(0, 16, 0, 52)
toggleBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
toggleBtn.Text = "HITBOX 30x30 : OFF"
toggleBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
toggleBtn.TextSize = 13
toggleBtn.Font = Enum.Font.FredokaOne
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 10)
local toggleStroke = Instance.new("UIStroke", toggleBtn)
toggleStroke.Thickness = 1.2
toggleStroke.Color = Color3.fromRGB(45, 45, 60)

-- Speed Toggle
local speedBtn = Instance.new("TextButton", main)
speedBtn.Size = UDim2.new(1, -32, 0, 45)
speedBtn.Position = UDim2.new(0, 16, 0, 105)
speedBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
speedBtn.Text = "SPEED x2 : OFF"
speedBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
speedBtn.TextSize = 13
speedBtn.Font = Enum.Font.FredokaOne
Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 10)
local speedStroke = Instance.new("UIStroke", speedBtn)
speedStroke.Thickness = 1.2
speedStroke.Color = Color3.fromRGB(45, 45, 60)

-- Select Player Dropdown Button
local selectBtn = Instance.new("TextButton", main)
selectBtn.Size = UDim2.new(1, -32, 0, 45)
selectBtn.Position = UDim2.new(0, 16, 0, 158)
selectBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
selectBtn.Text = "Chọn người chơi..."
selectBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
selectBtn.TextSize = 13
selectBtn.Font = Enum.Font.FredokaOne
Instance.new("UICorner", selectBtn).CornerRadius = UDim.new(0, 10)
local selectStroke = Instance.new("UIStroke", selectBtn)
selectStroke.Thickness = 1.2
selectStroke.Color = Color3.fromRGB(45, 45, 60)

-- List người chơi (ScrollFrame)
local playerList = Instance.new("ScrollingFrame", main)
playerList.Size = UDim2.new(1, -32, 0, 110)
playerList.Position = UDim2.new(0, 16, 0, 208)
playerList.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
playerList.Visible = false
playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
playerList.ScrollBarThickness = 4
playerList.ZIndex = 5
Instance.new("UICorner", playerList).CornerRadius = UDim.new(0, 8)

local listLayout = Instance.new("UIListLayout", playerList)
listLayout.Padding = UDim.new(0, 4)

-- Nút Teleport (Không bật/tắt)
local tpBtn = Instance.new("TextButton", main)
tpBtn.Size = UDim2.new(1, -32, 0, 45)
tpBtn.Position = UDim2.new(0, 16, 0, 250)
tpBtn.BackgroundColor3 = Color3.fromRGB(120, 90, 255)
tpBtn.Text = "TELEPORT"
tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBtn.TextSize = 14
tpBtn.Font = Enum.Font.FredokaOne
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 10)

-- Hàm Cập nhật danh sách Player
local function updatePlayerList()
	for _, child in pairs(playerList:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	
	local count = 0
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			count = count + 1
			local btn = Instance.new("TextButton", playerList)
			btn.Size = UDim2.new(1, -8, 0, 30)
			btn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
			btn.Text = p.DisplayName .. " (@" .. p.Name .. ")"
			btn.TextColor3 = Color3.fromRGB(220, 220, 240)
			btn.TextSize = 12
			btn.Font = Enum.Font.FredokaOne
			btn.ZIndex = 6
			Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
			
			btn.MouseButton1Click:Connect(function()
				SelectedPlayer = p
				selectBtn.Text = p.DisplayName
				playerList.Visible = false
				tpBtn.Position = UDim2.new(0, 16, 0, 211)
				main.Size = UDim2.new(0, 260, 0, 270)
			end)
		end
	end
	playerList.CanvasSize = UDim2.new(0, 0, 0, count * 34)
end

-- Toggle Dropdown List
selectBtn.MouseButton1Click:Connect(function()
	playerList.Visible = not playerList.Visible
	if playerList.Visible then
		updatePlayerList()
		tpBtn.Position = UDim2.new(0, 16, 0, 325)
		main.Size = UDim2.new(0, 260, 0, 380)
	else
		tpBtn.Position = UDim2.new(0, 16, 0, 211)
		main.Size = UDim2.new(0, 260, 0, 270)
	end
end)

-- Click Nút TP (Ấn là dịch chuyển ngay)
tpBtn.MouseButton1Click:Connect(function()
	if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			LocalPlayer.Character.HumanoidRootPart.CFrame = SelectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
		end
	end
end)

-- Initial UI Fix Size
tpBtn.Position = UDim2.new(0, 16, 0, 211)
main.Size = UDim2.new(0, 260, 0, 270)

-- Logic Toggle Hitbox & Speed
toggleBtn.MouseButton1Click:Connect(function()
	HitboxEnabled = not HitboxEnabled
	if HitboxEnabled then
		toggleBtn.Text = "HITBOX 30x30 : ON"
		toggleBtn.TextColor3 = Color3.fromRGB(85, 255, 140)
		toggleStroke.Color = Color3.fromRGB(85, 255, 140)
	else
		toggleBtn.Text = "HITBOX 30x30 : OFF"
		toggleBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
		toggleStroke.Color = Color3.fromRGB(45, 45, 60)
	end
end)

speedBtn.MouseButton1Click:Connect(function()
	SpeedEnabled = not SpeedEnabled
	if SpeedEnabled then
		speedBtn.Text = "SPEED x2 : ON"
		speedBtn.TextColor3 = Color3.fromRGB(85, 255, 140)
		speedStroke.Color = Color3.fromRGB(85, 255, 140)
	else
		speedBtn.Text = "SPEED x2 : OFF"
		speedBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
		speedStroke.Color = Color3.fromRGB(45, 45, 60)
	end
end)

-- UI Min/Max
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

-- Main Loop
RunService.RenderStepped:Connect(function()
	if LocalPlayer.Character then
		local myHumanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if myHumanoid then
			myHumanoid.WalkSpeed = SpeedEnabled and (NormalSpeed * 2) or NormalSpeed
		end
	end

	for _, v in pairs(Players:GetPlayers()) do
		if v ~= LocalPlayer and v.Character then
			local hrp = v.Character:FindFirstChild("HumanoidRootPart")
			local humanoid = v.Character:FindFirstChildOfClass("Humanoid")
			if hrp then
				if HitboxEnabled and humanoid and humanoid.Health > 0 then
					hrp.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
					hrp.Color = CustomColor
					hrp.Transparency = 0.5
					hrp.Material = Enum.Material.SmoothPlastic
					hrp.CanCollide = false
				else
					hrp.Size = Vector3.new(2, 2, 1)
					hrp.Transparency = 1
				end
			end
		end
	end
end)
