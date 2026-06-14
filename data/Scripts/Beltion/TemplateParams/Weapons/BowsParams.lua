--[[/******************************************************************************
	File:	swordsParams.lua
	Desc:	 Описание характеристик мечей
	Copyright: (c) Rostok-Games 2007
	$Id: swordsParams.lua,v 1.6 2007/11/14 16:58:08 weba Exp $	
******************************************************************************/]]

------------------------------------------------------------------------------------------------------
-- Описание шаблонов готовых мечей
prototypes = prototypes and prototypes or {}

prototypes["bow"] = {
	templateName = "BowTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/50_arbalets/w12500_simple_bow/w1250_simple_bow.obj.xml",
				thumbSmall = 24344,
				thumbnail = 16883,
				isShown = false,
				name = "SimpleBow",
				isEnable = false,
				["isGameStateSave"] =false,
				isEnabledPhysics = true,
				["weaponType"]= "Bow", 
				["type"] = "Bow",	
				stats = {damageAmount = 5},
				price = 50,
				dontShowInEditor = true,
			}};

prototypes["longbow"] = {
	templateName = "BowTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/50_arbalets/w12500_simple_bow/w1250_long_bow.obj.xml",
				thumbSmall = 24344,
				thumbnail = 16883,
				isShown = false,
				name = "LongBow",
				isEnable = false,
				["isGameStateSave"] =false,
				isEnabledPhysics = true,
				["weaponType"]= "Bow", 
				["type"] = "Bow",	
				stats = {damageAmount = 100},
				price = 10000,
				dontShowInEditor = true,
			}};
			
prototypes["salmonsBow"] = {
	templateName = "BowTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/50_arbalets/w18500_salmon_bow/w1850_salmon_bow.obj.xml",
				thumbSmall = 24752,
				thumbnail = 24214,
				isShown = false,
				name = "SalmonsBow",
				isEnable = false,
				["isGameStateSave"] =false,
				isEnabledPhysics = true,
				["weaponType"]= "Bow", 
				["type"] = "Bow",	
				stats = {damageAmount = 35},
				velocityCoef = 1.5,
				price = 600,
				dontShowInEditor = true,
			}};

prototypes["autBow"] = {
	templateName = "BowTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/50_arbalets/w18500_ayut_bow/w1850_ayut_bow.obj.xml",
				thumbSmall = 24751,
				thumbnail = 24213,
				isShown = false,
				name = "AyutBow",
				isEnable = false,
				["isGameStateSave"] =false,
				isEnabledPhysics = true,
				["weaponType"]= "Bow", 
				["type"] = "Bow",	
				stats = {damageAmount = 60},
				price = 2000,
				velocityCoef = 2, 
				dontShowInEditor = true,
			}};			

			
prototypes["Xbow_1"] = {
	templateName = "ArbalestTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/50_arbalets/w23500_primitivniysamostrel/w2350_primitivniysamostrel.OBJ.XML",	
				thumbSmall = 24758,
				thumbnail = 12545,
				isShown = false,
				name = "SimpleArbalest",
				isEnable = false,
				["isGameStateSave"] =false,
				isEnabledPhysics = true,
				["weaponType"]= "Arbalest",
				["type"] = "Bow",	
				stats = {damageAmount = 5},
				price = 200,
				dontShowInEditor = true,
			}};
			
prototypes["Xbow_2"] = {
	templateName = "ArbalestTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/50_arbalets/w21500_arbaletlegkii/w2150_arbaletlegkii.OBJ.XML",
				thumbSmall = 24754,	
				thumbnail = 12538,
				isShown = false,
				name = "LightCrossbow",
				isEnable = false,
				["isGameStateSave"] =false,
				isEnabledPhysics = true,
				["weaponType"]= "Arbalest",
				["type"] = "Bow",	
				stats = {damageAmount = 10},
				price = 300,
				dontShowInEditor = true,
			}};
			
prototypes["Xbow_3"] = {
	templateName = "ArbalestTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/50_arbalets/w18500_samostrel_lyogkiy/w1850_samostrel_lyogkiy.OBJ.XML",	
				thumbSmall = 24759,
				thumbnail = 12536,
				isShown = false,
				name = "LightArbalest",
				isEnable = false,
				["isGameStateSave"] =false,
				isEnabledPhysics = true,
				["weaponType"]= "Arbalest",
				["type"] = "Bow",	
				stats = {damageAmount = 15},
				price = 500,
				dontShowInEditor = true,
			}};

