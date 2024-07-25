do
	local overrideCategory = {
		weapon_physgun = 'construction',
		weapon_physcannon = 'construction',
		gmod_tool = 'tool',
		weapon_fists = 'weapon'
	}

	local slotToCategory = {
		'construction', 'other', 'weapon', 'tool'
	}

	local categoryToSlot = {
		construction = 1,
		other = 2,
		weapon = 3,
		tool = 4
	}

	local activeWeapon
	local activeID
	local activeCategory

	local getWeapons do
		local function sortFunction(obj, obj2)
			return obj:GetSlot() + obj:GetSlotPos() * 10 < obj2:GetSlot() + obj:GetSlotPos() * 10
		end

		local sort = table.sort
		local ipairs, pairs = ipairs, pairs
		function getWeapons(ply)
			local tab = {{}, {}, {}, {}}
			local selectedCategory = ''
			local selectedID = -1
			local selectedWeapon

			local weapon = activeWeapon and activeWeapon or ply:GetActiveWeapon()

			local weaps = ply:GetWeapons()
			sort(weaps, sortFunction)

			for k, v in ipairs(weaps) do
				local categorySlot = categoryToSlot[v.weaponCategory or overrideCategory[v:GetClass()] or 'other']
				local category = tab[categorySlot]
				local newLen = #category + 1

				category[newLen] = v

				if v == weapon then
					selectedCategory = categorySlot
					selectedID = newLen
					selectedWeapon = v
				end
			end

			return tab, selectedCategory, selectedID, selectedWeapon
		end
	end

	local weaponsToJS do

		local getPhrase = language.GetPhrase
		local concat = table.concat
		function weaponsToJS(tab)
			local newTab = {}

			for k, v in ipairs(tab) do
				local name = v.PrintName and getPhrase(v.PrintName) or getPhrase(v:GetClass())
				newTab[k] = '"' .. name:JavascriptSafe() .. '"'
			end

			return concat(newTab, ', ')
		end
	end

	local function findNextWeapon(weapons, category, back)
		local start, endPos, step = category, category + 2, 1

		if back then
			start = category - 2
			endPos = category - 4
			step = - 1
		end

		for i = start, endPos, step do
			local newCategoryPos = (i % 4) + 1
			local newCategory = weapons[newCategoryPos]

			if newCategory[back and #newCategory or 1] then
				return newCategory[back and #newCategory or 1], newCategoryPos, back and #newCategory or 1
			end
		end
	end

	do
		local isValid = IsValid
		local tonumber = tonumber

		local exists = timer.Exists
		local remove = timer.Remove
		local create = timer.Create

		local function dissapear() -- тут только логика, на js свои таймеры и так.
			activeWeapon = nil
			activeCategory = nil
			activeID = nil

			do
				local panel = motionHudPanel

				if not IsValid(panel) then return end

				panel:RunJavascript('cancelSelect()')
			end
		end

		local pattern = 'selectWeapon(%i, %q, [%s], [%s], [%s], [%s]);'
		local function sendSelectorInfo(id, category, weapons)
			if isnumber(category) then
				category = slotToCategory[category]
			end

			local panel = motionHudPanel
			if not isValid(panel) then return end

			local code = pattern:format(id, category, weaponsToJS(weapons[1]), weaponsToJS(weapons[2]), weaponsToJS(weapons[3]), weaponsToJS(weapons[4]))
			panel:RunJavascript(code)
		end

		hook.Add('motionHudReady', 'motionHudSelector', function()
			hook.Add('PlayerBindPress', 'motionHudSelector', function(ply, bind)
				local slot = tonumber(bind:match('^slot([1234])$'))

				if slot then
					local weapons, selectedCategory, selectedID, selectedWeapon = getWeapons(ply)
					selectedID = selectedID or 1

					if activeCategory and activeCategory ~= selectedCategory or selectedCategory ~= slot then
						selectedCategory = slot
						selectedID = 1
						selectedWeapon = weapons[selectedCategory][selectedID]

						if not isValid(selectedWeapon) then return end
					elseif activeWeapon then
						if weapons[selectedCategory][activeID + 1] then
							selectedID = activeID + 1
							selectedWeapon = weapons[selectedCategory][selectedID]
						elseif weapons[selectedCategory][1] then
							selectedID = 1
							selectedWeapon = weapons[selectedCategory][1]
						end
					end

					activeWeapon = selectedWeapon
					activeID = selectedID
					activeCategory = selectedCategory

					if not isValid(activeWeapon) then return end

					if exists('motionHudPanelSelector') then
						remove('motionHudPanelSelector')
					end

					create('motionHudPanelSelector', 1, 1, dissapear)

					sendSelectorInfo(selectedID, selectedCategory, weapons)

					return
				end

				if bind == 'invprev' or bind == 'invnext' then
					local weapons, selectedCategory, selectedID, selectedWeapon = getWeapons(ply)

					if not activeWeapon then
						if not isValid(selectedWeapon) then 
							selectedCategory = 'construction'
							selectedID = bind == 'invprev' and 2 or 0
						end

						activeCategory = selectedCategory
						activeID = selectedID
						activeWeapon = selectedWeapon
					end

					activeID = activeID + (bind == 'invprev' and -1 or 1)
					activeWeapon = weapons[activeCategory][activeID]

					if not isValid(activeWeapon) then
						local newWeap, newCategory, newID = findNextWeapon(weapons, activeCategory, bind == 'invprev')

						if isValid(newWeap) then
							activeID = newID
							activeCategory = newCategory
							activeWeapon = newWeap
						else
							return
						end
					end

					if exists('motionHudPanelSelector') then
						remove('motionHudPanelSelector')
					end

					create('motionHudPanelSelector', 1, 1, dissapear)

					sendSelectorInfo(activeID, activeCategory, weapons)

					return
				end

				if bind == '+attack' or bind == 'cancelselect' then
					remove('motionHudPanelSelector')

					if bind == '+attack' and activeWeapon then
						input.SelectWeapon(activeWeapon)
					end
					
					dissapear()

					return true
				end
			end)
		end)
	end
end