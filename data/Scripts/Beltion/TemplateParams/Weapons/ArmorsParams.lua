--[[/******************************************************************************
	File:	bottleParams.lua
	Desc:	 Описание характеристик доспехов
	Copyright: (c) Rostok-Games 2007
	$Id: armorsParams.lua,v 1.5 2007/10/25 14:46:53 weba Exp $	
******************************************************************************/]]
-- Описание шаблонов доспехов и костюмов
prototypes = prototypes and prototypes or {}

globalResistsTable = globalResistsTable and globalResistsTable or {}
globalResistsTable["SaitagRadagarna"] = {melee = 0.8, byArrow = 0.5, explosion = 0.5}
globalResistsTable["SaitagBeltion"] = {melee = 0.95, byArrow = 0.95, explosion = 0.95}

globalResistsTable["Sonn"] = {}
globalResistsTable["Gieron"] = {}

globalResistsTable["Makuta"] = {}
globalResistsTable["Udinna"] = {}
globalResistsTable["Fork"] = {}
globalResistsTable["Hunuber"] = {}
globalResistsTable["Semelvenk"] = {}
globalResistsTable["Belga"] = {}

prototypes["armorBase"] = {
	templateName = "Cloth",
	data = {tm = MATRIX_IDENTITY(),
	visualFileName = "models/03_decorations/f23030_vimpel/f2303_vimpel.OBJ.XML",
	thumbnail = 23641,
	name = nil,
	isShown = false,
	isEnable = false,
	isEnabledPhysics = false,
	["isGameStateSave"] = false,
	["isHitBoxesEnabled"] = false,
	["type"] = "Cloth",
	clothFilename = nil,
	clothPreset = 0,
	resists = {melee = 0, byArrow = 0, claws = 0, explosion = 0},
	dontShowInEditor = true,
		}};	
		
prototypes["topless"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["topless"] ["data"], {
	thumbnail = 23641,
	name = "NoSuit",
	price = 0,
	clothFilename = "models/85_characters/h33850_matros/h3385_matros.OBJ.XML",
	clothPreset = 0,
	});
		
prototypes["cadet_suit"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["cadet_suit"] ["data"], {
	thumbnail = 20052,
	name = "CadetSuit",
	price = 30,
	clothFilename = "models/85_characters/h20850_lightleather_assmag/h2085_lightleather_assmag.OBJ.XML",
	clothPreset = 0,
	resists = {melee = .1, byArrow = .1, claws = .1, explosion = 0},	
	});

prototypes["official_suit"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["official_suit"] ["data"], {
	thumbnail = 17715,
	name = "OfficialSuit",
	price = 30,
	clothFilename = "models/85_characters/h18850_staff_bh/h1885_staff_bh.OBJ.XML",
	clothPreset = 5,
	});
		
prototypes["trader_suit"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["trader_suit"] ["data"], {
	thumbnail = 23621,
	name = "TraderSuit",
	price = 120,
	clothFilename = "models/85_characters/h18850_staff_th/h1885_staff_th.OBJ.XML",
	clothPreset = 1,
	});
	
prototypes["clerk_suit"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["clerk_suit"] ["data"], {
	thumbnail = 23940,
	name = "ClerkSuit",
	price = 50,
	clothFilename = "models/85_characters/h18850_staff_tn/h1885_staff_tn.OBJ.XML",
	clothPreset = 4,
	});	
	
prototypes["citizen_suit"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["citizen_suit"] ["data"], {
	thumbnail = 17716,
	name = "CitizenSuit",
	price = 80,
	clothFilename = "models/85_characters/h18850_staff_th/h1885_staff_th.OBJ.XML",
	clothPreset = 0,
	});	
	
prototypes["fop_suit"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["fop_suit"] ["data"], {
	thumbnail = 23941,
	name = "FopSuit",
	price = 200,
	clothFilename = "models/85_characters/h18850_staff_sk/h1885_staff_sk.OBJ.XML",
	clothPreset = 9,
	});	
	
prototypes["rider_suit"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["rider_suit"] ["data"], {
	thumbnail = 23942,
	name = "RiderSuit",
	price = 150,
	clothFilename = "models/85_characters/h18850_staff_sh/h1885_staff_sh.OBJ.XML",
	clothPreset = 6,
	});		
	
