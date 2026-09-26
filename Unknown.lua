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
local HitboxSize = 30
local CustomColor = Color3.fromRGB(35, 35, 40)

-- Main Frame
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 260, 0, 135)
main.Position = UDim2.new(0.05, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
main.BackgroundTransparency = 0.05
main.Active = true
main.Draggable = true
main.ClipsDescendants = true
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

-- Toggle Button
local toggleBtn = Instance.new("TextButton", main)
toggleBtn.Size = UDim2.new(1, -32, 0, 52)
toggleBtn.Position = UDim2.new(0, 16, 0, 58)
toggleBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
toggleBtn.Text = "HITBOX 30x30 : OFF"
toggleBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
toggleBtn.TextSize = 13
toggleBtn.Font = Enum.Font.FredokaOne
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 10)

local toggleStroke = Instance.new("UIStroke", toggleBtn)
toggleStroke.Thickness = 1.2
toggleStroke.Color = Color3.fromRGB(45, 45, 60)

local function addHoverEffect(btn)
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
	end)
end

addHoverEffect(toggleBtn)
addHoverEffect(minBtn)

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

-- Hitbox System (Xử lý khi chết thì reset)
RunService.RenderStepped:Connect(function()
	for _, v in pairs(Players:GetPlayers()) do
		if v ~= LocalPlayer and v.Character then
			local hrp = v.Character:FindFirstChild("HumanoidRootPart")
			local humanoid = v.Character:FindFirstChildOfClass("Humanoid")
			
			if hrp then
				-- Nếu sống & bật hack -> Tăng hitbox. Nếu chết/tắt hack -> Reset về 2,2,1
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
