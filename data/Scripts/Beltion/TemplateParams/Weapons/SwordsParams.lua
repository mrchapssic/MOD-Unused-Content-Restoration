--[[/******************************************************************************
	File:	swordsParams.lua
	Desc:	 Описание характеристик мечей
	Copyright: (c) Rostok-Games 2007
	$Id: swordsParams.lua,v 1.6 2007/11/14 16:58:08 weba Exp $	
******************************************************************************/]]

------------------------------------------------------------------------------------------------------
-- Описание шаблонов готовых мечей
prototypes = prototypes and prototypes or {}

prototypes["onehandBase"] = {
	templateName = "OneHandSwordTemplate",
	dataReadOnly = {"speedLine"},	
	data = {tm = MATRIX_IDENTITY(),		
	hitBoxesFileName = "byBoundingBox",
	isShown = false,
	isEnable = false,
	isEnabledPhysics = false,
	["isGameStateSave"] = false,
	["isHitBoxesEnabled"] = false,
	["type"] = "OneHandSword",		
	speedLine = {"oneHandSword", "oneHandSwordYellow"},
	dontShowInEditor = true,
	}};	

prototypes["small_sword"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["small_sword"] ["data"], {
	visualFileName = "models/46_blades/w19460_rome_sword/w1946_rome_sword.OBJ.XML",		
	thumbnail = 12474,
	name = "ShortSword",
	stats = {damageAmount = 10},
	price = 50,
	});

prototypes["kit_knife1"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["kit_knife1"] ["data"], {
	visualFileName = "models/46_blades/w18440_nojkuhoniy01/w1844_nojkuhoniy01.OBJ.XML",		
	thumbnail = 23559,
	name = "KnifeKit",
	stats = {damageAmount = 4},
	price = 10,
	});	
	
prototypes["kit_knife2"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["kit_knife2"] ["data"], {
	visualFileName = "models/46_blades/w18440_nojkuhoniy02/w1844_nojkuhoniy02.OBJ.XML",		
	thumbnail = 23560,
	name = "Knife",
	stats = {damageAmount = 6},
	price = 15,
	});
	
prototypes["dagger1"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["dagger1"] ["data"], {
	visualFileName = "models/46_blades/w33440_kingal_ubica/w3344_kingal_ubica.OBJ.XML",		
	thumbnail = 24342,
	name = "Dagger1",
	stats = {damageAmount = 12},
	price = 15,
	});

prototypes["dagger2"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["dagger2"] ["data"], {
	visualFileName = "models/46_blades/w23440_kingal_tihaja_smer/w2344_kingal_tihaja_smer.OBJ.XML",		
	thumbnail = 24340,
	name = "Dagger2",
	stats = {damageAmount = 16},
	price = 40,
	});	

prototypes["dagger3"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["dagger3"] ["data"], {
	visualFileName = "models/46_blades/w12440_huntingknife/w1244_huntingknife.OBJ.XML",			
	thumbnail = 23558,
	name = "Dagger3",
	stats = {damageAmount = 23},
	price = 100,
	});	

prototypes["hunt_knife"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["hunt_knife"] ["data"], {
	visualFileName = "models/46_blades/w33440_kingal/w3344_kingal.OBJ.XML",		
	thumbnail = 24341,
	name = "HuntKnife",
	stats = {damageAmount = 30},
	price = 700,
	});
	
prototypes["axe"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["axe"] ["data"], {
	visualFileName = "models/47_axes/w12470_simpleaxe2/w1247_simpleaxe2.OBJ.XML",		
	thumbnail = 24212,
	name = "SimpleAxe",
	stats = {damageAmount = 8},
	price = 30,
	});		
	
prototypes["parlor_sword"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["parlor_sword"] ["data"], {
	visualFileName = "models/46_blades/w31460_korean_onehand/w3146_korean_onehand.OBJ.XML",			
	thumbnail = 12494,
	name = "ParlorSword",
	stats = {damageAmount = 12},
	price = 150,
	});		
	