prototypes["Xbow_g1"] = {
	templateName = "ArbalestTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/50_arbalets/w23500_shnepper/w2350_shnepper.OBJ.XML",	
				thumbnail = 12490,
				isShown = false,
				name = "Shnepper",
				isEnable = false,
				["isGameStateSave"] =false,
				isEnabledPhysics = true,
				["weaponType"]= "Arbalest",
				["type"] = "Bow",	
				stats = {damageAmount = 30},
				price = 700,
				dontShowInEditor = true,
			}};
			
prototypes["Xbow_g2"] = {
	templateName = "ArbalestTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/50_arbalets/w23500_gnomi/w2350_gnomi.OBJ.XML",
				thumbSmall = 24756,
				thumbnail = 12543,
				isShown = false,
				name = "Crossbow4Arcs",
				isEnable = false,
				["isGameStateSave"] =false,
				isEnabledPhysics = true,
				["weaponType"]= "Arbalest",
				["type"] = "Bow",	
				stats = {damageAmount = 45},
				price = 1200,
				dontShowInEditor = true,
			}};
			
prototypes["Xbow_g3"] = {
	templateName = "ArbalestTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/50_arbalets/w23500_6dug/w2350_6dug.OBJ.XML",
				thumbSmall = 24753,	
				thumbnail = 12542,
				isShown = false,
				name = "Crossbow6Arcs",
				isEnable = false,
				["isGameStateSave"] =false,
				isEnabledPhysics = true,
				["weaponType"]= "Arbalest",
				["type"] = "Bow",	
				stats = {damageAmount = 70},
				price = 2200,
				dontShowInEditor = true,
			}};

prototypes["Xbow_4"] = {
	templateName = "ArbalestTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/50_arbalets/w23500_tyagoliyarbalet/w2350_tyagoliyarbalet.OBJ.XML",	
				thumbnail = 12546,
				isShown = false,
				name = "SniperCrossbow",
				isEnable = false,
				["isGameStateSave"] =false,
				isEnabledPhysics = true,
				["weaponType"]= "Arbalest",
				["type"] = "Bow",	
				stats = {damageAmount = 30},
				price = 800,
				dontShowInEditor = true,
			}};
			
prototypes["Xbow_5"] = {
	templateName = "ArbalestTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/50_arbalets/w23500_ubiyca/w2350_ubiyca.OBJ.XML",
				thumbnail = 12547,
				isShown = false,
				name = "Killer",
				isEnable = false,
				["isGameStateSave"] =false,
				isEnabledPhysics = true,
				["weaponType"]= "Arbalest",
				["type"] = "Bow",	
				stats = {damageAmount = 75},
				price = 15000,
				dontShowInEditor = true,
			}};
			
prototypes["Xbow_6"] = {
	templateName = "ArbalestTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/50_arbalets/w23500_poslanecsmerti/w2350_poslanecsmerti.OBJ.XML",
				thumbSmall = 24757,	
				thumbnail = 12544,
				isShown = false,
				name = "DeathSender",
				isEnable = false,
				["isGameStateSave"] =false,
				isEnabledPhysics = true,
				["weaponType"]= "Arbalest",
				["type"] = "Bow",	
				stats = {damageAmount = 80},
				price = 5400,
				dontShowInEditor = true,
			}};

prototypes["hvy_Xbow"] = {
	templateName = "ArbalestTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/50_arbalets/w21500_arbalet_rog/w2150_arbalet_rog.OBJ.XML",
				thumbSmall = 24755,	
				thumbnail = 12539,
				isShown = false,
				name = "HeavyCrossbow",
				isEnable = false,
				["isGameStateSave"] =false,
				isEnabledPhysics = true,
				["weaponType"]= "Arbalest",
				["type"] = "Bow",	
				stats = {damageAmount = 32},
				price = 1800,
				dontShowInEditor = true,
			}};	
			
prototypes["harquebus"] = {
	templateName = "HarquebusTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/50_arbalets/w18500_arquebus/w1850_arquebus.OBJ.XML",	
				thumbnail = 23544,
				isShown = false,
				name = "Harquebus",
				["weaponType"]= "Harquebus",
				["hitBoxesFileName"] = "byBoundingBox",
				isEnable = false,
				["isGameStateSave"] =false,
				isEnabledPhysics = true,
				["type"] = "Bow",	
				stats = {damageAmount = 15},
				price = 2500,
				dontShowInEditor = true,
			}};				
