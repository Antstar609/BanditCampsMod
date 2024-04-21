--- @class MBCUtils Utility functions
MBCUtils = {}

--- Logs a message to the console
--- @param _message string Message to log
function MBCUtils:Log(_message)
	System.LogAlways("$5[" .. MBCMain.name .. "] " .. tostring(_message))
end

--- Logs a message to the screen
--- @param _message string Message to show
--- @param _forceClear boolean Force clear the screen (default: false)
--- @param _time number Time in seconds to show the message (default: 3)
function MBCUtils:LogOnScreen(_message, _forceClear, _time)
	Game.SendInfoText(tostring(_message), _forceClear or false, nil, _time or 3)
end

--- Prints the player's location to the console and the screen
function MBCUtils:PrintLoc()
	local pos = player:GetWorldPos()
	self:Log(string.format("{ x = %.3f, y = %.3f, z = %.3f }", pos.x, pos.y, pos.z))
	self:LogOnScreen(Vec2Str(pos), true, 10)
end
System.AddCCommand(MBCMain.prefix .. 'Loc', 'MBCUtils:PrintLoc()', "Prints the player's location")

--- Teleports the player to the given position
--- @param _xyz string Position to teleport to (x y z) or camp name (test)
function MBCUtils:Teleport(_xyz)
	if (_xyz == "npc") then
		local pos = { x = MBCQuest.npcPosition.x, y = MBCQuest.npcPosition.y + 2, z = MBCQuest.npcPosition.z }
		player:SetWorldPos(pos)
		return
	end

	if (_xyz == "camp") then
		if (MBCQuest.spawnedCamp.name == "") then
			MBCUtils:LogOnScreen("No camp spawned")
			return
		else
			local pos = MBCCamps.locations[MBCQuest.spawnedCamp.name]
			player:SetWorldPos(pos)
			return
		end
	end

	local function SplitStringToCoordinates(_string)
		local coordinates = { "x", "y", "z" }
		local result = {}
		local i = 1
		for value in string.gmatch(_string, "%d+") do
			result[coordinates[i]] = tonumber(value)
			i = i + 1
		end
		return result
	end
	local pos = SplitStringToCoordinates(_xyz)
	self:LogOnScreen("Teleported to " .. pos.x .. ", " .. pos.y .. ", " .. pos.z, true, 5)
	player:SetWorldPos(pos)
end
System.AddCCommand(MBCMain.prefix .. 'Teleport', 'MBCUtils:Teleport(%line)', "Teleports the player to the given position")

--- Shows the intro banner from startup (temporary)
function MBCUtils:ShowTextbox()
	local message = "<font color='#ff8b00' size='28'>More Bandit Camps</font>" .. "\n"
			.. "<font color='#333333' size='20'>Antstar609</font>"

	Game.ShowTutorial(message, 3, false, true);
end
System.AddCCommand(MBCMain.prefix .. 'ShowText', 'MBCUtils:ShowText()', "Shows the intro banner from startup")