prototypes["beggar_suit"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["beggar_suit"] ["data"], {
	thumbnail = 23939,
	name = "BeggarSuit",
	price = 300,
	clothFilename = "models/85_characters/c33120_krestyanin/h3385_krestyanin.OBJ.XML",
	clothPreset = 1,
	});
	
prototypes["hides"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["hides"] ["data"], {
	thumbnail = 23630,
	name = "RawHides",
	price = 25,
	clothFilename = "models/85_characters/h33850_smeg/h3385_smeg.OBJ.XML",
	clothPreset = 0,
	resists = {melee = .15, byArrow = 0, claws = 0, explosion = 0},
	});
		
prototypes["leather_breast"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["leather_breast"] ["data"], {
	thumbnail = 23638,
	name = "Leather",
	price = 250,
	clothFilename = "models/85_characters/h20850_kozhaniydospeh/h2085_kozhaniydospeh.OBJ.XML",
	clothPreset = 0,
	resists = {melee = .15, byArrow = .1, claws = .15, explosion = 0},
	});
		
prototypes["salmon_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["salmon_armor"] ["data"], {
	thumbnail = 23642,
	name = "SalmonSailor",
	price = 250,
	clothFilename = "models/85_characters/h33850_ryadovoi_Losos/h3385_ryadovoi_Losos.OBJ.XML",
	clothPreset = 0,
	helmFilename = "models/85_characters/h33850_ryadovoi_Losos/h3385_ryadovoi_Losos_hlm.OBJ.XML",
	helmPreset = 0,
	resists = {melee = .25, byArrow = .1, claws = .1, explosion = .25},
	});	

prototypes["bowman_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["bowman_armor"] ["data"], {
	thumbnail = 23640,
	name = "SalmonBowman",
	price = 300,
	clothFilename = "models/85_characters/h33850_lu4nik/h3385_lu4nik.OBJ.XML",
	clothPreset = 5,
	helmFilename = "none",
	helmPreset = 0,
	resists = {melee = .15, byArrow = .2, claws = .1, explosion = .15},
	});

prototypes["ter_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["ter_armor"] ["data"], {
	thumbnail = 23618,
	name = "TerArmor",
	price = 300,
	clothFilename = "models/85_characters/h18850_blackmask/h1885_blackmask.OBJ.XML",
	clothPreset = 0,
	resists = {melee = .2, byArrow = .2, claws = .2, explosion = .2},
	});
	
prototypes["quest_ter_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["quest_ter_armor"] ["data"], {
	thumbnail = 23618,
	name = "TerArmor",
	clothFilename = "models/85_characters/h18850_blackmask/h1885_blackmask.OBJ.XML",
	clothPreset = 0,
	resists = {melee = .2, byArrow = .2, claws = .2, explosion = .2},
	cannotEquip=true,
	});	
		
prototypes["guard_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["guard_armor"] ["data"], {
	thumbnail = 23635,
	name = "GuardArmor",
	price = 350,
	clothFilename = "models/85_characters/h20850_hermitarmor/h2085_hermitarmor.OBJ.XML",
	clothPreset = 0,
	helmFilename = "models/85_characters/h20850_temnayabronya/h2085_temnayabronya_hlm.OBJ.XML",
	helmPreset = 0,	
	resists = {melee = .2, byArrow = .2, claws = .05, explosion = .1},
	});

prototypes["chainmail"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["chainmail"] ["data"], {
	thumbnail = 23637,
	name = "GaerayanChainmail",
	price = 800,
	clothFilename = "models/85_characters/h20850_kolchuzhniydospeh/h2085_kolchuzhniydospeh.OBJ.XML",
	clothPreset = 5,
	resists = {melee = .2, byArrow = .2, claws = .6, explosion = 0},
	});
		
prototypes["ter_cavalry"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["ter_cavalry"] ["data"], {
	thumbnail = 23631,
	name = "TerCavalry",
	price = 800,
	clothFilename = "models/85_characters/h18850_zertsalo/h1885_zertsalo.OBJ.XML",
	clothPreset = 0,
	helmFilename = "models/85_characters/h18850_zertsalo/h1885_zertsalo_hlm.OBJ.XML",
	helmPreset = 0,
	resists = {melee = .25, byArrow = .15, claws = .25, explosion = .25},
	});

