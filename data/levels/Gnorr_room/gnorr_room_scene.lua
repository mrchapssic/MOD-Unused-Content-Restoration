dofile(levelspath.."Gnorr_room/sonnWps.lua")
dofile(levelspath.."Gnorr_room/gnor_roomsecret.lua")


GameScene.createObject("Mission", "missionTemplate", {
	
	["sceneFile"] ="$levels/Gnorr_room/Gnorr_room.scene.xml",
	--["lightGridFile"] = "$levels/Gnorr_room/Gnorr_LG_05.lgrd",
	--["lightGridFile"] = "$levels/Gnorr_room/LG_025.lgrd", 
	["lightGridOffs"] ={
		[1] = 0,
		[2] = 0,
		[3] = 0,
	},
	["events"] ={
		["onAllSpawned"] ={
		 	[1] = "! checkPharos(); checkGnorrQ5(); checkGnorrQ12(); checkQuest13(); checkQuest14(); checkQuest16(); checkQuest17(); checkGnorrQ18(); placeFakeMarkers();",
			[2] = 0,
		},
	},
	["isEnable"] =true,
	["spawnPoints"] ={
		[1] = {
			["y"] =-3.63,
			["x"] =-7.31,
			["z"] =-0.02,
			["dirY"] =0,
			["dirZ"] =0,
			["dirX"] =1,
		},
	},
	["dayLengthInSeconds"] =-1,
	["isGameStateSave"] =false,
	["skyFile"] ="xml/sky_gnorr.xml",
	["startHour"] =15,
	["refPoints"] = {sx=-220, sz=28, ex=220, ez=-164},
	["mapID"] = 22494,
	["namePlace"] = "Vault_Gnorr",
	
	--["eaxPreset"] = "BATHROOM",
	["ambientSong"] = 23539,
	["ambientVolume"] = 180,
});

GameScene.createObject("BarrierGnorr", "BarrierTemplate", {
	["tm"] ={
		[1] = -0.048819035291672,
		[2] = 0,
		[3] = 0.99880766868591,
		[4] = 0,
		[5] = 0,
		[6] = 1,
		[7] = 0,
		[8] = 0,
		[9] = -0.99880766868591,
		[10] = 0,
		[11] = -0.048819035291672,
		[12] = 0,
		[13] = 7.8931059837341,
		[14] = -1.8281307220459,
		[15] = -0.16418285667896,
		[16] = 1,
	},
	["prototypeName"] ="Barrier",
	["scale"] ={
		[1] = 0.76999664306641,
		[2] = 3.3100204467773,
		[3] = 0.76000213623047,
	},
	["needVisualization"] =false,
	["isGameStateSave"] =false,
	["events"] ={
	},
	["isEnabledPhysics"] =true,
	["collisionCheckerName"] ="avatar",
	["isEnable"] =true,

});

