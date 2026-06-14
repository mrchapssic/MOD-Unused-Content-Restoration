--[[/******************************************************************************
	File:	grenadeParams.lua
	Desc:	 Описание характеристик гранат
	Copyright: (c) Rostok-Games 2007
	$Id: grenadeParams.lua,v 1.4 2007/11/14 16:58:08 weba Exp $	
******************************************************************************/]]

prototypes = prototypes and prototypes or {};

prototypes["grenade"] = {templateName = "CountableItem", data = {	tm = MATRIX_IDENTITY(),
	visualFileName = "models/53_magicstuff/s18530_grenade/s1853_grenade.OBJ.XML",
	isEnable=false,
	isShown=true,
	thumbnail=24218,
	["isGameStateSave"] =false,
	["type"]= "Grenade", 
	countable = "SimpleGrenade",
	counts = 5,
	instanceTemplate = "GrenadeTemplate",
	dontShowInEditor = true,
	instanceData = {
		["tm"] =MATRIX_IDENTITY(),
		["timeToExpl"]=2,
		["isDestroyOnColl"] =false,
		--["visualFileName"] ="models/test/Grenade/w0000_Grenate.OBJ.XML",
		["visualFileName"] ="models/53_magicstuff/s18530_grenade/s1853_grenade.OBJ.XML",
		["isShown"] =false,
		["isGameStateSave"] =false,
		["isMaterialPoint"] =false,
		["isEnabledPhysics"] =false,
		["isExplosive"] =true,
		["isEnable"] =false,
		effectName = "fuseFire", 
		effectOffset = {0, 0.2, 0}, 
		
		explosionData = {tm =MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "explosion_small",
						radius = 5;
						damage = 250;
						timeOfExist = 5;
						impulse = 250;
						},
		velocity = 20,												
		velocityVert = 12,											
	},
	price = 20,
}};

prototypes["grenadePauseless"] = {templateName = "CountableItem", data = {	tm = MATRIX_IDENTITY(),
	visualFileName = "models/53_magicstuff/s18530_grenade/s1853_grenade.OBJ.XML",
	isEnable=false,
	isShown=true,
	thumbnail=24219,
	["isGameStateSave"] =false,
	["type"]= "Grenade", 
	countable = "FastGrenade",
	counts = 5,
	instanceTemplate = "GrenadeTemplate",
	dontShowInEditor = true,
	instanceData = {
		["tm"] =MATRIX_IDENTITY(),
		["isDestroyOnColl"] =true,
		--["visualFileName"] ="models/test/Grenade/w0000_Grenate.OBJ.XML",
		["visualFileName"] ="models/53_magicstuff/s18530_grenade_p/s1853_grenade_p.OBJ.XML ",
		["isShown"] =false,
		["isGameStateSave"] =false,
		["isMaterialPoint"] =false,
		["isEnabledPhysics"] =false,
		["isExplosive"] =true,
		["isEnable"] =false,
		effectName = "fuseFire", 
		effectOffset = {0, 0.2, 0}, 
		
		explosionData = {tm =MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "explosion_small",
						radius = 2;
						damage = 200;
						timeOfExist = 5;
						impulse = 200;
						},
		velocity = 20,												
		velocityVert = 12,											
	},
	price = 40,
}};

prototypes["simpleBeetle"] = {templateName = "CountableItem", data = {tm = MATRIX_IDENTITY(),
		visualFileName = "models/84_creatures/u23810_juk_mertvel/u2381_juk_mertvel_small.OBJ.XML",
		isEnable=false,
		isShown=false,
		thumbnail=17717,
		["isGameStateSave"] =false,
		["type"]= "Grenade", 
		countable = "BeetleGrenadeSimple",
		counts = 5,
		instanceTemplate = "Beetle",						
		instanceData = {
		["tm"] =MATRIX_IDENTITY(),
		visualFileName = "models/84_creatures/u23810_juk_mertvel/u2381_juk_mertvel_small.OBJ.XML",
		["timeToExpl"]=5,
		["effectName"] ="beetleFly",
		["isDestroyOnColl"] =true,
		["isShown"] =false,
		["isEnable"] =false,
		["isMaterialPoint"] =true,
		["isEnabledPhysics"] =false,
		["isExplosive"] =true,
		constLookDirY = true,
		explosionData = {tm = MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "explosionBeetleSmall",
						radius = .8;
						damage = 80;
						timeOfExist = 4;
						impulse = 30;
						},
		velocity = 8,
		velocityVert = 6,
		},
		price = 35,
		dontShowInEditor = true,		
}};


