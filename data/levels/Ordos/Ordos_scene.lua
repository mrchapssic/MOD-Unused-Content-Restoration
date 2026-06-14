GameScene.createObject("Mission", "missionTemplate", {
	["isGameStateSave"] = false,
	["events"]= {
		["onGoToLocation"] ={
			[1] = "! woundedQuestFailed()",
			[2] = 0, 
		},
	},
	["isEnable"] = true,
	["sceneFile"] = "$levels/Ordos/Ordos.scene.xml",
	["skyFile"] = "xml/sky_ordos.xml",
	["spawnPoints"]= { 
			[1] = {x=70.898, y=-27.486, z=10.333, dirX=-0.999, dirY=0, dirZ=0.0375},
		},
	["refPoints"] = {sx=-110, sz=100, ex=95, ez=-55},
	["mapID"] = 22786,
	["namePlace"] = "Old_Ordos",
	["ambientSong"] = 23002,
});

dofile(levelspath.."/Ordos/Quest_Scene.lua")
dofile(levelspath.."/Ordos/_barriers.lua")
dofile(levelspath.."/Ordos/_scene1.lua")
dofile(levelspath.."/Ordos/_scene2.lua")
dofile(levelspath.."/Ordos/_scene3.lua")
dofile(levelspath.."/Ordos/_scene4.lua")
dofile(levelspath.."/Ordos/_scene5.lua")
dofile(levelspath.."/Ordos/_scene6.lua")
dofile(levelspath.."/Ordos/_scene8_2.lua")
dofile(levelspath.."/Ordos/_scene9.lua")
dofile(levelspath.."/Ordos/_scene_stones.lua")
dofile(levelspath.."/Ordos/_scene_chest.lua")
dofile(levelspath.."/Ordos/_scene_items.lua")
dofile(levelspath.."/Ordos/_scene_broken_object.lua")
dofile(levelspath.."/Ordos/_ravens.lua")
dofile(levelspath.."Ordos/secret_items.lua")