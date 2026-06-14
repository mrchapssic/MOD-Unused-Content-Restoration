

dofile(TW_LEVELS.."Tamay/Tamay_Ovel1.lua");
dofile(TW_LEVELS.."Tamay/Tamay_scene1.lua");
dofile(TW_LEVELS.."Tamay/Tamay_scene2.lua");
dofile(TW_LEVELS.."Tamay/Tamay_scene3.lua");
dofile(TW_LEVELS.."Tamay/Tamay_scene4.lua");
dofile(TW_LEVELS.."Tamay/Tamay_Ovel_before_bonehand.lua");
dofile(TW_LEVELS.."Tamay/Tamay_scene5.lua");
dofile(TW_LEVELS.."Tamay/Tamay_scene6.lua");
dofile(TW_LEVELS.."Tamay/Tamay_scene7.lua");
dofile(TW_LEVELS.."Tamay/Tamay_scene8.lua");
dofile(TW_LEVELS.."Tamay/Tamay_Ovel2.lua");

dofile(TW_LEVELS.."Tamay/Tamay_anchors.lua");
dofile(TW_LEVELS.."Tamay/Tamay_doors.lua");
dofile(TW_LEVELS.."Tamay/Tamay_breakables.lua");
dofile(TW_LEVELS.."Tamay/Tamay_secret.lua");

GameScene.createObject("Mission", "missionTemplate", {
	["isGameStateSave"] = false,
	["events"]= {
		["onAllSpawned"] = "! enterTamayQ5();",
		["onDestroy"] = "! ",
	},
	maxRangeShadow = true,
	["isEnable"] = true,
	["sceneFile"] = "$levels/Tamay/Tamay.scene.xml",
	--["pathFinding"] = "$levels/Tamay/tamay_aiGrid.pfg",
	["skyFile"] = "xml/sky_tamay.xml",
	["dayLengthInSeconds"] = -1,
	["startHour"] = 15,
	["spawnPoints"]= {
			[1]={x=-56.60, y=-2.94, z=-25.49, dirX = 1, dirY = 0, dirZ = 0},
		},
	
	["refPoints"] = {sx=-71, sz=10, ex=45, ez=-77},
	["mapID"] = 22375,
	["namePlace"] = "Wild_Duck",
	["lightGridFile"] = "$levels/Tamay/tamay_LightGrid_1.lgrd",
	["eaxPreset"] = "STONEROOM", --"STONECORRIDOR",
	["ambientSong"] = 22810,
	["ambientVolume"] = 190,
});

GameScene.createObject("FakeEntry", "WayPointTemplate", {
	["tm"] ={
		[1] = 1,
		[2] = 0,
		[3] = 0,
		[4] = 0,
		[5] = 0,
		[6] = 1,
		[7] = 0,
		[8] = 0,
		[9] = 0,
		[10] = 0,
		[11] = 1,
		[12] = 0,
		[13] = -59,
		[14] = -2.7,
		[15] = -25.7,
		[16] = 1,
	},
	["prototypeName"] ="Waypoint",
	["visualFileName"] ="models/00_common/o0000_waypoint.OBJ.XML",
	["isShown"] =true,
	["needVisualization"] =false,
	["isEnable"] =true,
});