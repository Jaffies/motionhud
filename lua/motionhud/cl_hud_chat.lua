do
	oldChat = oldChat or chat
	oldChat.__index = oldChat
	
	local newChat = setmetatable({}, oldChat)

	local isValid = IsValid
	function newChat.Open()
		local panel = motionHudPanel

		if not isValid(panel) then return end 

		panel:RunJavascript('openChat()')
		panel:MakePopup()
	end

	function newChat.Close()
		local panel = motionHudPanel

		if not isValid(panel) then return end 

		panel:RunJavascript('closeChat()')
		panel:SetMouseInputEnabled(false)
		panel:SetKeyBoardInputEnabled(false)

		gui.EnableScreenClicker(false)
	end

	local colorPattern = '[%i, %i, %i, %f]'
	local function parse(value)
		local valueType = type(value)
		if valueType == 'Player' then
			local teamColor = team.GetColor(value:Team())
			return '["player", "' .. value:GetName():JavascriptSafe() .. '", undefined, ' .. colorPattern:format(teamColor.r, teamColor.g, teamColor.b, teamColor.a / 255) .. ']'
		elseif valueType == 'table' then
			return colorPattern:format(value.r, value.g, value.b, value.a / 255)
		else
			value = tostring(value)
			local match = value:match('^%[(.+)%]%s-$')
			if match then
				return '["tag", "' .. match:JavascriptSafe() .. '"]'
			else
				return '"' .. value:JavascriptSafe() .. '"'
			end
		end
	end

	local pattern = 'chatAddText(true, [%s])'
	local concat = table.concat
	function newChat.AddText(...)
		oldChat.AddText(...)

		local tab = {}
		for i = 1, select('#', ...) do
			local v = select(i, ...)

			tab[i] = parse(v)
		end

		do
			local panel = motionHudPanel

			if not isValid(panel) then return end
			panel:RunJavascript(pattern:format(concat(tab, ', ')))
		end
	end

	hook.Add('motionHudReady', 'motionHudChat', function()
		chat = newChat

		local panel = motionHudPanel
		if not isValid(panel) then return end

		panel:AddFunction('gmod', 'chatClose', chat.Close)
		panel:AddFunction('gmod', 'chatType', function(text)
			RunConsoleCommand('say', text)
		end)

		hook.Add('PlayerBindPress', 'motionHudChat', function(ply, bind)
			if bind == 'messagemode' then
				chat.Open()
				return true
			end
		end)
	end)
end