prototypes["ter_blue_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["ter_blue_armor"] ["data"], {
	thumbnail = 23619,
	name = "TerBlueArmor",
	price = 700,
	clothFilename = "models/85_characters/h18850_blackmask/h1885_blackmask.OBJ.XML",
	clothPreset = 1,
	helmFilename = "models/85_characters/h18850_blackmask/h1885_blackmask_hlm.OBJ.XML",
	helmPreset = 1,	
	resists = {melee = .3, byArrow = .3, claws = .3, explosion = .3},
	});
	
prototypes["quest_blue_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["quest_blue_armor"] ["data"], {
	thumbnail = 23619,
	name = "TerBlueArmor",
	clothFilename = "models/85_characters/h18850_blackmask/h1885_blackmask.OBJ.XML",
	clothPreset = 1,
	resists = {melee = .3, byArrow = .3, claws = .3, explosion = .3},
	cannotEquip =true,
	});	

prototypes["ter_command_cavalry"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["ter_command_cavalry"] ["data"], {
	thumbnail = 23632,
	name = "TerCommandCavalry",
	price = 2300,
	clothFilename = "models/85_characters/h18850_zertsalo/h1885_zertsalo.OBJ.XML",
	clothPreset = 1,
	helmFilename = "models/85_characters/h18850_zertsalo/h1885_zertsalo_hlm.OBJ.XML",
	helmPreset = 1,
	resists = {melee = .45, byArrow = .45, claws = .35, explosion = .45},
	});
		
prototypes["erm_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["erm_armor"] ["data"], {
	thumbnail = 23634,
	name = "ErmSavann",
	price = 750,
	clothFilename = "models/85_characters/h20850_erm_savan/h2085_erm_savan.OBJ.XML",
	clothPreset = 0,		
	helmFilename = "models/85_characters/h20850_temnayabronya/h2085_temnayabronya_hlm.OBJ.XML",
	helmPreset = 1,		
	resists = {melee = .3, byArrow = .25, claws = .2, explosion = .2, fireball = .1},
	});
		
prototypes["salmonOff_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["salmonOff_armor"] ["data"], {
	thumbnail = 23644,
	name = "SalmonCommander",
	price = 1000,
	clothFilename = "models/85_characters/h20850_cuirass/h2085_cuirass.OBJ.XML",
	clothPreset = 0,		
	helmFilename = "models/85_characters/h33850_ryadovoi_Losos/h3385_ryadovoi_Losos_hlm.OBJ.XML",
	helmPreset = 0,		
	resists = {melee = .35, byArrow = .3, claws = .3, explosion = .25},
	});	

prototypes["guard_officer_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["guard_officer_armor"] ["data"], {
	thumbnail = 23636,
	name = "GuardOfficerArmor",
	price = 1500,
	clothFilename = "models/85_characters/h20850_hermitarmor/h2085_hermitarmor.OBJ.XML",
	clothPreset = 1,
	helmFilename = "models/85_characters/h20850_temnayabronya/h2085_temnayabronya_hlm.OBJ.XML",
	helmPreset = 2,	
	resists = {melee = .4, byArrow = .3, claws = .35, explosion = .25},
	});	
	
prototypes["cuirass"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["cuirass"] ["data"], {
	thumbnail = 23633,
	name = "GaerayanCuirass",
	price = 3300,
	clothFilename = "models/85_characters/h20850_brongnomraboty/h2085_brongnomraboty.OBJ.XML",
	clothPreset = 5,
	resists = {melee = .4, byArrow = .5, claws = .5, explosion = .5},
	});	

prototypes["salmonCap_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["salmonCap_armor"] ["data"], {
	thumbnail = 23643,
	name = "SalmonCaptain",
	price = 4500,
	clothFilename = "models/85_characters/h23850_goluboilosos/h2385_goluboilosos.OBJ.XML",
	clothPreset = 0,		
	helmFilename = "models/85_characters/h23850_goluboilosos/h2385_goluboilosos_hlm.OBJ.XML",
	helmPreset = 0,		
	resists = {melee = .6, byArrow = .5, claws = .5, explosion = .4},
	});
	
	
