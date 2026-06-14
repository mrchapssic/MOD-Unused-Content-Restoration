 --[[/******************************************************************************
	File:	сharacterHuman.lua
	Desc:	Игровой объект персонаж человек
	Copyright: (c) Rostok-Games 2007
	$Id: human.lua,v 1.138 2007/11/21 10:54:48 nicks Exp $	
******************************************************************************/]]
 
CharacterHuman = {};
CharacterHuman = utils.inherit(CharacterTemplate);

-- в эту таблицу будут записаны наборы различных звуковых характеров,
-- для озвучивания человеческих персонажей
humanSoundsPack = {};

-- время блендинга для тела в диалоге больше, чем в обычном режим.
-- для того чтобы жесты были мягче
DIALOG_BLEND_TIME = 0.7;

--[[CharacterHuman.inventory = {};
CharacterHuman.inventory = utils.inherit(InventoryTable);
CharacterHuman.slot = {};
CharacterHuman.slot = utils.inherit(SlotTable);
]]
-- параметры персонажа
CharacterHuman.needFakeWeapon = true; -- потребность в боксах на руках для рукопашной драки
CharacterHuman.turnSpeed = 350 * PI / 180;
CharacterHuman.data.isNeedAim = true;
CharacterHuman.data.canManoeuvre = true;
CharacterHuman.physicsFile = "characters/human_physics.phv.xml";

CharacterHuman.standardActions = {};

-- временное ускорение передвижения аватара, поскольку скилл доступен во всех стейтах, то объябвляем его здесь
CharacterHuman.standardActions["speedUp"] = function(self) self:setAction("speedUp") end;
CharacterHuman.standardActions["crushedTime"] = function(self) self:setAction("crushedTime") end;
CharacterHuman.standardActions["eyeOfTruth"] = function(self) if(not self:resetAction("eyeOfTruth")) then self:setAction("eyeOfTruth") end end;
CharacterHuman.standardActions["steelSkin"] = function(self) self:setAction("steelSkin") end;
CharacterHuman.standardActions["arrowsImmunity"] = function(self) self:setAction("arrowsImmunity") end;
CharacterHuman.standardActions["arrowsRejection"] = function(self) self:setAction("arrowsRejection") end;
CharacterHuman.standardActions["wordOfStrength"] = function(self) self:setAction("wordOfStrength") end;
CharacterHuman.standardActions["castHipnosis"] = function(self) self:setAction("castHipnosis") end;
CharacterHuman.standardActions["castContusion"] = function(self) self:setAction("castContusion") end;
CharacterHuman.standardActions["сastFireball_01"] = function(self) self:setAction("сastFireball_01") end;
CharacterHuman.standardActions["сastFireball_02"] = function(self) self:setAction("сastFireball_02") end;
CharacterHuman.standardActions["сastFireball_03"] = function(self) self:setAction("сastFireball_03") end;
CharacterHuman.standardActions["castHomingFireball"] = function(self) self:setAction("castHomingFireball") end;
CharacterHuman.standardActions["castArrowsRejection"] = function(self) self:setAction("castArrowsRejection") end;
CharacterHuman.standardActions["castWordOfStrength"] = function(self) self:setAction("castWordOfStrength") end;
CharacterHuman.standardActions["castSteelSkin"] = function(self) self:setAction("castSteelSkin") end;

CharacterHuman.standardActions["kamikazeAttack"] = function(self) self:setAction("kamikazeAttack") end;

CharacterHuman.standardActions["showBadge"] = function(self) self:setAction("showBadge") end;
                             
CharacterHuman.damageFx = "humanBlood";


CharacterHuman.data.lowKickRadius = 5.5;
CharacterHuman.data.lowKickFov = PI/3;


-- восприятие гранат
CharacterHuman.data.enableGrenadeVision = true;
CharacterHuman.data.grenadeViewLength = 6;

--коэффициенты для хитбоксов
CharacterHuman.data.coefficientsOfDamage = {};
CharacterHuman.data.coefficientsOfDamage["Bip01 Head"]      = 4;
CharacterHuman.data.coefficientsOfDamage["Bip01 Spine1"]    = 1;
CharacterHuman.data.coefficientsOfDamage["Bip01 L Foot"]    = 0.4;
CharacterHuman.data.coefficientsOfDamage["Bip01 R Foot"]    = 0.4;
CharacterHuman.data.coefficientsOfDamage["Bip01 L Calf"]    = 0.7;
CharacterHuman.data.coefficientsOfDamage["Bip01 R Calf"]    = 0.7;
CharacterHuman.data.coefficientsOfDamage["Bip01 R ForeArm"] = 0.7;
CharacterHuman.data.coefficientsOfDamage["Bip01 L ForeArm"] = 0.7;
CharacterHuman.data.coefficientsOfDamage["Bip01 Pelvis"]    = 1;

----------------------------------------------------------------------------------------------------
-- Описание эффекторов
----------------------------------------------------------------------------------------------------
CharacterHuman.BRAIN = "brain";
CharacterHuman.BRAIN1 = "brain1";
CharacterHuman.BRAIN2 = "brain2";
CharacterHuman.BRAIN_MOVING = "brain_moving";
CharacterHuman.BRAIN_FOLLOW = "brain_follow";
CharacterHuman.BRAIN_MAGIC = "brain_magic";


CharacterHuman.BODY = "body";
CharacterHuman.FACE = "face";
CharacterHuman.HEAD = "head";
CharacterHuman.HANDS = "hands";
CharacterHuman.LEGS = "legs";

CharacterHuman.SLOPE = "slope";
CharacterHuman.SLOPE_UP = "slope_up";
CharacterHuman.SLOPE_DOWN = "slope_down";

CharacterHuman.PAIN = "pain";
CharacterHuman.ALL_EFFECTORS = {CharacterHuman.HEAD, CharacterHuman.BODY, CharacterHuman.HANDS, 
								CharacterHuman.LEGS, CharacterHuman.PAIN, CharacterHuman.FACE,
								CharacterHuman.SLOPE, CharacterHuman.SLOPE_UP, CharacterHuman.SLOPE_DOWN,
								CharacterHuman.BRAIN, CharacterHuman.BRAIN1, CharacterHuman.BRAIN2, CharacterHuman.BRAIN_MOVING,
								CharacterHuman.BRAIN_FOLLOW, CharacterHuman.BRAIN_MAGIC};
CharacterHuman.UPDATE_EFFECTOR_TIME = {};
CharacterHuman.UPDATE_EFFECTOR_TIME[CharacterHuman.BRAIN] = 0.1;
CharacterHuman.UPDATE_EFFECTOR_TIME[CharacterHuman.BRAIN1] = 0.1;
CharacterHuman.UPDATE_EFFECTOR_TIME[CharacterHuman.BRAIN2] = 0.1;
CharacterHuman.UPDATE_EFFECTOR_TIME[CharacterHuman.BRAIN_MOVING] = 0.1;
CharacterHuman.UPDATE_EFFECTOR_TIME[CharacterHuman.BRAIN_FOLLOW] = 0.1;
CharacterHuman.UPDATE_EFFECTOR_TIME[CharacterHuman.BRAIN_MAGIC] = 0.1;
		
