GameScene.createObject("Mission", "missionTemplate", {
	["isGameStateSave"] = false,
	["isEnable"] = true,
	["sceneFile"] = "$levels/Zinor_coast_q13/Zinor_coast_q13.scene.xml",

	["skyFile"] = "xml/sky_night_port.xml",
	["dayLengthInSeconds"] = -1,
	["startHour"] = 23,

	["spawnPoints"]= {
			[1]={x=-141.7, y=1.28, z=-338.4, dirX=-0.0035292899701744, dirY=-0, dirZ=0.9999937415123},
			[2]={x=-129.57, y=43.65, z=-67.3, dirX=-0.70820534229279, dirY=-0, dirZ=-0.70600646734238},
		},
	["events"] = {
		["onSpawn"] = {
			[1] = "! checkQuest13_zinor()",
			[2] = 0,
		},
		["onAllSpawned"] = {
			[1] = "! GO('Mission'):showSceneObject('l12020_ship-n-cannons',false)",
			[2] = 0,
		},
	},
	
	["refPoints"] = {sx=-278, sz=-18, ex=185, ez=-372},
	["mapID"] = 17890,
	["namePlace"] = "Zinor_Coast",
});

dofile(levelspath.."/Zinor_coast_q13/_stones.lua")
dofile(levelspath.."/Zinor_coast_q13/_scene_boat.lua")
dofile(levelspath.."/Zinor_coast/_scene5_barriers.lua")
dofile(levelspath.."/Zinor_coast/_scene_Barriers_01.lua")
dofile(levelspath.."/Zinor_coast/_scene_Barriers_02.lua")
dofile(levelspath.."/Zinor_coast/_scene_Barriers_03.lua")
dofile(levelspath.."/Zinor_coast/_scene_Barriers_04.lua")
dofile(levelspath.."/Zinor_coast/_scene_bluff_Barriers.lua")
dofile(levelspath.."/Zinor_coast_q13/_scene_forestAmbientNight.lua")
dofile(levelspath.."/Zinor_coast_q13/_scene_oseanNoiseNight.lua")
dofile(levelspath.."/Zinor_coast_q13/_eggs.lua")
dofile(levelspath.."/Zinor_coast_q13/_items.lua")
dofile(levelspath.."/Zinor_coast_q13/Zinor_q13secret.lua")

GameScene.createObject("Music_Zinor13", "GameEffect", {
	["tm"] ={
		[1] = 0.73821878433228,
		[2] = 0,
		[3] = -0.67456132173538,
		[4] = 0,
		[5] = 0,
		[6] = 1,
		[7] = 0,
		[8] = 0,
		[9] = 0.67456132173538,
		[10] = 0,
		[11] = 0.73821878433228,
		[12] = 0,
		[13] = 50.790924072266,
		[14] = -32.30598449707,
		[15] = -7.0200572013855,
		[16] = 1,
	},
	["isGameStateSave"] =false,
	["events"] ={
	},
	["isEnable"] =false,
	["sound"] ={
		["freqMult"] =1,
		["isLooped"] =true,
		["volume"] =255,
		["bone"] =-1,
		["soundUid"] =20205,
		["minDist"] =99999997952,
		["maxDist"] =99999997952,
	},

});
