-- Main script logic for Blox Fruits mining

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")

local RedeemRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Redeem")

_G.CodeMining = false
_G.MiningSpeed = 10000
_G.FPS_Limit = 25
_G.MiningCommandQueue = {}
_G.AdaptiveMode = true
_G.MiningStatus = {
    Active = false,
    GeneratedCodes = 0,
    ExecutedCodes = 0,
    FPS = 60,
    MiningSpeed = _G.MiningSpeed,
    AdjustmentStatus = "Stable",
    LearnedSpeed = _G.MiningSpeed
}

local function safeSetGlobal(variable, value)
    if _G[variable] ~= value then
        _G[variable] = value
        task.wait(0.4)
    end
end

Players.LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

local function generateCode()
    local characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local code = ""
    for i = 1, 12 do
        local randomIndex = math.random(1, #characters)
        code = code .. characters:sub(randomIndex, randomIndex)
    end
    safeSetGlobal("MiningStatus.GeneratedCodes", _G.MiningStatus.GeneratedCodes + 1)
    return code
end

local function warmUpMining(targetSpeed)
    safeSetGlobal("MiningStatus.AdjustmentStatus", "Warming Up...")
    safeSetGlobal("CodeMining", false)
    task.wait(1)

    local startSpeed = math.max(100, targetSpeed * 0.2)
    local increment = (targetSpeed - startSpeed) / 5
    local currentSpeed = startSpeed

    for i = 1, 5 do
        safeSetGlobal("MiningSpeed", math.floor(currentSpeed))
        safeSetGlobal("MiningStatus.MiningSpeed", _G.MiningSpeed)
        safeSetGlobal("MiningStatus.AdjustmentStatus", "Adjusting Speed...")
        task.wait(1)
        currentSpeed = currentSpeed + increment
    end

    safeSetGlobal("MiningSpeed", targetSpeed)
    safeSetGlobal("MiningStatus.MiningSpeed", _G.MiningSpeed)
    safeSetGlobal("MiningStatus.AdjustmentStatus", "Stable")
    safeSetGlobal("CodeMining", true)
end

local function adaptiveSpeedControl()
    while _G.CodeMining and _G.AdaptiveMode do
        local currentFPS = _G.MiningStatus.FPS

        if currentFPS < 20 then
            safeSetGlobal("MiningSpeed", math.max(_G.MiningSpeed * 0.6, 500))
            safeSetGlobal("MiningStatus.AdjustmentStatus", "Slowing Down (Low FPS)")
        elseif currentFPS < 25 then
            safeSetGlobal("MiningSpeed", math.max(_G.MiningSpeed * 0.85, 500))
            safeSetGlobal("MiningStatus.AdjustmentStatus", "Slight Speed Reduction (FPS)")
        elseif currentFPS >= 50 then
            safeSetGlobal("MiningSpeed", math.min(_G.MiningSpeed * 1.1, 95000))
            safeSetGlobal("MiningStatus.AdjustmentStatus", "Increasing Speed (Stable FPS)")
        end

        safeSetGlobal("MiningStatus.LearnedSpeed", _G.MiningSpeed)
        safeSetGlobal("MiningStatus.MiningSpeed", _G.MiningSpeed)

        task.wait(3)
    end
end

local function executeMining()
    while _G.CodeMining do
        if #_G.MiningCommandQueue > 0 then
            local newSpeed = table.remove(_G.MiningCommandQueue, 1)
            warmUpMining(newSpeed)
        end

        if _G.AdaptiveMode then
            task.spawn(adaptiveSpeedControl)
        end

        for _ = 1, _G.MiningSpeed do
            task.spawn(function()
                local code = generateCode()
                local success, response = pcall(function()
                    return RedeemRemote:InvokeServer(code)
                end)
                if success then
                    safeSetGlobal("MiningStatus.ExecutedCodes", _G.MiningStatus.ExecutedCodes + 1)
                end
            end)
        end

        task.wait(1)
    end
end

RunService.RenderStepped:Connect(function()
    safeSetGlobal("MiningStatus.FPS", math.floor(1 / RunService.RenderStepped:Wait()))
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.X then
        if not _G.CodeMining then
            print("🚀 Starting Mining...")
            warmUpMining(_G.MiningSpeed)
            executeMining()
        else
            print("⚠️ Mining Already Running!")
        end
    elseif input.KeyCode == Enum.KeyCode.Z then
        safeSetGlobal("CodeMining", false)
        safeSetGlobal("MiningStatus.AdjustmentStatus", "Stopped")
        print("🛑 Mining Stopped by User")
    end
end)