prototypes["smeg's_sword"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["smeg's_sword"] ["data"], {
	visualFileName = "models/46_blades/w19460_boarding_sabre/w1946_boarding_sabre.OBJ.XML",			
	thumbnail = 12472,
	name = "RustySaber",
	stats = {damageAmount = 16},
	price = 25,
	});		
	
prototypes["salmon's_sword"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["salmon's_sword"] ["data"], {
	visualFileName = "models/46_blades/w33460_me4_odnoru4nii/w3346_me4_odnoru4nii3.OBJ.XML",	
	thumbnail = 22551,
	name = "BoardingSword",
	stats = {damageAmount = 20},
	price = 380,
	});		

prototypes["saber"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["saber"] ["data"], {
	visualFileName = "models/46_blades/w33460_me4_odnoru4nii/w3346_me4_odnoru4nii.OBJ.XML",			
	thumbnail = 22549,
	name = "CavSaber",	
	stats = {damageAmount = 15},
	speedLine = {"middleSword", "middleSwordYellow"},
	price = 225,
	});	

prototypes["long_sword"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["long_sword"] ["data"], {
	visualFileName = "models/46_blades/w19460_bastard/w1946_bastard.OBJ.XML",			
	thumbnail = 12471,
	name = "Longsword",
	stats = {damageAmount = 18},
	speedLine = {"longSword", "longSwordYellow"},	
	price = 100,
	});		
	
prototypes["infantry_sword"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["infantry_sword"] ["data"], {
	visualFileName = "models/46_blades/w33460_me4_odnoru4nii/w3346_me4_odnoru4nii2.OBJ.XML",			
	thumbnail = 22550,
	name = "InfantrySword",	
	stats = {damageAmount = 22},
	price = 300,
	});	
	
prototypes["eastern_onehand"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["eastern_onehand"] ["data"], {
	visualFileName = "models/46_blades/w31460_eastsabre_onehanded/w3146_eastsabre_onehanded.OBJ.XML",		
	thumbnail = 12492,
	name = "GryutSaber",	
	stats = {damageAmount = 25},
	speedLine = {"longSword", "longSwordYellow"},
	price = 600,
	});

prototypes["elite_infantry_sword"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["elite_infantry_sword"] ["data"], {
	visualFileName = "models/46_blades/w21460_alshpis_onehanded/w2146_alshpis_onehanded.OBJ.XML",
	thumbnail = 22547,
	name = "GuardSword",
	stats = {damageAmount = 28},
	price = 900,
	});

prototypes["dao1_onehand"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["dao1_onehand"] ["data"], {
	visualFileName = "models/46_blades/w31460_paldao1_onehanded/w3146_paldao1_onehanded.OBJ.XML",
	thumbnail = 12496,
	name = "GryutDao1",	
	stats = {damageAmount = 34},
	speedLine = {"middleSword", "middleSwordYellow"},
	price = 1400,
	});

prototypes["dao3_onehand"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["dao3_onehand"] ["data"], {
	visualFileName = "models/46_blades/w31460_dao3_onehanded/w3146_dao3_onehanded.OBJ.XML",
	thumbnail = 11173,
	name = "GryutDao3",	
	stats = {damageAmount = 48},
	speedLine = {"longSword", "longSwordYellow"},
	price = 3200,
	});

prototypes["hand_axe"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["hand_axe"] ["data"], {
	visualFileName = "models/47_axes/w20470_knightly_onehanded/w2047_knightly_onehanded.OBJ.XML",
	thumbnail = 22546,
	name = "HandAxe",	
	stats = {damageAmount = 25},
	price = 600,
	});

prototypes["elite_falchion"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["elite_falchion"] ["data"], {
	visualFileName = "models/46_blades/w21460_huntingknife_onehanded/w2146_huntingknife_onehanded.OBJ.XML",			
	thumbnail = 22548,
	name = "Falchion",	
	stats = {damageAmount = 30},
	speedLine = {"middleSword", "middleSwordYellow"},		
	price = 1000,
	});

