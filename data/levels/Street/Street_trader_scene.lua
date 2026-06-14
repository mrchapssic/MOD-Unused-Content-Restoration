GameScene.createObject("Barrels_group44", "VisualGameObject", {
	["tm"] ={
		[1] = 0.98191064596176,
		[2] = 0,
		[3] = 0.18934501707554,
		[4] = 0,
		[5] = 0,
		[6] = 1,
		[7] = 0,
		[8] = 0,
		[9] = -0.18934501707554,
		[10] = 0,
		[11] = 0.98191064596176,
		[12] = 0,
		[13] = -1.1035772562027,
		[14] = -44.449550628662,
		[15] = 136.38293457031,
		[16] = 1,
	},
	["prototypeName"] ="Barrels_group",
	["visualFileName"] ="models/03_decorations/f2203_bochki.OBJ.XML",
	["isShown"] =true,
	["isDynamic"] =true,
	["isGameStateSave"] =false,
	["events"] ={
	},
	["isEnabledPhysics"] =true,
	["isStaticAmbient"] =false,
	["isShadowCaster"] =true,
	["isHitBoxesEnabled"] =false,
	["isEnable"] =true,

});

GameScene.createObject("ClothesTrader", "CharacterMale", {
	["stats"] ={
		["spRegeneration"] =1,
		["sp"] =100,
		["hp"] =100,
		["maxHp"] =100,
	},
	["armorThickness"] =0,
	["isShadowCaster"] =true,
	["isStaticAmbient"] =false,
	["items_name"] ={
	},
	["isEnabledPhysics"] =true,
	["thumbnail"] =9083,
	["tm"] ={
		[1] = -0.97693800926208,
		[2] = 0,
		[3] = 0.21352328360081,
		[4] = 0,
		[5] = 0,
		[6] = 1,
		[7] = -0,
		[8] = 0,
		[9] = -0.21352328360081,
		[10] = -0,
		[11] = -0.97693800926208,
		[12] = 0,
		[13] = -1.2104268074036,
		[14] = -44.921142578125,
		[15] = 137.86477661133,
		[16] = 1,
	},
	["state"] ="normalState",
	["io"] ={
		["dialogName"] ="Side_ClothesTrader3",
	},
	["name"] ="ClothesTrader",
	["sellTypes"] ={
		[1] = "Bow",
		[2] = "Arrow",
		
	},
	["hitBoxesFileName"] ="models/test/HitBoxes.hb.xml",
	["spawnPoint"] ={
		[1] = -1.2104268074036,
		[2] = -44.921142578125,
		[3] = 137.86477661133,
	},
	["isEnable"] =true,
	["visualFileName"] ="characters/NPC/lightleatherarmor_d_h_mp0.chr.xml",
	["isGameStateSave"] =false,
	["sellItems"] ={
		"Xbow_2", -- легкий  самострел 
		"Xbow_3", -- тернаунский малый самострел
		"autBow", -- Аютский лук
		"longbow", -- Тисовый лук 
		"Xbow_1", -- примитивный самострел
		"hvy_Xbow", -- тяжелый самострел
		"simpleArrow",
		"fireArrow",
		"smokeArrow",
		"explosiveArrow",
		"singingArrow",
		"simpleBolt",
		"fireBolt",
		"explosiveBolt",
		"hides",
		"leather_breast",
		"topless",
		"bullet",
		"roundOfSmallShot",
		
	},
	["radiusAct"] =0,
	["bodyParts"] ={
		["hair"] ={
			["fileName"] ="models/70_humans/h23700_hair_m3/h2370_hair_m3.OBJ.XML",
			["preset"] =1,
		},
		["head"] ={
			["fileName"] ="models/70_humans/h18700_human_male_head/h1870_m_slim.OBJ.XML",
			["preset"] =2,
		},
	},
	["prototypeName"] ="Human/Civilians/Midclass",
	["currentIdle"] ="idle01",
	["slot"] ={
	},
	["radiusNotify"] =0,
	["hasBattlePhys"] =false,
	["isShown"] =true,
	["actions"] ={
	},
	["isDynamic"] =true,
	["isHitBoxesEnabled"] =false,
	["usePathFinder"] =true,
	["events"] ={
		["onUse"] ={
			[1] = "! self:startDialog()",
			[2] = 0,
		},
	},
	["radiusDeact"] =0,
	["cantMove"] =false,
	["isAutoActivation"] =false,

});
