
if IsValid(motionHudPanel) then
	motionHudPanel:Remove()
end

local isAwesomium = BRANCH == 'dev' or BRANCH == 'unknown'

local html = [=[
<!DOCTYPE html>
<html lang='en'>
<head>
	<meta charset='UTF-8'>
	<meta name='viewport' content='width=device-width, initial-scale=1.0'>
	<title>HUD</title>
	<style>body {
	overflow: hidden;
	background-color: rgb(50, 00, 100);
	background: url("rockford.png");
	background-size: 100%;
}

body {
	overflow: hidden;
	background-color: transparent;
}

.stats {
	position: absolute;
	left: 32px;
	bottom: 26px;
	display: inline-block;
	max-width: calc(50% - 22px - 32px) !important;
	max-width: 45%;
}

.frame {
	background-color: rgba(79, 88, 95, 0.25);
	vertical-align: middle;
	padding: 4px 6px;
	border-radius: 6px;
	left: 0px;
	top: 0px;
	color: white;
	font-size: 16px;
	font-family: inter;
	font-weight: 500 !important;
	font-weight: bold
	text-align: center;
	line-height: 16px;	
}

.frame img {
	height: 16px;
	margin-right: 2px;
}

.statsframe {
	display: inline-block;
}

.line {
	position: relative;
	background-color: black;
	width: 43px;
	height: 4px;

	bottom: 0px;
	left: 50%;
	-webkit-transform: translateX(-50%);
	margin-top: 6px;

	background-color: rgba(255, 255, 255, 0.24);
	border-radius: 4px;
}

.linetop {
	border-radius: 4px;
	width: 45%;
	height: 100%;
	left: 0;
}

.moneyimg {
	height: 16px;
	display: inline-block;
	margin-left: 8px;
	vertical-align: middle;
}

.moneyclass {
	color: white;
	line-height: 100%;
	vertical-align: middle;
	margin: 2px;
	font-size: 24px;
	font-family: inter;
	display: inline-block;
	font-weight: 600 !important;
	font-weight: bold;
}

.salary {
	color: #E4D578;
	line-height: 100%;
	vertical-align: middle;
	font-size: 14px;
	font-family: inter;
	margin: 0;
	display: inline-block;
	font-weight: 600 !important;
	font-weight: bold;
}

#voice {
	position: absolute;
	bottom: 24px;
	width: 43px;
	height: 43px;
	border-radius: 4px;
	background-color: rgba(79, 88, 95, 0.25);
	left: 50%;
	-webkit-transform: translateX(-50%);
}

.weapons {
	display: none;
	position: absolute;
	color: white;
	right: 32px;
	bottom: 24px;
	font-family: inter;
}

#weaponname {
	font-family: inter;
	text-transform: uppercase;
}

#weapon {
	text-transform: uppercase;
	position: relative;
	width: 100%;
	height: fit-content;
	line-height: 19px;
	font-family: inter;
	font-size: 16px;
	text-align: right;
	font-family: inter;
	font-weight: bold;
	margin-bottom: 3px;
}

.ammo {
	width: 100%;
	height: fit-content;
	font-size: 30px;
	font-weight: 600 !important;
	font-weight: bold;
	font-family: inter;
	vertical-align: middle;
	line-height: 36px;
	vertical-align: middle;
}

.notifications {
	position: absolute;
	right: 0;
	bottom: 154px;
	padding-right: 32px;
	max-width: 320px;
	overflow: hidden;
	direction: rtl;
}

.notifyframe {
	position: relative;
	-webkit-transform: translateX(350px);
	-webkit-transition: all 0.4s ease-in-out;
	display: table;
	direction: initial;
	margin: 8px;
	background-color: rgba(65, 72, 82, 0.76);
	border-radius: 12px;
	border-width: 2px;
	border-style: solid;
	border-color: rgba(255, 255, 255, 0.16);
	padding: 12px 24px 12px 12px;
	color: white;
	font-family: inter;
	font-weight: 500;
	font-size: 16px;
}