GameScene.createObject("Gnorr", "CharacterMale", {
	["cantMove"] =false,
	["stats"] ={
		["maxSp"] =100,
		["sp"] =100,
		["hp"] =100,
		["maxHp"] =100,
	},
	["armorThickness"] =0,
	["hasBattlePhys"] =false,
	["isShadowCaster"] =true,
	["isGameStateSave"] =false,
	["isDynamic"] =true,
	["items_name"] ={
	},
		
	["isEnable"] =true,
	["isEnabledPhysics"] =false,
	["currentIdle"] ="lagha_idle",
	talkIdle = "majestic",
		
	["thumbnail"] =9083,
	["radiusAct"] =0,
	["tm"] ={
		[1] = -0.00045911164488643,
		[2] = 0,
		[3] = 0.99999988079071,
		[4] = 0,
		[5] = 0,
		[6] = 1,
		[7] = -0,
		[8] = 0,
		[9] = -0.99999988079071,
		[10] = -0,
		[11] = -0.00045911164488643,
		[12] = 0,
		[13] = 7.74298620224,
		[14] = -2.1725285053253,
		[15] = -0.12542147934437,
		[16] = 1,
	},
	["usePathFinder"] =true,
	["name"] ="Gnorr",
	["slot"] ={
	},
	["radiusNotify"] =0,
	["visualFileName"] ="characters/NPC/Lagha.chr.xml",
	["necroVisionType"] =131072,
	["isShown"] =true,
	["state"] ="normalState",
	["io"] ={
		["dialogName"] ="GnorrQ5In",
	},
	["events"] ={
		["onUse"] ={
			[1] = "! self:startDialog()",
			[2] = 0,
		},
	},
	["isHitBoxesEnabled"] =false,
	["radiusDeact"] =0,
	["spawnPoint"] ={
		[1] = 7.74298620224,
		[2] = -2.1725285053253,
		[3] = -0.12542147934437,
	},
	["hitBoxesFileName"] ="models/test/HitBoxes.hb.xml",
	["isAutoActivation"] =false,
});
GameScene.createObject("Gates_Gnorr_Square", "TransferDoor", {
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
		[13] = -12.444024085999,
		[14] = -3.4873902797699,
		[15] = 2.8116080760956,
		[16] = 1,
	},
	["visualFileName"] ="models/53_magicstuff/s12530_bomb/s1253_bomb.OBJ.XML",	
	["triggerScale"] ={
		[1] = 2,
		[2] = 4,
		[3] = 6,
	},
	["necroVisionType"] =65536,
	["isShown"] =false,	
	["isEnable"] =true,	
	["isEnabledPhysics"] =false,
	["thumbnail"] =14747,	
	["name"] ="Exit_Square",	
	["dest"] ="Square",
	["spawnPoint"] =4,
});