prototypes["officer_sword"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["officer_sword"] ["data"], {
	visualFileName = "models/46_blades/w19460_palash/w1946_palash.OBJ.XML",
	thumbnail = 12473,
	name = "Broadsword",
	stats = {damageAmount = 45},
	speedLine = {"middleSword", "middleSwordYellow"},
	price = 3000,
	});	
	
prototypes["elite_marine_sword"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["elite_marine_sword"] ["data"], {
	visualFileName = "models/46_blades/w18460_sablya_onehanded/w1846_sablya_onehanded.OBJ.XML",
	thumbnail = 11169,
	name = "EliteSaber",
	stats = {damageAmount = 55},
	speedLine = {"longSword", "longSwordYellow"},	
	price = 5000,
	});	

prototypes["makhayra_onehand"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["makhayra_onehand"] ["data"], {
	visualFileName = "models/46_blades/w31460_makhayra_onehanded/w3146_makhayra_onehanded.OBJ.XML",
	thumbnail = 12495,
	name = "TerSaber",
	stats = {damageAmount = 35},
	price = 1800,
	});	

prototypes["feon_sword"] = DuplicateTable(prototypes["onehandBase"]);
utils.merge(prototypes["feon_sword"] ["data"], {
	visualFileName = "models/46_blades/w23440_kingal_hram-gizni/w2344_kingal_hram-gizni.OBJ.XML",
	thumbnail = 23561,
	name = "feonSword",
	stats = {damageAmount = 10},
	});	

--------------------------- ДВУРУЧНОЕ ОРУЖИЕ
prototypes["twohandBase"] = {
	templateName = "SwordTemplate",
	dataReadOnly = {"speedLine"},	
	data = {tm = MATRIX_IDENTITY(),		
	hitBoxesFileName = "byBoundingBox",
	isShown = false,
	isEnable = false,
	isEnabledPhysics = false,
	["isGameStateSave"] = false,
	["isHitBoxesEnabled"] = false,
	["type"] = "TwoHandSword",		
	dontShowInEditor = true,
	speedLine = {"twoHandSword", "twoHandSword"},
	}};	

prototypes["smeg's_club"] = DuplicateTable(prototypes["twohandBase"]);
utils.merge(prototypes["smeg's_club"] ["data"], {
	visualFileName = "models/48_hammers/w23480_shipovanayadubinka/w2348_shipovanayadubinka.OBJ.XML",
	thumbnail = 12541,
	name = "Hedgehog",
	stats = {damageAmount = 12},
	price = 60,
	});

prototypes["godendag"] = DuplicateTable(prototypes["twohandBase"]);
utils.merge(prototypes["godendag"] ["data"], {
	visualFileName = "models/48_hammers/w23480_godendag/w2348_godendag.OBJ.XML",
	thumbnail = 12540,
	name = "Hedgehog",
	stats = {damageAmount = 15},
	price = 150,
	});	

prototypes["hunting_sword"] = DuplicateTable(prototypes["twohandBase"]);
utils.merge(prototypes["hunting_sword"] ["data"], {
	visualFileName = "models/46_blades/w21460_huntingsword/w2146_huntingsword.OBJ.XML",	
	thumbnail = 12488,
	name = "HuntingSword",
	stats = {damageAmount = 85},
	price = 500,
	});	

prototypes["dao5"] = DuplicateTable(prototypes["twohandBase"]);
utils.merge(prototypes["dao5"] ["data"], {
	visualFileName = "models/46_blades/w31460_dao5/w3146_dao5.OBJ.XML",	
	thumbnail = 12491,
	name = "Dao5Rings",
	stats = {damageAmount = 69},
	price = 7000,
	});

prototypes["knight_axe"] = DuplicateTable(prototypes["twohandBase"]);
utils.merge(prototypes["knight_axe"] ["data"], {
	visualFileName = "models/47_axes/w20470_knightly/w2047_knightly.OBJ.XML",	
	thumbnail = 12479,
	name = "KnightAxe",
	stats = {damageAmount = 30},
	price = 1400,
	});		

prototypes["vouge"] = DuplicateTable(prototypes["twohandBase"]);
utils.merge(prototypes["vouge"] ["data"], {
	visualFileName = "models/46_blades/w20460_vuzh/w2046_vuzh.OBJ.XML",	
	thumbSmall = 24750,
	thumbnail = 12477,
	name = "Vouge",
	stats = {damageAmount = 33},
	price = 1000,
	});	

