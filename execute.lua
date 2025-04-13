-- Execute script for Blox Fruits mining automation

local scriptUrls = {
    "https://raw.githubusercontent.com/Mrdeep009/blackboxai-1744533077607/main/main.lua",
    "https://raw.githubusercontent.com/Mrdeep009/blackboxai-1744533077607/main/performance.lua",
    "https://raw.githubusercontent.com/Mrdeep009/blackboxai-1744533077607/main/ui.lua",
    "https://raw.githubusercontent.com/Mrdeep009/blackboxai-1744533077607/main/utils.lua"
}

for _, url in ipairs(scriptUrls) do
    local success, response = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    
    if not success then
        warn("Failed to execute script from: " .. url .. " - " .. response)
    end
end
