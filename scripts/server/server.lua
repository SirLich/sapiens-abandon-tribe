--- AbandonTribe: server.lua
--- @author SirLich

local mod = {
	loadOrder = 1,

	-- Local state
	bridge = nil,
	serverWorld = nil,
	server = nil
}

local function tribeFailed(clientID)
	--- paramTable Required because net-functions can only pass one argument
	mod.serverWorld:tribeFailed(clientID)
end

local function registerNetFunctions()
	mod.server:registerNetFunction("tribeFailed", tribeFailed)
end

function mod:onload(server)
	mod.server = server
	
	-- Shadow setBridge
	local super_setBridge = server.setBridge
	server.setBridge = function(self, bridge)
		super_setBridge(self, bridge)
		mod.bridge = bridge
	end

	-- Shadow setServerWorld
	local super_setServerWorld = server.setServerWorld
	server.setServerWorld = function(self, serverWorld)
		super_setServerWorld(self, serverWorld)
		mod.serverWorld = serverWorld
		registerNetFunctions()
	end
end

return mod