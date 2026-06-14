--[[/******************************************************************************
	File:	staffsParams.lua
	Desc:	 Описание характеристик посохов
	Copyright: (c) Rostok-Games 2007
	$Id:  $	
******************************************************************************/]]

------------------------------------------------------------------------------------------------------
-- Описание шаблонов готовых посохов
prototypes = prototypes and prototypes or {}

prototypes["bone"] = {
	templateName = "StaffTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/49_spears/w2149_kost_long.OBJ.XML",
				hitBoxesFileName = "byBoundingBox",
				thumbnail = 14746,
				name = "Bone",
				isShown = true,
				isEnable = true,
				isEnabledPhysics = false,
				["isGameStateSave"] = false,
				["isHitBoxesEnabled"] = false,
				["type"] = "Staff",		
				stats = {damageAmount = 50},
				price = 30,
				dontShowInEditor = true,
				speedLine = {"staff"},
			}};	
			
prototypes["staff"] = {
	templateName = "StaffTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/49_spears/w1949_posoh_red.OBJ.XML",
				hitBoxesFileName = "byBoundingBox",
				thumbnail = 24346,
				name = "Staff",
				isShown = true,
				isEnable = true,
				isEnabledPhysics = false,
				["isGameStateSave"] = false,
				["isHitBoxesEnabled"] = false,
				["type"] = "Staff", 				
				stats = {damageAmount = 30},
				price = 30,
				dontShowInEditor = true,
				speedLine = {"staff"},
			}};				
			
prototypes["bone_1"] = {
	templateName = "StaffTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/49_spears/w2149_kost_long.OBJ.XML",
				hitBoxesFileName = "byBoundingBox",
				thumbnail = 14746,
				name = "Bone_1",
				isShown = false,
				isEnable = false,
				isEnabledPhysics = false,
				["isGameStateSave"] = false,
				["isHitBoxesEnabled"] = false,
				["type"] = "OneHandSword",
				["weaponType"]= "Staff",
				stats = {damageAmount = 70},
				dontShowInEditor = true,
				speedLine = {"staff"},

			}};	
			
prototypes["staff_1"] = {
	templateName = "StaffTemplate",
	data = {tm = MATRIX_IDENTITY(),
				visualFileName = "models/49_spears/w1949_posoh_red.OBJ.XML",
				hitBoxesFileName = "byBoundingBox",
				thumbnail = 24346,
				name = "Staff_1",
				isShown = false,
				isEnable = false,
				isEnabledPhysics = false,
				["isGameStateSave"] = false,
				["isHitBoxesEnabled"] = false,
				["type"] = "OneHandSword",
				["weaponType"]= "Staff", 
				stats = {damageAmount = 50},
				dontShowInEditor = true,
				speedLine = {"staff"},
			}};				