----------------------------------------------------------------------------------------------------
-- объявление таблицы с именами и значениями action'ов
----------------------------------------------------------------------------------------------------
CharacterHuman.actions = {};
CharacterHuman.actions["think"] = ActionThink;
CharacterHuman.actions["followObject"] = ActionFollowObject;
CharacterHuman.actions["followObjectByWP"] = ActionFollowObjectByWP;
CharacterHuman.actions["fight"] = ActionFight;
CharacterHuman.actions["rangeFight"] = ActionRangeFight;
CharacterHuman.actions["meleeFight"] = ActionMeleeFight;
CharacterHuman.actions["furyFight"] = ActionFuryFight;
CharacterHuman.actions["move"] = ActionMove;
CharacterHuman.actions["turn"] = ActionTurn;
CharacterHuman.actions["alert"] = ActionAlert;
CharacterHuman.actions["strafe"] = ActionStrafe;
CharacterHuman.actions["bounce"] = ActionBounce;
CharacterHuman.actions["spin"] = ActionSpin;
CharacterHuman.actions["facedMove"] = ActionFacedMove;
CharacterHuman.actions["use"] = ActionUse;
CharacterHuman.actions["moveForward"] = ActionMoveForward;
CharacterHuman.actions["moveToPoint"] = ActionMoveToPoint;
CharacterHuman.actions["moveToObject"] = ActionMoveToObject;
CharacterHuman.actions["flee"] = ActionFlee;
CharacterHuman.actions["moveByWp"] = ActionMoveByWayPoints;
CharacterHuman.actions["drinkPotion"] = ActionDrinkPotion;
CharacterHuman.actions["throwGrenade"] = ActionThrowGrenade;
CharacterHuman.actions["hideWeapon"] = ActionWeaponHide;
CharacterHuman.actions["drawWeapon"] = ActionWeaponDraw;
CharacterHuman.actions["attack"] = ActionAttack;
CharacterHuman.actions["shoot"] = ActionShoot;
CharacterHuman.actions["reload"] = ActionReload;
CharacterHuman.actions["pain"] = ActionPain;
CharacterHuman.actions["die"] = ActionDie;
CharacterHuman.actions["slope"] = ActionSlope;
CharacterHuman.actions["jump"] = ActionJump;
CharacterHuman.actions["landing"] = ActionLanding;

CharacterHuman.actions["block"] = ActionBlock;
CharacterHuman.actions["showBadge"] = ActionShowBadge;
CharacterHuman.actions["piss"] = ActionPiss;


CharacterHuman.actions["speedUp"] = ActionSpeedUp;
CharacterHuman.actions["crushedTime"] = ActionCrushedTime;
CharacterHuman.actions["eyeOfTruth"] = ActionEyeOfTruth;
CharacterHuman.actions["steelSkin"] = ActionSteelSkin;
CharacterHuman.actions["arrowsImmunity"] = ActionArrowsImmunity;
CharacterHuman.actions["arrowsRejection"] = ActionArrowsRejection;
CharacterHuman.actions["wordOfStrength"] = ActionWordOfStrength;
CharacterHuman.actions["castHipnosis"] = ActionCastHipnosis;
CharacterHuman.actions["castContusion"] = ActionCastContusion;
CharacterHuman.actions["сastFireball_01"] = ActionCastFireball_01;
CharacterHuman.actions["сastFireball_02"] = ActionCastFireball_02;
CharacterHuman.actions["сastFireball_03"] = ActionCastFireball_03;
CharacterHuman.actions["castHomingFireball"] = ActionCastHomingFireball;
CharacterHuman.actions["castArrowsRejection"] = ActionCastArrowsRejection;
CharacterHuman.actions["castWordOfStrength"] = ActionCastWordOfStrength;
CharacterHuman.actions["castSteelSkin"] = ActionCastSteelSkin;

CharacterHuman.actions["kamikazeAttack"] = ActionKamikazeAttack;

-- негативные эффекты назначаемые на ботов
CharacterHuman.actions["contusion"] = ActionContusion;
CharacterHuman.actions["hypnosis"] = ActionHypnosis;

CharacterHuman.data.damageEffects = { melee = "humanBlood",
								fist = "punchDamage",
								explosion = "humanBlood",
								}

-----------------------

function CharacterHuman:initialize()
	local cantMove = self.data.cantMove	;
	self:blockActions(false);
	self:canMove(not cantMove);

	-- для всех кроме аватара выключаем анимацию головы,
	-- при этом заставляем голову принудительно обновить свое состояние
	if self:tag() == "Avatar" then
		self:allowHeadAnimation(true);
	else
		self:allowHeadAnimation(false);
	end
	
	self:setHeadAnim(self.data.headIdle, 1.7);
	
	CharacterHuman.Parent.initialize(self);

	if self.data.sellItems then
		for i, v in pairs(self.data.sellItems) do
			local obj = Editor.createObjectByPrototype(v);
			obj:needToSave(false);
			assert(obj, "Wrong sale item created!!!!")
			addItemToInventory(self, obj);
		end
	end
	if self.data.fakeWeapon then
		self.data.fakeWeapon.item1.data.damageType = "fist";
		self.data.fakeWeapon.item2.data.damageType = "fist";
	end
end

function CharacterHuman:showWithAttachments(isShown)
	--.hack некрасиво сделано, чтобы персонаж исчезал вместе со своим оружием
	-- Некрасиво потому что fakeWeapon надо постоянно прятатать, а то на show(true) оно появится.
	self:show(isShown, nil, true);
	if self.data.hiddenWeapon then
		self.data.hiddenWeapon:show(false)
	end
	if self.data.fakeWeapon then
		self.data.fakeWeapon.item1:show(false);
		self.data.fakeWeapon.item2:show(false);
	end
end

function CharacterHuman:AnimCallbackSwordDraw(animIdx)
	--print(" swordDraw"..animIdx);
	local slotname = self:getActiveSlot();
	local weapon = self:getEquiped(slotname);
	if not weapon then return end	
	
	self:equip(weapon);
	self:setState(weapon:getCharacterState(),true);
	
	if weapon and self:isPlayerControlled() then
		GAME_SCREEN.showAmmoTip(Res_Table[weapon.data.name])
	end
end

function CharacterHuman:AnimCallbackSwordHide(animIdx)
	--print(" swordHide"..animIdx);
	local slotname = self:getActiveSlot();
	local weapon = self:getEquiped(slotname);
	if not weapon then return end

	--self:detachObject(weapon);
	--self:attachObject(weapon, Character.BODY, weapon.data.attachData.hidden.attachBone, weapon.data.attachData.hidden.attachTm);--, true);
	self:unEquip(weapon);
	self:setState("normalState",true);	
	self:setActiveSlot(nil,nil);
end