prototypes["twohand_sword"] = DuplicateTable(prototypes["twohandBase"]);
utils.merge(prototypes["twohand_sword"] ["data"], {
	visualFileName = "models/46_blades/w19460_espadon/w1946_espadon.obj.xml",
	thumbSmall = 24743,
	thumbnail = 11168,
	name = "TwoHandedSword",
	stats = {damageAmount = 20},
	price = 600,
	});
	
prototypes["alshpis"] = DuplicateTable(prototypes["twohandBase"]);
utils.merge(prototypes["alshpis"] ["data"], {
	visualFileName = "models/46_blades/w21460_alshpis/w2146_alshpis.OBJ.XML",
	thumbSmall = 24744,
	thumbnail = 12486,
	name = "Alshpis",
	stats = {damageAmount = 28},
	price = 900,
	speedLine = "twoHandSword",	
	});
	
prototypes["footman_sword"] = DuplicateTable(prototypes["twohandBase"]);
utils.merge(prototypes["footman_sword"] ["data"], {
	visualFileName = "models/46_blades/w20460_swordinfantry/w2046_swordinfantry.OBJ.XML",
	thumbSmall = 24749,
	thumbnail = 12476,
	name = "FootmansSword",
	stats = {damageAmount = 36},
	price = 1600,
	});
	
prototypes["espadon"] = DuplicateTable(prototypes["twohandBase"]);
utils.merge(prototypes["espadon"] ["data"], {
	visualFileName = "models/46_blades/w31460_espadon/w3146_espadon.OBJ.XML",
	thumbSmall = 24746,
	thumbnail = 24215,
	name = "Espadon",
	stats = {damageAmount = 44},
	price = 2500,
	});		

prototypes["claymore"] = DuplicateTable(prototypes["twohandBase"]);
utils.merge(prototypes["claymore"] ["data"], {
	visualFileName = "models/46_blades/w31460_claymore/w3146_claymore.OBJ.XML",	
	thumbSmall = 24745,
	thumbnail = 11170,
	name = "Claymore",
	stats = {damageAmount = 52},
	price = 4000,
	});	

prototypes["flamberge"] = DuplicateTable(prototypes["twohandBase"]);
utils.merge(prototypes["flamberge"] ["data"], {
	visualFileName = "models/46_blades/w31460_flamberg/w3146_flamberg.OBJ.XML",	
	thumbSmall = 24747,
	thumbnail = 11171,
	name = "Flamberge",
	stats = {damageAmount = 60},
	price = 5500,
	});	

prototypes["good_hammer"] = DuplicateTable(prototypes["twohandBase"]);
utils.merge(prototypes["good_hammer"] ["data"], {
	visualFileName = "models/48_hammers/w20480_good/w2048_good.OBJ.XML",
	thumbnail = 12484,
	name = "BronzeHammer",
	stats = {damageAmount = 28},
	price = 1000,
	speedLine = nil,
	shakerName = "HammerShaker",
	splashDamage = {
		damageAmount = 20,
		splashRadius = 1.5,
		impulse = 160,
		contusionDuration = 2,
		},
	});	

prototypes["evil_hammer"] = DuplicateTable(prototypes["twohandBase"]);
utils.merge(prototypes["evil_hammer"] ["data"], {
	visualFileName = "models/48_hammers/w20480_evilhammer/w2048_evilhammer.OBJ.XML",
	thumbnail = 12483,
	name = "SteelHammer",
	stats = {damageAmount = 64},
	price = 5500,
	speedLine = nil,
	shakerName = "HammerShaker",
	splashDamage = {
		damageAmount = 25,
		splashRadius = 2,
		impulse = 250,
		contusionDuration = 5,
		},
	});	

