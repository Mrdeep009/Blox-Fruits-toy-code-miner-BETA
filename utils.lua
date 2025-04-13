-- Utility functions for Blox Fruits mining

local function generateRandomCode()
    local characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local code = ""
    for i = 1, 12 do
        local randomIndex = math.random(1, #characters)
        code = code .. characters:sub(randomIndex, randomIndex)
    end
    return code
end

return {
    generateRandomCode = generateRandomCode
}