.infoimg {
	display: inline-block;
	height: 16px;
	vertical-align: text-top;
	margin-right: 12px;
}

.bignotify {
	display: none;
	position: absolute;
	right: 34px;
	top: 156px;
	padding: 14px 24px 14px 12px;

	background-color: rgba(75, 82, 92, 0.88);
	border-radius: 12px;
	border-style: solid;
	border-color: rgba(255, 255, 255, 0.16);
	border-width: 2px;
	color: white;
	font-family: inter;
	width: fit-content;

	max-width: 220px;
}

.bignotifycontext {
	margin-bottom: 16px;
	font-size: 16px;
	font-weight: 600 !important;
	font-weight: bold;
}

.bignotifytext {
	display: block;
	font-size: 10px;
	font-weight: 300 !important;
	font-weight: lighter;
}

.bignotifyicon {
	height: 26px;
	margin-right: 8px;
	vertical-align: top;	
}

.weaponselector {
	opacity: 0;
	-webkit-transition: opacity 0.25s;
	vertical-align: top;
	width: fit-content !important;
	position: absolute;
	top: 0;
	left: 50%;
	-webkit-transform: translateX(-50%);
}

.weaponselectorcolumn {
	display: inline-block;
	font-family: inter;
	color: white;
	width: fit-content;
	vertical-align: top;
	max-width: 270px;
}

.weaponselectornumber {
	font-size: 32px;
	opacity: 0.5;
	font-style: bold;
	line-height: 32px;
}

.weaponselectorname {
	margin: 0px;
	text-transform: uppercase;
	font-size: 16px;
	line-height: 32px;
	opacity: 0.8;
	font-weight: bold;
	vertical-align: top;
}


.weaponselectorline {
	height: 32px;
	overflow: hidden;
	vertical-align: bottom;
}

.weaponselectorlineline {
	position: relative;
	top: 50%;
	-webkit-transform: translateY(-50%);
	height: 2px;
	background-color: white;
	opacity: 0.5;
}

.weaponselectorframe {
	background-color: rgba(65, 72, 82, 0.44);
	margin-top: 4px;
	padding: 8px 10px;
	margin-left: 20px;
	text-align: center;
	font-size: 16px;
	font-weight: 500;
	border-radius: 6px;
	border-style: solid;
	border-width: 1px;
	border-color: rgba(255, 255, 255, 0.16);
}

.weaponselectorframeactive {
	background: linear-gradient(180deg, rgba(225, 229, 241, 0.11), rgba(80, 82, 94, 0.11)) rgba(85, 92, 101, 0.44);
	margin-top: 4px;
	padding: 8px 10px;
	margin-left: 20px;
	text-align: center;
	font-size: 16px;
	font-weight: 500;
	border-radius: 6px;
	border-style: solid;
	border-width: 1px;
	border-color: rgba(255, 255, 255, 0.16);
}

.chatbox {
	display: table;
	position: absolute;
	left: 22px;
	top: 26px;
	width: fit-content;
	max-width: 320px;
	height: 25%;
	font-family: inter;
	color: white;
}

.richtextobertka {
	-webkit-transform: scaleX(-1);
	overflow-y: scroll;
}

.richtext {
	letter-spacing: 1.5px;
	font-family: inter;
	font-size: 12px;
	font-weight: 500;
	height: 200px;
	padding-left: 9px;
	-webkit-transform: scaleX(-1);
}

.richtextobertka::-webkit-scrollbar {
	width: 5px;
	height: 8px;
	background: url('asset://garrysmod/materials/motionhud/1pix.png') no-repeat;
	background-position-x: center;
	background-size: 1px 100%;
	background-repeat: no-repeat;
}

.richtextobertka::-webkit-scrollbar-thumb {
  background: #4F585F;
}

.richtextline {
	direction: initial;
	margin-bottom: 8px;
}

.player {
	font-weight: 800 !important;
	font-weight: bold;
	color: rgba(255, 255, 255, 0.75);
}

