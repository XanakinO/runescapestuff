-- Arch-Glacor Auto Kill and Loot Script

local API = require("api")

-- Define Arch-Glacor NPC ID and loot parameters
local ARCH_GLACOR_ID = 28241  -- Replace with actual Arch-Glacor ID
local LOOT_DISTANCE = 10

-- Function to attack Arch-Glacor
function attackArchGlacor()
    API.FindNPCss(ARCH_GLACOR_ID, 20, 1, 100, API.PlayerCoord(), 20, 10, "Attack")
end

-- Function to check if Arch-Glacor is still alive
function isArchGlacorAlive()
    return API.FindNPCbyName("Arch-Glacor", 20) ~= nil
end

-- Function to loot ground items
function lootGround()
    local items = API.GetAllObjArrayInteract({}, LOOT_DISTANCE, 3)  -- Type 3 for ground items
    for _, item in ipairs(items) do
        API.OFF_ACT_Pickup_route(item)
    end
end

-- Function to perform weapon special attack
function performSpecialAttack()
    if API.GetAdrenalineFromInterface() >= 50 then
        API.DoSpecialAttack()
    end
end

-- Main loop
while API.Read_LoopyLoop() == 1 do
    performSpecialAttack()
    if not isArchGlacorAlive() then
        lootGround()
        attackArchGlacor()
    end
    API.Sleep_tick(2)
end
