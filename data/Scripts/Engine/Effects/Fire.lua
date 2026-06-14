--[[/******************************************************************************
	File:	fire.lua
	Desc:	огонь
	Copyright: (c) Rostok-Games 2007
	$Id: fire.lua,v 1.7 2007/10/08 18:51:09 dandy Exp $	
******************************************************************************/]]

local SOUND_ARROW_WHISTLE = {
								soundUid = {21915, 21916, 21917, 21918,},
								volume = 155,
								bone = -1,
								minDist = 3,
								maxDist = 5,
								isLooped = true,
							};
							
local smallshotParticles = {
	-- fire 
	fire = {
		particleCount = 300,
		texture = 17265,
		material = "QuadParticlesAdd",
		color = { "line", .77, .55, .5, .7, .4, .3},
		alpha = { "point1", 0.1 },
		size = { "line", 0.1, 0.1, 0.1, 0.1, 0.1, 0.1},
		velocity = { "disc", 0, 1, 0, 0, 1, 0, 0.1, 0.2},
		rotation = { "line1", 0, 180},
		angularVel = { "line1", 20, 50},
		parentVelScale = {1.0, 1.0, 1.0},
		
		-- actions
		targetColor = { 0, 0, 0, 0, 4, },
		targetSize = { 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, },
		targetVelocity = { 0, 0.3, 0, 0.2, 0.2, 0.2,},
		source = { 70, { "sphere", 0, 0, 0, 0.07, 0} },
		killOld = { 0.05 },
		damping = { -1, 0, -1, },
	},
};							

local fireParticles = {
	-- fire 
	fire = {
		particleCount = 3000,
		texture = 17265,
		material = "QuadParticlesAdd",
		color = { "line", .77, .55, .5, .7, .4, .3},
		alpha = { "point1", 0.1 },
		size = { "line", 0.02, 0.02, 0.02, 0.3, 0.3, 0.3},
		velocity = { "disc", 0, 1, 0, 0, 1, 0, 0.1, 0.2},
		rotation = { "line1", 0, 180},
		angularVel = { "line1", 20, 50},
		parentVelScale = {1.0, 1.0, 1.0},
		
		-- actions
		targetColor = { 0, 0, 0, 0, 4, },
		targetSize = { 0.04, 0.04, 0.04, 0.3, 0.3, 0.3, },
		targetVelocity = { 0, 0.3, 0, 0.2, 0.2, 0.2,},
		source = { 50, { "sphere", 0, 0, 0, 0.07, 0} },
		killOld = { 0.7 },
		damping = { -1, 0, -1, },
	},
};

local magicFireParticles = {
	-- fire 
	fire = {
		particleCount = 3000,
		texture = 17265,
		material = "QuadParticlesAdd",
		color = { "line", .2, .2, .9, .6, .6, .6},
		alpha = { "point1", 0.1 },
		size = { "line", 0.02, 0.02, 0.02, 0.3, 0.3, 0.3},
		velocity = { "disc", 0, 1, 0, 0, 1, 0, 0.1, 0.2},
		rotation = { "line1", 0, 180},
		angularVel = { "line1", 20, 50},
		parentVelScale = {1.0, 1.0, 1.0},
		
		-- actions
		targetColor = { 0, 0, 0, 0, 4, },
		targetSize = { 0.04, 0.04, 0.04, 0.3, 0.3, 0.3, },
		targetVelocity = { 0, 0.3, 0, 0.2, 0.2, 0.2,},
		source = { 50, { "sphere", 0, 0, 0, 0.07, 0} },
		killOld = { 0.7 },
		damping = { -1, 0, -1, },
	},
};
					
					
EffectsManager.effects["arrowFire"] = {
						fxTable = fireParticles,
						sound = SOUND_ARROW_WHISTLE,
						destructionTime = -1,
					};
					
EffectsManager.effects["smallshot"] = {
						fxTable = smallshotParticles,
						sound = SOUND_ARROW_WHISTLE,
						destructionTime = -1,
					};					
									
EffectsManager.effects["arrowWhistle"] = {
						sound = SOUND_ARROW_WHISTLE,
						destructionTime = -1,
					};					
					