GameScene.createObject("fishInEyeOfTruth", "VisualGameObject", {
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
		[13] = 7.4914035797119,
		[14] = -2.1500000953674,
		[15] = 3.914393901825,
		[16] = 1,
	},
	["visualFileName"] ="models/test/fish_in_zrak_istini/u1984_fish_in_zrak_istini.OBJ.XML",
	["isShown"] =true,
	["isDynamic"] =true,
	["isHitBoxesEnabled"] =false,
	["events"] ={
		["onSpawn"] ={
			[1] = "! self:playPrimitiveAnimation(0, 2);",
			[2] = 0,
		},
	},
	["isEnabledPhysics"] =false,
	["necroVisionType"] =65536,
	["isShadowCaster"] =false,
	["isGameStateSave"] =false,
	["isEnable"] =true,

});
GameScene.createObject("Gates_Arrum", "TransferDoor", {
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
		[13] = -12.587623596191,
		[14] = -3.0273895263672,
		[15] = -3.1519088745117,
		[16] = 1,
	},
	["isEnabledPhysics"] =false,
	["triggerScale"] ={
		[1] = 2,
		[2] = 4,
		[3] = 6,
	},
	["necroVisionType"] =65536,
	["isGameStateSave"] =false,
	["visualFileName"] ="models/53_magicstuff/s12530_bomb/s1253_bomb.OBJ.XML",
	["isShadowCaster"] =true,
	["isShown"] =false,
	["isDynamic"] =true,
	["isHitBoxesEnabled"] =false,
	["events"] ={
	},
	["isEnable"] =true,
	["dest"] ="arrum_room",
	["name"] ="arrum_room",
	["thumbnail"] =14747,
	["spawnPoint"] =2,

});
GameScene.createObject("scene1", "CameraScene", {
	["tm"] ={
		[16] = 1,
		[12] = 0,
		[6] = 1,
		[13] = 0,
		[1] = 1,
		[3] = 0,
		[7] = 0,
		[15] = 0,
		[8] = 0,
		[4] = 0,
		[9] = 0,
		[14] = 0,
		[2] = 0,
		[5] = 0,
		[11] = 1,
		[10] = 0,
	},
	["needToFadeOut"] =true,
	
	["sounds"] = {
			[1] = {filename = "sounds/scenes/gnorr_room_00.ogg", time = 0},
			[2] = {filename = "sounds/scenes/gnorr_room_01.ogg", time = 5 - 4.4},
			[3] = {filename = "sounds/scenes/gnorr_room_02.ogg", time = 9.406 - 4.2},
			[4] = {filename = "sounds/scenes/gnorr_room_03.ogg", time = 14.813 - 4.6},
			[5] = {filename = "sounds/scenes/gnorr_room_04.ogg", time = 22.469 - 5.1},
		}, 
		
	["cameras"] ={
		[1] = {
			["model"] ="models/test/w00000_camera_gnorr_room/w0000_camera_gnorr_room.OBJ.XML",
		},
	},
	["isGameStateSave"] =false,
	["events"] ={
		["onAllSpawned"] ={
			[1] = "! self:play()",
			[2] = 0,
		},
		["onPlay"] ={
			[1] = "! avatar:quickHidingWeapon(); \
					local m = GO('Mission'); \
					if(m.data.ambientSongChannel) then \
						setSoundVolume(m.data.ambientSongChannel, m.data.ambientVolume/1.5); \
					end",
			[2] = 0,
		},
		["onStop"] ={
			[1] = "! local m = GO('Mission'); \
					if(m.data.ambientSongChannel) then \
						setSoundVolume(m.data.ambientSongChannel, m.data.ambientVolume); \
					end",
			[2] = 0,
		},
	},
	["isEnable"] =false,
	["allowStopByKey"] =true,
	["visualObjects"] ={
		[1] = {
			["tm"] ={
				[16] = 1,
				[12] = 0,
				[6] = 1,
				[13] = 0,
				[1] = 1,
				[3] = 0,
				[7] = 0,
				[15] = 0,
				[8] = 0,
				[4] = 0,
				[9] = 0,
				[14] = 0,
				[2] = 0,
				[5] = 0,
				[11] = 1,
				[10] = 0,
			},
			["tag"] ="Gnorr",
			["restoreState"] =true,
			["animName"] ="scene_gnorr_room_gnorr",
		},
		[2] = {
			["tm"] ={
				[16] = 1,
				[12] = 0,
				[6] = 1,
				[13] = 0,
				[1] = 1,
				[3] = 0,
				[7] = 0,
				[15] = 0,
				[8] = 0,
				[4] = 0,
				[9] = 0,
				[14] = 0,
				[2] = 0,
				[5] = 0,
				[11] = 1,
				[10] = 0,
			},
			["tag"] ="Avatar",
			["restoreState"] =true,
			["animName"] ="scene_gnorr_room_orvin",
		},
	},
	["isSavable"] =false,
	["startFromFade"] =true,

});

GameScene.createObject("BookGiver", "ItemGiver", {
	["tm"] ={
		[1] = -1,
		[2] = 0,
		[3] = 0,
		[4] = 0,
		[5] = 0,
		[6] = 1,
		[7] = 0,
		[8] = 0,
		[9] = 0,
		[10] = 0,
		[11] = -1,
		[12] = 0,
		[13] = 7.5,
		[14] = -3.4,
		[15] = 11.15,
		[16] = 1,
	},
	["scale"] ={
		[1] = 1,
		[2] = 1,
		[3] = 1,
	},
	["geomType"] =1,
	["angVel"] =1,
	["isEnabledPhysics"] =true,
	["itemPrototype"] ="book3",
	["effectName1"] ="itemGiverIdle",
	["isEnable"] =true,
	["effectName2"] ="itemGiverTake",
	["itemOffsetY"] =1,
	["isGameStateSave"] =false,
	["events"] ={
		["checkEnter"] ={
			[1] = "! for i,v in pairs(other) do if (v:tag() == 'Avatar') then return true else return false end end",
			[2] = 1,
		},
		["onEnter"] ={
			[1] = "! print('onEnter'); self:enter(other);",
			[2] = 0,
		},
		["onLeave"] ={
			[1] = "! print('onLeave'); self:leave();",
			[2] = 0,
		},
	},

});