.normaltext {
	word-break: break-all;
	font-weight: 500;
}

.textinput {
	margin-left: 10px;
	background-color: rgba(65, 72, 82, 0.44);
	border-style: solid;
	border-color: rgba(255, 255, 255, 0.16);
	border-width: 1px;
	border-radius: 6px;
	display: block;
	padding: 9px;
	margin-bottom: 8px;
}

.runbutton {
	vertical-align: middle;
}

.actionframe {
	display: inline-block;
	padding: 4px 10px 6px 10px;
	background-color: #FECF41;
	border-radius: 6px !important;
	font-weight: 600 !important;
	font-weight: bold;
	font-size: 12px;
	color: #1E1E1E;
	text-transform: uppercase;
}

.richtextframe {
	display: inline-block;
	padding: 4px;
	background-color: #FECF41;
	border-radius: 6px !important;
	font-weight: 600 !important;
	font-weight: bold;
	font-size: 12px;
	color: #1E1E1E;
	margin-right: 8px;
	text-transform: uppercase;
}

#action {
	display: inline-block;
	float: left;
}

button.actionframe {
	padding: 6px 12px;
	border-color: rgba(255, 255, 255, 0.16);
	border-width: 1px;
	border-style: solid;
	text-transform: uppercase;

	margin-right: 4px;
}

#me, #do, #it, #ad {
	color: white;
	opacity: 0.5;
	background-color: #495BFC;
}

#ad {
	background-color: #FECF41;
	color: #1E1E1E;
}

.input {
	padding: 4px 10px 6px 10px;
	background: none;
	border: none;
	font-weight: 600 !important;
	font-weight: bold;
	font-size: 12px;
	color: white;
	float: left;
	outline: none;
}