prototypes["fireBeetle"] = {templateName = "CountableItem", data = {tm = MATRIX_IDENTITY(),
		visualFileName = "models/84_creatures/u23810_juk_mertvel/u2381_juk_mertvel.OBJ.XML",
		isEnable=false,
		isShown=false,
		thumbnail=23706,
		["isGameStateSave"] =false,
		["type"]= "Grenade", 
		countable = "BeetleGrenadeFire",
		counts = 5,
		instanceTemplate = "Beetle",						
		instanceData = {
		["tm"] =MATRIX_IDENTITY(),
		visualFileName = "models/84_creatures/u23810_juk_mertvel/u2381_juk_mertvel.OBJ.XML",
		["timeToExpl"]=8,
		["effectName"] ="beetleFlyFire",
		["isDestroyOnColl"] =true,
		["isShown"] =false,
		["isEnable"] =false,
		["isMaterialPoint"] =true,
		["isEnabledPhysics"] =false,
		["isExplosive"] =true,
		constLookDirY = true,
		explosionData = {tm = MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "explosion_small",
						radius = 5;
						damage = 200;
						timeOfExist = 4;
						impulse = 170;
						},
		velocity = 5,
		velocityVert = 4,
		},
		price = 75,
		dontShowInEditor = true,
}};

prototypes["acidBeetle"] = {templateName = "CountableItem", data = {tm = MATRIX_IDENTITY(),
		visualFileName = "models/84_creatures/u23810_juk_mertvel/u2381_juk_mertvel_big.OBJ.XML",
		isEnable=false,
		isShown=false,
		thumbnail=23705,
		["isGameStateSave"] =false,
		["type"]= "Grenade", 
		countable = "BeetleGrenadeAcid",
		counts = 5,
		instanceTemplate = "Beetle",						
		instanceData = {
			["tm"] =MATRIX_IDENTITY(),
			["timeToExpl"]=12,
			["effectName"] ="beetleFlyAcid",
			["isDestroyOnColl"] =true,
			["visualFileName"] ="models/84_creatures/u23810_juk_mertvel/u2381_juk_mertvel_big.OBJ.XML",
			["isShown"] =false,
			["isEnable"] =false,
			["isMaterialPoint"] =true,
			["isEnabledPhysics"] =false,
			["isExplosive"] =true,
			["events"] ={
				-- кислотный жук, создает сразу несколько взрывов, как бы облако из кислоты всех жжет
				["onCollision"] ={
					[1] = "! \
							print('acidExpl'); \
							local owner = nil; \
							if self:validateOwner() then \
								owner = self:getOwner(); \
							end \
							local COUNT = 20; \
							for i = 1, COUNT do  \
								addTimeEvent(function(tag, count, position, owner) \
									local explosion = GameScene.createObject('explosionOf'..tag..count,'ExplosionTemplate',  \
													prototypes['acidBeetle'].data.instanceData.explosionData); \
									explosion.data.effectName = nil; \
									explosion.data.damage =  50; \
									explosion.data.radius = 9 / (count + 1); \
									explosion:setPosition(position[1], position[2], position[3]); \
									explosion:setOwner(owner); \
								end, {self:tag(), i, {self:getPosition()}, owner}, i * 0.6 + math.random()); \
							end",
					[2] = 0,
				},		
			},
			constLookDirY = true,
			explosionData = {tm = MATRIX_IDENTITY(),
							isEnable = true,
							effectName = "explosion_acid",
							radius = 8;
							damage = 70;
							timeOfExist = 3;
							impulse = 30;
							},
			velocity = 5,
			velocityVert = 4,
		},
		price = 80,
		dontShowInEditor = true,
}};