function CharacterHuman:AnimCallbackUnarmedDraw(animIdx)
	--print("CharacterHuman:AnimCallbackUnarmedDraw(animIdx)")
	local slot,slot2 = self:getActiveSlot();
	local weapon1 = self:getEquiped(slot);
	local weapon2 = self:getEquiped(slot2);
	if not weapon1 or not weapon2 then return end	
	self:equip(weapon1);
	self:equip(weapon2);
	weapon1:show(false);
	weapon2:show(false);
	self:setState(weapon1:getCharacterState(),true);
	
	if self:isPlayerControlled() then
		GAME_SCREEN.showAmmoTip(Res_Table["FistFight"])
	end
end	

function CharacterHuman:AnimCallbackUnarmedHide(animIdx)
	--print("CharacterHuman:AnimCallbackUnarmedHide(animIdx)")	
	local slot,slot2 = self:getActiveSlot();
	self:unEquip(self:getEquiped(slot));
	self:unEquip(self:getEquiped(slot2));
	self:setState("normalState",true);
	self:setActiveSlot(nil,nil);
end	


function CharacterHuman:AnimCallbackBowDraw(animIdx)
	self:AnimCallbackSwordDraw(animIdx);
	--print("CharacterHuman:AnimCallbackBowDraw(animIdx)")
	
	local bow = self:getEquiped("Bow")
	
	if (not self:getEquiped("Arrow") or self:getEquiped("Arrow").data.weaponType != bow.weaponType) and not self:getNextAmmunition("Arrow", bow.weaponType) then return end
	
	if bow and self:isPlayerControlled() then
		GAME_SCREEN.showAmmoTip(Res_Table[bow.data.name])
	end
	
	local arrow = self:getEquiped("Arrow");
	-- if arrow and self:isPlayerControlled() then
		-- GAME_SCREEN.showAmmoTip(Res_Table[arrow.data.name or arrow.data.countable])
	-- end
	self:AnimCallbackReloadArrow(animIdx);
	if self:isPlayerControlled() and GAME_SCREEN then
		GAME_SCREEN.UpdateArrows();
	end
end

function CharacterHuman:AnimCallbackReloadArrow(animIdx)
	-- print("AnimCallbackReloadArrow");
	local bow = self:getEquiped(self:getActiveSlot());
	if not bow or bow.data.type != "Bow" then print("FOR SOME REASONS THERE IS NO EQIPED BOW!! MAYBE WAS STARTED DIALOG SO SKIPING!!") return end
	local arrows = self:getEquiped(bow.ammunition);
	
	if not arrows then print("No arrows"); return end;
	
	if self.data.isDead then print("owner is nearly dead!!! ") return end
	local arrow = arrows:createInstance();	
	
	
	-- НЕ ВЫКЛЮЧАТЬ СТРЕЛУ!!!! иначе она помещается при создании в нулевую ноду и не перемещается по дереву. потому соответственно не видна
	arrow:enable(true);
	arrow:enableHitBoxes(false);
	arrow:enablePhysics(false);
	arrow:needToSave(false);
	if bow.dontShowArrow or bow.data.dontShowArrow then
		arrow:show(false);
	else	
		arrow:show(true);
	end
	local attachData = bow.arrowAttachData;
	if not attachData then
		attachData  = arrow.data.attachData.bare;
	end
	self:attachObject(arrow, Character.BODY, attachData.attachBone, attachData.attachTm);	
	bow:setInstance(arrow);
end

function CharacterHuman:AnimCallbackBowHide(animIdx)
	--print("CharacterHuman:AnimCallbackBowHide(animIdx)");
	--self:destroyArrow(); 	-- стрела дестроится на выходе из стейта
	self:AnimCallbackSwordHide(animIdx);
	if self:isPlayerControlled() and GAME_SCREEN then
		GAME_SCREEN.UpdateArrows();
	end	
end

function CharacterHuman:destroyArrow()
	print("CharacterHuman:destroyArrow() ");
	local bow = self:getEquiped("Bow");
	if bow and bow.data.arrow then
		self:detachObject(bow.data.arrow);
		safeDestroy(bow.data.arrow)
		bow:setInstance(nil);
	end
end

function CharacterHuman:AnimCallbackTakeGrenade(animIdx)
	local grenades = self:getEquiped("Grenade");
	if not grenades then 
		self:getNextToSlot("Grenade")
		grenades = self:getEquiped("Grenade");
		assert(grenades, "Something go wrong, for some reason "..self:tag().." have no grenades!!!!!!");
	end
	
	local grenade = grenades:createInstance();
	local attachData = nil;
	if not grenades then return end
	assert(grenades:getCharacterState(),"No state to change!");
	
	if self:getActiveSlot() == "Grenade" and self:getStateName() != grenades:getCharacterState() then
		self:setState(grenades:getCharacterState(), true);		--переходим в grenadeState
	end

	if self:getStateName() != grenades:getCharacterState() then
		--throw grenade - attach to slot2
		attachData = grenade.data.attachData.onThrow;
	end

	if not attachData then
		attachData = grenade.data.attachData.bare;
	end
	
	if grenades and self:isPlayerControlled() then
		GAME_SCREEN.showAmmoTip(Res_Table[grenades.data.countable])
	end
	
	grenade:needToSave(false)
	self.data.currentGrenade = grenade
	self:attachObject(grenade, Character.BODY, attachData.attachBone, attachData.attachTm);
	grenade:enable(true);
	grenade:show(true);
	grenade:enablePhysics(false);
	
end

function CharacterHuman:AnimCallbackThrowGrenade(animIdx)
	--print("CharacterHuman:AnimCallbackThrowGrenade")
	local grenades = self:getEquiped("Grenade");
	local grenade = grenades:getInstance();
	assert(grenade, "Here must be a grenade!!!!")
	self:detachObject(grenade);
	grenade:throw(nil,self:isPlayerControlled());
	grenade.data.isThrown = true;
	grenades:setInstance(nil);
	self.data.currentGrenade = nil
end

function CharacterHuman:AnimCallbackGrenadeHide(animIdx)
	local grenades = self:getEquiped(self:getActiveSlot());
	assert(grenades,"No grenades in active slot")
	--print("AnimCallbackGrenadeHide",grenades:tag(),self:getActiveSlot())
	local grenade = grenades:getInstance();
	if grenade then 
		self:detachObject(grenade);
		grenade:destroy();
		grenades:setInstance(nil);
	end
	self:setState("normalState",true);	
	self:setActiveSlot(nil,nil);
end

function CharacterHuman:AnimCallbackShoot(animIdx)	
	--print("AnimCallbachShoot ",animIdx);
	local owner = self;
	local bow = owner:getEquiped(owner:getActiveSlot());	
	if not bow then print("THERE IS NO BOW OR GRENADE IN SLOT!!!!!! --- ", self:tag()) return end
	local arrow = bow:getInstance();
	
	--print("bow:getInstance():",self:tag())
	assert(GameScene.checkObject(arrow), "ERROR!! Wrong arrow tag = "..self:tag());
	owner:detachObject(arrow);
	
	
	if not self:isPlayerControlled() and self.data.shootDir then
		--для бота необходимо пересчитать направление выстрела 
		self.data.shootDir = nil
	end
	
	if bow.data.shootEffect then
		local effect = EffectsManager.playEffect(bow.data.shootEffect);
		effect:enable(true)
		effect:setPosition(bow:getPosition())
		--owner:attachObject(self.effect, Character.BODY, -1, MATRIX_IDENTITY(), false);
	end
	if bow.stats and bow.stats.damageAmount then
		arrow.stats.damageAmount = arrow.stats.damageAmount + bow.stats.damageAmount
	end
	arrow:throw(self.data.shootDir, owner:isPlayerControlled(), bow.data.velocityCoef);
	bow:setInstance(nil);
	if bow.attackEnd then bow:attackEnd() end;	
