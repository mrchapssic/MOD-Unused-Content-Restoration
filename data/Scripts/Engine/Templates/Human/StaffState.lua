--[[/******************************************************************************
	File:	staffState.lua
	Desc:	Состояние персонажа "с посохом"
	Copyright: (c) Rostok-Games 2007
	$Id: $	
******************************************************************************/]]

CharacterMale.moveStaffRun = {
					{dir = {0, 0, -1}, velocity = 5, visualTableName = "runForward"}, -- вперед
					{dir = {0, 0, 1}, velocity = 5, visualTableName = "runBackward"}, -- назад
					{dir = {-1, 0, 0}, velocity = 4, visualTableName = "runRight"},  -- вправо		
					{dir = {1, 0, 0},  velocity = 4, visualTableName = "runLeft"}, -- влево
					
					{dir = {-0.7071, 0, -0.7071}, velocity = 5, visualTableName = "runForwardRight"}, -- вперед - вправо
					{dir = {0.7071, 0, -0.7071}, velocity = 5, visualTableName = "runForwardLeft"}, -- вперед - влево
					--[[{dir = {-0.7071, 0, 0.7071}, velocity = 5, visualTableName = "runBackwardRight"}, -- назад - вправо
					  {dir = {0.7071, 0, 0.7071}, velocity = 5, visualTableName = "runBackwardLeft"}, -- назад - влево]]
				};			

--------------------------------------------------------------------
-- описание визуальных состояний				
--------------------------------------------------------------------
CharacterMale.visualStates = CharacterMale.visualStates and CharacterMale.visualStates or {};

CharacterMale.visualStates["staff_idle_attack"] = {animation = {id = "staff_idle_attack", speed = 1}};


CharacterMale.visualStates["staff_run_forward"] = {animation = {id = "staff_run_forward", speed = 1,callbacks = {
			{frame = 1, func = CharacterTemplate.createDust},
			{frame = 13, func = CharacterTemplate.createDust},}}};-- }};
CharacterMale.visualStates["staff_run_backward"] = {animation = {id = "staff_run_backward", speed = 1}};
CharacterMale.visualStates["staff_run_left"] = {animation = {id = "staff_run_left", speed = 1.3}};
CharacterMale.visualStates["staff_run_right"] = {animation = {id = "staff_run_right", speed = 1.3}};
-- бег по диагонали
CharacterMale.visualStates["staff_run_forward_left"] = {animation = {id = "staff_run_forward_left", speed = 1}};
CharacterMale.visualStates["staff_run_forward_right"] = {animation = {id = "staff_run_forward_right", speed = 1}};


CharacterMale.visualStates["staff_attack_01"] = {animation = {id = "staff_attack_01", speed = 1, callbacks = {
			{frame = 18, func = CharacterHuman.enableWeapon},
			{frame = 25, func = CharacterHuman.disableWeapon},
			}}, sounds = SOUND_STAFF_WHISTLE};

CharacterMale.visualStates["staff_magic_attack_01"] = {animation = {id = "staff_magic_attack_01", speed = 1}, callbacks = {
			{frame = 30, func = CharacterHuman.staffShot},
			}};
CharacterMale.visualStates["staff_magic_attack_02"] = {animation = {id = "staff_magic_attack_02", speed = 1, callbacks = {
			{frame = 31, func = CharacterHuman.summonMonster},
			}}, sounds = SOUND_SUMMON};
CharacterMale.visualStates["staff_magic_attack_03"] = {animation = {id = "staff_magic_attack_03", speed = 1, callbacks = {
			{frame = 30, func = CharacterHuman.staffShot},
			}}, sounds = SOUND_FIREBALLCAST};
CharacterMale.visualStates["staff_magic_attack_04"] = {animation = {id = "staff_magic_attack_04", speed = 1, callbacks = {
			{frame = 26, func = CharacterHuman.staffShot},
			}}, sounds = SOUND_FIREBALLCAST};

