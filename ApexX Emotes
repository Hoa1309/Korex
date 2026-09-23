local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- [ EMOTE EXECUTION FUNCTION ]
local function DoEmote(emoteCmd, emoteName)
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            local channel = TextChatService:FindFirstChild("TextChannels") and TextChatService.TextChannels:FindFirstChild("RBXGeneral")
            if channel then channel:SendAsync(emoteCmd) end
        end
    end)
    pcall(function()
        local chatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if chatEvents and chatEvents:FindFirstChild("SayMessageRequest") then
            chatEvents.SayMessageRequest:FireServer(emoteCmd, "All")
        end
    end)
    pcall(function()
        local char = lp.Character
        if char and char:FindFirstChild("Animate") and char.Animate:FindFirstChild("PlayEmote") then
            char.Animate.PlayEmote:Invoke(emoteName)
        end
    end)
end

-- [ CLEANUP OLD UI ]
if CoreGui:FindFirstChild("ApexX_Dance_Mod") then 
    CoreGui.ApexX_Dance_Mod:Destroy() 
end

-- [ MAIN UI FRAME ]
local sg = Instance.new("ScreenGui", CoreGui)
sg.Name = "ApexX_Dance_Mod"
sg.ResetOnSpawn = false

local MainContainer = Instance.new("Frame", sg)
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 310, 0, 54)
MainContainer.Position = UDim2.new(0.5, -155, 0.8, 0)
MainContainer.BackgroundColor3 = Color3.fromRGB(15, 18, 28)
MainContainer.ClipsDescendants = true

local MainCorner = Instance.new("UICorner", MainContainer)
MainCorner.CornerRadius = UDim.new(0, 14)

local MainStroke = Instance.new("UIStroke", MainContainer)
MainStroke.Color = Color3.fromRGB(0, 220, 255)
MainStroke.Thickness = 1.5

local GlowGradient = Instance.new("UIGradient", MainStroke)
GlowGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 170)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 255))
}
GlowGradient.Rotation = 45

local UIListLayout = Instance.new("UIListLayout", MainContainer)
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout.Padding = UDim.new(0, 8)

-- [ HELPER FUNCTION TO CREATE BUTTONS ]
local function CreateEmoteButton(title, iconText, keybind, emoteCmd, emoteName)
    local Btn = Instance.new("TextButton", MainContainer)
    Btn.Name = title .. "Btn"
    Btn.Size = UDim2.new(0, 142, 0, 42)
    Btn.BackgroundColor3 = Color3.fromRGB(22, 28, 42)
    Btn.Text = ""
    Btn.AutoButtonColor = false

    local BtnCorner = Instance.new("UICorner", Btn)
    BtnCorner.CornerRadius = UDim.new(0, 10)

    local Icon = Instance.new("TextLabel", Btn)
    Icon.Size = UDim2.new(0, 26, 1, 0)
    Icon.Position = UDim2.new(0, 8, 0, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = iconText
    Icon.TextSize = 18

    local Label = Instance.new("TextLabel", Btn)
    Label.Size = UDim2.new(1, -58, 1, 0)
    Label.Position = UDim2.new(0, 34, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = title
    Label.TextColor3 = Color3.fromRGB(240, 245, 255)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local KeyHint = Instance.new("TextLabel", Btn)
    KeyHint.Size = UDim2.new(0, 22, 0, 18)
    KeyHint.Position = UDim2.new(1, -26, 0.5, -9)
    KeyHint.BackgroundColor3 = Color3.fromRGB(30, 38, 56)
    KeyHint.Text = keybind
    KeyHint.TextColor3 = Color3.fromRGB(0, 220, 255)
    KeyHint.Font = Enum.Font.GothamBold
    KeyHint.TextSize = 10

    local KeyCorner = Instance.new("UICorner", KeyHint)
    KeyCorner.CornerRadius = UDim.new(0, 4)

    -- Hover & Click effects
    local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, tweenInfo, {BackgroundColor3 = Color3.fromRGB(32, 40, 60)}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, tweenInfo, {BackgroundColor3 = Color3.fromRGB(22, 28, 42)}):Play()
    end)

    local function Trigger()
        TweenService:Create(Btn, TweenInfo.new(0.06), {Size = UDim2.new(0, 136, 0, 38)}):Play()
        DoEmote(emoteCmd, emoteName)
        task.wait(0.06)
        TweenService:Create(Btn, TweenInfo.new(0.06), {Size = UDim2.new(0, 142, 0, 42)}):Play()
    end

    Btn.MouseButton1Click:Connect(Trigger)

    return Trigger
end

-- [ BUILD BUTTONS ]
local TriggerDance = CreateEmoteButton("DANCE 2", "/e dance2", "dance2")
local TriggerLaugh = CreateEmoteButton("LAUGH", "/e laugh", "laugh")

-- [ DRAGGABLE SYSTEM FOR MAIN CONTAINER ]
local dragging, dragInput, dragStart, startPos
MainContainer.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainContainer.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainContainer.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        TweenService:Create(MainContainer, TweenInfo.new(0.08), {
            Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        }):Play()
    end
end)

-- [ HOTKEYS ]
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed then
        if input.KeyCode == Enum.KeyCode.P then
            TriggerDance()
        elseif input.KeyCode == Enum.KeyCode.L then
            TriggerLaugh()
        end
    end
end)