end

function CharacterHuman:AnimCallbackEyeDraw(animIdx)
	print("CharacterHuman:AnimCallbackEyeDraw",animIdx);
	self:AnimCallbackSwordDraw(animIdx);
	--local eye = self:getEquiped("eyeOfTruth");
	-- self:equip(eye);
	-- self:setState(eye:getCharacterState(),true);
	playEyeOfTruth();
	-- flashPp(nil,15220);
	-- NecroVisionOn();
	-- if not NECRO_SONG then
		-- NECRO_SONG = CreateSoundChannel(13860);		
		-- PlaySound(NECRO_SONG, true, 200);
	-- else
		-- ResumeSound(NECRO_SONG);	
	-- end
	-- self.data.cantMove = true;
end


function CharacterHuman:AnimCallbackEyeHide(animIdx)
	print("CharacterHuman:AnimCallbackEyeHide",animIdx);
	self:AnimCallbackSwordHide(animIdx);
	-- local eye = self:getEquiped("eyeOfTruth");
	-- if not eye then return end
	-- self:unEquip(eye);
	-- self:setState("normalState",true);	
	-- self:setActiveSlot(nil,nil);
	stopEyeOfTruth();
	fromSlotToInventory(avatar,"eyeOfTruth");
	-- flashPp(nil,15220);
	-- if(NECRO_SONG) then
		-- PauseSound(NECRO_SONG);
	-- end
	-- NecroVisionOff();
	-- self.data.cantMove = false;
end
	

-- выйти из режима зрака истины, если камера уже не наша
function CharacterHuman:onCameraControl(isAquired)
	self:resetAction("eyeOfTruth");
	self:halt();
end
	
function CharacterHuman:showBottle()
	local bottle =  self.data.currentPotion;
	assert(bottle, "Here must be a bottle")
	bottle:enable(true);
	bottle:show(true);
end

function CharacterHuman:hideBottle()
	local bottle =  self.data.currentPotion;
	assert(bottle, "Here must be a bottle")
	bottle:enable(false);
	bottle:show(false);
end

function CharacterHuman:restartAttack(animIdx)
	--print("CharacterHuman:restartAttack")
	if not self:isPlayerControlled() or not globalKeyboardState or not globalKeyboardState[L_MOUSE] then return end
	for i, v in pairs(self.effectors) do
		if v.animation == animIdx and v.action then								
			v.action.needToBeDestroyed = true;
			v.action.restart = true
		end
	end
end

function CharacterHuman:attackTerminator(animIdx)
	--print("CharacterHuman:attackTerminator")
	-- .hack
	if(self.data.isLowKick) then return end
	
	for i, v in pairs(self.effectors) do
		if v.animation == animIdx and v.action then
			if self.data.attackTerminationData and self.data.attackTerminationData.clickCounter then		
				self.data.attackTerminationData.clickTerminateCounter = self.data.attackTerminationData.clickTerminateCounter and self.data.attackTerminationData.clickTerminateCounter or 0;
				self.data.attackTerminationData.clickTerminateCounter = self.data.attackTerminationData.clickTerminateCounter + 1;
							
				if self.data.attackTerminationData.clickTerminateCounter >= self.data.attackTerminationData.clickCounter then
					v.action.needToBeDestroyed = true;
					if globalKeyboardState[L_MOUSE] then
						v.action.restart = true
					end				
				else
					if self:isPlayerControlled() and self.data.attackTerminationData.clickTerminateCounter == 2 then						
						self.data.stageCoef = 2;
					end
					-- .hack для звуков меча
					--[[
					if(aaaa) then
						self:playSound(13416, nil, nil, false);
						aaaa = nil;
					else
						self:playSound(13415, nil, nil, false);
						aaaa = 1;
					end
					--]]				
				end
			else
				-- для ботов делаем рандомный прерыватель, что бы все удары не смотрелись одинаковыми
				self.data.attacksAmount = self.data.attacksAmount + 1
				if math.random(3) == 1 then
					v.action.needToBeDestroyed = true;
				end								
			end					
		end
	end
end

function CharacterHuman:block()
	--print("CharacterHuman:block")		
	if(not self.data.blockAnims) then
		self.data.blockAnims = {};
		self.data.blockAnims.idle = "handsIdle1";
		self.data.blockAnims.onCollision = "onCollision2"
		self.data.blockAnims.changeState = "changeState1"
	else
		self:playBlockChangeState();
	end	
	self:playBlockHandsIdle();
end

function CharacterHuman:onStartAttack()
	CharacterHuman.Parent.onStartAttack(self);

	self.data.shakerKick = nil
end

function CharacterHuman:playBlockHandsIdle()
	self:playVisual(self.data.blockAnims.idle, false, {"hands"}, 1);	
end

function CharacterHuman:playBlockChangeState()
	--print("CharacterHuman:playBlockChangeState")
	--self:playVisual(self.data.blockAnims.changeState, false, {"hands"}, 1);--, CharacterHuman.playBlockHandsIdle);
	self.data.blockAnims.changeState = self.data.blockAnims.changeState == "changeState1" and "changeState2" or "changeState1";
	self.data.blockAnims.idle = self.data.blockAnims.idle == "handsIdle1" and "handsIdle2" or "handsIdle1";	
	self.data.blockAnims.onCollision = self.data.blockAnims.onCollision == "onCollision1" and "onCollision2" or "onCollision1";	
	--self:playBlockHandsIdle()	
	--print("self.data.blockAnims.idle = ", self.data.blockAnims.idle)
	--print("self.data.blockAnims.changeState = ", self.data.blockAnims.changeState)
end

function CharacterHuman:save(saveTable)
	CharacterHuman.Parent.save(self, saveTable);
	
	-- сохранение имен "шаблонов" для предметов создаваемых "на лету"
	saveTable.weapon = self.data.weapon;	
	saveTable.arrows = self.data.arrows;
	saveTable.ammoQuantity = self.data.ammoQuantity;
	saveTable.bottle = self.data.bottle;
	saveTable.bottlesQuantity = self.data.bottlesQuantity;
	saveTable.sellItems = self.data.sellItems;
	
	saveTable.talkIdle = self.data.talkIdle;
	saveTable.speakIdle = self.data.speakIdle;
	saveTable.headIdle = self.data.headIdle;
	saveTable.headTalk = self.data.headTalk;
	
	saveTable.armorThickness = self.data.armorThickness;
	
	saveTable.soundPack = self.data.soundPack;
	
	self.inventory.save(self.inventory, saveTable);
	self.slot.save(self.slot, saveTable);
	
	if self.data.dontSaveCantMove then
		saveTable.cantMove = nil;
	end
		
	if self.data.sellTypes then
		saveTable.sellTypes = self.data.sellTypes;
	end
	
	if self.data.wait then
		saveTable.wait = self.data.wait;
	end	
