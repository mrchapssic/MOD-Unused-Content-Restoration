--[[/******************************************************************************
	File:	zombieParams.lua
	Desc:	ќписание характеристик игрового персонажа «омби
	Copyright: (c) Rostok-Games 2007
	$Id: zombieParams.lua,v 1.3 2007/11/09 18:10:28 weba Exp $	
******************************************************************************/]]

CharacterZombie.data.xpCost = 10;

--коэффициенты дл€ хитбоксов
CharacterZombie.data.masterDamageCoefitient = 1;

CharacterZombie.data.coefficientsOfDamage = {};

CharacterZombie.data.coefficientsOfDamage["Bip01 Head"]      = 2;
CharacterZombie.data.coefficientsOfDamage["Bip01 Spine1"]    = 1;
CharacterZombie.data.coefficientsOfDamage["Bip01 Pelvis"]    = 1;
CharacterZombie.data.coefficientsOfDamage["Bip01 L Calf"]    = 0.4;
CharacterZombie.data.coefficientsOfDamage["Bip01 R Calf"]    = 0.4;
CharacterZombie.data.coefficientsOfDamage["Bip01 L Foot"]    = 0.3;
CharacterZombie.data.coefficientsOfDamage["Bip01 R Foot"]    = 0.3;
CharacterZombie.data.coefficientsOfDamage["Bip01 L ForeArm"] = 0.5;
CharacterZombie.data.coefficientsOfDamage["Bip01 R ForeArm"] = 0.5;

CharacterZombie.data.damageBonus = {fakeWeapon = 13} -- дополнительные повреждени€, fakeWeapon сам по себе имеет 5 очков

globalResistsTable = globalResistsTable and globalResistsTable or {}
globalResistsTable["ZombieOrdos"] = {melee = -1.5, byArrow = -3}
globalResistsTable["Zombie"] = {}

--описание прототипа дл€ редактора
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
prototypes = prototypes and prototypes or {}
prototypes["Monsters/Zombie"] = { 

	data = {
				["stats"] = { 
					sp = 100, 
					maxSp = 100,
					hp = 100, 
					maxHp = 100,
				},
				["resistsTableName"] = "Zombie",
				["visualFileName"] = "characters/monsters/zombie.chr.xml",
				["hitBoxesFileName"] ="models/test/HitBoxes.hb.xml",
				["thumbnail"] = 9085,
				["events"] = {},	
				["isEnable"] = true,
				["isEnabledPhysics"] = true,
				["isShown"] = true,
			},			
	templateName = "CharacterZombie",
}
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
local newPrototype = DuplicateTable(prototypes["Monsters/Zombie"]);
newPrototype.data.resistsTableName = "ZombieOrdos";
newPrototype.data.damageBonus = {fakeWeapon = 6};
newPrototype.dataReadOnly = {"damageBonus", "resistsTableName"};
prototypes["Monsters/ZombieOrdos"] = newPrototype;
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--// СОЮЗНЫЙ Зомби, призываемый Аватаром игрока (на базе параметров Monsters/Zombie)
prototypes = prototypes and prototypes or {}
prototypes["Monsters/AvatarSummonZombie"] = { 
	data = {
				["stats"] = { 
					sp = 100, 
					maxSp = 100,
					hp = 140,              -- Можно дать чуть больше здоровья, чтобы он дольше работал "танком"
					maxHp = 140,
				},
				["resistsTableName"] = "Zombie",
				["visualFileName"] = "characters/monsters/zombie.chr.xml",
				["hitBoxesFileName"] = "models/test/HitBoxes.hb.xml",
				["thumbnail"] = 9085,
				["events"] ={
								["onDestroy"] = {"! ", 0},
							},	
				["isEnable"] = true,
				["isEnabledPhysics"] = true,
				["isShown"] = true,
				
				-- ИИ НАСТРОЙКИ СОЮЗНИКА (Копируем у Голубых лососей для защиты игрока):
				team = "avatar",                       -- Фракция игрока
				["enemySelectionCriteria"] = "byTeam", -- Атаковать строго по фракциям
				["enemiesList"] ={"smegs", "soldier", "enemies", "soldiers", "gateSoldier", "Enemy",},  -- Будет атаковать нежить Смега и обычных врагов
				isSummonedCompanion = true,            -- Системный флаг компаньона   
			},			                                                              
	templateName = "CharacterZombie",                                                 
}                                                                                     
   