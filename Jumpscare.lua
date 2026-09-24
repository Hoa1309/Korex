if jumpscare_jeffwuz_loaded and not _G.jumpscarefucking123 == true then
	warn("Already Loading")
    return
end

pcall(function() getgenv().jumpscare_jeffwuz_loaded = true end)

local imageUrl = "https://cdn.phototourl.com/free/2026-09-19-2b0fcec7-4a91-4eac-86e0-a7bdaa6ba9e4.jpg"
writefile("jumpscare_img.jpg", game:HttpGet(imageUrl))

local ScreenGui = Instance.new("ScreenGui")
local ImageLabel = Instance.new("ImageLabel")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.IgnoreGuiInset = true
ScreenGui.Name = "JumpscareImageGui"

ImageLabel.Parent = ScreenGui
ImageLabel.Size = UDim2.new(1, 0, 1, 0)
ImageLabel.BackgroundTransparency = 1
ImageLabel.Image = getcustomasset("jumpscare_img.jpg")

local Sound = Instance.new("Sound")
Sound.Parent = game:GetService("SoundService")
Sound.SoundId = "rbxassetid://140658234151287"
Sound.Volume = 9999999999999999999999
Sound.Looped = true
Sound:Play()