end

function CharacterHuman:onDeath()
	self:destroyArrow()
	self:allowHeadAnimation(false);
	CharacterHuman.Parent.onDeath(self);	
end

function CharacterHuman:load(loadTable)
	CharacterHuman.Parent.load(self, loadTable);
	
	self.data.moveData = {};
	self.data.moveData.angle = nil;
	self.data.moveData.anim = 0;
	self.data.moveData.speed = 0;

	-- имя таблици с описанием звукового пресета
	self.data.soundPack = loadTable.soundPack and loadTable.soundPack or self.data.soundPack;
	self:initSoundPack();
	
	self:prepareVisuals();
	
	for i, v in pairs(self.ALL_EFFECTORS) do
		self.effectors[v] = {visualTableName = nil, priority = -1};
		self.effectors[v].updateTime = self.UPDATE_EFFECTOR_TIME[v];
		self.effectors[v].lastUpdateTime = 0;
	end
	
	self.inventory.load(self.inventory, loadTable);	
	
	self.data.weapon = loadTable.weapon and loadTable.weapon or self.data.weapon;
	
	if self.data.weapon then
		self:createWeapon(self.data.weapon);
	end
	
	self.data.arrows = loadTable.arrows and loadTable.arrows or self.data.arrows;
	
	self.data.ammoQuantity = loadTable.ammoQuantity;
	
	if self.data.arrows then
		self:createArrows(self.data.arrows);
	end
	
	self.data.bottle = loadTable.bottle and loadTable.bottle or self.data.bottle;
	self.data.bottlesQuantity = loadTable.bottlesQuantity
	
	if self.data.bottle then
		self:createBottles(self.data.bottle);
	end
	
	self.slot.load(self.slot, loadTable);
	self.data.armorThickness = loadTable.armorThickness and loadTable.armorThickness or 0;
	
	self.data.sellItems = loadTable.sellItems;
	self.data.sellTypes = loadTable.sellTypes;
	
	self.data.talkIdle = loadTable.talkIdle; -- idle спокойной позы слушателя во время разговора
	self.data.speakIdle = loadTable.speakIdle; -- idle жестикуляции, когда персонаж говорит непосредственно
	self.data.headIdle = loadTable.headIdle; -- анимация лица
	self.data.headTalk = loadTable.headTalk; -- анимация губ и рта для разговора по-умолчанию
	
	self.data.wait = loadTable.wait;
end


-- Устанавливает различные виды idle-анимаций и приатачивает  оружие (старжники на посту и прочее)
function CharacterHuman:equipWeapon(weaponName, inHands)
	if self:getStateName() != "normalState" then
		self:quickHidingWeapon()
	end

	
	-- одноручный меч
	if(weaponName == 'OneHandSword') then
		if not self:getEquiped('OneHandSword') then
			self:getNextToSlot('OneHandSword'); 
		end	
		self:setActiveSlot('OneHandSword');
		local weapon = self:getEquiped('OneHandSword');
		self:equip(weapon);
		if(not inHands) then
			self.data.hidingWeapon = true;
			self:unEquip(weapon);
		else
			self:callStandardAction('drawWeapon');
		end
	-- алебарда   
	elseif(weaponName == 'Halberd') then
		self:getNextToSlot('TwoHandSword'); 
		self:setActiveSlot('TwoHandSword'); 
		local weapon = self:getEquiped('TwoHandSword');
		weapon:show(true);
		self:equip(weapon);
		addTimeEvent(self.setIdle, {self, 'two_hand_lumberman_idle_01'},  math.random(3, 11)); 
		self:setIdle('two_hand_lumberman_idle_02'); 
	-- лук
	elseif(weaponName == 'Bow') then
		self:getNextToSlot('Bow');
		self:setActiveSlot('Bow');
		local weapon = self:getEquiped('Bow');
		self:equip(weapon);
		if(not inHands) then
			self.data.hidingWeapon = true;
			self:unEquip(weapon);
		end
	end
end

function CharacterHuman:initSoundPack()
	if self:tag() == 'Avatar' or self.data.soundPack == "none" then return end
	
	-- имя таблици с описанием звукового пресета,
	-- а если soundPack является таблицей, подразумевается, что он содержит
	-- список имен таблиц с описанием звуков, в последнем случае имя выбираем
	-- случайным образом из таблицы
	local soundPackName;
	if(type(self.data.soundPack)=="string") then
		soundPackName = self.data.soundPack;
	elseif(type(self.data.soundPack)=="table") then
		soundPackName = self.data.soundPack[math.random(1, table.getn(self.data.soundPack))];
	else 
		return;
	end
	
	-- print("CharacterHuman:initSoundPack")
	-- print("self:tag() = ", self:tag())
	-- print("soundPackName = ", soundPackName)
	-- print("self.data.soundPack = ", self.data.soundPack)
	
	local soundPackTable;
	if isstring(soundPackName) then 
		soundPackTable = humanSoundsPack[soundPackName];
	end
	if(not istable(soundPackTable)) then return end

	-- PrintTable(soundPackTable)
	
	for i,v in pairs(soundPackTable) do
		self.sounds[i] = v;
	end
end

-- достает оружие указанного типа
function CharacterHuman:drawSpecifiedWeapon(weaponType)
	self:getNextToSlot(weaponType)
	self:setActiveSlot(weaponType)
	self:callStandardAction('drawWeapon');
end

function CharacterHuman:createWeapon(kind)
	--print("CharacterHuman:createWeapon")
	if isstring(kind) then
		kind = {kind};
	end
	
	for i, v in pairs(kind) do
		assert(prototypes[v], "Wrong type of created weapon!!!!  "..v)
		local weapon = Editor.createObjectByPrototype(v, self:tag()..v);		
		
		weapon:enableHitBoxes(false);
		weapon:needToSave(false);
			
		addItemToInventory(self, weapon);
	end
	--fromInventoryToSlot(self, weapon.data.type, weapon);
end

function CharacterHuman:createArrows(kind)
	if isstring(kind) then
		kind = {kind};
	end
	for i, v in pairs(kind) do
		assert(prototypes[v], "Wrong type of created arrows!!!! "..v)
		local arrows = Editor.createObjectByPrototype(v, self:tag().."_"..v..getGameTime());
			
		addItemToInventory(self, arrows);
		if self.data.ammoQuantity then
			arrows.data.counts = self.data.ammoQuantity
		end
		arrows:needToSave(false)
	end
end

function CharacterHuman:createBottles(kind)
	if isstring(kind) then
		kind = {kind};
	end
	
	for i, v in pairs(kind) do
		assert(prototypes[v], "Wrong type of created bottle!!!! "..v)
		local bottle = Editor.createObjectByPrototype(v, self:tag().."_bottle"..getGameTime());
		
		if self.data.bottlesQuantity then
			bottle.data.counts = self.data.bottlesQuantity
		end
		
		addItemToInventory(self, bottle);
		bottle:needToSave(false)
	end