EffectsManager.effects["singingArrow"] = {
						--fxTable = fireParticles;
						sound = {
								soundUid = 23205,
								volume = 200,
								bone = -1,
								minDist = 2, 
								--maxDist = 5, 
								isLooped = true,
							},
						destructionTime = -1,
					};											
					
													
					
EffectsManager.effects["magicFire"] = {
						fxTable = fireParticles;
						destructionTime = -1,
					};	
					
EffectsManager.effects["blueFire"] = {
						fxTable = magicFireParticles,
						destructionTime = -1,
					};						

------------------------------------------------------------------------------------------------------
-- целеуказание дымом при наведении мортиры
------------------------------------------------------------------------------------------------------
					
local smokeParticles = {};
smokeParticles.fire = utils.inherit(fireParticles.fire);
smokeParticles.fire.color = { "line", .5, .5, .5, .7, .7, .7};
					
EffectsManager.effects["arrowSmoke"] = {
						fxTable = smokeParticles,
						sound = SOUND_ARROW_WHISTLE,
						destructionTime = -1,
					};
					
					
										
local mortarTargetParticles = {
	smoke = {
		particleCount = 3000,
		texture = 17268, -- pfx_smoke03.tga
		material = "QuadParticlesMltplyTexAdd",
		
		color = { "line", 0.1, 0.1, 0.1, .3, .3, .3},
		alpha = { "point1", 1},
		size = { "line", 0.3, 0.3, 0.3, 0.5, 0.5, 0.5},
		velocity = { "sphere", 0, 0, 0, 0.4, 0.7},
		rotation = { "line1", 0, 180},
		angularVel = { "line1", 20, 50},
		parentVelScale = {1.0, 1.0, 1.0},
		
		-- actions
		targetColor = { 1, 1, 1, 0, 0.02, },
		targetSize = { 3.2, 3.2, 3.2, 0.3, 0.3, 0.3, },
		targetVelocity = { 0, 0.3, 0, 0.2, 0.2, 0.2,},
		gravity = {0, 2, 0},
		source = { 10, { "point", 0, 0, 0, 0.07, 0}, time = {0, 15} },
		killOld = { 20 },
		damping = { -1, 0, -1, },
	},
};

					
EffectsManager.effects["mortarTarget"] = {
						fxTable = mortarTargetParticles;
						sound = {
								soundUid = -1,
								volume = 155,
								bone = -1,
								minDist = 0.5, 
								isLooped = true,
							},
						destructionTime = 30,
					};
					
					
------------------------------------------------------------------------------------------------------
-- облако пыли и дыма при рождении скелета
------------------------------------------------------------------------------------------------------
			
local skeletonAppearenceSmokeParticles = {
	smoke = {
		particleCount = 100,
		texture = 17268, -- pfx_smoke03.tga
		material = "QuadParticlesMltplyTexAdd",
		
		color = { "line", 0.3, 0.3, 0.3, .3, .3, .3},
		alpha = { "point1", 1},
		
		size = { "line", 0.5, 0.5, 0.5, 0.7, 0.7, 0.7},
		rotation = { "line1", 0, 180},
		angularVel = { "line1", 20, 50},
		velocity = { "sphere", 0, 1, 0, 0.7, 0.9},
				
		-- actions
		targetColor = { 1, 1, 1, 0, 0.1, },
		targetSize = { 4, 4, 4, 1, 1, 1, },
		targetVelocity = { 0, 0, 0, 0.2, 0.2, 0.2,},
		source = { 40, { "cylinder", 0, 0, 0, 0, 1, 0, 0, 0.6}, time = {0, 3} },
		killOld = { 10 },
		damping = { -1, 0, -1, },
	},
};
					
EffectsManager.effects["skeletonAppearenceSmoke"] = {
						fxTable = skeletonAppearenceSmokeParticles;
						--fxFile = "effects/ritual_1.pfx.xml",
						--fxFile = "effects/zombie_summon.pfx.xml",
						--fxFile = "effects/runes_green.pfx.xml",
						sound = {
								soundUid = {20112, 20191, 20192},
								volume = 255,
								bone = -1,
								minDist = 4, 
								--maxDist = 10, 
								isLooped = false,
							},
							
						destructionTime = 4,
						};

