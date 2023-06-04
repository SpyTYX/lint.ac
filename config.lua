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
	 
	 1.0.0f

]]

local config = {}

--// Main Anticheat

config.anticheatKick = true  --// Current does nothing, this will be released in the future updates!
config.anticheatSetBack = true  --// Should anticheat set people back once flag? | RECOMMENDED: True
config.anticheatDebug = true  --// Debugging for Developers | RECOMMENDED: False

--// Checks
config.flyA = true    --// Should Flight A Check be enabled? | RECOMMENDED: True
config.flyB = true    --// Should Flight B Check be enabled? | RECOMMENDED: True
config.flyC = true    --// Should Flight B Check be enabled? | RECOMMENDED: True
config.flyD = true    --// Should Flight B Check be enabled? | RECOMMENDED: True

config.speedA = true  --// Should Speed A Check be enabled? | RECOMMENDED: True
config.speedB = true  --// Should Speed B Check be enabled? | RECOMMENDED: True
config.speedC = true  --// Should Speed C Check be enabled? | RECOMMENDED: True
config.speedD = true  --// Should Speed D Check be enabled? | RECOMMENDED: True

config.jumpA = true  --// Should Jump A Check be enabled? | RECOMMENDED: True
config.jumpB = true  --// Should Jump B Check be enabled? | RECOMMENDED: True
config.jumpE = true  --// Should Jump E Check be enabled? | RECOMMENDED: True

config.healthA = true  --// Should Health A Check be enabled? | RECOMMENDED: True
config.healthB = true  --// Should Health A Check be enabled? | RECOMMENDED: True
config.healthC = true  --// Should Health A Check be enabled? | RECOMMENDED: True

config.invalidA = true  --// Should Invalid A Check be enabled? | RECOMMENDED: True

--// Check Configuration
config.flyAMax = 1.65  --// Maximum allowed time in air before flagging the user as cheating (only detects down).
config.flyBMax = 1.65  --// Maximum allowed time in air before flagging the user as cheating (only detects up).
config.flyCMax = 1.65  --// Maximum allowed time in air before flagging the user as cheating (only detects down).
config.flyDMax = 1.65  --// Maximum allowed time in air before flagging the user as cheating (only detects up).

config.speedAMax = 27  --// Maximum allowed Velocity Magnitude, detects most speed hacks.
config.speedBMax = 31  --// Maximum allowed Velocity Magnitude, detects most speed hacks that abuses air-friction.
config.speedCMax = 55  --// Maximum allowed acceleration, detects sudden-changes in the player's velocity.
config.speedDMax = 65  --// Maximum allowed acceleration, detects sudden-changes in the player's velocity.

config.jumpAMax = 57  --// Maximum allowed Velocity Height before flagging the user as cheating.
config.jumpBMax = 7  --// Maximum allowed Jumping Frequency before flagging the user as cheating.
config.jumpCMax = 66  --// Maximum allowed Jumping Frequency before flagging the user as cheating.

config.healthAMin = 0  --// Minimum allowed health before Lint kills the user.

config.healthBMax = 25  --// Maximum allowed change in user's health before settings back the health to the old health.

config.healthCMax = 100  --// Maximum allowed MaxHealth before user is flagged as cheating

return config