prototypes["ancestor_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["ancestor_armor"] ["data"], {
	thumbnail = 23617,
	name = "AncestorArmor",
	price = 5000,
	clothFilename = "models/85_characters/h20850_latniydospeh/h2085_latniydospeh.OBJ.XML",
	clothPreset = 0,		
	helmFilename = "models/85_characters/h20850_latniydospeh/h2085_latniydospeh_hlm.OBJ.XML",
	helmPreset = 0,		
	resists = {melee = .4, byArrow = .5, claws = .7, explosion = .8, fireball = .6},
	});
	
prototypes["rah_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["rah_armor"] ["data"], {
	thumbnail = 23639,
	name = "RahSavann",
	price = 7000,
	clothFilename = "models/85_characters/h20850_rah_savan/h2085_rah_savan.OBJ.XML",
	clothPreset = 0,		
	helmFilename = "models/85_characters/h20850_temnayabronya/h2085_temnayabronya_hlm.OBJ.XML",
	helmPreset = 1,		
	resists = {melee = .7, byArrow = .7, claws = .6, explosion = .6, fireball = .4},
	});
		

prototypes["it_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["it_armor"] ["data"], {
	thumbnail = 11300,
	name = "ItArmor",
	price = 4500,
	clothFilename = "models/85_characters/h20850_temnayabronya/h2085_temnayabronya.OBJ.XML",
	clothPreset = 2,	
	resists = {melee = .5, byArrow = .5, claws = .9, explosion = .7},
	});


prototypes["ter_black_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["ter_black_armor"] ["data"], {
	thumbnail = 23620,
	name = "TerBlackArmor",
	price = 2600,
	clothFilename = "models/85_characters/h18850_blackmask/h1885_blackmask.OBJ.XML",
	clothPreset = 2,
	helmFilename = "models/85_characters/h18850_blackmask/h1885_blackmask_hlm.OBJ.XML",
	helmPreset = 2,		
	resists = {melee = .5, byArrow = .4, claws = .6, explosion = .6, fireball = .2},
	});


prototypes["cadet_suit2"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["cadet_suit2"] ["data"], {
	thumbnail = 5850,
	name = "CadetSuit2",
	price = 5000,
	clothFilename = "models/85_characters/h20850_lightleather_assmag/h2085_lightleather_assmag.OBJ.XML",
	clothPreset = 1,
	resists = {melee = .2, byArrow = .9, claws = .2, explosion = .9, fireball = .9},	
	});


prototypes["cadet_suit3"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["cadet_suit3"] ["data"], {
	thumbnail = 10072,
	name = "CadetSuit3",
	price = 1000,
	clothFilename = "models/85_characters/h20850_lightleather_assmag/h2085_lightleather_assmag.OBJ.XML",
	clothPreset = 2,
	resists = {melee = .2, byArrow = .1, claws = .4, explosion = 0},	
	});
	

prototypes["it_armor2"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["it_armor2"] ["data"], {
	thumbnail = 14683,
	name = "ItArmor2",
	price = 5500,
	clothFilename = "models/85_characters/h20850_temnayabronya/h2085_temnayabronya.OBJ.XML",
	clothPreset = 0,
	helmFilename = "models/85_characters/h20850_temnayabronya/h2085_temnayabronya_horns_x_hlm.OBJ.XML",
	helmPreset = 0,	
	resists = {melee = .5, byArrow = .6, claws = .9, explosion = .8},
	});
	
	
prototypes["it_armor3"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["it_armor3"] ["data"], {
	thumbnail = 8854,
	name = "ItArmor3",
	price = 5500,
	clothFilename = "models/85_characters/h20850_temnayabronya/h2085_temnayabronya.OBJ.XML",
	clothPreset = 2,
	helmFilename = "models/85_characters/h20850_temnayabronya/h2085_temnayabronya_horns_x_hlm.OBJ.XML",
	helmPreset = 2,	
	resists = {melee = .5, byArrow = .6, claws = .9, explosion = .8},
	});
	
	
prototypes["arrom_armor"] = DuplicateTable(prototypes["armorBase"]);
utils.merge(prototypes["arrom_armor"] ["data"], {
	thumbnail = 11835,
	name = "arromarmor",
	price = 7500,
	clothFilename = "models/85_characters/h20850_erm_savan/h2085_erm_savan.OBJ.XML",
	clothPreset = 1,			
	resists = {melee = .4, byArrow = .3, claws = .3, explosion = .5, fireball = .9},
	});
	
