GameScene.createObject("Mission", "missionTemplate", {
	["isGameStateSave"] = false,
	["events"]= {
		["onAllSpawned"] ={
			[1] = "! arriveOrdosQ14()",
			[2] = 0,
		},
	},
	["isEnable"] = true,
	["sceneFile"] = "$levels/Ordos/Ordos.scene.xml",
	["skyFile"] = "xml/sky_ordos_night.xml",
	["spawnPoints"]= {
			[1] = {x=56.23762512207, y=-29.186973571777, z=3.4853630065918, dirX=-0.033151231706142, dirY=0, dirZ=0.99945032596588
			},
		},
	["refPoints"] = {sx=-110, sz=100, ex=95, ez=-55},
	["mapID"] = 22786,
	["namePlace"] = "Old_Ordos",
	["ambientSong"] = 23002,
});

dofile(levelspath.."/Ordos/_barriers.lua")
dofile(levelspath.."/Ordos_Q14/_scene1.lua")
dofile(levelspath.."/Ordos_Q14/_scene2.lua")
dofile(levelspath.."/Ordos_Q14/_scene3.lua")
dofile(levelspath.."/Ordos_Q14/_scene4.lua")
dofile(levelspath.."/Ordos_Q14/_scene5.lua")
dofile(levelspath.."/Ordos_Q14/_scene6.lua")
dofile(levelspath.."/Ordos_Q14/_final_scene.lua")
dofile(levelspath.."/Ordos_Q14/_broken_objects.lua")
dofile(levelspath.."/Ordos_Q14/Quest_Scene.lua")

dofile(levelspath.."/Ordos_Q14/_sceneTargets.lua")
dofile(levelspath.."/Ordos_Q14/Ordos_Q14secret.lua")