prototypes["fireBall"] = {templateName = "GrenadeTemplate", data = {
		["tm"] = MATRIX_IDENTITY(),
		["timeToExpl"]=12,
		["isDestroyOnColl"] =true,
		["visualFileName"] ="models/53_magicstuff/s12530_bomb/s1253_bomb.OBJ.XML",
		["isShown"] =false,
		["hide"] =true,
		["isEnable"] =false,
		["isMaterialPoint"] =true,
		["isEnabledPhysics"] =false,
		["isExplosive"] =true,
		["effectName"] ="fireBall",
		constLookDirY = true,
		["damageType"] = "magic",
		explosionData = {tm = MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "explosion_small",--"explosion_01",
						radius = 3;
						damage = 100;
						timeOfExist = 5;
						impulse = 250;
						},
		velocity = 40,--6,
		velocityVert = 0,--5,
		dontShowInEditor = true,
}};

prototypes["fireBallSkill"] = {templateName = "GrenadeTemplate", data = {
		["tm"] = MATRIX_IDENTITY(),
		["timeToExpl"]=12,
		["isDestroyOnColl"] =true,
		["visualFileName"] ="models/53_magicstuff/s12530_bomb/s1253_bomb.OBJ.XML",
		["isShown"] =false,
		["hide"] =true,
		["isEnable"] =false,
		["isMaterialPoint"] =true,
		["isEnabledPhysics"] =false,
		["isExplosive"] =true,
		["effectName"] ="fireBall",
		constLookDirY = true,
		["damageType"] = "magic",
		explosionData = {tm = MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "explosionFireBallSkill",--"explosion_01",
						radius = 1.5;
						damage = 45;
						timeOfExist = 5;
						impulse = 60;
						},
		velocity = 40,--6,
		velocityVert = 0,--5,
		dontShowInEditor = true,
}};


prototypes["bigFireBall"] = {templateName = "GrenadeTemplate", data = {
		["tm"] = MATRIX_IDENTITY(),
		["timeToExpl"] = 12,
		["isDestroyOnColl"] =true,
		["visualFileName"] ="models/53_magicstuff/s12530_bomb/s1253_bomb.OBJ.XML",
		["isShown"] = false,
		["hide"] = true,
		["isEnable"] = false,
		["isMaterialPoint"] =true,
		["isEnabledPhysics"] = false,
		["isExplosive"] = true,
		["effectName"] = "bigFireBallEffect",
		constLookDirY = true,
		explosionData = {tm = MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "explosionSalamanderSpit",
						radius = 4;
						damage = 110;
						timeOfExist = 5;
						impulse = 60;
						},
		velocity = 30,--6,
		velocityVert = 5,--5,
		dontShowInEditor = true,
		},
		
};


prototypes["multyfireBall"] = {templateName = "GrenadeTemplate", data = {
		["tm"] = MATRIX_IDENTITY(),
		["timeToExpl"]= 1.5,
		["isDestroyOnColl"] =true,
		["visualFileName"] ="models/53_magicstuff/s12530_bomb/s1253_bomb.OBJ.XML",
		["isShown"] =false,
		["hide"] =true,
		["isEnable"] =false,
		["isMaterialPoint"] =true,
		["isEnabledPhysics"] =false,
		["isExplosive"] =true,
		["effectName"] ="fireBall",
		constLookDirY = true,
		explosionData = {tm = MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "explosion_small",--"explosion_01",
						radius = 4;
						damage = 50;
						timeOfExist = 5;
						impulse = 40;
						},
		["events"] ={
			["onThrow"] ={
				[1] = "createSatellite",
				[2] = 0,
			},		
		},
		velocity = 15,--6,
		velocityVert = 0,--5,
		dontShowInEditor = true,
}};