end

function CharacterHuman:setHeadAnim(animName, offsetTime)
	if not animName then animName = "idle" end
	if not offsetTime then offsetTime=1.7 end
	
	if not self:isVisualExists(Character.HEAD) then return end
	local animIdx = self:findAnimById(Character.HEAD, animName);
	self.data.headAnimIdle = animIdx;
	self:playAnimation(Character.HEAD, self.data.headAnimIdle, true, nil, nil, nil);
	
	if(not self:isHeadAnimationAllowed()) then
		self:forceUpdateAnimation(Character.HEAD, offsetTime);
	end
end


function CharacterHuman:resumeHeadAnim()
	if(self.data.headAnimIdle) then
		--self:playAnimation(Character.HEAD, self.data.headAnimIdle, true, nil, nil);
		self:setActionWeight(Character.HEAD, self.data.headAnimIdle, 1);
	end	

end

function CharacterHuman:stopHeadAnim()
	if(self.data.headAnimIdle) then
		--self:stopAnimation(Character.HEAD, self.data.headAnimIdle);
		self:setActionWeight(Character.HEAD, self.data.headAnimIdle, 0.1);
	end	
end

function CharacterHuman:onEyeOfTruth(isOn)
	if(isOn) then
		if self:usability() == "talk" and self.data.necroVisionType == OBJ_NV_ALIVE then
			self:setNecroVisionType(OBJ_NV_UNDEAD);
			return;
		end
		self:setNecroVisionType(self.data.necroVisionType);
	end
end

-- глобальная переменная, указывающая на то, кто говорит в текущий момент
g_currentDialogTalker = nil
g_continueOnSndEnd = true;
g_continueOnSndEndTime = 1;
g_continueWithoutSndTime = 10;
g_dialogTimeEventID = nil;	-- храним айди тайм ивента продолжения диалога (без звука) для его удаления при прерывании диалога

LIP_SYNC_K = 1;

-- проигрывание анимации и звука во время диалога
function CharacterHuman:playRemark(animName, animHeadName, soundId, callbackOnEnd)
	print('self:tag() = ', self:tag())
	print('animHeadName = ', animHeadName)
	if g_dialogTimeEventID then
		removeTimeEvent(g_dialogTimeEventID);
		g_dialogTimeEventID = nil;
	end;
	self:stopRemark();
	
	if(g_currentDialogTalker and GameScene.checkObject(g_currentDialogTalker)) then
		g_currentDialogTalker:stopRemark();
	end
	g_currentDialogTalker = self;
	
	if(animName) then
		self.data.remarkAnimIdx = self:findAnimById(Character.BODY, animName);
		if(self.data.remarkAnimIdx != -1) then
			self:playAnimation(Character.BODY, self.data.remarkAnimIdx, false, nil, nil);
		else
			self.data.remarkAnimIdx = nil;
		end
	end

	local noSnd = false;
	
	if soundId then
		local animHeadCallback = nil;
		animHeadCallback = function(self,sound, isEnded)
							if(self.data.remarkHeadAnimIdx) then
								self:resetAnimationCallbacks(Character.HEAD, self.data.remarkHeadAnimIdx);
								self:stopAnimation(Character.HEAD, self.data.remarkHeadAnimIdx); 
								self:resumeHeadAnim(); 
							end
							
							if(self.data.remarkAnimIdx) then
								self:stopAnimation(Character.BODY, self.data.remarkAnimIdx); 
							end
							
							if g_continueOnSndEnd and isEnded then
								--addTimeEvent(continueDialog,{},g_continueOnSndEndTime);
								g_dialogTimeEventID = addTimeEvent(continueDialogByTimeEvent,{},g_continueOnSndEndTime);
							end;
					end;

		self.data.remarkSoundIdx = self:playSound(soundId, nil, nil, false, g_voiceVolume, 3 --[[minDist]], nil, animHeadCallback, false --[[is3d]], false --[[isHardware]]);

		if self.data.remarkSoundIdx == -1 then
			noSnd = true;
		end
		
		if(animHeadName) then
			if self.data.headTalk and animHeadName == "talk" then
				animHeadName = self.data.headTalk;
			end 
		
			self.data.remarkHeadAnimIdx = self:findAnimById(Character.HEAD, animHeadName);
			if(self.data.remarkHeadAnimIdx != -1 and self.data.remarkHeadAnimIdx != self.data.headAnimIdle) then
				
				
				--.hack включаем анимацию головы еще раз, так как для диалогов с NPC кроме одного основного
				--анимация им не включается. Проблема  в том, что головы мы не выключаем после разговора.
				-- Т.е. если в диалоге будет учавствовать больше 2х собеседников, то для неосновного мы не выключим анимацию головы,
				--а в противном случае она будет неприятно дергаться.
				self:allowHeadAnimation(true);
				
				self:stopHeadAnim();			
				self:setAnimationCallbacks(Character.HEAD, self.data.remarkHeadAnimIdx, 
														{{everyFrame = true, 
														func = function(self) 
																	--print("Callback Anim Head!!!! "..self:tag());
																	if(self.data.remarkSoundIdx and 
																			--.hack непонятно как в этом callback может  self.data.remarkHeadAnimIdx не быть int-ом,
																			-- но такое случается
																			self.data.remarkHeadAnimIdx) then
																		local sndLevel = getSoundLevel(self.data.remarkSoundIdx);
																		sndLevel = utils.clamp(LIP_SYNC_K * sndLevel / 0.3, 0.001, 1);
																		self:setActionWeight(Character.HEAD, self.data.remarkHeadAnimIdx, sndLevel);
																	end
														end},});
				self:playAnimation(Character.HEAD, self.data.remarkHeadAnimIdx, true, nil, nil);

			else
				self.data.remarkHeadAnimIdx = nil;
			end
		end	
	else
		noSnd = true;
	end;
	
	if noSnd then
		g_dialogTimeEventID = addTimeEvent(continueDialogByTimeEvent,{},g_continueWithoutSndTime);
	end;
end
function continueDialogByTimeEvent(owner)
	g_dialogTimeEventID = nil;
	continueDialog();
end

function CharacterHuman:stopRemark()
	if(self.data.remarkAnimIdx) then
		self:stopAction(Character.BODY, self.data.remarkAnimIdx);
	end
	if(self.data.remarkHeadAnimIdx) then
		self:stopAction(Character.HEAD, self.data.remarkHeadAnimIdx);
	end	
	if(self.data.remarkSoundIdx) then
		self:stopSound(self.data.remarkSoundIdx);
		--print(" TALK STOP ",self:tag(), ",", self.data.remarkSoundIdx);
	end
	
	self.data.remarkAnimIdx = nil;
	self.data.remarkHeadAnimIdx = nil;
	self.data.remarkSoundIdx = nil;
	self:setHeadAnim(self.data.headIdle);
end

function CharacterHuman:setDialog(questName)
	self.data.io = self.data.io and self.data.io or {}
	self.data.io.dialogName = questName;
end

