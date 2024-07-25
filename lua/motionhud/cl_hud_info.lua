do
	local isValid = IsValid
	local getCount = player.GetCount
	local getPhrase = language.GetPhrase
	local concat = table.concat
	local scrH = ScrH
	local floor = math.floor

	hook.Add('motionHudReady', 'motionHudInfo', function()
		do
			local disallow = {
				['CHudAmmo'] = true,
				['CHudBattery'] = true,
				['CHudHealth'] = true,
				['CHudSecondaryAmmo'] = true,
				['CHudWeaponSelection'] = true,
				['CHudChat'] = true
			}

			hook.Add('HUDShouldDraw', 'motionHudShouldDraw', function(element)
				if disallow[element] then
					return false
				end
			end)
		end

		hook.Add('PlayerStartVoice', 'motionHudPanelVoice', function(ply)
			local panel = motionHudPanel
			if panel.player and ply == panel.player then
				panel:RunJavascript('setVoice(true);')
			end
		end)

		hook.Add('PlayerEndVoice', 'motionHudPanelVoice', function(ply)
			local panel = motionHudPanel
			if panel.player and ply == panel.player then
				panel:RunJavascript('setVoice(false);')
			end
		end)

		timer.Create('motionHudInfo', 0.25, 0, function()
			local panel = motionHudPanel

			if not isValid(panel) then return end
			if panel:IsLoading() then return end

			local ply = panel.player

			local tab = {}
			local index = 1

			do
				local scrH = scrH()

				if panel.scrH ~= scrH then
					panel.scrH = scrH
					tab[index] = 'document.body.style.zoom = "' .. floor(scrH / 10.8) .. '%";'
					index = index + 1
				end
			end

			do
				local health, maxHealth = ply:Health(), ply:GetMaxHealth()

				if panel.health ~= health or panel.maxHealth ~= panel.maxHealth then
					panel.health = health
					panel.maxHealth = maxHealth

					tab[index] = 'setHealth(' .. health .. ',' .. maxHealth .. ')'
					index = index + 1
				end
			end

			do
				local armor, maxArmor = ply:Armor(), ply:GetMaxArmor()

				if panel.armor ~= armor or panel.maxArmor ~= maxArmor then
					panel.armor = armor
					panel.maxArmor = maxArmor

					tab[index] = 'setArmor(' .. armor .. ',' .. maxArmor .. ');'
					index = index + 1
				end
			end

			do
				local hunger = ply:getDarkRPVar('Energy')

				if panel.hunger ~= hunger then
					panel.hunger = hunger

					tab[index] = 'setHunger(' .. hunger .. ', 100);'
					index = index + 1
				end
			end

			do
				local money, salary = ply:getDarkRPVar('money'), (RPExtraTeams[ply:Team()]).salary or 0

				if panel.money ~= money or panel.salary ~= salary then
					panel.money = money
					panel.salary = salary

					tab[index] = 'setMoney(' .. money .. ',' .. salary .. ');'
					index = index + 1
				end
			end

			do
				local ammo, leftAmmo
				local weapon = ply:GetActiveWeapon()

				if weapon:IsValid() then
					ammo = weapon:Clip1()
					leftAmmo = ply:GetAmmoCount(weapon:GetPrimaryAmmoType())
					weapon = weapon.PrintName and getPhrase(weapon.PrintName) or getPhrase(weapon:GetClass())
				else
					weapon = ''
					ammo = -1
					leftAmmo = -1
				end

				if panel.weapon ~= weapon or panel.ammo ~= ammo or panel.leftAmmo ~= leftAmmo then
					panel.weapon = weapon
					panel.ammo = ammo
					panel.leftAmmo = leftAmmo

					tab[index] = 'setWeaponInfo("' .. weapon:JavascriptSafe() .. '", ' .. ammo .. ', ' .. leftAmmo .. ');'
					index = index + 1
				end
			end

			do
				local lockdown = GetGlobalBool('DarkRP_Lockdown', false)

				if panel.lockdown ~= lockdown then
					panel.lockdown = lockdown

					tab[index] = 'setLockDown(' .. tostring(lockdown) .. ', "Коммендантский час", "Причина: повышенная преступность")'
					index = index + 1
				end
			end

			if index == 1 then return end

			local text = concat(tab, '\n')
			panel:RunJavascript(text)
		end)
	end)
end