------------------------------------------------------------------------------------------------------
local skeletonArcherAppearenceSmokeParticles = {
	smoke = {
		particleCount = 100,

		texture = 17268, -- pfx_smoke03.tga
		material = "QuadParticlesMltplyTexAdd",
		color = { "line", 0.4, 0.1, 0.1, .3, .3, .3},
		alpha = { "point1", 1},
		
		size = { "line", 0.5, 0.5, 0.5, 0.7, 0.7, 0.7},
		rotation = { "line1", 0, 180},
		angularVel = { "line1", 20, 50},
		velocity = { "sphere", 0, 1, 0, 0.7, 0.9},
				
		-- actions
		targetColor = { 1, 1, 1, 0, 0.2 },
		targetSize = { 4, 4, 4, 1, 1, 1, },
		targetVelocity = { 0, 0, 0, 0.2, 0.2, 0.2,},
		source = { 40, { "cylinder", 0, 0, 0, 0, 1, 0, 0, 0.6}, time = {0, 2} },
		killOld = { 10 },
		damping = { -1, 0, -1, },
	},
};
				
EffectsManager.effects["skeletonArcherAppearenceSmoke"] = {
						fxTable = skeletonArcherAppearenceSmokeParticles;
						sound = {
								soundUid = {20112, 20191, 20192},
								volume = 255,
								bone = -1,
								minDist = 4, 
								isLooped = false,
							},
						destructionTime = 4,
					};
					
------------------------------------------------------------------------------------------------------
local skeletonMageAppearenceSmokeParticles = {
	smoke = {
		particleCount = 100,

		texture = 17268, -- pfx_smoke03.tga
		material = "QuadParticlesMltplyTexAdd",
		color = { "line", 0.3, 0.3, 0.6, .3, .3, .3},
		alpha = { "point1", 1},
		
		size = { "line", 0.5, 0.5, 0.5, 0.7, 0.7, 0.7},
		rotation = { "line1", 0, 180},
		angularVel = { "line1", 20, 50},
		velocity = { "sphere", 0, 1, 0, 0.7, 0.9},
				
		-- actions
		targetColor = { 1, 1, 1, 0, 0.2 },
		targetSize = { 4, 4, 4, 1, 1, 1, },
		targetVelocity = { 0, 0, 0, 0.2, 0.2, 0.2,},
		source = { 40, { "cylinder", 0, 0, 0, 0, 1, 0, 0, 0.6}, time = {0, 2} },
		killOld = { 10 },
		damping = { -1, 0, -1, },
	},
};
				
EffectsManager.effects["skeletonMageAppearenceSmoke"] = {
						fxTable = skeletonMageAppearenceSmokeParticles;
						sound = {
								soundUid = {20112, 20191, 20192},
								volume = 255,
								bone = -1,
								minDist = 4, 
								isLooped = false,
							},
						destructionTime = 4,
					};					

						
					
------------------------------------------------------------------------------------------------------
-- партиклы магического эффекта на светоче в кабинете гнорра
------------------------------------------------------------------------------------------------------
			
