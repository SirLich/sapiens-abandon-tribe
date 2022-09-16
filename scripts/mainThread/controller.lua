--- AbandonTribe: controller.lua
--- @author SirLich

-- Abandon Tribe
local abandonTribe = mjrequire "abandonTribe"

local mod = {
	loadOrder = 1000, -- Load after hammerstone. Stupid number.
}

function mod:onload(controller)
	abandonTribe:init()
end

return mod