function CharacterHuman:startDialog(interlocutor)
	if self.data.isTalking then return end

	if not self.data.io then
		print("No data found for ", self:tag());
		return;
	end
	
	local enemy = self.memory:getEnemy()
	if enemy then
		print("Can't start dialog!! "..self:tag().." in fighting mode. Enemy = "..enemy:tag())
		return
	end
	local diaName = self.data.io.dialogName;
	if not diaName then 
		print("No dialog found for ", self:tag());
		return;
	else
		print("Starting dialog ", diaName, " with ", self:tag());		
	end
	
	--если вдруг аватар еще не проинициализирован
	if not avatar or not GameScene.checkObject(avatar) or avatar.data.isDead then
		print('AVATAR IS DEAD, SKIPING DIALOG!!!')
		return		
	end

	interlocutor = interlocutor and interlocutor or avatar;	

	ReloadDialogs("$scripts/".."dialogs/"..diaName);	

	--wide screen on
	cinemaPpStart();
	dofPpStart();
	local flag = StartDialog(diaName, self, interlocutor)
	print("Dialog started with ", flag);

	if flag then
		-- получение направления взгляда собеседника для восстановлени его в конце диалога
		self.data.lookDir = {self:getLookDir()}
		
		-- установка камеры в позицию по собеседникам
		prepareCamera(self,interlocutor);
		
		if avatar:getStateName() != "normalState" then
			avatar:quickHidingWeapon()
		end
		if self:getStateName() != "normalState" then
			self:quickHidingWeapon()
		end
		avatar:blockActions(true);

		self.data.isTalking = true;
		self.data.wait = true;
		nPhraseID = 1;
		
		-- установить специальный idle для диалога, если такой прописан		
		if(self.data.talkIdle) then
			self.data.originalIdle = self:getIdle()
			self:setIdle(self.data.talkIdle);
		end
		
		-- установить специальный idle для диалога, если такой прописан		
		if(avatar.data.talkIdle) then
			avatar.data.originalIdle = avatar:getIdle()
			--avatar:setIdle(avatar.data.talkIdle);			
			avatar["normalState"].visualTables.currentIdle = {{visual = avatar.data.talkIdle, weight = 1}}
		end
		
		if avatar.data.hiddenWeapon then
			avatar.data.hiddenWeapon:show(false)
		end
		
		self:allowHeadAnimation(true);
		
		avatar.data.io = avatar.data.io and avatar.data.io or {}
		avatar.data.io.originalUndamageable = avatar.data.undamageable
		avatar:makeUndamageable(true);
		avatar:enableHitBoxes(false);
		
		--self.data.originalAnimBlendTime = self:setAnimBlendTime(Character.BODY, DIALOG_BLEND_TIME);
		--avatar.data.originalAnimBlendTime = avatar:setAnimBlendTime(Character.BODY, DIALOG_BLEND_TIME);
		
		self.data.io.originalHitBoxes = self:isEnabledHitBoxes();
		self.data.io.originalUndamageable = self.data.undamageable;
		print('self.data.io.originalUndamageable = ', self.data.io.originalUndamageable)
		self.data.io.originalPerception = self.data.enablePerception;
		self:makeUndamageable(true);
		self:enableHitBoxes(false);
		self:enablePerception(false);
	else
		--wide screen off
		cinemaPpEnd();
		dofPpEnd();
		--assert(false, "For some reason can't start dialog "..diaName.." with "..self:tag())
	end
end


function onEndDialog(_avatar, interlocutor)
	print('onEndDialog')
	--reset aim thumbnail to avoid blinking if avatar will be moved somewhere from interlocutor
	GAME_SCREEN.updateAim();
	g_currentDialogTalker = nil;


	globalGameState.state.io.DialogPos = nil;
	globalGameState.state.io.DialogLookDir = nil;
	globalGameState.state.io.DialogLookDirPartner = nil;
	
	if interlocutor.data.isTalking then
		interlocutor.data.isTalking = nil;
	end
	
	-- восстановить анимацию idle для персонажа
	if(interlocutor.data.talkIdle) then
		interlocutor:setIdle(nil, true);
	end
	
	interlocutor.data.wait = nil;

	--print("onEndDialog()");
	--print(utils.traceback());
	
	assert(interlocutor, "Here must be interlocutor!!!");
	cinemaPpEnd();
	dofPpEnd()
	if(sndChannelId) then
		FreeSoundChannel(sndChannelId);
	end
	_avatar:stopRemark();
	interlocutor:allowHeadAnimation(false);
	interlocutor:stopRemark();	
	if interlocutor.data.originalIdle then
		interlocutor:setIdle(interlocutor.data.originalIdle)
		interlocutor.data.originalIdle = nil
	end
	if avatar.data.originalIdle then	
		--avatar:setIdle(avatar.data.originalIdle)
		avatar["normalState"].visualTables.currentIdle = nil
		avatar.data.originalIdle = nil
	end	
	if globalGameState.state.io.dialogBlockTime then
		avatar:addTimeEvent(avatar.blockActions, {false}, globalGameState.state.io.dialogBlockTime);
		globalGameState.state.io.dialogBlockTime = nil;
	else
		avatar:addTimeEvent(avatar.blockActions, {false}, 0.2);
		
		--print(" UNblock Actions!!!!!")
	end
	--.hack не очень красивый способ, но если не делать, в том случае когда после диалога
	--стартует новая локация, то в ней персонаж будет заблокирован
	avatar.data.dontSaveCantMove = true;
	print('avatar.data.io.originalUndamageable = ', avatar.data.io.originalUndamageable)
	avatar:makeUndamageable(avatar.data.io.originalUndamageable)
	avatar.data.io.originalUndamageable = nil
	avatar:enableHitBoxes(true)
	
	--interlocutor:setAnimBlendTime(Character.BODY, interlocutor.data.originalAnimBlendTime);
	--avatar:setAnimBlendTime(Character.BODY, avatar.data.originalAnimBlendTime);
	
	interlocutor.data.io = interlocutor.data.io or {};
	if(interlocutor.data.io.originalHitBoxes) then
		interlocutor:enableHitBoxes(interlocutor.data.io.originalHitBoxes);
		interlocutor.data.io.originalHitBoxes = nil;
	end
	print('interlocutor.data.io.originalUndamageable = ', interlocutor.data.io.originalUndamageable)
	interlocutor:makeUndamageable(interlocutor.data.io.originalUndamageable);
	interlocutor.data.io.originalUndamageable = nil;
	
	if(interlocutor.data.io.originalPerception) then
		interlocutor:enablePerception(interlocutor.data.io.originalPerception);
		interlocutor.data.io.originalPerception = nil;
	end

	resetCamera();
	
	if g_dialogTimeEventID then
		removeTimeEvent(g_dialogTimeEventID);
		g_dialogTimeEventID = nil;
	end
	
	if avatar.data.hiddenWeapon then
		avatar.data.hiddenWeapon:show(true)
	end
end