</style>
	<script>
		function setHealth(health, maxHealth) {
			document.getElementById('health').innerText = health
			document.getElementById('healthBar').style['width'] = (100 * (health / maxHealth)) + '%'
		}

		function setArmor(armor, maxArmor) {
			document.getElementById('armor').innerText = armor
			document.getElementById('armorBar').style['width'] = (100 * (armor / maxArmor)) + '%'
		}

		function setHunger(hunger, maxHunger) {
			document.getElementById('hunger').innerText = hunger
			document.getElementById('hungerBar').style['width'] = (100 * (hunger / maxHunger)) + '%'
		}

		function setInfo(health, maxHealth, armor, maxArmor, hunger, maxHunger) {
			setHealth(health, maxHealth)
			setArmor(armor, maxArmor)
			setHunger(hunger, maxHunger)
		}

		function setMoney(money, salary) {
			document.getElementById('money').innerText = money.toLocaleString('en-Us', {
				'style': 'decimal'
			})

			document.getElementById('salary').innerText = '+' + salary
		}

		function setWeaponInfo(weapon, ammo, leftAmmo) {
			if (ammo < 0 || leftAmmo == 0 && ammo == 0) {
				document.getElementById('weapons').style['display'] = 'none'
			}
			else {
				document.getElementById('weapons').style['display'] = 'initial'
			}
			document.getElementById('weaponname').innerText = weapon

			if (ammo < 100){
				document.getElementById('left0').style['display'] = 'initial'
			}
			else{
				document.getElementById('left0').style['display'] = 'none'
			}

			document.getElementById('ammo').innerText = ammo
			document.getElementById('leftammo').innerText = leftAmmo
		}

		function setLockDown(enabled, title, desc) {
			if (enabled) {
				document.getElementById('lockdown').style['display'] = 'initial'
			}
			else {
				document.getElementById('lockdown').style['display'] = 'none'
			}

			document.getElementById('lockdowntitle').innerText = title
			document.getElementById('lockdowntext').innerText = desc
		}

		const defaultTime = 3000
		function addNotify(notifyIcon, time,  args) {
			if (!args) {
				args = time
				time = defaultTime
			}

			if (!time) {
				time = defaultTime
			}

			var notifyNode = document.createElement('div')
			notifyNode.className = 'notifyframe'

			var image = document.createElement('img')
			image.src = notifyIcon
			image.className = 'infoimg'

			notifyNode.appendChild(image)

			var color = 'inherit'
			for (i in args) {
				var v = args[i]

				var element = document.getElementById('notifications')
				if (Array.isArray(v)) {
					color = 'rgba(' + v[0] + ',' + v[1] + ',' + v[2] + ',' + v[3] + ')'
				}
				else {
					var node = document.createElement('span')
					node.innerText = v
					node.style['color'] = color
					notifyNode.appendChild(node)
				}
			}

			document.getElementById('notifications').insertAdjacentElement('afterbegin', notifyNode)
			notifyNode.focus()

			notifyNode.style['-webkit-transform'] = 'translateX(0)'

			setTimeout(function(){
				notifyNode.style['-webkit-transform'] = 'translateX(350px)'

				setTimeout(function() {
					document.getElementById('notifications').removeChild(notifyNode)
				}, 1000)
			}, time)
		}

		function setWeapons(selectedId, id, weapons) {
			var element = document.getElementById(id)

			while (element.firstChild) {
				element.removeChild(element.firstChild)
			}

			for (i in weapons) {
				var v = weapons[i]

				var newElement = document.createElement('div')
				if (selectedId == parseInt(i) + 1 ) {
					newElement.className = 'weaponselectorframeactive'
				}
				else {
					newElement.className = 'weaponselectorframe'
				}
				newElement.innerText = v

				element.appendChild(newElement)

			}
		}

		function setVoice(enable) {
			document.getElementById('voice').style['display'] = enable && 'initial' || 'none'
		}

		function selectWeapon(selectedId, selectCategory, construction, other, weapon, tool ) {			
			var element = document.getElementById('weaponselector')
			element.style['opacity'] = 1

			if (construction) {
				setWeapons(selectCategory == 'construction' && selectedId || null, 'construction', construction)
			}

			if (other) {
				setWeapons(selectCategory == 'other' && selectedId || null, 'other', other)
			}

			if (weapon) {
				setWeapons(selectCategory == 'weapon' && selectedId || null, 'weapon', weapon)
			}

			if (tool) {
				setWeapons(selectCategory == 'tool' && selectedId || null, 'tool', tool)
			}
		}

		function cancelSelect() {
			document.getElementById('weaponselector').style['opacity'] = 0
		}

		function chatAddText(newLine, tab) {
			var element
			var richtext = document.getElementById('richtext')

			if (newLine || richtext.children.length == 0 ) {
				element = document.createElement('div')
				element.className = 'richtextline'

				var array = richtext.children

				if (array.length > 600) {
					elemend.removeChild(richtext.firstChild)
				}

				richtext.appendChild(element)
			}
			else {
				element = richtext.lastChild
			}

			var color
			var isDark
			for (i in tab) {
				var v = tab[i]

				if (Array.isArray(v)) {
					var id = v[0]

					if (typeof(id) == 'number') {
						isDark = (v[0] + v[1] + v[2]) < 255

						color = 'rgba(' + v[0] + ',' + v[1] + ',' + v[2] + ',' + (v[3] || 1) + ')'

						continue
					}

					var newElement = document.createElement('span')
					newElement.className = id == 'tag' && 'richtextframe' || id == 'player' && 'player' || 'normaltext'
					newElement.innerText = v[1]

					if (id == 'tag') {
						if (v[2]) {
							var tagColor = v[2]
							newElement.style['background-color'] = 'rgba(' + tagColor[0] + ',' + tagColor[1] + ',' + tagColor[2] + ',' + (tagColor[3] || 1) + ')'
						}
						else if (color) {
							newElement.style['background-color'] = color

							if (isDark) {
								newElement.style['color'] = 'white'
							}
						}
					}

					if (v[3] ) {
						var textColor = v[3]
						newElement.style['color'] = 'rgba(' + textColor[0] + ',' + textColor[1] + ',' + textColor[2] + ',' + (textColor[3] || 1) + ')'
					}
					else if (color && id != 'tag') {
						newElement.style['color'] = color
					}

					element.appendChild(newElement)
				}
				else {
					var newElement = document.createElement('span')
					
					newElement.className = 'normaltext'
					newElement.innerText = v

					if (color) {
						newElement.style['color'] = color
					}

					element.appendChild(newElement)
				}
			}

			var scroll = document.getElementById('richtextobertka')

			scroll.scrollTop = scroll.scrollHeight;
		}

		function setChat(text) {
			var input = document.getElementById('input')
			var action = document.getElementById('action')
			input.value = text

			var command = text.match('^/[^ ]+ ')
			if (command && action.style['display'] == 'none') {
				action.innerText = command[0].substring(1)
				action.style['display'] = 'initial'

				input.value = text.substring(command[0].length)
			}
		}

		function openChat() {
			document.getElementById('inputs').style['display'] = 'initial'

			setTimeout(function() {
				document.getElementById('input').focus()
			}, 100)
		}

		function closeChat() {
			document.getElementById('input').blur()
			document.getElementById('inputs').style['display'] = 'none'
		}
	</script>