prototypes["krys2h"] = DuplicateTable(prototypes["twohandBase"]);
utils.merge(prototypes["krys2h"] ["data"], {
	visualFileName = "models/46_blades/w20460_krys/w2046_krys.OBJ.XML",	
	thumbSmall = 24748,
	thumbnail = 11172,
	name = "TwoHandedKrys",
	stats = {damageAmount = 100},
	["effectName"] ="steelSkinEffect",
	});	

--------------------- АЛЕБАРДЫ

prototypes["halberd"] = {
	templateName = "SwordTemplate", 
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/47_axes/w20470_axetwocres_aleb/w2047_axetwocres_aleb.OBJ.XML",			
				hitBoxesFileName = "byBoundingBox",
				thumbnail = 12478,
				name = "GuardHalberd",
				isShown = false,
				isEnable = false,
				isEnabledPhysics = false,
				["isGameStateSave"] = false,
				["isHitBoxesEnabled"] = false,
				["type"] = "TwoHandSword",		
				stats = {damageAmount = 50},
				price = 4800,
				dontShowInEditor = true,
			}};

prototypes["poleaxe_halberd"] = {
	templateName = "SwordTemplate", 
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/47_axes/w21470_sekira_aleb/w2147_sekira_aleb.OBJ.XML",			
				hitBoxesFileName = "byBoundingBox",
				thumbnail = 9182,
				name = "PoleaxeHalberd",
				isShown = false,
				isEnable = false,
				isEnabledPhysics = false,
				["isGameStateSave"] = false,
				["isHitBoxesEnabled"] = false,
				["type"] = "TwoHandSword",		
				stats = {damageAmount = 110},
				price = 10000,
				dontShowInEditor = true,
			}};

prototypes["gryut_halberd"] = {
	templateName = "SwordTemplate", 
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/47_axes/w31470_dao3_aleb/w3147_dao3_aleb.OBJ.XML",
				hitBoxesFileName = "byBoundingBox",
				thumbnail = 9186,
				name = "GryutHalberd",
				isShown = false,
				isEnable = false,
				isEnabledPhysics = false,
				["isGameStateSave"] = false,
				["isHitBoxesEnabled"] = false,
				["type"] = "TwoHandSword",		
				stats = {damageAmount = 75},
				price = 6500,
				dontShowInEditor = true,
			}};

prototypes["bardishe"] = {
	templateName = "SwordTemplate", 
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/47_axes/w31470_maillot_aleb/w3147_maillot_aleb.OBJ.XML",
				hitBoxesFileName = "byBoundingBox",
				thumbnail = 9188,
				name = "Bardishe",
				isShown = false,
				isEnable = false,
				isEnabledPhysics = false,
				["isGameStateSave"] = false,
				["isHitBoxesEnabled"] = false,
				["type"] = "TwoHandSword",		
				stats = {damageAmount = 70},
				price = 6500,
				dontShowInEditor = true,
			}};
			
prototypes["it_halberd"] = {
	templateName = "SwordTemplate", 
	data = {tm = MATRIX_IDENTITY(),
			visualFileName = "models/47_axes/w20470_twosided_aleb/w2047_twosided_aleb.OBJ.XML",			
			hitBoxesFileName = "byBoundingBox",
				thumbnail = 16991,
				name = "it_halberd",
				isShown = false,
				isEnable = false,
				isEnabledPhysics = false,
				["isGameStateSave"] = false,
				["isHitBoxesEnabled"] = false,
				["type"] = "TwoHandSword",		
				stats = {damageAmount = 100},
				price = 9500,
				dontShowInEditor = true,
			}};
			
prototypes["protazan"] = {
	templateName = "SwordTemplate", 
	data = {tm = MATRIX_IDENTITY(),
			visualFileName = "models/47_axes/w31470_spear4el_aleb/w3147_spear4el_aleb.OBJ.XML",			
			hitBoxesFileName = "byBoundingBox",
				thumbnail = 10960,
				name = "protazan",
				isShown = false,
				isEnable = false,
				isEnabledPhysics = false,
				["isGameStateSave"] = false,
				["isHitBoxesEnabled"] = false,
				["type"] = "TwoHandSword",		
				stats = {damageAmount = 95},
				price = 8900,
				dontShowInEditor = true,
			}};