local magicBarrierParticles = {

	starsGold = {	
		--global = false,
		particleCount = 30,
		
		texture = 17266,
		material = "QuadParticlesAdd",
				
		-- init
		color = { "line", .8, .4, .2, .9, .4, .3},
		alpha = { "point1", 1, },
		
		size = { "point", 0, 0, 0 },

		rotation = { "line1", 0, 180, },
		angularVel = { "line1", 0, 33, },
		
		-- actions
		source = {30, { "sphere", 0, 0, 0, 0.3, 0.45,}, },

		targetSize = {0.7, 0.7, 0.7, 2.8, 2.8, 2.8, },
		targetColor = {.0, .0, .0, 0, 2,},
				
		killOld = {3,},
	},
	
	
	starsRed = {	
		--global = false,
		particleCount = 30,
		
		texture = 17266,
		material = "QuadParticlesAdd",
				
		-- init
		color = { "line", 1, .2, .2, 1, .1, .1},
		alpha = { "point1", 1, },
		
		size = { "point", 0, 0, 0 },

		rotation = { "line1", 0, 180, },
		angularVel = { "line1", 0, 33, },
		
		-- actions
		source = {20, { "sphere", 0, 0, 0, 0.3, 0.35,}, },
		targetSize = {0.8, 0.8, 0.8, 7, 7, 7, },
		targetColor = {.0, .0, .0,  0,  3,},
		killOld = {2,},
	},
};
					-- [
					
EffectsManager.effects["magicBarrier"] = {
						fxTable = magicBarrierParticles;
						sound = {
								soundUid = -1,
								volume = 155,
								bone = -1,
								minDist = 0.5, 
								isLooped = true,
							},
							
						light = {
							color = { 1, .2, .2, 1 },
							radius = 1,
							attenuation = 0.4,
							lifeTime = -1,
						},
						destructionTime = -1,
					};
					--]]
					
		
------------------------------------------------------------------------------------------------------
-- Шептун в Ордосе
------------------------------------------------------------------------------------------------------
local feonSmokeParticles = {
	fire = {
		particleCount = 50,
		texture = 17267,
		material = "QuadParticlesAlpha",
		color = { "line", .15, .15, .17, .17, .17, .19},
		alpha = { "point1", 0.8 },
		size = { "line", 0.16, 0.16, 0.16, 0.35, 0.35, 0.35, },
		velocity = { "point", 0, 0.43, 0},
		rotation = { "line1", 0, 180, },
		angularVel = {"line1", 0, 21, },
	
		
		-- actions
		targetColor = { .17, .17, .19,  0, 0.4, },
		--damping = {0, -1, 0, },
		--gravity = {0, 1, 0, },
		--targetVelocity = {0, 0, 0.35, .3},
		targetSize = {3, 3, 3, 0.5, 0.5, 0.5, },

		
		
		texture = 17265,
		material = "QuadParticlesAdd",
		color = { "line", .15, .15, .17, .17, .17, .19},
		targetColor = { 0, 0, 0,  0,  0.5, },

		source = { 5, { "disc", 0, -0.3, 0, 0, 1,0, 0.4, 0.5},},
		killOld = { 10 },
	},
};
					-- [
					
EffectsManager.effects["feonSmoke"] = {
						fxTable = feonSmokeParticles;
						destructionTime = -1,
					};
					--]]
					

					
					


local fireballParticles = {
	-- fire 
	fire = {
		particleCount = 3000,
		texture = 17265,
		texture = 24738, -- flame2.dds
		material = "QuadParticlesAdd",
		color = { "line", .77, .55, .5, .7, .4, .3},
		alpha = { "point1", 0.1 },
		size = { "line", 0.02, 0.02, 0.02, 0.3, 0.3, 0.3},
		velocity = { "disc", 0, 1, 0, 0, 1, 0, 0.1, 0.2},
		rotation = { "line1", 0, 180},
		angularVel = { "line1", 20, 50},
		parentVelScale = {1.0, 1.0, 1.0},
		
		-- actions
		targetColor = { 0, 0, 0, 0, 4, },
		targetSize = { 0.07, 0.07, 0.07, 0.5, 0.5, 0.5, },
		targetVelocity = { 0, 0.3, 0, 0.2, 0.2, 0.2,},
		source = { 70, { "sphere", 0, 0, 0, 0.07, 0} },
		killOld = { 0.7 },
		damping = { -1, 0, -1, },
	},
};
					
EffectsManager.effects["fireBall"] = {
	fxTable = fireballParticles;
	sound = {
			soundUid = 21329,
			volume = 155,
			bone = -1,
			minDist = 10, 
			isLooped = true,
		},
	destructionTime = -1,
};	
EffectsManager.effects["skeletonfly"] = {
						fxTable = skeletonArcherAppearenceSmokeParticles;
						sound = {
								soundUid = 14197,
								volume = 255,
								bone = -1,
								minDist = 10, 
								isLooped = false,
							},
						destructionTime = 4,
					};
