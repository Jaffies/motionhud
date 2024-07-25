local function load(path) -- cl
	if CLIENT then
		include(path)
	end

	AddCSLuaFile(path)
end

load('motionhud/cl_hud_panel.lua')
load('motionhud/cl_hud_info.lua')
load('motionhud/cl_hud_chat.lua')
load('motionhud/cl_hud_selector.lua')