prototypes["homingFireBall"] = {templateName = "HomingProjectile", data = {
		["tm"] = MATRIX_IDENTITY(),
		["timeToExpl"]= 1.5,
		["isDestroyOnColl"] =true,
		["visualFileName"] ="models/53_magicstuff/s12530_bomb/s1253_bomb.OBJ.XML",
		["isShown"] =false,
		["hide"] =true,
		["isEnable"] =false,
		["isMaterialPoint"] =true,
		["isEnabledPhysics"] =false,
		["isExplosive"] =true,
		["effectName"] ="fireBall",
		explosionData = {tm = MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "explosion_small",--"explosion_01",
						radius = 2;
						damage = 30;
						timeOfExist = 5;
						},
		velocity = 15,
		velocityVert = 5,
		dontShowInEditor = true,
}};



prototypes["spiderSpit"] = {templateName = "GrenadeTemplate", data = {
		["tm"] = MATRIX_IDENTITY(),
		["timeToExpl"] = 12,
		["isDestroyOnColl"] =true,
		["visualFileName"] ="models/53_magicstuff/s12530_bomb/s1253_bomb.OBJ.XML",
		["isShown"] = false,
		["hide"] = true,
		["isEnable"] = false,
		["isMaterialPoint"] =true,
		["isEnabledPhysics"] = false,
		["isExplosive"] = true,
		["effectName"] = "spiderSpitEffect",
		constLookDirY = true,
		explosionData = {tm = MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "explosionSpiderSpit",--"explosion_01",
						radius = 1;
						damage = 25;
						timeOfExist = 5;
						impulse = 6;
						},
		velocity = 30,--6,
		velocityVert = 5,--5,
		dontShowInEditor = true,
		},
		
};


prototypes["salamanderSpit"] = {templateName = "GrenadeTemplate", data = {
		["tm"] = MATRIX_IDENTITY(),
		["timeToExpl"]=12,
		["isDestroyOnColl"] =true,
		["visualFileName"] ="models/53_magicstuff/s12530_bomb/s1253_bomb.OBJ.XML",
		["isShown"] =false,
		["hide"] =true,
		["isEnable"] =false,
		["isMaterialPoint"] =true,
		["isEnabledPhysics"] =false,
		["isExplosive"] =true,
		["effectName"] ="salamanderSpitEffect",
		constLookDirY = true,
		explosionData = {tm = MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "explosionSalamanderSpit",--"explosion_01",
						radius = 1;
						damage = 30;
						timeOfExist = 5;
						impulse = 30;
						},
		velocity = 40,--6,
		velocityVert = 5,--5,
		dontShowInEditor = true,
}};


prototypes["zombieSpit"] = {templateName = "GrenadeTemplate", data = {
		["tm"] = MATRIX_IDENTITY(),
		["timeToExpl"]=12,
		["isDestroyOnColl"] =true,
		["visualFileName"] ="models/06_stones/s18060_rock10/s1806_rock10_small.OBJ.XML",
		["isShown"] =false,
		["hide"] =false,
		["isEnable"] =false,
		["isMaterialPoint"] =false,
		["isEnabledPhysics"] =false,
		["isExplosive"] =true,
		["effectName"] ="zombieSpitEffect",
		constLookDirY = true,
		explosionData = {tm = MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "explosionZombieSpit",--"explosion_01",
						radius = 1;
						damage = 10;
						timeOfExist = 5;
						impulse = 0;
						},
		velocity = 30,--6,
		velocityVert = 15,--5,
		dontShowInEditor = true,
}};

prototypes["contusionMissile"] = {templateName = "GrenadeTemplate", data = {
		["tm"] = MATRIX_IDENTITY(),
		["timeToExpl"]=12,
		["isDestroyOnColl"] =true,
		["visualFileName"] ="models/06_stones/s18060_rock10/s1806_rock10_small.OBJ.XML",
		["isShown"] =false,
		["hide"] =false,
		["isEnable"] =false,
		["isMaterialPoint"] =true,
		["isEnabledPhysics"] =false,
		["isExplosive"] =true,
		["effectName"] ="contusionMissileEffect",
		constLookDirY = true,
		explosionData = {tm = MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "explosionContusionMissileEffect",--"explosion_01",
						radius = 0.1;
						damage = 0;
						timeOfExist = 5;
						impulse = 0;
						},
		["events"] ={
			["onCollision"] ={
				[1] = "! if other and other[1] and other[1] ['setAction'] then other = other[1] other:setAction('contusion') end ",
				[2] = 0,
			},		
		},
		velocity = 40,--6,
		velocityVert = 5,--5,
		dontShowInEditor = true,
}};