</head>
<body>
	<div class='stats'>
		<div class='statsframe'>
			<div class='frame'>
				<img src='asset://garrysmod/materials/motionhud/health.png'><span id='health'></span></div>

			<div class='line'>
				<div class='linetop' id='healthBar' style='background-color: #FF7575;'></div>
			</div>
		</div>
		<div class='statsframe'>
			<div class='frame'>
				<img src='asset://garrysmod/materials/motionhud/armor.png'><span id='armor'></span></div>

			<div class='line'>
				<div class='linetop' id = 'armorBar' style='background-color: #32A4F6;'></div>
			</div>
		</div>
		<div class='statsframe'>
			<div class='frame'>
				<img src='asset://garrysmod/materials/motionhud/hunger.png'><span id='hunger'></span></div>

			<div class='line'>
				<div class='linetop' id='hungerBar' style='background-color: #F69032;'></div>
			</div>
		</div>

		<div style='display: inline-block;'>
			<img class='moneyimg' src='asset://garrysmod/materials/motionhud/money.png'>
			<div class='moneyclass'><span id='money'></span><span style='opacity: 0.8'>€</span>
			</div>

			<div class='salary'><span id='salary'></span> <span style='opacity: 0.8;'>€</span>
			</div>
		</div>

	</div>

	<div id='voice' style='display: none;'>
		<img style='width: 100%; height: 100%;' src='asset://garrysmod/materials/motionhud/voice.png'>
	</div>

	<div class='weapons' id='weapons'>
		<div id='weaponname'></div>
		<div class='ammo'><span id='left0' style='opacity: 0.8;'>0</span><span id='ammo'></span><span style='font-size: 25px; vertical-align: middle'>|</span><span id ='leftammo' style='opacity: 0.8; font-size: 20px; vertical-align: middle;'></span>
		</div>
	</div>

	<div class='notifications' id='notifications'>
	</div>

	<div class='bignotify' id='lockdown'>
		<div class='bignotifycontext'>
			<img src='asset://garrysmod/materials/motionhud/bignotify.png', class='bignotifyicon'>
			<span id='lockdowntitle'></span>
		</div>
		<div class='bignotifytext' id='lockdowntext'></div>
	</div>

	<div class="weaponselector" id = 'weaponselector'>
		<div class="weaponselectorcolumn">
			<div>
				<div style="display: inline-block; float: left;">
					<span class='weaponselectornumber'>1</span><span class='weaponselectorname'>?Construction?</span>
				</div>
				<div class='weaponselectorline'>
					<div class='weaponselectorlineline'></div>
				</div>
			</div>
			<div id='construction'>
			</div>
		</div><div class="weaponselectorcolumn">
			<div>
				<div style="display: inline-block; float: left;">
					<span class='weaponselectornumber'>2</span><span class='weaponselectorname'>?Other?</span>
				</div>
				<div class='weaponselectorline'>
					<div class='weaponselectorlineline'></div>
				</div>
			</div><div id='other'>
			</div>
		</div><div class="weaponselectorcolumn">
			<div>
				<div style="display: inline-block; float: left;">
					<span class='weaponselectornumber'>3</span><span class='weaponselectorname'>?Weapons?</span>
				</div>
				<div class='weaponselectorline'>
					<div class='weaponselectorlineline'></div>
				</div>
			</div>
			<div id ='weapon'>
			</div>
		</div><div class="weaponselectorcolumn">
			<div>
				<div style="display: inline-block; float: left;">
					<span class='weaponselectornumber'>4</span><span class='weaponselectorname'>?Tool?</span>
				</div>
				<div class='weaponselectorline'>
					<div class='weaponselectorlineline'></div>
				</div>
			</div>
			<div id='tool'>
			</div>
		</div>

	</div>

	<div class='chatbox' id = 'chatbox'>
		<div class='richtextobertka' id='richtextobertka'>
			<div class='richtext' id='richtext'>
			</div>
		</div>
		<div id='inputs' style='display: none;'>
			<div class='textinput'>
				<div>
					<span id='action' class='actionframe' style='display: none;'></span>
					<div style="overflow: hidden;">
						<div style="float: right;">
							<img src="asset://garrysmod/materials/motionhud/textinput.png" style='width: 12px; height: 12px'>
						</div>
						<input class ="input" id='input' placeholder="?EnterText?">
					</div>
				</div>
				<script>
					var input = document.getElementById('input')
					input.addEventListener('keydown', function(f) {
						if (f.keyCode == 8 && input.value == '') {
							var action = document.getElementById('action')
							action.innerText = ''
							action.style['display'] = 'none'
						}

						if (f.keyCode == 13) {
							if (input.value == '') {
								gmod.chatClose()
								return
							}

							var action = document.getElementById('action')
							var text = input.value

							if (action.innerText.length > 0) {
								text = '/' + action.innerText.toLowerCase() + ' ' + text
							}

							input.value = ''
							action.innerText = ''
							action.style['display'] = 'none'

							gmod.chatType(text)
							gmod.chatClose()
						}

					})

					input.addEventListener('keyup', function(f) {
						setChat(input.value)
					})
				</script>
			</div>
			<div>
				<button class="actionframe" id='ooc' onclick="setChat('/ooc ')">OOC</button>
				<button class="actionframe" id='me' onclick="setChat('/me ')">ME</button>
				<button class="actionframe" id='do' onclick="setChat('/looc ')">LOOC</button>
				<button class="actionframe" id='ad' onclick="setChat('/advert ')">AD</button>
			</div>
		</div>
	</div>
</body>
</html>
]=]

if isAwesomium then
	print('WebHUD detected awesomium, deleting font-weights')
	html = html:gsub('\n[^\n]+!important;', '\n') -- убираем с авесомиума, он не поддерживает variable шрифты
end

local phrases = {
	EnterText = 'Отправить',
	Tool = 'Инструменты',
	Weapons = 'Оружия',
	Other = 'Другое',
	Construction = 'Строительство'
}

html = html:gsub('?(%a+)?', phrases)

-- Уродски? ДА
-- что делать? Ждать пока рубат даст возможность поставлять html, css, js в data_static

local function onDocumentReady(obj)
	hook.Run('motionHudReady', obj)
end

hook.Add('HUDPaint', 'motionHudPanel', function()
	hook.Remove('HUDPaint', 'motionHudPanel')

	local pnl do
		pnl = GetHUDPanel():Add('DHTML')
		pnl:Dock(FILL)

		pnl:SetHTML(html)
		pnl.player = LocalPlayer()
		pnl.OnDocumentReady = onDocumentReady
	end

	motionHudPanel = pnl
end)