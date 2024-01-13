ModMain = {
	name = "TestMod",
	version = "0.0.1",
	prefix = '',
}

-- Listener for the scene init event
function ModMain:sceneInitListener(actionName, eventName, eventArgs)
	if eventArgs then
		--ModUtils:Log("eventArgs: " .. eventName)
	end

	if actionName == "sys_loadingimagescreen" and eventName == "OnEnd" then
		-- When the scene is loaded
		System.LogAlways(self.name .. " loaded " .. "(v" .. self.version .. ")")
		--local testEntity = System.SpawnEntity({ class = "TestEntity", name = "TestEntity", position = { x = 0, y = 0, z = 0 } })
		ModCamps:SpawnCamp("CampSkalice", "skalice", 3)
	end
end

-- Register the listener
UIAction.RegisterActionListener(ModMain, "", "", "sceneInitListener")