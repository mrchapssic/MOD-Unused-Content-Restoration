GameScene.createObject("traderBarrier2", "BarrierTemplate", {
	["tm"] ={
		[1] = -0.9997633099556,
		[2] = 0,
		[3] = -0.02175721898675,
		[4] = 0,
		[5] = 0,
		[6] = 1,
		[7] = 0,
		[8] = 0,
		[9] = 0.02175721898675,
		[10] = 0,
		[11] = -0.9997633099556,
		[12] = 0,
		[13] = -46.734889984131,
		[14] = -9.4432182312012,
		[15] = -116.74227905273,
		[16] = 1,
	},
	["collisionCheckerName"] ="avatar",
	["scale"] ={
		[1] = 2.9400024414063,
		[2] = 4.3400001525879,
		[3] = 1,
	},
	["saveFile"] ="_scene_trader.lua",
	["needVisualization"] =false,
	["isGameStateSave"] =false,
	["events"] ={
		["onSpawn"] ={
			[1] = "! print('Spawn')",
			[2] = 0,
		},
	},
	["isEnabledPhysics"] =false,
	["isEnable"] =false,

});
GameScene.createObject("traderBarrier1", "BarrierTemplate", {
	["tm"] ={
		[1] = -0.97827368974686,
		[2] = 0,
		[3] = 0.20731773972511,
		[4] = 0,
		[5] = 0,
		[6] = 1,
		[7] = 0,
		[8] = 0,
		[9] = -0.20731773972511,
		[10] = 0,
		[11] = -0.97827368974686,
		[12] = 0,
		[13] = -32.668586730957,
		[14] = -8.2538404464722,
		[15] = -121.09752655029,
		[16] = 1,
	},
	["collisionCheckerName"] ="avatar",
	["scale"] ={
		[1] = 7.3099994659424,
		[2] = 2.7700004577637,
		[3] = 1,
	},
	["saveFile"] ="_scene_trader.lua",
	["needVisualization"] =false,
	["isGameStateSave"] =false,
	["events"] ={
		["onSpawn"] ={
			[1] = "! print('Spawn')",
			[2] = 0,
		},
	},
	["isEnabledPhysics"] =false,
	["isEnable"] =false,

});
GameScene.createObject("traderTrigger01", "TriggerTemplate", {
	["tm"] ={
		[1] = -0.99942034482956,
		[2] = 0,
		[3] = 0.034044280648232,
		[4] = 0,
		[5] = 0,
		[6] = 1,
		[7] = 0,
		[8] = 0,
		[9] = -0.034044280648232,
		[10] = 0,
		[11] = -0.99942034482956,
		[12] = 0,
		[13] = -41.320789337158,
		[14] = -10.188430786133,
		[15] = -122.44911193848,
		[16] = 1,
	},
	["isGameStateSave"] =false,
	["events"] ={
		["checkEnter"] ={
			[1] = "! for i,v in pairs(other) do if (v:tag() == 'Avatar') then return true else return false end end",
			[2] = 1,
		},
		["onEnter"] ={
			[1] = "! local obj = GO('trader'); \
					obj:enable(true); obj:enablePhysics(true); obj:show(true); \
					GO('traderTrigger02'):enable(true); \
					GO('traderTrigger03'):enable(true); \
					self:destroy();",
			[2] = 0,
		},
	},
	["isEnable"] =false,
	["scale"] ={
		[1] = 3.1700010299683,
		[2] = 6.4399862289429,
		[3] = 2.2399911880493,
	},
	["geomType"] =2,
	["saveFile"] ="_scene_trader.lua",
	["isEnabledPhysics"] =false,

});
GameScene.createObject("traderTrigger02", "TriggerTemplate", {
	["tm"] ={
		[1] = -0.04151077568531,
		[2] = 0,
		[3] = 0.9991380572319,
		[4] = 0,
		[5] = 0,
		[6] = 1,
		[7] = 0,
		[8] = 0,
		[9] = -0.9991380572319,
		[10] = 0,
		[11] = -0.04151077568531,
		[12] = 0,
		[13] = -38.281768798828,
		[14] = -9.7499198913574,
		[15] = -132.51658630371,
		[16] = 1,
	},
	["isGameStateSave"] =false,
	["events"] ={
		["onDestroy"] ={
			[1] = "! if not self:isEnabled() then return end \
					 avatar:blockActions(true); local obj = GO('trader'); \
					 obj:setDialog('DesolateHarbor_Trader'); \
					 addTimeEvent(obj.startDialog, {obj, avatar}, 1);  ",
			[2] = 0,
		},
		["onEnter"] ={
			[1] = "! GO('traderTrigger03'):destroy(); self:destroy(); ",
			[2] = 0,
		},
		["checkEnter"] ={
			[1] = "! for i,v in pairs(other) do if (v:tag() == 'Avatar') then return true else return false end end",
			[2] = 1,
		},
	},
	["isEnable"] =false,
	["scale"] ={
		[1] = 17.219989776611,
		[2] = 6.0599966049194,
		[3] = 2.2399911880493,
	},
	["geomType"] =2,
	["saveFile"] ="_scene_trader.lua",
	["isEnabledPhysics"] =false,

});
GameScene.createObject("traderTrigger03", "TriggerTemplate", {
	["tm"] ={
		[1] = -0.54090791940689,
		[2] = 0,
		[3] = 0.84108185768127,
		[4] = 0,
		[5] = 0,
		[6] = 1,
		[7] = 0,
		[8] = 0,
		[9] = -0.84108185768127,
		[10] = 0,
		[11] = -0.54090791940689,
		[12] = 0,
		[13] = -42.138969421387,
		[14] = -9.5839014053345,
		[15] = -125.73191070557,
		[16] = 1,
	},
	["isGameStateSave"] =false,
	["events"] ={
		["checkEnter"] ={
			[1] = "! for i,v in pairs(other) do if (v:tag() == 'Avatar') then return true else return false end end",
			[2] = 1,
		},
		["onEnter"] ={
			[1] = "! addTimeEvent(TriggerTemplate.destroy, {GO('traderTrigger02')}, 2.5, true); \
						avatar:blockActions(true); \
						self:destroy(); ",
			[2] = 0,
		},
	},
	["isEnable"] =false,
	["scale"] ={
		[1] = 12.299957275391,
		[2] = 6.4299621582031,
		[3] = 1,
	},
	["geomType"] =2,
	["saveFile"] ="_scene_trader.lua",
	["isEnabledPhysics"] =false,

});
GameScene.createObject("traderWp01", "WayPointTemplate", {
	["tm"] ={
		[1] = 0.74942266941071,
		[2] = 0,
		[3] = 0.66209185123444,
		[4] = 0,
		[5] = 0.45130753517151,
		[6] = 0.73168879747391,
		[7] = -0.51083558797836,
		[8] = 0,
		[9] = -0.48444521427155,
		[10] = 0.68163883686066,
		[11] = 0.54834419488907,
		[12] = 0,
		[13] = -35.137065887451,
		[14] = -9.542407989502,
		[15] = -125.35855102539,
		[16] = 1,
	},
	["isGameStateSave"] =false,
	["events"] ={
	},
	["isEnable"] =true,
	["visualisationColor"] ={
		[1] = 1,
		[2] = 0,
		[3] = 0,
		[4] = 1,
	},
	["saveFile"] ="_scene_trader.lua",
	["needVisualization"] =false,

});
GameScene.createObject("traderWp02", "WayPointTemplate", {
	["tm"] ={
		[1] = -0.81735897064209,
		[2] = 0,
		[3] = -0.57612878084183,
		[4] = 0,
		[5] = -0.31089845299721,
		[6] = 0.84189993143082,
		[7] = 0.44107443094254,
		[8] = 0,
		[9] = 0.48504278063774,
		[10] = 0.53963369131088,
		[11] = -0.68813449144363,
		[12] = 0,
		[13] = -36.049083709717,
		[14] = -9.593939781189,
		[15] = -126.19417572021,
		[16] = 1,
	},
	["isGameStateSave"] =false,
	["events"] ={
	},
	["isEnable"] =false,
	["visualisationColor"] ={
		[1] = 1,
		[2] = 0,
		[3] = 0,
		[4] = 1,
	},
	["saveFile"] ="_scene_trader.lua",
	["needVisualization"] =false,

});
GameScene.createObject("traderWp03", "WayPointTemplate", {
	["tm"] ={
		[1] = -0.61311429738998,
		[2] = 0,
		[3] = -0.78999423980713,
		[4] = 0,
		[5] = -0.61882370710373,
		[6] = 0.62161004543304,
		[7] = 0.48026889562607,
		[8] = 0,
		[9] = 0.49106830358505,
		[10] = 0.78332686424255,
		[11] = -0.38111796975136,
		[12] = 0,
		[13] = -37.311420440674,
		[14] = -9.5804309844971,
		[15] = -126.33375549316,
		[16] = 1,
	},
	["isGameStateSave"] =false,
	["events"] ={
	},
	["isEnable"] =true,
	["visualisationColor"] ={
		[1] = 1,
		[2] = 0,
		[3] = 0,
		[4] = 1,
	},
	["saveFile"] ="_scene_trader.lua",
	["needVisualization"] =false,

});
GameScene.createObject("traderWp04", "WayPointTemplate", {
	["tm"] ={
		[1] = 0.92853260040283,
		[2] = 0,
		[3] = 0.37125086784363,
		[4] = 0,
		[5] = 0.22467578947544,
		[6] = 0.79608416557312,
		[7] = -0.56193482875824,
		[8] = 0,
		[9] = -0.29554694890976,
		[10] = 0.60518592596054,
		[11] = 0.73919010162354,
		[12] = 0,
		[13] = -39.157081604004,
		[14] = -9.5551433563232,
		[15] = -125.96932983398,
		[16] = 1,
	},
	["isGameStateSave"] =false,
	["events"] ={
		["onEnter"] ={
			[1] = "! other[1].data.io.wayDone = true; other[1]:setAim(avatar);",
			[2] = 0,
		},
	},
	["isEnable"] =true,
	["visualisationColor"] ={
		[1] = 1,
		[2] = 0,
		[3] = 0,
		[4] = 1,
	},
	["saveFile"] ="_scene_trader.lua",
	["needVisualization"] =false,

});
GameScene.createObject("trader", "CharacterMale", {
	["stats"] ={
		["mp"] =100,
		["maxSp"] =100,
		["maxHp"] =100,
		["hp"] =100,
		["maxMp"] =100,
	},
	["armorThickness"] =0,
	["isShadowCaster"] =true,
	["isDynamic"] =true,
	["items_name"] ={
	},
	["isEnabledPhysics"] =false,
	["thumbnail"] =9083,
	["enableBattlePhys"] =false,
	["tm"] ={
		[1] = 0.99947965145111,
		[2] = 0,
		[3] = 0.032256197184324,
		[4] = 0,
		[5] = 0,
		[6] = 1,
		[7] = 0,
		[8] = 0,
		[9] = -0.032256197184324,
		[10] = 0,
		[11] = 0.99947965145111,
		[12] = 0,
		[13] = -38.687652587891,
		[14] = -9.5582885742188,
		[15] = -126.09855651855,
		[16] = 1,
	},
	["necroVisionType"] =131072,
	["state"] ="normalState",
	["isGameStateSave"] =false,
	["hitBoxesFileName"] ="models/test/HitBoxes.hb.xml",
	["spawnPoint"] ={
		[1] = -38.687652587891,
		[2] = -9.5582885742188,
		[3] = -126.09855651855,
	},
	["ragDollFile"] ="xml/RagDoll.xml",
	["wayPointsType"] ="findByMask",
	["wayPointsMask"] ="traderWp",
	["saveFile"] ="_scene_trader.lua",
	["radiusAct"] =0,
	["bodyParts"] ={
		["beard"] ={
			["fileName"] ="models/70_humans/h33850_boroda/h3385_boroda.OBJ.XML",
			["preset"] =0,
		},
		["hair"] ={
			["fileName"] ="bald",
			["preset"] =0,
		},
		["head"] ={
			["fileName"] ="models/70_humans/h18700_human_male_head/h1870_m_round.OBJ.XML",
			["preset"] =2,
		},
	},
	["weapon"] ="infantry_sword",
	["isEnable"] =false,
	["slot"] ={
	},
	["radiusNotify"] =0,
	["visualFileName"] ="characters/NPC/blackmask_d_h_mp1.chr.xml",
	["isShown"] =false,
	["wayPoints"] ={
	},
	["isHitBoxesEnabled"] =false,
	["events"] ={
		["onSpawn"] ={
			[1] = "! if self.data.io.wayDone then return end; \
					self:setPosition(GO('traderWp01'):getPosition()); \
					self:moveByWP('disposable', true); \
					self:runMode(false);",
			[2] = 0,
		},
		["onDeath"] ={
			[1] = "! GO('traderBarrier1'):destroy(); \
							GO('traderBarrier2'):destroy(); ",
			[2] = 0,
		},
		["onUse"] ={
			[1] = "! self:startDialog()",
			[2] = 0,
		},
	},
	["hasBattlePhys"] =true,
	["radiusDeact"] =0,
	["io"] ={
	},
	["usePathFinder"] =true,
	["isAutoActivation"] =false,
	
	["sellItems"] = {
		"eastern_onehand",
		"elite_infantry_sword",
		"makhayra_onehand",
		"autBow",
		"Xbow_3",
		"fireArrow",
		"simpleBolt",
		"ter_armor",
		"ter_blue_armor",
		"ter_black_armor",
		"bardishe",
		"gryut_halberd",
		"cadet_suit2", -- магический костюм
	},
	["sellTypes"] = {
		"OneHandSword",
		"TwoHandSword",
		"Staff",
		"Bow",
		"Arrow",
		"Grenade",
		"Cloth"
	},
	["name"] ="TerTrader",
	["disallowedAttacks"] = {"bowAttack", "arbalestAttack"},
	["giveItemPrototype"] = "moneyBig",
});