CharacterMale.staff_magic_attack = {attack = "attackBackward"};
--------------------------------------------------------------------
-- Состояния персонажа				
--------------------------------------------------------------------
CharacterMale.staffState = {
	
	visualTables = {
	
		idle = {{visual = "staff_idle_attack", weight = 1}},
		drink = {{visual = "drink", weight = 1}},
					
		runForward = {{visual = "staff_run_forward"}},
		runBackward = {{visual = "staff_run_backward"}},
		runLeft = {{visual = "staff_run_left"}},
		runRight = {{visual = "staff_run_right"}},
		
		runForwardLeft = {{visual = "staff_run_forward_left"}},
		runForwardRight = {{visual = "staff_run_forward_right"}},
		                                             
		hideWeapon = {{visual = "two_hand_hide"}},
		
		pain = {{visual = "two_hand_pain"}},
		
		jump_body = {{visual = "jump_body"}},
		jump_legs = {{visual = "jump_legs"}},
		landing_body = {{visual = "landing_body"}},
		landing_legs = {{visual = "landing_legs"}},
		
		cast_01 = {{visual = "1hand_cast_magic_01"}},		
		cast_02 = {{visual = "1hand_cast_magic_02"}},		

		attack = {
			{visual = "staff_attack_01", weight = 1},
		},
		
		attack_low = {{visual = "staff_attack_01", weight = 1},},
		
		block = {{visual = "two_hand_idle_block1"}},		
		
		attackVector = {{visual = "staff_attack_01", weight = 1},},
		attackBackward = {{visual = "staff_magic_attack_04", weight = 1},},
		
		-- ИСПРАВЛЕНИЕ: Оставили ОДНО единственное объявление броска для призыва!
		throwGrenade = {{visual = "staff_magic_attack_02", weight = 1},},
		
		attackRight = {{visual = "staff_magic_attack_03", weight = 1},},
		
		die = {{visual = "unarmed_die_01"},
				{visual = "unarmed_die_02"}},
		dieForward = {{visual = "die_forward"}},	
		dieBackward = {{visual = "die_backward"}},	
		dieLeft = {{visual = "die_left"}},	
		dieRight = {{visual = "die_right"}},	
	},
	move = CharacterMale.moveTwoHandRun,
	
	moveRun = CharacterMale.moveStaffRun,
	moveWalk = CharacterMale.moveStaffRun,
	move = CharacterMale.moveStaffRun,
	
	save = function(self)
		local stateData = {};
		stateData.activeSlot, stateData.activeSlot2 = self:getActiveSlot();
		return stateData;
	end,
	
	load = function(self, stateData)
		assert(stateData, "Here must be stateData. For "..self:tag())
		self:setActiveSlot(stateData.activeSlot, stateData.activeSlot2)
		local weapon = self:getEquiped(stateData.activeSlot);
		if not weapon then		
			if not self:isPlayerControlled() then
				self:getNextToSlot(stateData.activeSlot)
				weapon = self:getEquiped(stateData.activeSlot);
			else
				assert(false, "ERROR!! For some reason avatar hasn't weapon in slot!!!! Can't load oneHandSwordState")
			end
		end
		self:equip(weapon);
	end,
	
	standardActions = {
		["drawWeapon"] = function (self, params)  
			 self:setAction("hideWeapon");
		end,
		["use"] = function(self)
			return self:setAction("use");
		end,
		["drinkPotion"] = function(self,params)
			return self:setAction("drinkPotion", params);
		end,
		["attack"] = function(self, params)
			return self:setAction("attack", params);
		end,
		["block"] = function(self)
			return self:setAction("block");
		end,
		
		-- ИСПРАВЛЕНИЕ: Насильно обучаем посох экшену броска гранаты, чтобы C++ запускал анимацию призыва!
		["throwGrenade"] = function(self)
			return self:setAction("throwGrenade");
		end,
	},
	
	changeState = {
		normalState = {effectorsList = {"hands"}, priority = 1, visualTableName = "hideWeapon", beginFunc = nil, endFunc = nil},
	}
};