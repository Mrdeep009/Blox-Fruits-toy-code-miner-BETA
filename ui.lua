-- GUI module for Blox Fruits mining with adaptive mode toggle

local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui", CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
local Title = Instance.new("TextLabel", MainFrame)
local MiningSpeedLabel = Instance.new("TextLabel", MainFrame)
local ExecutedCodesLabel = Instance.new("TextLabel", MainFrame)
local FPSLabel = Instance.new("TextLabel", MainFrame)
local PingLabel = Instance.new("TextLabel", MainFrame)
local StabilityLabel = Instance.new("TextLabel", MainFrame)
local FPSBar = Instance.new("Frame", MainFrame)
local PingBar = Instance.new("Frame", MainFrame)

-- Add Adaptive Mode Toggle
local AdaptiveModeToggle = Instance.new("TextButton", MainFrame)
AdaptiveModeToggle.Size = UDim2.new(0.8, 0, 0, 40)
AdaptiveModeToggle.Position = UDim2.new(0.1, 0, 0.68, 0)
AdaptiveModeToggle.Text = "Toggle Adaptive Mode"
AdaptiveModeToggle.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
AdaptiveModeToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AdaptiveModeToggle.TextSize = 18

AdaptiveModeToggle.MouseButton1Click:Connect(function()
    _G.AdaptiveMode = not _G.AdaptiveMode
    if _G.AdaptiveMode then
        AdaptiveModeToggle.Text = "Adaptive Mode: ON"
    else
        AdaptiveModeToggle.Text = "Adaptive Mode: OFF"
    end
end)

-- Existing UI update loop...
RunService.RenderStepped:Connect(function()
    -- Existing FPS and Ping update logic...
end)