-- блокирует все действия доступные персонажу
function CharacterHuman:blockActions(isOn, dontResetAnim)
	print("blockActions ",self:tag(), isOn and " true" or " false");
	if(isOn == true) then
		self:halt();
		--.hack CharacterHuman.BODY не освобождаем, т.к. на нем actionMove, который играет idle
		--self:setAnimBlendTime(-1, 0);
		--self:addTimeEvent(self.setAnimBlendTime, {}, 2.1);
		if not dontResetAnim then
			self:resetAnimations(Character.BODY, "actions");		
		end
		
		-- Шева закоментарил эти эффекторы потому, что в случае перехода между уровнями (да и вообще) если у аватара в руках была аркебуза - он становился в позу Ку
		-- потому, что для этого стейта Idle назначается только на ноги и за верхнюю часть тела отвечает action Slope
		self:releaseEffectors({CharacterHuman.HEAD, CharacterHuman.HANDS, 
								CharacterHuman.LEGS, CharacterHuman.PAIN, CharacterHuman.FACE,
								--CharacterHuman.SLOPE, CharacterHuman.SLOPE_UP, CharacterHuman.SLOPE_DOWN,
								CharacterHuman.BRAIN, CharacterHuman.BRAIN1, CharacterHuman.BRAIN2, CharacterHuman.BRAIN_MOVING,
								CharacterHuman.BRAIN_FOLLOW, CharacterHuman.BRAIN_MAGIC});
	
		
		self.data.dialogStarted = true;
		self:canMove(false);
	else
		self.data.dialogStarted = false;
		self:canMove(true);	
	end
	
	self.data.dontSaveCantMove = nil;
end


function CharacterHuman:sitDown(func)	
	assert(self:checkVisual("sittingIdle"))
	self:playVisual("sitDown", false, {"legs"}, 1, func)
	self:setIdle(self:getState().visualTables.sittingIdle[1] ["visual"]);
end

function CharacterHuman:standUp(func)
	self:setIdle();
	self:playVisual("standUp", false, {"legs"}, 1, func)
end



function playHitWoodEffect(self)
	assert(self.data.myAxe, "No Axe to attach effect!!!! "..self:tag())
	self.data.hitWoodEffect = EffectsManager.playEffect('hitWoodAxe', {self.data.myAxe:getPosition()}) 	
	--self.data.hitWoodEffect:attachToObject(self.data.myAxe, MATRIX_IDENTITY())
end

function CharacterHuman:usability()
	if self.data.io and self.data.io.dialogName and not self.memory:isEnemy(avatar) and not self.data.cantUse and
		self:eventExists("onUse") then
		return "talk";
	end
end

function CharacterHuman:reactOnEnemyAim(enemy)
	if self.data.canManoeuvre and self.memory and self.memory:getEnemy() == enemy then
		if not (math.random(0, 2) > getGameComplexity()) then
			self:setAction("strafe");
		end
	end
end


function CharacterHuman:staffShot(animIdx)
	local enemy = self.memory:getEnemy()
	
	-- Если врага в памяти ИИ нет, пробуем захватить цель прицела ГГ
	if not enemy and self:isPlayerControlled() then
		if type(self.getAimTarget) == "function" then
			enemy = self:getAimTarget()
		end
	end
	
	local fireBall = self:createFireball("fireBall")
	if not fireBall then return end
	
	local x, y, z = self:getPosition()
	local firePos = {x, y + 0.7, z}
	fireBall:setPosition(firePos)
	
	-- ВАЖНО: Считываем направление взгляда через системную функцию getLookDir()
	local shootDirection = nil
	if type(self.getLookDir) == "function" then
		local lx, ly, lz = self:getLookDir()
		if lx then
			shootDirection = {lx, ly, lz}
		end
	end
	
	-- Если getLookDir не вернул вектор, пробуем получить его через getDirection
	if not shootDirection and type(self.getDirection) == "function" then
		local dx, dy, dz = self:getDirection()
		if dx then shootDirection = {dx, dy, dz} end
	end
	
	-- Если движок совсем ничего не вернул, ставим дефолт вперед по оси Z
	if not shootDirection then
		shootDirection = {0, 0, 1}
	end
	
	-- Записываем вектор в системную переменную персонажа (как это сделано у лука)
	self.data.shootDir = shootDirection
	
	fireBall.data.velocity = 30
	self:detachObject(fireBall)
	
	-- Если есть враг — используем калькулятор баллистики движка, если нет — пускаем по shootDir
	if enemy then
		local targetPosition = {enemy:getPosition()};
		targetPosition[2] = targetPosition[2] + 1;
		local calcDir, velocity = calcShootDirection(firePos, targetPosition,
								10, nil, nil, {{dist = 10, vel = 15}, {dist = 10000, vel = 35}});
		fireBall.data.velocity = velocity or 25;
		fireBall:throw(calcDir or shootDirection, true);
	else
		-- Насильно скармливаем движку родной системный вектор
		fireBall:throw(shootDirection, false);
	end
	
	local damageBonus = (self.data.damageBonus and self.data.damageBonus["fireball"]) and self.data.damageBonus["fireball"] or 0
	fireBall.stats.damageAmount = fireBall.stats.damageAmount + damageBonus
	
	self.data.fireball = nil
end


function CharacterHuman:createFireball(kind, attachBone)
	CharacterHuman.Parent.createFireball(self, kind);
	attachBone = attachBone or "slot2";
	if attachBone != "none" and self.data.fireball then
		self:attachObject(self.data.fireball, Character.BODY, attachBone, MATRIX_IDENTITY());
	end	
	return self.data.fireball;
end
	

function CharacterHuman:throwFireball(animIdx)
	-- Перенаправляем все вызовы из анимаций в staffShot, 
	-- чтобы задействовать системный shootDir во всех сценариях
	self:staffShot(animIdx)
end



function CharacterHuman:swordShake(other)
	--if not self:isPlayerControlled() then return end
	local slot1, slot2 = self:getActiveSlot();
	local weapon = self:getEquiped(slot1)
	
	if weapon then 
		EffectsManager.playEffect(weapon.data.type.."Shaker", {weapon:getPosition()})
		weapon:createSplash()
	end
end

function attachAxe(self)
	local obj = avatar.inventory:findByType("Badge")
	obj:show(true)
	obj:enable(true)
	self:attachObject(obj, Character.BODY, "slot1", MATRIX_IDENTITY() );
end

function enableAxeParticles(self)
	local obj = avatar.inventory:findByType("Badge")
	
	obj.data.effect = EffectsManager.playEffect("vaultBadgeEffect");
	obj.data.effect:enable(true)
	obj.data.effect:setOwner(self);
	self:attachObject(obj.data.effect, Character.BODY, "slot1", MATRIX_IDENTITY(), false);
end

function hideAxe(self)
	local obj = avatar.inventory:findByType("Badge")
	obj:show(false)
	obj:enable(false)
	
	if(obj.data.effect) then
		self:detachObject(obj.data.effect);
		obj.data.effect:setOwner(nil);
		safeDestroy(obj.data.effect)
		obj.data.effect = nil;
	end
	self:detachObject(obj);
end


require("engine/templates/human/attckInfos/attackInfo.lua");
require("engine/templates/human/attckInfos/distantAttcks.lua");
require("engine/templates/human/attckInfos/magicAttacks.lua");
require("engine/templates/human/attckInfos/staffAttacks.lua");