prototypes["hypnosisMissile"] = {templateName = "GrenadeTemplate", data = {
		["tm"] = MATRIX_IDENTITY(),
		["timeToExpl"]=12,
		["isDestroyOnColl"] =true,
		["visualFileName"] ="models/06_stones/s18060_rock10/s1806_rock10_small.OBJ.XML",
		["isShown"] =false,
		["hide"] =false,
		["isEnable"] =false,
		["isMaterialPoint"] =true,
		["isEnabledPhysics"] =false,
		["isExplosive"] =true,
		["effectName"] ="hypnosisMissileEffect",
		constLookDirY = true,
		explosionData = {tm = MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "explosionHypnosisMissileEffect",--"explosion_01",
						radius = 0.1;
						damage = 0;
						timeOfExist = 5;
						impulse = 0;
						},
		["events"] ={
			["onCollision"] ={
				[1] = "! if other and other[1] and other[1] ['setAction'] then other = other[1] other:setAction('hypnosis') end ",
				[2] = 0,
			},		
		},
		velocity = 40,--6,
		velocityVert = 5,--5,
		dontShowInEditor = true,
}};

prototypes["flyingSkeleton"] = {templateName = "CountableItem", data = {tm = MATRIX_IDENTITY(),
		visualFileName = "models/53_magicstuff/s12530_bomb/s1253_bomb.OBJ.XML",
		isEnable=false,
		isShown=false,
		thumbnail=14684,
		["isGameStateSave"] =false,
		["type"]= "Grenade", 
		countable = "flyingSkeleton",
		counts = 50,
		instanceTemplate = "Beetle",						
		instanceData = {
		["tm"] =MATRIX_IDENTITY(),
		["timeToExpl"]=8,
		["isDestroyOnColl"] =true,
		["visualFileName"] ="models/82_undeads/u23820_flyskeleton/u2382_flyskeleton.OBJ.XML",
		["isShown"] =false,
		["isEnable"] =false,
		["isMaterialPoint"] =true,
		["isEnabledPhysics"] =false,
		["isExplosive"] =true,
		constLookDirY = true,
		["effectName"] ="skeletonArcherAppearenceSmoke",
		explosionData = {tm = MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "skeletonfly",
						radius = 3;
						damage = 500;
						impulse = 350;
						timeOfExist = 5;
						},
		velocity = 5,
		velocityVert = 4,
		},
		price = 0,
		dontShowInEditor = true,
}};


prototypes["clinchers"] = {templateName = "CountableItem", data = {	tm = MATRIX_IDENTITY(),
	visualFileName = "models/test/Grenade/w0000_Grenate.OBJ.XML",
	isEnable=false,
	isShown=true,
	thumbnail=24218,
	["isGameStateSave"] =false,
	["type"]= "Grenade", 
	countable = "Clincher",
	counts = 15,
	instanceTemplate = "GrenadeTemplate",
	dontShowInEditor = true,
	instanceData = {
		["tm"] =MATRIX_IDENTITY(),
		["timeToExpl"]=1,
		["isDestroyOnColl"] =false,
		["visualFileName"] ="models/test/Grenade/w0000_Grenate.OBJ.XML",
		["isShown"] =false,
		["isGameStateSave"] =false,
		["isMaterialPoint"] =false,
		["isEnabledPhysics"] =false,
		["isExplosive"] =true,
		["isEnable"] =false, 
		damageAmount = 10000,				
		effectName = "bigFireBallEffect", 
		effectOffset = {0, 0.2, 0}, 
		
		explosionData = {tm =MATRIX_IDENTITY(),
						isEnable = true,
						effectName = "explosionBigFireBall",
						radius = 8;
						damage = 500;
						timeOfExist = 5;
						impulse = 500;
						},
		velocity = 20,												
		velocityVert = 12,											
	},
	price = 50,
}};