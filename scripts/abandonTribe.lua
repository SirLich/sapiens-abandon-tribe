--- AbandonTribe: abandonTribe.lua
--- @author SirLich

local abandonTribe = {
	-- A small safegaurd, to prevent idiots from killing their tribe
	abandonTribeInstantly = false,

	-- Execution must be repeated within 5 seconds, or it's discarded.
	retryDelay = 5
}

-- Hammerstone
local inputManager = mjrequire "hammerstone/input/inputManager"

-- Sapiens
local timer = mjrequire "common/timer"
local logicInterface = mjrequire "mainThread/logicInterface"

-- Key Mapping
local keyMapping = mjrequire "mainThread/keyMapping"
local keyCodes = keyMapping.keyCodes
local modifiers = keyMapping.modifiers

function abandonTribe:init()
	mj:log("Init Mod: Abandon Tribe.")

	inputManager:addGroup("AbandonTribe")
	inputManager:addMapping("AbandonTribe", "AbandonTribe", keyCodes.backspace, modifiers.shift)

	inputManager:addKeyChangedCallback("AbandonTribe", "AbandonTribe", function (isDown, isRepeat)
		mj:log("AbandonTribe called, instant kill is: ", abandonTribe.abandonTribeInstantly)

		if abandonTribe.abandonTribeInstantly then
			logicInterface:callServerFunction("tribeFailed")
		else
			abandonTribe.abandonTribeInstantly = true
			timer:addCallbackTimer(abandonTribe.retryDelay, function()
				abandonTribe.abandonTribeInstantly = false
			end)
		end
	 end)

end

return abandonTribe