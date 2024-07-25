do
	oldNotification = oldNotification or notification
	oldNotification.__index = oldNotification

	local notify = setmetatable({}, oldNotification)

	function notify.AddLegacy(text, type, len)
		if type == NOTIFY_ERROR or type == NOTIFY_UNDO then
			type = 'asset://garrysmod/materials/motionhud/delete.png'
		else
			type = 'asset://garrysmod/materials/motionhud/info.png'
		end

		local panel = motionHudPanel
		if not IsValid(panel) then return end

		panel:RunJavascript('addNotify("' .. type ..  '", ' .. (len and len * 1000 or 'undefined') .. ', ["' .. text:JavascriptSafe() .. '"]);')
	end

	hook.Add('kent.onHUDReady', 'kent.HUDNotify', function()
		notification = notify
	end)
end