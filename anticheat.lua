--[[

	LL			IIIIIIII	NNN    NN	TTTTTTTTTTT
	LL			   II		NN N   NN		TT
	LL			   II		NN  N  NN		TT
	LL			   II		NN   N NN		TT
	LLLLLLLL	IIIIIIII	NN    NNN		TT
	
	 ..
	....
	 ..
	 
	 AAAAAAAA	CCCCCCCC
	 AA	   AA	CC
	 AAAAAAAA	CC
	 AA	   AA	CC
	 AA	   AA   CCCCCCCC
	 
	 Advanced Anti-Cheat
	 Want to send hackers to the shadow realm for free? Use lint today!
	 RBLX: @HiRobloxDown | DISCORD: Moonzy#0001
	 
	 1.0.1

]]




--// Configurations are inside the module script.

local configuration = require(script.config)
local playerService = game:GetService('Players')

playerService.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(chr)
		repeat task.wait() until chr.Humanoid
		task.wait(0.5)
		local root = chr.HumanoidRootPart
		local hum = chr.Humanoid
		local lastPosition = root.Position
		local lastGoodPosition = root.CFrame
		local lastTick = tick()
		local onGround = false
		
		local function setBack(antiInfFlag, number)
			if antiInfFlag == 0 then
				chr:PivotTo(lastGoodPosition)
			end
			antiInfFlag = 1
			task.wait(number);
			antiInfFlag = 0
			task.wait();
		end
		
		local function raycastOnFloor(root)
			if not root.Parent.Humanoid then else
				local x = RaycastParams.new()
				x.FilterType = Enum.RaycastFilterType.Exclude
				x.FilterDescendantsInstances = {root.Parent}

				local touchingPart = false
				local numRaycasts = 20
				local radius = 1.5
				local stepSize = math.pi * 2 / numRaycasts
				local origin = root.Position - Vector3.new(0, 0.1, 0)
				for i = 1, numRaycasts do
					local angle = i * stepSize
					local dir = Vector3.new(radius * math.cos(angle), 0, radius * math.sin(angle))
					local raycast = workspace:Raycast(origin + dir, Vector3.new(0, -3.5, 0), x)
					if raycast and raycast.Instance then
						touchingPart = true
						break
					end
				end

				return touchingPart
			end
		end
		
		local function onAir(root)
			if not root.Parent.Humanoid then else
				local humanoid = root.Parent.Humanoid
				local material = humanoid.FloorMaterial
				local state = humanoid:GetState()
				local timeOnAir = 0

				if material == Enum.Material.Air and state ~= Enum.HumanoidStateType.Seated or hum.Sit == false and material == Enum.Material.Air then
					timeOnAir = timeOnAir + 0.015
				else
					timeOnAir = 0
				end

				return timeOnAir
			end
		end
		
		task.spawn(function()
			while task.wait(math.random(5,8)) do
				lastPosition = root.Position
				lastGoodPosition = root.CFrame
				lastTick = tick()
			end
		end)
		
		task.spawn(function()
			while hum do
				if hum.FloorMaterial ~= Enum.Material.Air then
					onGround = true
				else
					onGround = false
				end
				task.wait(0.000000000000000000000000000000000000000000000000000000000000002184821)
			end
		end)
		
		--// Fly A
		task.spawn(function()
			if configuration.flyA then
				local antiInfFlag = 0
				local lastTouchedFloor = tick()
				while plr do
					task.wait()
					if raycastOnFloor(root) then
						lastTouchedFloor = tick()
					end

					local timeSinceFloor = tick() - lastTouchedFloor
					local verticalMovement = root.Velocity.Y
					local distance = math.sqrt((root.Position.X - lastPosition.X) ^ 2 + (root.Position.Z - lastPosition.Z) ^ 2)
					local material = hum.FloorMaterial

					if timeSinceFloor >= configuration.flyAMax then
						if verticalMovement <= 0 then
							if verticalMovement >= -40 and verticalMovement <= 0.1 then
								if configuration.anticheatSetBack then
									setBack(antiInfFlag, 0.55)
								end
								if configuration.anticheatDebug then
									warn('[LINT] '..plr.Name..' has failed Flight (TYPE A) | Movement: '..verticalMovement..' | Distance: '..distance..' | Time: ' .. lastTouchedFloor)
								end
							end
						end
					else
						lastPosition = root.Position
						lastTick = tick()
					end
					
					task.wait(0.0193726384)
				end
			end
		end)
		
		--// Fly B
		task.spawn(function()
			if configuration.flyB then
				local antiInfFlag = 0
				local lastTouchedFloor = tick()
				while plr do
					task.wait()
					if raycastOnFloor(root) then
						lastTouchedFloor = tick()
					end

					local timeSinceFloor = tick() - lastTouchedFloor
					local verticalMovement = root.Velocity.Y
					local distance = math.sqrt((root.Position.X - lastPosition.X) ^ 2 + (root.Position.Z - lastPosition.Z) ^ 2)
					local material = hum.FloorMaterial

					if timeSinceFloor >= configuration.flyBMax then
						if verticalMovement >= 0 then
							if verticalMovement >= 0.1 and verticalMovement <= 145 then
								if configuration.anticheatSetBack then
									setBack(antiInfFlag, 0.55)
								end
								if configuration.anticheatDebug then
									warn('[LINT] '..plr.Name..' has failed Flight (TYPE B) | Movement: '..verticalMovement..' | Distance: '..distance..' | Time: ' .. lastTouchedFloor)
								end
							end
						end
					else
						lastPosition = root.Position
						lastTick = tick()
					end

					task.wait(0.0193726383)
				end
			end
		end)
		
		--// Fly C
		task.spawn(function()
			if configuration.flyC then
			local timeOnAir = 0
			local antiInfFlag = 0
				while plr do
					task.wait(0.0174291482)

					local currentAirTime = onAir(root)
					timeOnAir = timeOnAir + currentAirTime
					local verticalMovement = root.Velocity.Y
					local distance = math.sqrt((root.Position.X - lastPosition.X) ^ 2 + (root.Position.Z - lastPosition.Z) ^ 2)

					if timeOnAir >= configuration.flyCMax then
						if verticalMovement <= 0 then
							if verticalMovement >= -40 and verticalMovement <= 0.1 then
								if configuration.anticheatSetBack then
									setBack(antiInfFlag, 0.55)
								end
								if configuration.anticheatDebug then
									warn('[LINT] '..plr.Name..' has failed Flight (TYPE C) | Movement: '..verticalMovement..' | Distance: '..distance..' | Time: ' .. timeOnAir)
								end
							end
						end
					else
						lastPosition = root.Position
						lastTick = tick()
					end

					if currentAirTime == 0 then
						timeOnAir = 0
					end
				end
			end
		end)
		
		--// Fly D
		task.spawn(function()
			if configuration.flyC then
				local timeOnAir = 0
				local antiInfFlag = 0
				while plr do
					task.wait(0.0174291482)

					local currentAirTime = onAir(root)
					timeOnAir = timeOnAir + currentAirTime
					local verticalMovement = root.Velocity.Y
					local distance = math.sqrt((root.Position.X - lastPosition.X) ^ 2 + (root.Position.Z - lastPosition.Z) ^ 2)

					if timeOnAir >= configuration.flyCMax then
						if verticalMovement >= 0 then
							if verticalMovement >= 0.1 and verticalMovement <= 150 then
								if configuration.anticheatSetBack then
									setBack(antiInfFlag, 0.55)
								end
								if configuration.anticheatDebug then
									warn('[LINT] '..plr.Name..' has failed Flight (TYPE D) | Movement: '..verticalMovement..' | Distance: '..distance..' | Time: ' .. timeOnAir)
								end
							end
						end
					else
						lastPosition = root.Position
						lastTick = tick()
					end

					if currentAirTime == 0 then
						timeOnAir = 0
					end
				end
			end
		end)
		
		--// Fly E
		task.spawn(function()
			if configuration.flyE then
				local timeOnAir = 0
				local antiInfFlag = 0
				while plr do
					task.wait(0.0174291482)

					
					local localTick = tick() - lastTick
					local distance = math.sqrt((root.Position.X - lastPosition.X) ^ 2 + (root.Position.Z - lastPosition.Z) ^ 2)
					local velocity = distance / localTick
					local currentAirTime = onAir(root)
					timeOnAir = timeOnAir + currentAirTime

					if timeOnAir >= configuration.flyEMaxAir then
						if velocity >= configuration.flyEMaxVelocity then
							if configuration.anticheatSetBack then
								setBack(antiInfFlag, 0.55)
							end
							if configuration.anticheatDebug then
								warn('[LINT] '..plr.Name..' has failed Flight (TYPE E) | On Ground: '..tostring(onGround)..' | Velocity: '..velocity..' | Distance: '..distance..' | Time: ' .. timeOnAir)
							end
						end
					else
						lastPosition = root.Position
						lastTick = tick()
					end

					if currentAirTime == 0 then
						timeOnAir = 0
					end
				end
			end
		end)
		
		--// Glide A
		task.spawn(function()
			if configuration.glideA then
				local timeOnAir = 0
				local antiInfFlag = 0
				while plr do
					task.wait(0.0174291482)


					local verticalMovement = root.Velocity.Y
					local distance = math.sqrt((root.Position.X - lastPosition.X) ^ 2 + (root.Position.Z - lastPosition.Z) ^ 2)
					local currentAirTime = onAir(root)
					timeOnAir = timeOnAir + currentAirTime

					if timeOnAir >= configuration.glideAMax then
						if verticalMovement <= 0 and verticalMovement >= 55 then
							if configuration.anticheatSetBack then
								setBack(antiInfFlag, 0.55)
							end
							if configuration.anticheatDebug then
								warn('[LINT] '..plr.Name..' has failed Glide (TYPE A) | On Ground: '..tostring(onGround)..' | Movement: '..verticalMovement..' | Distance: '..distance..' | Time: ' .. timeOnAir)
							end
						end
					else
						lastPosition = root.Position
						lastTick = tick()
					end

					if currentAirTime == 0 then
						timeOnAir = 0
					end
				end
			end
		end)
		
		--// Glide B
		task.spawn(function()
			if configuration.glideB then
				local timeOnAir = 0
				local antiInfFlag = 0
				while plr do
					task.wait(0.0174291482)


					local verticalMovement = root.Velocity.Y
					local distance = math.sqrt((root.Position.X - lastPosition.X) ^ 2 + (root.Position.Z - lastPosition.Z) ^ 2)
					local currentAirTime = onAir(root)
					timeOnAir = timeOnAir + currentAirTime

					if timeOnAir >= configuration.glideBMax then
						if verticalMovement >= 0 and verticalMovement <= 145 then
							if configuration.anticheatSetBack then
								setBack(antiInfFlag, 0.55)
							end
							if configuration.anticheatDebug then
								warn('[LINT] '..plr.Name..' has failed Glide (TYPE B) | On Ground: '..tostring(onGround)..' | Movement: '..verticalMovement..' | Distance: '..distance..' | Time: ' .. timeOnAir)
							end
						end
					else
						lastPosition = root.Position
						lastTick = tick()
					end

					if currentAirTime == 0 then
						timeOnAir = 0
					end
				end
			end
		end)
		
		--// Speed A
		task.spawn(function()
			if configuration.speedA then
				local antiInfFlag = 0
				while plr do
					local localTick = tick() - lastTick
					local distance = math.sqrt((root.Position.X - lastPosition.X) ^ 2 + (root.Position.Z - lastPosition.Z) ^ 2)
					local velocity = distance / localTick
					
					if hum.FloorMaterial ~= Enum.Material.Air then
						if velocity >= configuration.speedAMax then
							if configuration.anticheatSetBack then
								setBack(antiInfFlag, 0.1)
							end
							if configuration.anticheatDebug then
								warn('[LINT] '..plr.Name..' has failed Speed (TYPE A) | Velocity: '..velocity..' | Distance: '..distance..' | Time: ' .. localTick)
							end
						else
							lastPosition = root.Position
							lastTick = tick()
						end
					end
					task.wait(0.072193)
				end
			end
		end)
		
		--// Speed B
		task.spawn(function()
			if configuration.speedB then
				local antiInfFlag = 0
				while plr do
					if hum.FloorMaterial == Enum.Material.Air then
						local localTick = tick() - lastTick
						local distance = math.sqrt((root.Position.X - lastPosition.X) ^ 2 + (root.Position.Z - lastPosition.Z) ^ 2)
						local velocity = distance / localTick

						if velocity >= configuration.speedBMax then
							if configuration.anticheatSetBack then
								setBack(antiInfFlag, 0.1)
							end
							if configuration.anticheatDebug then
								warn('[LINT] '..plr.Name..' has failed Speed (TYPE B) | Velocity: '..velocity..' | Distance: '..distance..' | Time: ' .. localTick)
							end
						else
							lastPosition = root.Position
							lastTick = tick()
						end
					end
					task.wait(0.067812)
				end
			end
		end)
		
		--// Speed C
		task.spawn(function()
			if configuration.speedC then
				local antiInfFlag = 0
				local previousVelocity = Vector3.new()
				while plr do
					if math.abs(root.Velocity.Y) <= 0.1 then
						local currentVelocity = root.Velocity
						local acceleration = currentVelocity - previousVelocity
						local distance = math.sqrt((root.Position.X - lastPosition.X) ^ 2 + (root.Position.Z - lastPosition.Z) ^ 2)
						local accelerationMagnitude = acceleration.Magnitude

						if accelerationMagnitude >= configuration.speedCMax then
							if configuration.anticheatSetBack then
								setBack(antiInfFlag, 0.1)
							end
							if configuration.anticheatDebug then
								warn('[LINT] '..plr.Name..' has failed Speed (TYPE C) | Acceleration: '..accelerationMagnitude..' | Distance: '..distance..' | Velocity: ' .. currentVelocity.Magnitude)
							end
						else
							lastPosition = root.Position
							lastTick = tick()
						end
						previousVelocity = currentVelocity
					end

					task.wait(0.09816382)
				end
			end
		end)
		
		--// Speed D
		task.spawn(function()
			if configuration.speedD then
				local antiInfFlag = 0
				while plr do
					if hum.FloorMaterial ~= Enum.Material.Air then
						local currentVelocity = math.sqrt((root.Velocity.X ) ^ 2 + (root.Velocity.Z) ^ 2)
						local distance = math.sqrt((root.Position.X - lastPosition.X) ^ 2 + (root.Position.Z - lastPosition.Z) ^ 2)
						local velocityMagnitude = currentVelocity

						if velocityMagnitude > configuration.speedDMax then
							if configuration.anticheatSetBack then
								setBack(antiInfFlag, 0.35)
							end
							if configuration.anticheatDebug then
								warn('[LINT] '..plr.Name..' has failed Speed (TYPE D) | Velocity: '..velocityMagnitude..' | Distance: '..distance)
							end
						else
							lastPosition = root.Position
							lastTick = tick()
						end
					end

					task.wait(0.04810387)
				end
			end
		end)
		
		--// Jump A
		task.spawn(function()
			if configuration.jumpA then
				local antiInfFlag = 0
				while plr do
					if hum.FloorMaterial == Enum.Material.Air then
						local verticalMovement = math.abs(root.Velocity.Y)
						local distance = math.sqrt((root.Position.Y - lastPosition.Y) ^ 2)
						local upwardMovement = math.max(0, root.Velocity.Y)

						if verticalMovement > configuration.jumpAMax and upwardMovement > configuration.jumpAMax then
							if configuration.anticheatSetBack then
								setBack(antiInfFlag, 0.35)
							end
							if configuration.anticheatDebug then
								warn('[LINT] '..plr.Name..' has failed Jump (TYPE A) | Vertical Movement: '..verticalMovement..' | Upwards Movement: '..upwardMovement..' | Distance: '..distance)
							end
						else
							lastPosition = root.Position
							lastTick = tick()
						end
					end

					task.wait(0.05719382)
				end
			end
		end)
		
		--// Jump B
		task.spawn(function()
			if configuration.jumpB then
				local antiInfFlag = 0
				local jumpCounter = 0
				
				task.spawn(function()
					while plr do
						if hum:GetState() == Enum.HumanoidStateType.Jumping then
							jumpCounter = jumpCounter + 1

							if jumpCounter >= configuration.jumpBMax then
								if configuration.anticheatDebug then
									warn('[LINT] '..plr.Name..' has failed Jump (TYPE B) | Frequency: '..jumpCounter)
								end
								if configuration.anticheatSetBack then
									if antiInfFlag == 0 then
										for i=1,15 do
											chr:PivotTo(lastGoodPosition)
											task.wait(0.1)
										end
									end
									antiInfFlag = 1
									task.wait(0.35);
									antiInfFlag = 0
									task.wait();
								end
							end
						end

						task.wait(0.0271937)
					end
				end)
				
				while task.wait(2.5,2.65829) do
					jumpCounter = 0
				end
			end
		end)
		
		--// Jump C
		task.spawn(function()
			if configuration.jumpA then
				local antiInfFlag = 0
				while plr do
					if hum.FloorMaterial == Enum.Material.Air then
						local movement = root.Velocity
						local distance = math.sqrt((root.Position.Y - lastPosition.Y) ^ 2)

						if movement.Y >= configuration.jumpCMax and root.Velocity.Y >= 0 then
							if configuration.anticheatSetBack then
								setBack(antiInfFlag, 0.35)
							end
							if configuration.anticheatDebug then
								warn('[LINT] '..plr.Name..' has failed Jump (TYPE C) | Vertical Movement: '..movement.Y..' | Distance: '..distance)
							end
						else
							lastPosition = root.Position
							lastTick = tick()
						end
					end

					task.wait(0.05719382)
				end
			end
		end)
		
		--// Health A
		task.spawn(function()
			if configuration.healthA then
				local health = hum.Health
				local maxhealth = hum.MaxHealth
				while plr do
					if health > maxhealth then
						health = maxhealth
						if configuration.anticheatDebug then
							warn('[LINT] '..plr.Name..' has failed Health (TYPE A) | Health: '..health..' | Maximum Health: '..maxhealth)
						end
					else
						local health = hum.Health
						local maxhealth = hum.MaxHealth
					end
					if health < configuration.healthAMin then
						health = 0
						if configuration.anticheatDebug then
							warn('[LINT] '..plr.Name..' has failed Health (TYPE A) | Health: '..health..' | Minimum Health: '..configuration.healthAMin)
						end
					else
						local health = hum.Health
						local maxhealth = hum.MaxHealth
					end
					task.wait(1)
				end
			end
		end)
		
		--// Health B
		task.spawn(function()
			if configuration.healthB then
				local oldHealth = hum.Health
				while plr do
					local currentHealth = hum.Health
					if (currentHealth - oldHealth) >= configuration.healthBMax then
						currentHealth = oldHealth
						if configuration.anticheatDebug then
							warn('[LINT] '..plr.Name..' has failed Health (TYPE B) | Previous: '..oldHealth..' | Current: '..currentHealth)
						end
					else
						oldHealth = hum.Health
					end
					task.wait(1)
				end
			end
		end)
		
		--// Health C
		task.spawn(function()
			if configuration.healthC then
				local maxhealth = hum.MaxHealth
				while plr do
					if maxhealth > configuration.healthCMax then
						maxhealth = configuration.healthCMax
						if configuration.anticheatDebug then
							warn('[LINT] '..plr.Name..' has failed Health (TYPE C) | Maximum Health: '..maxhealth..' | Allowed Health: '..configuration.healthCMax)
						end
					else
						local health = hum.Health
						local maxhealth = hum.MaxHealth
					end
					task.wait(1)
				end
			end
		end)
		
		--// Invalid A
		task.spawn(function()
			if configuration.invalidA then
				local antiInfFlag = 0
				local isSeated = hum.Sit
				local isJumping = hum.Jump
				local isJumping2 = Enum.HumanoidStateType.Jumping
				local state = hum:GetState()
				local isJumping3 = false
				while plr do
					if state == isJumping2 then
						isJumping3 = true
					else
						isJumping3 = false
					end
					if (isSeated and isJumping or isSeated and state == isJumping2) then
						if antiInfFlag == 0 then
							for i=1,15 do
								chr:PivotTo(lastGoodPosition)
								task.wait(0.1)
							end
						end
						if configuration.anticheatDebug then
							warn('[LINT] '..plr.Name..' has failed Invalid (TYPE A) | Seated: '..isSeated..' | Humanoid Jump: '..isJumping..' | State Jump: '..isJumping3)
						end
					end
					task.wait(0.0372917349)
				end
			end
		end)
	end)
end)
