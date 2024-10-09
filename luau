-- Place in StarterGui.
-- Script to manage blur, brightness, and saturation effects when the GUI menu is opened or closed

-- Services
local GuiService = game:GetService('GuiService') -- Handles GUI interactions
local TweenService = game:GetService('TweenService') -- Handles animations (tweens)

-- Get the current camera
local camera = workspace.CurrentCamera or workspace:GetPropertyChangedSignal('CurrentCamera'):Wait()

-- Tween information: duration of 0.5 seconds
local tweenInfo = TweenInfo.new(0.5)

-- Create and configure the BlurEffect
local blur = Instance.new('BlurEffect') -- Create a new blur effect instance
blur.Size = 0 -- Start with no blur
blur.Parent = camera -- Attach the blur effect to the camera

-- Create and configure the ColorCorrectionEffect for brightness and saturation
local colorCorrection = Instance.new('ColorCorrectionEffect') -- Create a new color correction effect
colorCorrection.Brightness = 0 -- Start with normal brightness
colorCorrection.Saturation = 0 -- Start with normal saturation
colorCorrection.Parent = camera -- Attach the effect to the camera

-- Create tweens for the effects
local blurInTween = TweenService:Create(blur, tweenInfo, {Size = 12}) -- Tween to increase blur
local blurOutTween = TweenService:Create(blur, tweenInfo, {Size = 0}) -- Tween to decrease blur

local brightnessInTween = TweenService:Create(colorCorrection, tweenInfo, {Brightness = 0.1}) -- Tween to increase brightness
local brightnessOutTween = TweenService:Create(colorCorrection, tweenInfo, {Brightness = 0}) -- Tween to reset brightness

local saturationInTween = TweenService:Create(colorCorrection, tweenInfo, {Saturation = 0.1}) -- Tween to increase saturation
local saturationOutTween = TweenService:Create(colorCorrection, tweenInfo, {Saturation = 0}) -- Tween to reset saturation

-- Function to handle the opening of the menu
local function onMenuOpened()
    -- Cancel any existing tweens that may interfere
    blurOutTween:Cancel()
    brightnessOutTween:Cancel()
    saturationOutTween:Cancel()

    -- Play tweens to apply the effects
    blurInTween:Play()
    brightnessInTween:Play()
    saturationInTween:Play()
end

-- Function to handle the closing of the menu
local function onMenuClosed()
    -- Cancel any existing tweens that may interfere
    blurInTween:Cancel()
    brightnessInTween:Cancel()
    saturationInTween:Cancel()

    -- Play tweens to remove the effects
    blurOutTween:Play()
    brightnessOutTween:Play()
    saturationOutTween:Play()
end

-- Connect the functions to the GuiService events
GuiService.MenuOpened:Connect(onMenuOpened) -- Trigger effects when the menu is opened
GuiService.MenuClosed:Connect(onMenuClosed) -- Trigger effects when the menu is closed

-- Optional: Error handling (for robustness)
local success, errorMessage = pcall(function()
    -- Check if the camera is available
    if not camera then
        error("Camera not found. Please ensure this script is running in an environment with a camera.")
    end
end)

if not success then
    warn("Error: " .. errorMessage) -- Output warning if an error occurs
end
