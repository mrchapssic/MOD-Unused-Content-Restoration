--[[/******************************************************************************
	File:	Character.lua
	Desc:	Игровой объект персонаж
	Copyright: (c) Rostok-Games 2007
	$Id: character.lua,v 1.279 2007/11/21 14:53:18 dandy Exp $	
******************************************************************************/]]


-- вляние сложности игры на количество повреждений на носимых противниками игроку
-- 0.7 -  отнимаем 70% от повреждения 
-- 0  - не отнимаем ничего
g_enemyDifficultyCoef = {0.7, 0.35, 0}

-- вляние сложности игры на количество повреждений на носимых игроком противникам
-- 0.2 - прибавляем 20% к наносимому повреждению
g_playerDifficultyCoef = {0.3, 0, 0}


require("engine/templates/itemContainer.lua");

require("engine/templates/characterMemory.lua");

CharacterTemplate = {};
CharacterTemplate = utils.inherit(Character);
require("engine/templates/characterPerception.lua");


CHARACTER_MIN_RELATIVE_SPEED_FOR_ANIMATION = 0.2;

CharacterTemplate.data = {};

-- восприятие персонажем других объектов
CharacterTemplate.data.enablePerception = false;

-- таблица для записи переменных (input/output) пользователя, будет автоматически загружаться и сохраняться
CharacterTemplate.data.io = CharacterTemplate.data.io and CharacterTemplate.data.io or {};

-- параметры персонажа (HP, MP) временно
CharacterTemplate.data.stats = {};
CharacterTemplate.data.stats.spRegeneration = 1

-- главный коэфициент изменения полученых повреждений
CharacterTemplate.data.masterDamageCoefitient = 1;


-- список исполнительных механизмов
CharacterTemplate.effectors = {};

-- дальность "зрения"  и угол обзора
CharacterTemplate.viewLenght = 20;
CharacterTemplate.fov = 360;
CharacterTemplate.turnSpeed = 50;

CharacterTemplate.inventory = {};
CharacterTemplate.inventory = utils.inherit(InventoryTable);
CharacterTemplate.slot = {};
CharacterTemplate.slot = utils.inherit(SlotTable);

CharacterTemplate.memory = {};
CharacterTemplate.memory = utils.inherit(CharacterMemory);
CharacterTemplate.visionUpdateInterval = 2;

CharacterTemplate.necroVisionType = OBJ_NV_ALIVE;

function CharacterTemplate:saveInGameState(flag)
	CharacterTemplate.Parent.saveInGameState(self,flag);
	for k,v in pairs(self.inventory.items) do 
		v:saveInGameState(flag);
	end
end



local partIdxToName = {[Character.BODY] = "body",
					[Character.BEARD] = "beard",
					[Character.HAIR] = "hair",
					[Character.HEAD] = "head",}

function CharacterTemplate:changeBodyPart(partName, fileName, preset)
	self.data.bodyParts = self.data.bodyParts and self.data.bodyParts or {};
	
	assert(partName == Character.BODY or partName == Character.HEAD or partName == Character.HAIR or partName == Character.BEARD or
		partName == "body" or partName == "beard" or partName == "hair" or partName == "head");
		
	if(type(partName) == "number") then
		partName = partIdxToName[partName];
	end
		
	self.data.bodyParts[partName] = self.data.bodyParts[partName] and self.data.bodyParts[partName] or {};
	self.data.bodyParts[partName].fileName = fileName;
	self.data.bodyParts[partName].preset = preset;
	self:applyBodyParts(true, partName);
end


function CharacterTemplate:applyBodyParts(initNow, partName)
	if(self.data.bodyParts.body and (partName == nil or partName == "body")) then
		self:setBodyPart(Character.BODY, self.data.bodyParts.body.fileName, 
			self.data.bodyParts.body.preset, initNow);
	end
	if(self.data.bodyParts.head and (partName == nil or partName == "head")) then
		self:setBodyPart(Character.HEAD, self.data.bodyParts.head.fileName, 
			self.data.bodyParts.head.preset, initNow);
	end
	if(self.data.bodyParts.hair and (partName == nil or partName == "hair")) then
		self:setBodyPart(Character.HAIR, self.data.bodyParts.hair.fileName, 
			self.data.bodyParts.hair.preset, initNow);
	end
	if(self.data.bodyParts.beard and (partName == nil or partName == "beard")) then
		self:setBodyPart(Character.BEARD, self.data.bodyParts.beard.fileName, 
			self.data.bodyParts.beard.preset, initNow);
	end
end

function CharacterTemplate:load(loadTable)
	-- части тела, инициализируем до вызова родительской функции, чтобы моделька создалась
	--с прочитанными значениями		
	self.inventory.owner = self
	self.slot.owner = self
	self.slot:load(loadTable)
	if(loadTable.bodyParts) then
		self.data.bodyParts = self.data.bodyParts and self.data.bodyParts or {};		
		self.data.bodyParts.body = loadTable.bodyParts.body;
		self.data.bodyParts.head = loadTable.bodyParts.head;
		self.data.bodyParts.hair = loadTable.bodyParts.hair;
		self.data.bodyParts.beard = loadTable.bodyParts.beard;
		
		if self:tag() == "Avatar" then	
			self.data.defaultHair = loadTable.defaultHair and loadTable.defaultHair or self.data.bodyParts.hair;
		end
		self:applyBodyParts(false);
	end
	
	--чтобы для charactera по умолчанию enableлись хитбоксы
	if loadTable.hitBoxesFileName and (loadTable.isHitBoxesEnabled == nil) then
		self.data.enableHitBoxesByDefault= true;
	end		
	
	CharacterTemplate.Parent.load(self, loadTable);		
	
	self.data.necroVisionType = loadTable.necroVisionType or self.necroVisionType;
	if self.data.necroVisionType then
		self:setNecroVisionType(self.data.necroVisionType);
	end
	
	self.data.thumbnail = loadTable.thumbnail and loadTable.thumbnail or self.data.thumbnail
	
	self.data.name = loadTable.name and loadTable.name or self.data.name
	
	self.data.team = loadTable.team and loadTable.team or self.data.team;
	
	self.data.enablePerception = loadTable.enablePerception;
	
	self.data.viewLenght = loadTable.viewLenght;
	
	self.memory.owner = self;
			
	if(loadTable.enemySelectionCriteria) then
		assert(loadTable.enemiesList and istable(loadTable.enemiesList), " for '"..self:tag().."' field 'enemiesList' must be specified when with 'enemySelectionCriteria': "..loadTable.enemySelectionCriteria);
		self.memory:setEnemySelectionCriteria(loadTable.enemySelectionCriteria);
		self.memory:setEnemiesList(loadTable.enemiesList);
	end
	self.data.needFakeWeapon = loadTable.needFakeWeapon;
	
	
	if loadTable.coefficientsOfDamage then
		self.data.coefficientsOfDamage = loadTable.coefficientsOfDamage;
		self.data.ownCoefficientsOfDamage = true;
	end
		
	self.data.stats = loadTable.stats and DuplicateTable(loadTable.stats) or self.data.stats;
	
	
	self.data.stats.maxHp = self.data.stats.maxHp and self.data.stats.maxHp or self.data.stats.hp
	
	-- коэффициент замедления скорости
	self.data.velocityK = 1.0;
	
	if istable(loadTable.wayPointsTags) then
		self.data.wayPointsTags = loadTable.wayPointsTags;
	else
		self.data.wayPointsType = loadTable.wayPointsType;
		if self.data.wayPointsType == "findByMask" then
			self.data.wayPointsMask = loadTable.wayPointsMask;
		end
	end
	
	self.data.cantDrawWeapon = loadTable.cantDrawWeapon;

	self.data.cantMove = loadTable.cantMove;
	
	self.data.xpCost = loadTable.xpCost and loadTable.xpCost or self.data.xpCost	
	
	self.data.damageEffects = loadTable.damageEffects and loadTable.damageEffects or self.data.damageEffects	
	
	self.data.stateName = loadTable.state and loadTable.state or "normalState";
	self.data.stateData = loadTable.stateData
	
	
	self.data.currentIdle = loadTable.currentIdle;
	--может устанавливать originalIdle как currentIdle только "normalState"? 
	self.data.currentIdle = loadTable.originalIdle and loadTable.originalIdle or loadTable.currentIdle;
	self.data.anchors = loadTable.anchors;
	
	--print("self:tag() = ", self:tag())

	if self:isAutoActivation() then		
		local radius = self:getActivationRadius();
		local pos = {self:getPosition()}
		pos[2] = pos[2] + 0.1

		--drawShape(Geometry.sphere, pos, {radius, 0.01, radius}, nil, self:tag().."ActRadius");
	end

	self.data.walkMode = loadTable.walkMode;
	

	self.data.undamageable = loadTable.undamageable;
	
	self.data.giveItemPrototype = loadTable.giveItemPrototype;
	
		self.data.ignoreDamage = loadTable.ignoreDamage -- при получении повреждений не атаковать нападающего

	self.data.usability = loadTable.usability;
	self.data.hiddenWeaponTag = loadTable.hiddenWeapon;
	self.data.hiddenOneHandSwordTag = loadTable.hiddenOneHandSword;
	-- в режиме редактора особые настройки
	-- if(g_editor) then
		-- Editor.initVisualGameObject(self);
	-- end
	
	self.data.isPlayerControlledFlag = loadTable.isPlayerControlledFlag; -- флаг для аттача контроллера

	-- проверяем чем у нас является damageBonus, для аватара это табличка, для бота - индекс в глобальной таблице
	if loadTable.damageBonus then		
		if isstring(loadTable.damageBonus) then
			print('loadTable.damageBonus = ', loadTable.damageBonus)
			self.data.damageBonus = damageBonusTable[loadTable.damageBonus]
			self.data.damageBonusName = loadTable.damageBonus
		else
			PrintTable(loadTable.damageBonus)
			self.data.damageBonus = loadTable.damageBonus
		end
		self.data.damageBonusLoaded = true;
	end
	
	if self:tag() == "Avatar" then
		avatar = self;
		self.data.damageBonus = self.data.damageBonus and self.data.damageBonus or {}
	end
	
	
	self.data.summonsPrototypes = loadTable.summonsPrototypes; -- имена прототипов призываемых созданий
	self.data.summonsAmount = loadTable.summonsAmount
	
	self.data.allowedAttacks = loadTable.allowedAttacks; -- список атак которые может применять персонаж, если таблица не задана по умолчанию разрешены все
	self.data.disallowedAttacks = loadTable.disallowedAttacks; -- список атак которые может применять персонаж, если таблица не задана по умолчанию разрешены все
	self.data.isPassive = loadTable.isPassive; -- является ли персонаж пассивным (не апдейтится память)
	
	self.data.activateFx = loadTable.activateFx; 
	
	self.data.dontSaveActions = loadTable.dontSaveActions	
	
	self.data.resists = loadTable.resists and loadTable.resists or self.data.resists
	self.data.resistsTableName = loadTable.resistsTableName
	
	self.data.notNeedSoundAlert = loadTable.notNeedSoundAlert
	self.data.ignoreCollision = loadTable.ignoreCollision
	
	if not self.data.dontSaveActions then
		self.data.loadedActions = loadTable.actions
	end
	
	if loadTable.isUnhiding then				--восстановлениe параметров после сейва во время начала перехода в нормал стейт
		self:unhide();
	end
	self.data.magicSlot = loadTable.magicSlot;
	
	self.data.magicResists = loadTable.magicResists and loadTable.magicResists or self.data.magicResists;
end


function CharacterTemplate:save(saveData)
	if(g_editor) then
		Editor.restoreVisualGameObject(self);
	end

	CharacterTemplate.Parent.save(self,saveData);	

	if self.data.name then
		saveData.name = self.data.name;
	end
	if self.data.thumbnail then
		saveData.thumbnail = self.data.thumbnail;
	end	
	saveData.bodyParts = self.data.bodyParts;
	saveData.hiddenWeapon =self.data.hiddenWeapon and  self.data.hiddenWeapon:tag() or nil;
	saveData.hiddenOneHandSword =self.data.hiddenOneHandSword and  self.data.hiddenOneHandSword:tag() or nil;
	if self == twController.getControlled() then
		saveData.defaultHair = self.data.defaultHair;
	end
	
	if self.data.ownCoefficientsOfDamage then
		saveData.coefficientsOfDamage = self.data.coefficientsOfDamage;
	end
	saveData.stats = self.data.stats;
	
	if self.data.viewLenght and self.data.viewLenght != self.viewLenght then
		saveData.viewLenght = self.data.viewLenght;
	end

	saveData.state = self:getStateName();
	if not saveData.state then
		saveData.state = self.data.stateName;
	end

	saveData.slot = self.slot:save();
	
	if self.data.stateData then
		saveData.stateData = self.data.stateData
	else
		if self:getState() and self:getState().save then
			saveData.stateData = self:getState().save(self)
		end
	end
	
	saveData.team = self.data.originalTeam and self.data.originalTeam or self.data.team;
	
	saveData.enablePerception = self.data.enablePerception;	
	
	saveData.enemySelectionCriteria = self.data.originalEnemySelectionCriteria and self.data.originalEnemySelectionCriteria or self.memory:getEnemySelectionCriteria();
	saveData.enemiesList = self.data.originalEnemies and self.data.originalEnemies or self.memory.enemies;
	saveData.needFakeWeapon = self.data.needFakeWeapon;
	
	saveData.wayPointsMask = self.data.wayPointsMask;
	saveData.wayPointsType  = self.data.wayPointsType;
	saveData.wayPoints  = self.data.wayPoints;
	saveData.wayPointsTags  = self.data.wayPointsTags;
	saveData.cantDrawWeapon  = self.data.cantDrawWeapon;	
	saveData.currentIdle = self.data.currentIdle;
	saveData.originalIdle = self.data.originalIdle;
	
	saveData.anchors = self.data.anchors;
	
	if self.data.originalCantMove != nil then
		saveData.cantMove = self.data.originalCantMove;
	else
		saveData.cantMove = self.data.cantMove
	end
	if self.data.isUnhiding then
		saveData.isUnhiding = self.data.isUnhiding;
		saveData.cantMove = self.data.originalCantMove;
	end
	
	saveData.undamageable = self.data.undamageable
	
	saveData.giveItemPrototype = self.data.giveItemPrototype
	
	if(self.data.walkMode) then
		saveData.walkMode = self.data.walkMode;
	end	
	
	saveData.xpCost = self.data.xpCost;		
	
	saveData.resists = self.data.resists;		
	saveData.resistsTableName = self.data.resistsTableName;		

	if(g_editor) then
		saveData.spawnPoint = {self:getPosition()};
	end


	-- if(g_editor) then
		-- Editor.restoreVisualGameObject(self);
	-- end
	
	saveData.usability = self.data.usability;
	saveData.ignoreDamage = self.data.ignoreDamage;
	
	-- табличку с бонусами к повреждениям сохраняем только для аватара, иначе сохраняем если есть индекс в глобальной таблице
	if self.data.damageBonusLoaded then
		if self.data.damageBonusName then
			saveData.damageBonus = self.data.damageBonusName
		else
			saveData.damageBonus = self.data.damageBonus
		end
	end
	if self:isPlayerControlled() then
		saveData.damageBonus = self.data.damageBonus;
	end
	
	saveData.summonsPrototypes = self.data.summonsPrototypes
	saveData.summonsAmount = self.data.summonsAmount
	
	saveData.allowedAttacks = self.data.allowedAttacks
	saveData.disallowedAttacks = self.data.disallowedAttacks
	saveData.isPassive = self.data.isPassive
	
	saveData.activateFx = self.data.activateFx
	
	
	saveData.notNeedSoundAlert = self.data.notNeedSoundAlert
	
	saveData.dontSaveActions = self.data.dontSaveActions
	-- сохранение параметров action'ов для последующего восстановления
	if not self.data.dontSaveActions then
		saveData.actions = {}
		for i, v in pairs(self.ALL_EFFECTORS) do		
			local effector = self.effectors[v];
			local action = effector.action;
			if action then
				saveData.actions[effector.actionName] = action:save();
			end		
		end
	end
	
	if self.necroVisionType != self.data.necroVisionType then
		saveData.necroVisionType =  self.data.necroVisionType;
	end
	if self.data.magicSlot then
		saveData.magicSlot = self.data.magicSlot;
	end
	
	if self.data.magicResists then
		saveData.magicResists = self.data.magicResists
	end
		
end 

function CharacterTemplate:initialize()						
	--print("CharacterTemplate:initialize() "..self:tag());
	--enable хитбоксов по умолчанию
	
	if self.data.enableHitBoxesByDefault then
		self:enableHitBoxes(true)
	end;
	self:setAction("move");
	if self != avatar and not self.data.isPassive then
		self:setAction("think");
	end
	
	---инициализация предметов в инвентаре
	self.inventory.owner = self;
	self.inventory.initialize(self.inventory);	
	if (self.needFakeWeapon or self.data.needFakeWeapon) and not self.data.isPassive then
		self:createFakeWeapon();
	end
	for i, v in pairs(self.inventory.items) do
		v:setOwner(self);
	end	
	--инициализация предметов в слотах
	self.slot:initialize();
	for i,v in pairs(self.slot.items) do
		v:setOwner(self);
		--if not v.data.cannotEquip then
			-- self:equip(v);
		-- end
	end
	if self != avatar then
		-- проверка наличия оружия и снарядов для разрешения или запрещения атак
		self:weaponChecker();
	end
	
	self:onEnable(self:isEnabled());	
	
	self:setState(self.data.stateName);	
	if self:getState().load then
		self:getState().load(self, self.data.stateData)
		self.data.stateData = nil;
	end
	
	if self.data.currentIdle then
		self["normalState"].visualTables.currentIdle = {{visual = self.data.currentIdle, weight = 1}}
	end
	
	-- если персонаж не активен, мы все равно подготавливаем анимацию, чтобы при его 
	-- активации начальная позиция была корректно просчитана
	if not self:isEnabled() then
		local visualTableName = self:selectVisualByDirection();
		if visualTableName then
			self:playVisual(visualTableName, true, {"body"}, 0);
		end
	end
	
	
	if self.data.walkMode then
		self:runMode(false)
	end
	
	--поиск и инициализация вейпойнтов
	if	self.data.wayPointsType then 
		self:findWayPoints();
	elseif self.data.wayPointsTags then
		self.data.wayPoints = {};
		for i, v in pairs(self.data.wayPointsTags) do
			local wp = GameScene.getObject(v);
			assert(wp, "Obj "..self:tag().." No such waypoint is scene: "..v);
			table.insert(self.data.wayPoints, wp);
		end
	end
	self.data.updateTime = getGameTime();
	
	if self.data.hiddenWeaponTag and  GO(self.data.hiddenWeaponTag) then
		local item = GO(self.data.hiddenWeaponTag);
		if  item.data.attachData.hidden then
			self.data.hiddenWeapon = item;
			self:attachObject(item, Character.BODY, item.data.attachData.hidden.attachBone, item.data.attachData.hidden.attachTm );
		end
		
	end
	if self.data.hiddenOneHandSwordTag and  GO(self.data.hiddenOneHandSwordTag) then
		local item = GO(self.data.hiddenOneHandSwordTag);
		if  item.data.attachData.hidden then
			self.data.hiddenOneHandSword = item;
			self:attachObject(item, Character.BODY, item.data.attachData.hidden.attachBone, item.data.attachData.hidden.attachTm );
		end
		
	end	

	self.data.isPlayerControlledFlag = nil --флаг больше не нужен	

	
	--self:checkAllowedAttacks()
	
	if self.data.summonsPrototypes then
		self:precashSummons()	
	end
	
	if self.data.loadedActions then
		for i, v in pairs(self.data.loadedActions) do
			self:setAction(i, v);
		end
	end
	
	
	self:setMagicSlot(self.data.magicSlot,true);
	
	CharacterTemplate.Parent.initialize(self);
	
end

-- устанавливает вектор направления движения
function CharacterTemplate:setMoveDir(moveDir)
	self.data.moveData.dir = moveDir;
end	

function CharacterTemplate:getMoveDir()	
	-- отойти от углов пока не вижу никакой возможности, потому как нужно регулярно поворачивать вектор направления движение вслед за поворотом камеры
	-- иначе аватар перемещается в заданом направлении но с неадекватными анимациями
	if self.data.moveData.angle then	
		if self.data.moveData.angle >= 0 then
			local x, y, z = self:getLookDir();	
			x, z = rotateVector2(x, z, self.data.moveData.angle)
			y = 0;		
			self.data.moveData.dir = {x, y, z}	
		else	
			self.data.moveData.dir = NULL_VECTOR()
		end
	end	
	return self.data.moveData.dir and self.data.moveData.dir or NULL_VECTOR()
end

function CharacterTemplate:getVelocity()
	return self.data.moveData.velocity and self.data.moveData.velocity or 0;
end

-- onoaiaaeeaaao oaie iai?aaeaiey aae?aiey
function CharacterTemplate:setDirAngle(angle)
	self.data.moveData.angle = angle;
end

-- iieo?aai oaie aaeoi?a nei?inoe	
function CharacterTemplate:getDirAngle()
	return self.data.moveData.angle;
end


function CharacterTemplate:calcOwnPlace(commanderTag)
	local commander  = GO(commanderTag);
	if not GameScene.checkObject(commander) then 
		print("No commander");
		return;
	end
	self.data.ownPlaceData = {};
	local destination = {commander:getPosition()}
	self.data.ownPlaceData.angle = getAngleFromVectorsXZwithSign(getDirection2D(destination,{self:getPosition()}),{commander:getLookDir()});
	self.data.ownPlaceData.fixedDist = math.sqrt(getDist2ObjectSq(self,commander));
	self.data.ownPlaceData.commander = commander;
end
	
function CharacterTemplate:setOnOwnPlace()
	assert(self.data.ownPlaceData and self.data.ownPlaceData.commander);
	local commander = self.data.ownPlaceData.commander;
	local tarLookDir = {commander:getLookDir()};
	local tx,tz = rotateVector2(tarLookDir[1],tarLookDir[3],self.data.ownPlaceData.angle);
	local rotatedLookDir = {tx,0,tz}
	local destination = vectorAdd({commander:getPosition()},scalarMul(rotatedLookDir,self.data.ownPlaceData.fixedDist));
	self:setPosition(destination);
	self:setLookDir(tarLookDir);
end

function CharacterTemplate:onEnable(isEnabled)
	CharacterTemplate.Parent.onEnable(self, isEnabled);	
	
	self.data.updateTime = getGameTime();
	-- for i,v in pairs(self.slot.items) do
		-- if (v != nil) then
			-- v:enable(isEnabled);
		-- end
	-- end
	
	-- вкл/выкл все loop-ed звуки
	for i, v in pairs(self.effectors) do
		if(v.sounds != nil) then
			for ii,vv in pairs(v.sounds) do
				if(isEnabled) then
					ResumeSound(vv);
				else
					PauseSound(vv);
				end
			end		
		end
	end
end

function CharacterTemplate:update()

	CharacterTemplate.Parent.update(self);
	if self.data.isDead then return end
	
	local curTime = getGameTime();
	--------------------------------
	-- проитерироваться по всем эффекторам и обновить action-ы, вызвать update
	--------------------------------
	if noaction then return end;
	for i, v in pairs(self.effectors) do
		if v.action and (not v.action.updated) then
			--check update time
			if not v.updateTime or v.updateTime < curTime  - v.lastUpdateTime then
				v.action.updated = true;	--экшены назначенные на несколько эффекторов должны апдейтится только один раз
				if not v.action.needToBeDestroyed then
					v.action.update(v.action);
				end
				if v.action and v.action.needToBeDestroyed then
					v.action.terminate(v.action);
				end
				v.lastUpdateTime = curTime;
			end
		end		
	end	
	
	for i, v in pairs(self.effectors) do
		if v.action and v.action.updated then v.action.updated = false end;
	end
	

	
	if g_editor then return end
		
	if(self.data.enablePerception) then
		if not self.data.visionUpdateTimer or self.data.visionUpdateTimer() == 0 then
			self.data.visionUpdateTimer = createCountdown(self.visionUpdateInterval);
			self:updateVision();		
		end
		self.memory:update();
		
		--активизировать соседних NPC (для персонажей с авто активизацией)
		if self:isAutoActivation() then
			if not self.data.activateFriendTimer or self.data.activateFriendTimer() == 0 then
				self.data.activateFriendTimer = createCountdown(1);
				self:activateFriendNPC();
			end
		end	
	end	
	
	
	if self:isPlayerControlled() then	
	
		--активизировать/деактивизиоравать NPC( для аватара)
		if not self.data.activateTimer or self.data.activateTimer() == 0 then
			self.data.activateTimer = createCountdown(1);
			self:activateNPC();
		end
		
		if self.data.updateTime then
			local gameTime = getGameTime();		
			
			self.data.updateTime = gameTime - self.data.updateTime;
			
			if self.data.stats.hpRegeneration and self:getHp() and self:getMaxHp() and self:getHp() < self:getMaxHp() then					
				local hpRegeneration = self.data.stats.hpRegeneration * self.data.updateTime;
				self:setHp(self:getHp() + hpRegeneration)
			end
			
			if self.data.stats.spRegeneration and self:getStateName()!="eyeOfTruth" and self:getSp() and self:getSp() < self:getMaxSp() then		
				local spRegeneration = self.data.stats.spRegeneration * self.data.updateTime;
				self:setSp(self:getSp() + spRegeneration)
			end
			self.data.updateTime = gameTime;
		end
	end

	if self.data.currentState and self.data.currentState.updateFunc then
		self.data.currentState.updateFunc(self);
	end
	
	if self.data.needToRotate then
		local ld = {self:getLookDir()}
		ld[1], ld[3] = rotateVector2(ld[1], ld[3], self.data.needToRotate * (curTime - self.data.lastUpdateTime))
		self:setLookDir(ld);
	end
	
	self.data.lastUpdateTime = curTime;
	--self.data.lastFrameCountUpdate = getFrameCount();
end

function CharacterTemplate:isPlayerControlled()
	return  not twController.getControlled() and isPlayerControlledFlag or self == twController.getControlled();
end


-- подготовить структуры визуальных состояний к использованию 
function CharacterTemplate:prepareVisuals()

	if(self.data.visualsPrepared == true) then return end
	
	print('self:tag() = ', self:tag())

	--local file = getFilePointer(TW_SCRIPTS, "anims.csv", "w")			
	for i, v in pairs(self.visualStates) do
		-- animation
		assert(v and v.animation and v.animation.id, "Invalid visual:"..i);
		
		v.animation.model = v.animation.model and v.animation.model or Character.BODY;
		
		v.animation.idx = self:findAnimById(v.animation.model, v.animation.id);
		--file:write(v.animation.id.."; "..v.animation.idx.."\n");
		assert(v.animation.idx != -1, self:tag().." anim not found:"..v.animation.id.." try to Get latest version of Skeleton folder from your AlienBrain!!!!!");
		
		v.animation.duration = self:getAnimationDuration(v.animation.model, v.animation.idx);
		
		if(v.animation.callbacks) then
			self:setAnimationCallbacks(v.animation.model, v.animation.idx, v.animation.callbacks);
		end
		
		-- sounds
		if(v.sound) then
			v.sounds = v.sounds and v.sounds or {};
			table.insert(v.sounds, v.sound);
			v.sound = nil;
		end
		if(v.sounds) then
			for ii,vv in pairs(v.sounds) do
				if(self.sounds and vv.name) then
					vv.id = self.sounds[vv.name];
				end
			end
		end
	end

	--closeFiles()
	self.data.visualsPrepared = true;

end


function CharacterTemplate:prepareState(state)
	if(state.prepared == true) then return end
	
	-- нормализировать веса случайного выбора
	for i, v in pairs(state.visualTables) do
		assert(table.getn(v)>0);
		
		local sum = 0;
		for ii, vv in pairs(v) do
			if(vv.weight == nil) then
				vv.weight = 1;
			end
			sum = sum + vv.weight;
		end
		local weight = 0;
		for ii, vv in pairs(v) do
			weight = weight + (vv.weight/sum);
			vv.weight = weight;			
		end
	end
		
	state.prepared = true;
end

-- выбрать наиболее подходящее визуальное состояние по текущему вектору направления перемещения
function CharacterTemplate:selectVisualByDirection(isSpining)	
	-- если не прописаны состояния передвижения, значит мы находимся в idle	
	
	--if not _d4 then
		-- if self.data.lastFrameCountUpdate == getFrameCount() then
			-- return;
		-- end
	--end	
	
	local visualTableNameIdle = self:getState().visualTables.currentIdle and "currentIdle" or "idle";
	if not self:getState().visualTables[visualTableNameIdle] then 
		visualTableNameIdle = nil 
	end;
	local visualTableName = visualTableNameIdle;
	
	self.data.isMoving = false;
	
	local moveDir = self:getMoveDir();
	local speed = getLenghtSq(self:getCurrentVelocity());
	local state = (isSpining and self:getState().spin) and self:getState().spin or self:getState().move;
	if not state or (moveDir[1] == 0 and moveDir[2] == 0 and moveDir[3] == 0) then return visualTableName end
		
	local maxDot = 0;
	for i, v in pairs(state) do
		local dot = self:getDotWithVector(v.dir);
		if maxDot <= dot then
			maxDot = dot;
			visualTableName = v.visualTableName;
			self.data.moveData.velocity = v.velocity;	
			self.data.isMoving = true;
		end
	end
	
	if self.data.moveData and 
		self.data.moveData.velocity and
		(speed / self.data.moveData.velocity) < CHARACTER_MIN_RELATIVE_SPEED_FOR_ANIMATION  and
		not isSpining then
		visualTableName = visualTableNameIdle;
	end
	
	return visualTableName;
end

function CharacterTemplate:releaseEffectors(effectorNames, dontStopAnimation)
	assert(type(effectorNames) == "table", "Wrong set of effector names! "..self:tag())		
	for i, v in pairs(effectorNames) do	
		--print("Effector = ", v)
		local effector = self.effectors[v];
		if effector then			
			effector.visualTableName = nil;
			effector.priority = -1;
			effector.state = nil;
			effector.action = nil;
			effector.actionName = nil					

			if effector.endActionCallback then
				effector.endActionCallback.func(self, effector.endActionCallback.params)			
			end
							
			if effector.animation != nil and not dontStopAnimation then		
				self:stopAnimation(effector.model, effector.animation);		
			end
			effector.animation = nil;
					
			-- звуки
			if(effector.sounds) then
				for i,v in pairs(effector.sounds) do
					self:stopSound(v);
				end
				effector.sounds = nil;
			end
		end
	end
end

function CharacterTemplate:checkAction(actionName)
	assert(self.actions[actionName]);
	local action = self.actions[actionName]
	return 	action:check(self);
end

function CharacterTemplate:setAction(actionTableName, params, overwriteSameAction, reinitSameAction)
	--print("CharacterTemplate:setAction(actionTableName, params, overwriteSameAction) = ", actionTableName)
	--------------------------------
	-- проверить занят ли эффектор, если занят то с каким приоритетом
	
	if self.data.isDead then return end
	if(not actionTableName or not self.actions[actionTableName]) then
		print(" CharacterTemplate:setAction for ", self:tag(), " action not found: "..actionTableName);
		return;
	end
	
	-- если наш приоретет выше того что был, то вызвать функцию terminate	
	-- создаем самостоятельный объект для того что бы избежать конфликта с указателями	
	if not self:checkAction(actionTableName) then return end

	local action = DuplicateTable(self.actions[actionTableName]);
	-- проверяем свободны ли запрошенные эффекторы
	for i, v in pairs(action.effectors) do
		assert(self.effectors[v], " Effector '"..v.."' doesn't exists.")
		if self.effectors[v].action and 
			(self.effectors[v].action.priority > action.priority or 
				(overwriteSameAction != true and self.effectors[v].actionName and 
				self.effectors[v].actionName == actionTableName)) then
					if self.effectors[v].actionName and self.effectors[v].actionName == actionTableName and reinitSameAction then
						self.effectors[v].action:init(params);
					end
				-- если приоритет действия на запрошенном эффекторе выше приоритета нового action-а или это тотже action
				-- print("SAME ACTION or lower priority "..actionTableName, " ", v, " ", self.effectors[v].actionName)
				return false;				
		else
			
			-- прерываем action'ы с меньшим приоритетом
			if self.effectors[v].action then
				self.effectors[v].action.terminate(self.effectors[v].action, v);					
			end
			
			--print("self.effectors[v].action = "..actionTableName)
			
			self.effectors[v].action = action;
			self.effectors[v].actionName = actionTableName;
		end
	end
	
	-- инициализируем новый action
	action:init(params);
	return true
end

function CharacterTemplate:resetAction(actionTableName)
	-- print("CharacterTemplate:resetAction(actionTableName) = ", actionTableName)
	local isReseted = nil;
	
	for i, v in pairs(self.effectors) do		
		if v.actionName == actionTableName then
			v.action.needToBeDestroyed = true;
			isReseted = true;
		end
	end
	
	return isReseted;
end

function CharacterTemplate:isExistAction(actionTableName)
	--print("CharacterTemplate:isExistAction(actionTableName) = ", actionTableName)
	local isExist = nil;
	
	for i, v in pairs(self.effectors) do		
		if v.actionName == actionTableName then
			isExist = true;
		end
	end
	
	return isExist;
end

function CharacterTemplate:destroyAction(actionTableName)
	-- print("CharacterTemplate:re(actionTableName) = ", actionTableName)
	for i, v in pairs(self.effectors) do		
		if v.actionName == actionTableName then
			v.action = nil;
			v.actionName = nil;
			--print("Action "..actionTableName.." was destroyed!!!!!!!")
		end
	end
end


function CharacterTemplate:checkVisual(visualTableName)
	return self:getState().visualTables[visualTableName] != nil
end

function CharacterTemplate:endNonCycleAnim(animIdx) 
	for i, v in pairs(self.effectors) do		
		if v.animation == animIdx then
			v.priority = -1	
			--v.animation = nil;
		end
	end
end


-- Проигрывает анимацию и звук, устанавливает флаги на указанном множестве эффекторов персонажа
-- Если есть возможность захватить ресурс, то случайным образом выбирает запись из таблицы визуализации.
function CharacterTemplate:playVisual(visualTableName, loop, effectorNames, priority, callbackOnEnd, timeOffset, restartSameVisual, smoothRestart, visualRecordIdx)
	-- проверку на наличие данного visualState'а лучше провести заранее, до освобожддения эффекторов
	-- зачем пытатся проиграть visual которого нет?
	local visualTable = self:getState().visualTables[visualTableName];
	assert(visualTable, self:tag().." wrong VisualTableName = "..visualTableName);
	assert(type(visualTable) == "table", "wrong VisualTableName "..visualTableName);
	assert(type(effectorNames) == "table", "wrong effectorNames, must be set of effectors names")
	
	local visualChanged = false;
	local usedEffectors = {};
	local animationsToStop = {};
	local soundsToStop = {};
		
	for i, v in pairs(effectorNames) do
		local effector = self.effectors[v];
		if(effector.priority <= priority) then
			if((restartSameVisual == true or effector.visualTableName != visualTableName) or
				effector.state != self:getStateName()) then
				visualChanged = true;
				effector.visualTableName = visualTableName;
				effector.priority = priority;
				effector.state = self:getStateName(); -- раньше тут сохранялся стейт целиком, зачем это делалось я не знаю, но пока я сохраняю только имя стейта

				if(effector.animation != nil) then
					animationsToStop[effector.animation] = effector.model;
				end
				
				-- звуки
				if(effector.sounds != nil) then
					for i,v in pairs(effector.sounds) do
						soundsToStop[v] = 1; 
					end		
				end	
				table.insert(usedEffectors, effector);
			end
		else
			--if self != avatar then	print(" Cant play visual "..visualTableName.." effector "..v.." , ", effector.visualTableName);	end	
		end
	end
	
	-- приоритеты не позволяют отыграть данный visual так как эффектор уже занят
	if(visualChanged == false) then return end
	
	-- остановить анимации, запущенные на эффекторах
	for i, v in pairs(animationsToStop) do
--		print(" stop animation "..i);
		self:stopAnimation(v, i);
	end
	-- остановить звуки
	for i, v in pairs(soundsToStop) do
		--print(" stop sound "..i);
		self:stopSound(i);
	end
	
	-- выбрать случайным образом, используя visualRecord.weight
	local chance = math.random(0, 10) / 10;
	
	local visualRecord = nil
	if visualRecordIdx then
		visualRecord = visualTable[visualRecordIdx];
	else
		visualRecordIdx = 1;
		visualRecord = visualTable[visualRecordIdx];
		for i, v in ipairs(visualTable) do
			local lowerThreshold = visualTable[i - 1] and visualTable[i - 1].weight or 0;
			local upperThreshold = visualTable[i].weight and visualTable[i].weight or 1;
			if chance > lowerThreshold and chance <= upperThreshold then
				visualRecordIdx = i
				visualRecord = visualTable[i];
			end
		end	
	end
	
	--print("visualTableName = ", visualTableName)
	--print("visualRecord.visual = ", visualRecord.visual)
	assert(visualRecord.visual and self.visualStates[visualRecord.visual], "State not found for Character '"..self:tag().."' visualTableName = "..visualTableName.." ,visualRecord.visual = "..visualRecord.visual);
	local animation = self.visualStates[visualRecord.visual].animation;
--	print(" playVisual animation "..animation.idx);

	if(not timeOffset and animation.offsetFrame) then
		timeOffset = animation.offsetFrame * ANIM_FRAME_TIME
	end
	if self==mm then
		print("play anim for mm: ",visualTableName);
	end
	
	-- не цикличские анимации, вызываемые не action'ами не освобождают по завершению эффекторы
	-- потому пришлось добавить callback который освобождает эффектор
	if not loop then 
		if not callbackOnEnd then
			callbackOnEnd = self.endNonCycleAnim;	
		else
			self.data.animCallbacks = self.data.animCallbacks and self.data.animCallbacks or {};
			self.data.animCallbacks[animation.idx] = callbackOnEnd;
			callbackOnEnd = function(self, animIdx)				
				if istable(self.data.animCallbacks[animIdx]) then
					functionBinder(self.data.animCallbacks[animIdx])
				else
					self.data.animCallbacks[animIdx](self, animIdx)
				end				
				self.data.animCallbacks[animIdx] = nil
				self:endNonCycleAnim(animIdx);
			end
		end
	end
	
	self.data.animSpeedUpCoefficient = self.data.animSpeedUpCoefficient and self.data.animSpeedUpCoefficient or 1
	
	self:playAnimation(animation.model, animation.idx, loop, animation.speed * self.data.animSpeedUpCoefficient, callbackOnEnd, animation.lockPose, timeOffset, smoothRestart);
	
	if(animation.blendWeight) then
		self:setActionWeight(animation.model, animation.idx, animation.blendWeight);
	end	
	
	local soundIdxTable = {};	
	local soundsTable = self.visualStates[visualRecord.visual].sounds;
	if(soundsTable) then
		for i, v in pairs(soundsTable) do
			local soundInfo = v;
			
			if(soundInfo.id and soundInfo.id != -1) then
				local sndId = nil;
				-- если в качестве id передана таблица, то выбираем случайным образом звук из нее
				if(istable(soundInfo.id)) then
					sndId = soundInfo.id[math.random(1, table.getn(soundInfo.id))];
				else
					sndId = soundInfo.id;
				end
				
				local soundIdx = self:playSound(sndId, nil, nil, loop, soundInfo.volume, soundInfo.minDist, soundInfo.maxDist);
				if(soundInfo.freqMult) then
					setChannelFrequencyMultiplier(soundIdx, soundInfo.freqMult);
				end	
				soundIdxTable[i] = soundIdx;
			end	
		end	
	end
	
	
	
	-- запомнить какая анимация запустилась на используемых ресурсах
	for i, v in pairs(usedEffectors) do
		v.animation = animation.idx;
		v.model = animation.model;
		v.sounds = soundIdxTable;
	end
	return animation, soundsTable, visualRecordIdx;
end

function CharacterTemplate:createFakeWeapon(modelName)
	modelName = modelName and modelName or "models/test/w1234_WeaponBox.OBJ.XML"
	self.data.fakeWeapon = {};
	self.data.fakeWeapon.item1 = GameScene.createObject(self:tag().."WeaponRight", "FakeWeapon", {
				tm = MATRIX_IDENTITY(),
				visualFileName = modelName,
				hitBoxesFileName = "byBoundingBox",
				isShown = false,
				isEnabled = false,
				["type"] = "fakeWeapon",
				attachData = {
					bare = {
						attachTm = self.data.fakeWeaponAttachTm or MATRIX_IDENTITY(), 
						attachBone = "slot1",
					},
					hidden = {
						attachTm=MATRIX_IDENTITY(), 
						attachBone = "slot1",
					}
				}
			});
	self.data.fakeWeapon.item2 = GameScene.createObject(self:tag().."WeaponLeft", "FakeWeapon", {
				tm = MATRIX_IDENTITY(),
				visualFileName = modelName,
				hitBoxesFileName = "byBoundingBox",
				isShown = false,
				isEnabled = false,
				["type"] = "fakeWeapon",
				attachData = {
					bare = {
						attachTm = self.data.fakeWeaponAttachTm or MATRIX_IDENTITY(), 
						attachBone = "slot2",
					},
					hidden = {
						attachTm=MATRIX_IDENTITY(), 
						attachBone = "slot2",
					}
				}
			});
	assert(self.data.fakeWeapon.item1 and self.data.fakeWeapon.item2, "Fake weapon was not created")
	
	self.data.fakeWeapon.item1:needToSave(false);
	self.data.fakeWeapon.item2:needToSave(false);	
	
	self.data.fakeWeapon.item1:enableHitBoxes(false);
	self.data.fakeWeapon.item2:enableHitBoxes(false);
	
		
	self.data.fakeWeapon.item1.data.damageType = "claws";	
	self.data.fakeWeapon.item2.data.damageType = "claws";	
		
	addItemToInventory(self, self.data.fakeWeapon.item1);
	addItemToInventory(self, self.data.fakeWeapon.item2);
	fromInventoryToSlot(self,"fakeWeaponSlot",self.data.fakeWeapon.item1);
	fromInventoryToSlot(self,"fakeWeaponSlot2",self.data.fakeWeapon.item2);
	
	self:equip(self.data.fakeWeapon.item1);
	self:equip(self.data.fakeWeapon.item2);
	
	self.data.fakeWeapon.item1:show(false);
	self.data.fakeWeapon.item2:show(false);
		
end


function CharacterTemplate:setState(stateName, withoutAnim)
	assert(istable(self[stateName]), self:tag().."NO such state = "..stateName);

	if self.data.currentState then	
		if self.data.currentState.terminateFunc then
			self.data.currentState.terminateFunc(self,stateName);
		end
	
		if self.data.currentState.changeState and 
				self.data.currentState.changeState[stateName] and 
				self.data.currentState.changeState[stateName] ["beginFunc"] then
			self.data.currentState.changeState[stateName]  ["beginFunc"](self);
		end	
	end
	
	if not self.data.currentState and self[stateName].changeState["default"]  and self[stateName].changeState["default"] ["beginFunc"]then
		self[stateName].changeState["default"] ["beginFunc"](self)		
	end
	
	local endCallback = nil;
	
	if self:getState() and self:getState().changeState and self:getState().changeState[stateName] then
		local visualTableName = self:getState().changeState[stateName] ["visualTableName"];	
		endCallback = self:getState().changeState[stateName] ["endFunc"]				
		if not withoutAnim and visualTableName then
			local effectorsList = self:getState().changeState[stateName] ["effectorsList"];
			local priority = self:getState().changeState[stateName] ["priority"];						
			self:playVisual(visualTableName, false, effectorsList, priority, endCallback);				
			endCallback = nil;
		end
	end
	
	self.data.currentStateName = stateName;
	self.data.currentState = self[stateName];
	
	if self.data.currentState.initializeFunc then
		self.data.currentState.initializeFunc(self, self.data.currentState);
	end
	
	if endCallback then
		endCallback(self, self.data.currentState);
	end
end

function CharacterTemplate:getState()
	return self.data.currentState;
end

function CharacterTemplate:getStateName()
	return self.data.currentStateName;
end

function CharacterTemplate:equip(item)
	assert(item and item.data.attachData, "Wrong item to equip "..self:tag())	
	if item.onEquip then
		item:onEquip();
	end

	local slot = self:getActiveSlot();
	if self.data.hiddenWeapon and slot != "fakeWeaponSlot" and slot != "OneHandSword" then
		self:detachObject(self.data.hiddenWeapon);
		if self.data.hiddenWeapon != item then
			self.data.hiddenWeapon:show(false);
			self.data.hiddenWeapon = nil;
		end
	end
	
	if self.data.hiddenOneHandSword and slot == "OneHandSword" then
		self:detachObject(self.data.hiddenOneHandSword);
		self.data.hiddenOneHandSword = nil
	end
	
	
	local attachTm =item.data.attachData.bare and item.data.attachData.bare.attachTm or item.data.attachData.attachTm;
	local attachBone =item.data.attachData.bare and item.data.attachData.bare.attachBone or item.data.attachData.attachBone;
	self:attachObject(item, Character.BODY, attachBone, attachTm );
	item:enable(true);
	item:show(true);
	item:enablePhysics(true);
end

function CharacterTemplate:unEquip(item)
	assert(item, "Here must be an Item!!!!!!! self:tag() = "..self:tag())
	if item.onUnEquip then
		item:onUnEquip();
	end
	print('CharacterTemplate:unEquip')
	print('self.data.hidingWeapon = ', self.data.hidingWeapon)
		
	if (self.data.hidingWeapon or self.data.hiddenOneHandSword or item.data.type == "OneHandSword") and item.data.attachData.hidden then
		self:detachObject(item);
		self:attachObject(item, Character.BODY, item.data.attachData.hidden.attachBone, item.data.attachData.hidden.attachTm );
		if item.data.type == "OneHandSword" then
			self.data.hiddenOneHandSword = item
		elseif item.data.type != "fakeWeapon" then
			self.data.hiddenWeapon = item;
		end
		self.data.hidingWeapon = nil;
	else
		self:detachObject(item);	
		item:show(false);
	end
	
	item:addTimeEvent(item.enable, {false}, 0.2);	
	item:enablePhysics(false);
	item:enableHitBoxes(false);
end


function CharacterTemplate:enableWeapon()
	--print("CharacterTemplate:enableWeapon")
	if not GameScene.checkObject(self) or self.data.isDead then print("CharacterTemplate:enableWeapon self is dead tag "..self:tag()) return end
	local slot1, slot2 = self:getActiveSlot();
	local weapon1 = self:getEquiped(slot1)
	local weapon2 = self:getEquiped(slot2)
	
	if weapon1 then 
		weapon1:attacking(true, self.data.stageCoef)
		weapon1:enableHitBoxes(true); 
	end
	if weapon2 then 
		weapon2:attacking(true, self.data.stageCoef)
		weapon2:enableHitBoxes(true); 
	end
end


function CharacterTemplate:enableWeaponLeft()
	if not GameScene.checkObject(self) or self.data.isDead then print("CharacterTemplate:enableWeapon self is dead tag "..self:tag()) return end
	local slot1, slot2 = self:getActiveSlot();
	local weapon2 = self:getEquiped(slot2)
	if weapon2 then 
		weapon2:attacking(true)
		weapon2:enableHitBoxes(true); 
	end
end

function CharacterTemplate:enableWeaponRight()
	if not GameScene.checkObject(self) or self.data.isDead then print("CharacterTemplate:enableWeapon self is dead tag "..self:tag()) return end
	local slot1, slot2 = self:getActiveSlot();
	local weapon1 = self:getEquiped(slot2)
	if weapon1 then 
		weapon1:attacking(true)
		weapon1:enableHitBoxes(true); 
	end
end


function CharacterTemplate:showSpeedLine(flg)
	local slot1, slot2 = self:getActiveSlot();
	local weapon1 = self:getEquiped(slot1)
	local weapon2 = self:getEquiped(slot2)
	
	if weapon1 then 
		weapon1:showSpeedLine(flg)
	end
	if weapon2 then 
		weapon2:showSpeedLine(flg)
	end
end

function CharacterTemplate:disableWeapon()
	--print("CharacterTemplate:disableWeapon")
	if not GameScene.checkObject(self) or self.data.isDead then print("CharacterTemplate:disableWeapon self is dead tag "..self:tag()) return end
	local slot1, slot2 = self:getActiveSlot();
	local weapon1 = self:getEquiped(slot1)
	local weapon2 = self:getEquiped(slot2)
	
	if weapon1 then
		weapon1:attacking(false)
		weapon1:enableHitBoxes(false); 
	end
	if weapon2 then 
		weapon2:attacking(false)
		weapon2:enableHitBoxes(false); 		
	end
end

function CharacterTemplate:getEquiped(slotName)
	return self.slot:getEquiped(slotName)
end

function CharacterTemplate:onDestroy()
	CharacterTemplate.Parent.onDestroy(self);
end

function CharacterTemplate:killSummons()
	print("CharacterTemplate:killSummons")
	if self.data.summonsList then
		for i, v in pairs(self.data.summonsList) do
			local obj = GO(v);
			if obj and GameScene.checkObject(obj) and not obj.data.isDead then
				obj:needToSave(false);
				obj:createActivationFx()
				obj:setAction("die")
			end
		end
		for i, v in pairs(self.data.summons) do
			if v and GameScene.checkObject(v) and not v.data.isDead then
				v:setAction("die")
			end
		end		
	end
end

function CharacterTemplate:onDeath()
	self.slot:destroy();
	self.inventory:destroy();

	self:setNecroVisionType(OBJ_NV_USUAL);
	
	if self.data.giveItemPrototype then
	
		local itemGiverPrototype = prototypes["ItemGiver"].data;
		local itemGiver = GameScene.createObject(self:tag().."_itemGiver", "ItemGiver", {	
					itemPrototype =  self.data.giveItemPrototype,	
					visualFileName = itemGiverPrototype.visualFileName,
					effectName1 = itemGiverPrototype.effectName1,
					effectName2 = itemGiverPrototype.effectName2,
					isShown = true,
					isEnable = false,
					isEnabledPhysics = false,
					geomType = itemGiverPrototype.geomType,
					scale = itemGiverPrototype.scale,
					events = itemGiverPrototype.events,
					});
		
		itemGiver:setPosition(self:getPosition());
		itemGiver:enableItemGiver(true, 1);
	end
	
	self:killSummons()	
end

function CharacterTemplate:use(user)
	if self.data.cantUse then return end
	print(user[1]:tag(), " is using ", self:tag());
	self:signal("onUse", user);
end

function CharacterTemplate:makeUndamageable(flag)
	self.data.undamageable = flag
end


function CharacterTemplate:checkFriendlyFire(attackInitiator)
	if self == avatar and attackInitiator.memory and not attackInitiator.memory:isEnemy(self) and not friendlyFire then		
		print("!!!!!!!!!friendlyFire1!!!!!!!!!")
		print(self:tag(), " by ", attackInitiator:tag())
		return true;
	elseif self != avatar and attackInitiator.memory and not self.memory:isEnemy(attackInitiator) and not friendlyFire then
		print("!!!!!!!!!friendlyFire2!!!!!!!!!")
		print(self:tag(), " by ", attackInitiator:tag())
		return true
	else
		return false
	end
end


function CharacterTemplate:damage(damageAmount,    -- кол-во нанесенного повреждения в HP
								  damageType,      -- тип повреждения ("melee", "explosion" и т.д.)
								  position,        -- позиция хита (может быть nil)
								  attacker,        -- объект, который непосредственно нанес повреждение (меч, взрыв, стрела)  
								  attackInitiator, -- объект, который инициировал атаку(человек, монстр, ловушка и т.д.)
								  direction,       -- направление нанесения повреждения (удара)
								  boneName         --имя кости(нужно при использовании рэг-долла)
								  )							  
	if g_editor then return end
	
	print("CharacterTemplate:damage "..damageAmount.." self = "..self:tag(), " hp ", self:getHp(),
		" by ", (GameScene.checkObject(attackInitiator) and attackInitiator:tag() or "nil"))	

	
	if attackInitiator and self:checkFriendlyFire(attackInitiator) and attackInitiator:checkFriendlyFire(self) and damageType != "explosion" then
		return
	end	
	
	if damageType == "explosion" and attacker.data.dontHurtOwner and attackInitiator == self then
		return
	end
	
	if self.data.blocked and damageType and damageType != "explosion" then
		local slot1, slot2 = self:getActiveSlot();
		local weapon1 = self:getEquiped(slot1);
		if weapon1 then
			weapon1:damage(damageAmount, damageType, position, attacker, attackInitiator)
		end
		return
	end
		
		
	if attackInitiator and not self.memory:getEnemy() and not self.data.ignoreDamage then
		-- self:enablePerception(true);
		self.memory:addFrame(attackInitiator, "damage", getGameTime());
		
		if(not self:isEnabled()) then
			self:enable(true);
			self:enablePhysics(true);
			self:enableHitBoxes(true);
		end
	end

	self:signal("onDamage", {attackInitiator, attacker});
	
	if position and self.damageFx and not self.data.noBlood then
		local damageFx = self.damageFx
		if self.data.damageEffects and self.data.damageEffects[damageType] then
			damageFx = self.data.damageEffects[damageType]
		end
		EffectsManager.playEffect(damageFx, position);
	end
	
	
	if self.data.undamageable then
		print("UNDAMAGEABLE!!!!!")
		return
	end
	
	local hp = self:getHp();
	
	if self.data.armorThickness then
		damageAmount = damageAmount - self.data.armorThickness;
	end
	
	local realDamageType = damageType
	if damageType and damageType == "fist" then
		realDamageType = "fist"
		damageType = "melee";
	end
	
	if self.data.resists and damageType and self.data.resists[damageType] then
		print("damageType = ", damageType)
		print("self.data.resists[damageType] = ", self.data.resists[damageType])
		damageAmount = damageAmount - (damageAmount * self.data.resists[damageType]);		
	end
		
	if self.data.resistsTableName then
		assert(globalResistsTable[self.data.resistsTableName], "ERROR!!! Wrong resists table name "..self.data.resistsTableName.." for "..self:tag())
		print("self.data.resistsTableName = ", self.data.resistsTableName)
		print("globalResistsTable[self.data.resistsTableName] [damageType] = ", globalResistsTable[self.data.resistsTableName] [damageType])
		if globalResistsTable[self.data.resistsTableName] [damageType] then
			damageAmount = damageAmount - (damageAmount * globalResistsTable[self.data.resistsTableName] [damageType]);		
		end
	end
		
	if self.data.damageResistCoef then
		damageAmount = damageAmount / self.data.damageResistCoef
	end
	
	local difficulty = getGameComplexity() + 1;
	print("difficulty = ", difficulty)
	print("damageAmount = ", damageAmount)
	if self == avatar then
		damageAmount = damageAmount - (damageAmount * g_enemyDifficultyCoef[difficulty])		
	else
		damageAmount = damageAmount + (damageAmount * g_playerDifficultyCoef[difficulty])
	end	
	print("damageAmount = ", damageAmount)	
	
	if damageAmount < 0 then
		--print(utils.traceback())
	end
		
	damageAmount = damageAmount < 0 and 0 or damageAmount;
		
	
	if damageType != "fall" and damageAmount > 0 then
		self:setAction("pain", nil, true);
	end	
	
	if self == avatar then
		addStatistics("damageGained", damageAmount)
	end
	
	if attackInitiator == avatar then
		addStatistics("damageCaused", damageAmount)
	end	

	local hpWas = self:getHp();
	
	self:setHp(hp - damageAmount);
	
	if attackInitiator and attackInitiator.isPlayerControlled and not attackInitiator:isPlayerControlled() then
		attackInitiator.data.successfulAttacksAmount = attackInitiator.data.successfulAttacksAmount and attackInitiator.data.successfulAttacksAmount or 0
		attackInitiator.data.successfulAttacksAmount = attackInitiator.data.successfulAttacksAmount + 1
	end
	
	print("CharacterTemplate:damage  self = "..self:tag(), " hp now: ", self:getHp())	

	
	if (self.data.stats.hp <= 0 or (attackInitiator and attackInitiator == avatar and globalGameState.state.io.killerMode)) and not self.data.isDead then
		local params = {}		
		params.dieDir = direction;
		params.boneName = boneName;
		params.deathReason = damageType;
		params.impulse = attacker and attacker.data.impulse or 0;

		if attackInitiator == avatar and self.data.xpCost then
			increaseXp(self.data.xpCost)
		end
		
		if attackInitiator and attackInitiator:tag() == "Avatar" then
			addStatistics("killed", 1)
			addStatistics(realDamageType, 1)
		end
				
		self:setAction("die", params);
	end
end

-- приземление с высоты
function CharacterTemplate:onLanding(fallHeight)
	if not self.actions["landing"] then return end
	self.data.fallHeight = fallHeight;
	if fallHeight > 1.3 and self:checkAction("landing") then
		--self:setAction("landing", nil, true);
	end
	
	if(fallHeight > 5) then
	    --.hack  решили не наносить повреждения при падении, 
		-- т.к. сейчас есть нехороший глюк с вычислением высоты падения.
		-- иногда можно умереть просто спускаясь по наклонной плоскости
		--self:damage((fallHeight - 5) * 10, "fall");
	end
end

function CharacterTemplate:getHp()
	return self.data.stats.hp;
end

function CharacterTemplate:getMaxHp()
	return self.data.stats.maxHp;
end
function CharacterTemplate:setMaxHp(hp)
	self.data.stats.maxHp = hp;
end
function CharacterTemplate:setHp(newHP)
	if newHP < 0 then
		newHP = 0;
	end;
	if newHP > self:getMaxHp() then
		newHP = self:getMaxHp();
	end;
	self.data.stats.hp = newHP;
	if GAME_SCREEN and (
			self:tag() == "Avatar" or
			self:tag() == globalGameState.state.io.CharShown)
			then
		GAME_SCREEN.Update();
	end
end

function CharacterTemplate:getSp()
	return self.data.stats.sp;
end

function CharacterTemplate:getMaxSp()
	return self.data.stats.maxSp;
end

function CharacterTemplate:onStartAttack()
	self.data.isAttacking = true
	
	self:signal("onStartAttack", {})
	if not GameScene.checkObject(self) or self.data.isDead then print("CharacterTemplate:enableWeapon self is dead tag "..self:tag()) return end
	local slot1, slot2 = self:getActiveSlot();
	local weapon1 = self:getEquiped(slot1)
	local weapon2 = self:getEquiped(slot2)
	
	if weapon1 then
		weapon1:attackStart()
	end
	if weapon2 then
		weapon2:attackStart()
	end
end

function CharacterTemplate:onEndAttack()
	self.data.isAttacking = nil
	self:signal("onEndAttack", {})
	if not GameScene.checkObject(self) or self.data.isDead then print("CharacterTemplate:enableWeapon self is dead tag "..self:tag()) return end
	local slot1, slot2 = self:getActiveSlot();
	local weapon1 = self:getEquiped(slot1)
	local weapon2 = self:getEquiped(slot2)
	
	if weapon1 then
		weapon1:attackEnd()
	end
	if weapon2 then
		weapon2:attackEnd()
	end
end

function CharacterTemplate:setSp(newSP)
	if newSP < 0 then
		newSP = 0;
	end;
	if newSP > self:getMaxSp() then
		newSP = self:getMaxSp();
	end;	
	self.data.stats.sp = newSP;
	if self:tag() == "Avatar" and GAME_SCREEN then
		GAME_SCREEN.Update();
	end
end

function CharacterTemplate:getStat(stat)
	return self.data.stats[stat] and self.data.stats[stat] or 0;
end

function CharacterTemplate:getStatMax(stat)
	local maxStat = "max"..string.upper(string.sub(stat, 1, 1))..string.sub(stat, 2)
	return self.data.stats[maxStat] and self.data.stats[maxStat] or 0;
end

function CharacterTemplate:effectedByPortal(flag)
	self.data.effectedByPortal = flag;
end

function CharacterTemplate:setStat(stat, value)
	if value < 0 then
		value = 0;
	end;
	
	assert(isstring(stat), "Wrong stat parameter for "..self:tag())
	
	local maxStat = "max"..string.upper(string.sub(stat, 1, 1))..string.sub(stat, 2)
	
	self.data.stats[stat] = value
	
	if self.data.stats[stat] > self.data.stats[maxStat] then
		self.data.stats[stat] = self.data.stats[maxStat]
	end
	
	if GAME_SCREEN then
		GAME_SCREEN.Update();
	end;
end

function CharacterTemplate:getTrackingVector(dir, time)
	local lookDir = {self:getLookDir()};
	
	if self.data.cantTurn then return lookDir, "turnLeft" end
	
	local angle = getAngleFromVectorsXZ(lookDir, dir);	
	
	local turnAnim = "turnLeft";
	
	if vecCross(lookDir, dir)[2] > 0 then
		angle = -angle;
		turnAnim = "turnRight";
	end

	local turnSpeed = self.turnSpeed * time;
	if angle > turnSpeed then
		angle = turnSpeed;
	else
		if angle < -turnSpeed then
			angle = -turnSpeed;
		else
			return normalizeVector(dir);
		end
	end
	
	local res_v = {}; 
	res_v[1] = math.cos(angle)* (lookDir[1])  +  0*(lookDir[2]) - math.sin(angle)*(lookDir[3]);
	res_v[2] =      0     * (lookDir[1])  +  0 +      0     *(lookDir[3]);
	res_v[3] = math.sin(angle)* (lookDir[1])  +  0*(lookDir[2]) + math.cos(angle)*(lookDir[3]);
	
	return res_v, turnAnim;
end

function CharacterTemplate:moveStraight()
	self:setAction("moveForward");
end

function CharacterTemplate:moveToPoint(point, precisionSq,reinit)
	assert(istable(point), "Not a point table!!!!!")
	local params = {}
	params.destination = point;
	params.precisionSq = precisionSq;
	self:setAction("moveToPoint", params,nil,reinit);
end

function CharacterTemplate:moveByWP(patrolType, moveToFirst, func, useYAxis, notUseTrackingVector, wayPointId, delta)
	assert(patrolType, "Wrong moveByWp parameters!!!")
	local params = {};
	params.wayPoints = self.data.wayPoints;
	params.type = patrolType;
	params.func = func;
	params.moveToFirst = moveToFirst;
	params.useYAxis =  useYAxis;
	params.wayPointId =  wayPointId;
	params.notUseTrackingVector = notUseTrackingVector;
	params.delta = delta;
	self:setAction("moveByWp", params)
end

function CharacterTemplate:followObjectByWP(target, dist, distToStartAttack, distToEndAttack, maxDistToTarget)
	local params = {};
	params.target = target;
	params.wayPoints = self.data.wayPoints;
	params.dist = dist;
	params.distToStartAttack = distToStartAttack;
	params.distToEndAttack = distToEndAttack;
	params.maxDistToTarget = maxDistToTarget;
	self:setAction("followObjectByWP",params);
end

--поиск вейпойнтов в сцене по их типу
---- findByOurTag:  ищутся  по тегам:   наштегHомер(00,01,....) (bird01)
---- findByMask:  ищутся  по тегам: маскаHомер(00,01,....)
function CharacterTemplate:findWayPoints()
	local mask;
	if self.data.wayPointsType == "findByOurTag" then
		mask = self:tag();
	elseif  self.data.wayPointsType =="findByMask" then
		mask = self.data.wayPointsMask;
		assert(mask,"No mask to findByMask");
	else
		print("Error! Unknown type to find WayPoint: ",self.data.wayPointsType);
		return;
	end		
	self.data.wayPoints = {};
	local num = 1;
	for num=1, 99 do 
		if num < 10 then
			strnum = "0"..tostring(num);
		else
			strnum = tostring(num);
		end;
		local wp = GameScene.getObject(mask..strnum);
		
		if not wp then return end;
		
		table.insert(self.data.wayPoints,wp);
	end
end


-- функция принимает раасстояние на которое персонаж должен подойти к другому персонажу (рассотяние передается НЕ в квадрате)
function CharacterTemplate:moveToObject(target, dist, forever, fixedLocation)
	assert(isuserdata(target), "No object to move!!!!!!")
	dist = dist and dist * dist or 4
	local params = {};
	params.target = target;
	params.dist = dist;	
	params.forever = forever;
	params.fixedLocation = fixedLocation;
	self:setAction("moveToObject", params);
end

-- запуск высокоуровневого action'а, который заставляет одного персонажа следовать за другим если у того нет противников
function CharacterTemplate:followObject(target, dist)
	assert(isuserdata(target), "No object to move!!!!!!")
	dist = dist and dist * dist or 4
	local params = {};
	params.target = target;
	params.dist = dist;	
	self:setAction("followObject", params);
end

function CharacterTemplate:flee(object, distance)
	assert(isuserdata(object), "No object to flee!!!!!!")
	local params = {};
	params.target = object;
	params.dist = distance * distance;	
	self:setAction("flee", params);
end

-- что бы остановить движение обнуляем скорость перемещения и удаляем угол поворота вектора скорости
function CharacterTemplate:stop()
	--if self == avatar then
		--print("CharacterTemplate:stop")
		--print(utils.traceback())
	--end
	self.data.moveData.velocity = 0;
	self.data.moveData.angle = nil;
	self:setMoveDir(NULL_VECTOR());
	--self.data.needToStop = true;
	self:move(NULL_VECTOR(), self.data.moveData.velocity);
	
	
end

function CharacterTemplate:halt()
	--print("CharacterTemplate:halt")
	--print("self:tag() = ", self:tag())
	self:releaseEffectors({"brain_moving", "brain_follow"})
	self.data.isMovingByWP = false;
	if self.data.io then
		self.data.io.movingByWp = nil
	end
	self:stop();
	
	--сбросить флаги перемещения во избежании залипания
	if self == avatar then
		resetButtonState();
	end
end

function CharacterTemplate:setIdle(visualStateName, restoreCurrent)
	-- print("CharacterTemplate:setIdle")
	-- print("self:tag() = ", self:tag())
	-- print("visualStateName = ", visualStateName)
	-- print(utils.traceback())
	if visualStateName and isstring(visualStateName) then
		self:getState().visualTables.currentIdle = {{visual = visualStateName, weight = 1}}
		self.data.resetIdle = true;
		self.data.currentIdle = visualStateName
	else
		if(restoreCurrent) then
			self:setIdle(self.data.currentIdle);
		else
			self:getState().visualTables.currentIdle = nil;
			self.data.currentIdle = nil
		end	
	end
end

function CharacterTemplate:getIdle()
	return self.data.currentIdle or self:getState().visualTables.idle[1] ["visual"]
end

-- остановка атаки
function CharacterTemplate:stopAttack()
	--print("CharacterTemplate:stopAttack")
	for i, v in pairs(self.effectors) do
		if v.actionName == "attack" then
			v.action.needToBeDestroyed = true;
		end
	end
end

function CharacterTemplate:getShootDirection(vel, withMoving, instance) --instance - граната или стрела(нужно передавать если атака выолнятется не из "своего" стейта.напр. бросок гранаты)
	--print("CharacterTemplate:getShootDirection")
	if self:isPlayerControlled() then
		local crossHairPos = CROSS_HAIR_POSITION();
		local p, d = calculateCrossHairDirection(crossHairPos[1], crossHairPos[2]);
		--calc right position to trace from
		local n = {d[1], 0, d[3]};
		local o = {self:getPosition()};
		n = normalizeVector(n);
		local v = vectorSub(p, o);
		local dist = dotProduct(n, v);
		local cosinus = dotProduct(n, d);
		local res = vectorAdd(p, scalarMul(d, dist/cosinus));
		
		local t = physicTrace(res, d, SHOOT_TRACE_DISTANCE, self);
		if t then
			local vec = t.position;
			local x, y, z ;
			if instance then
				x, y, z = instance:getPosition();
			else
				x, y, z = self:getEquiped(self:getActiveSlot()):getInstance():getPosition();
			end 
			
			if CHEATCH then
				--drawShape(Geometry.sphere, t.position, {0.1, 0.1, 0.1}, nil, self:tag().."pricel"); 
				local dist = math.sqrt(getDistSq2D(vec,{x,y,z}));
				--print("dist ",dist," vel ",vel);
				if not vel then vel = 30; end
				local height = vec[2]  - y;
				angle = findingAngle(vel,dist,height)
				--print("height ",height," angle ",angle);
				vec[1], vec[2], vec[3] = vec[1] - x,0, vec[3] - z;
				vec = normalizeVector(vec);
				vec[2] = math.tan(angle);
			else
				vec[1], vec[2], vec[3] = vec[1] - x, vec[2] - y, vec[3] - z;
			end
			vec = normalizeVector(vec);
			d = vec;
		end
		
		
		--PrintTable(d);
		--print("angle",math.asin(d[2])/3.14*180)
		--dist = 30*30*math.sin(2*math.asin(d[2]))/9
		--print("dist ",dist);
		return d;
	else		
		local dir = {self:getLookDir()};
		if self.memory and self.memory:getEnemy() then
			-- .hack
			-- нахождение угла функцией findingAngle() завязано на скорости стрелы (т.к. учитывается еще и парабола полета стрелы), 
			-- это правильно для лука но не нужно для аркебузы и арбалета, поэтому для получения более точного значения угла
			-- устанавливаем большую скорость при подсчете (на скорость полета стрелы это не влияет)
			if (self:getEquiped(self:getActiveSlot()).data.weaponType == "Arbalest") or (self:getEquiped(self:getActiveSlot()).data.weaponType == "Harquebus") then
				dir = self:getDirToEnemy(self.memory:getEnemy(), dir, math.sqrt(self.memory:getEnemyDistance()), 9999, withMoving)
			else
				dir = self:getDirToEnemy(self.memory:getEnemy(), dir, math.sqrt(self.memory:getEnemyDistance()), vel, withMoving)
			end
		end
		return dir;		
	end
end

function CharacterTemplate:getDirToEnemy(enemy, dir, dist, vel, withMoving)
	if not enemy or not GameScene.checkObject(enemy) or enemy.data.isDead then return NORMAL_VECTOR() end
	local enemyPos = {enemy:getPosition()};
	local myPos = {self:getPosition()};
			
	--учитываем разницу между взглядом сhara и стрелы
	dir[1], dir[3] = rotateVector2(dir[1], dir[3], 0.01)	
		
	if not vel then vel = 20; end
		
	local height = enemyPos[2] - myPos[2];
	if enemy.data.heightOffset then
		height = height + enemy.data.heightOffset
	end
	local angle;

	angle, t = findingAngle(vel, dist, height);
	--withMoving = true
	if withMoving then
		local futurePos = enemyPos;
		local curvel = enemy:getCurrentVelocity();
		futurePos = vectorAdd(enemyPos, scalarMul(curvel,t));
		dist = math.sqrt(getDistSq2D(myPos, futurePos))
		height = futurePos[2] - myPos[2];-- + self.memory:getEnemy().data.heightOffset;
		angle = findingAngle(vel, dist, height);
		dir = getDirection(myPos, futurePos);
		dir[2] = 0;
		dir = normalizeVector(dir);
	end
	
	
	local n = 12
	local x = 0
	local y = 0;
	for i = 1, n do 
		x = x + math.random() * 2 - 1;
		y = y + math.random() * 2 - 1;
	end
	
	angle = angle + x/16 * 0.1;
	dir[1] = dir[1] + y/16 * 0.1;			
	dir[2] = math.tan(angle);
	dir = normalizeVector(dir);
	return dir;
end

function findingAngle(vel, dist, height, amin, amax, high, gK)
	local alpha,t;
	local g = 9.81 * (gK or 1);
	
	--print(" !!!! "..g);
	
	if math.abs(height) < 0.5 and not high then
		--print("dist ",dist);
		local sinangle = dist * g/(vel^2);
		sinangle = utils.clamp(sinangle,-1,1);
		alpha = 1/2*math.asin(sinangle);
		t = dist/(vel*math.cos(alpha));
		--print("angle ",angle," ",angle/3.14*180);
	else
		--print("ATHEIGHT!!!");
		--print("dist ",dist," height ",height);
		local alphaFind = nil;
		local alphaMin = amin or -PI/2;
		local alphaMax = amax or PI/2;
		local prevDelta = 99999;
		
		while not alphaFind do
		   alpha = (alphaMin+alphaMax)/2;
		    
			--t = (vel*math.sin(alpha)/g + math.sqrt(vel^2*math.sin(alpha)^2/(g)^2-2*height/g));
			--d = vel*math.cos(alpha)*t;
				
			--h = v*sin()*t - g*t*t/2
			--g/2*t*t - v*sin()*t + h = 0;
			--t = (v*sin() +- sqrt(v*v*sin*sin - 2*g*h) )/g
			
			t  = dist/(vel*math.cos(alpha));
			
			h = vel*math.sin(alpha)*t - g*t*t/2;

			--print("calc h = ",h," alp ",alpha/3.14*180," delta h", height-h);
			--print("calc d = ",d," alp ",alpha);
			--[[
			if math.abs(d - dist)<0.1 or alphaMax-alphaMin<0.00001 then
				--print("Stop finding:", d,"  ",dist)
				alphaFind = true
			elseif d>dist then
				alphaMax = alpha
			else
				alphaMin = alpha;
			end;
			]]
			if math.abs(h - height)<0.01 or alphaMax-alphaMin<0.01 or ((height - h)>prevDelta and prevDelta>0) then
				--print("Stop finding:", h,"  ",height, "prevDelta ", prevDelta)
				if (height - h)>prevDelta then	
					--print("Back alpha: ",prevAlpha);
					alpha = prevAlpha;
				end
				alphaFind = true
			else
				prevDelta = height - h;
				prevAlpha = alpha;
				if not high then
					if h>height then
						alphaMax = alpha
					else
						alphaMin = alpha;
					end
				else
					if h<height then
						--print("h<height",h," ",height)
						alphaMax = alpha
					else
						--print("else h>height",h," ",height)
						alphaMin = alpha;
					end
				end
			end;
		end
	end
	
	--print("Final alpha ", 180 * alpha / PI," t", t);
	
	return alpha,t;
end


function calcShootDirection(selfPos, targetPosOriginal, errorRadius, angleMin, angleMax, velOrDistVelTable, highParabola, gK)
	-- ошибка прицеливания вычисляется, путем эмуляции неправильной оценки положения объекта
	-- ошибка тем больше, чем дальше объект
	-- errorRadius - ошибка в метрах на расстоянии 100м
	local n = 6;
	local x = 0;
	local y = 0;
	local z = 0;
	
	local dist = math.sqrt(getDistSq2D(selfPos, targetPosOriginal));
	errorRadius = (type(errorRadius) == "number") and errorRadius or 0;
	
	local distK =  dist / 100;
	errorRadius = errorRadius * distK;
	
	local delta = errorRadius / n;
	for i= 1, n do 
		x = x + (math.random() - 0.5) * delta;
		y = y + (math.random() - 0.5) * delta;
		z = z + (math.random() - 0.5) * delta;
	end

	local targetPos = {targetPosOriginal[1] + x, targetPosOriginal[2] + y, targetPosOriginal[3] + z};
	local lookDir = getDirection2D(selfPos, targetPos);
	local dist = math.sqrt(getDistSq2D(selfPos, targetPos));
	
	local velocity = 0;
	local minDist = 99999999;
	--choose appropriate  velocity
	if type(velOrDistVelTable) == "number" then
		velocity = velOrDistVelTable;
	elseif type(velOrDistVelTable) == "table" then
		for i,v in pairs(velOrDistVelTable) do
			-- так как массив не отсортирован то проходимся по всему
			if v.dist > dist and minDist > v.dist then
				velocity = v.vel;
				minDist = v.dist;
			end
		end
	else
		assert(false, "velocity not specified!");
	end

	local angle = findingAngle(velocity, dist, 
					targetPos[2] - selfPos[2], angleMin, angleMax, highParabola, gK);

	--print(" !targetPos ", targetPos[2] - selfPos[2]);
	
	local dir = lookDir;
	dir[2] = 0;
	dir = normalizeVector(dir);
	dir[2] = math.tan(angle);
	dir = normalizeVector(dir);
	
	return dir, velocity;
end



function CharacterTemplate:setAim(object)	
	CharacterTemplate.Parent.setAim(self, object);
	self.data.aim = object;
end

function CharacterTemplate:turn(_direction)	
	if isuserdata(_direction) then
		_direction = getDirection({self:getPosition()}, {_direction:getPosition()})
	end
	_direction[2] = 0;
	_direction = normalizeVector(_direction);
	self:setAction("turn", {direction = _direction});
end

function CharacterTemplate:getAim()	
	return self.data.aim;
end

function CharacterTemplate:getEnemy()	
	return self.memory:getEnemy()
end

function CharacterTemplate:setActiveSlot(slotname,slotname2)	
	self.data.activeSlot = slotname;
	self.data.activeSlot2 = slotname2;
end
function CharacterTemplate:getActiveSlot()
	return self.data.activeSlot,self.data.activeSlot2;
end

function CharacterTemplate:getNextToSlot(slotname)
	assert(slotname and isstring(slotname),"Wrong slotname");
	local isntEmpty  = false;
	local foundNew = false;
	local newItem = self.inventory:findByType(slotname);
	if self:getEquiped(slotname) then
		print("Was equiped by ",self:getEquiped(slotname):tag())
		if newItem then			
			fromSlotToInventory(self,slotname);
			fromInventoryToSlot(self,slotname,newItem);
			foundNew = true;
		end
		isntEmpty = true;
	elseif newItem then
		print("Was not equiped")
		fromInventoryToSlot(self,slotname,newItem);
		isntEmpty = true;
		foundNew = true;
	end
	return isntEmpty,foundNew;
end

function CharacterTemplate:getNextAmmunition(slotname, weaponType)
	assert(slotname and isstring(slotname),"Wrong slotname");
	local isntEmpty  = false;
	local foundNew = false;
	local newItem = self.inventory:findAmmunition(slotname, weaponType);
	if self:getEquiped(slotname) then
		if newItem then			
			fromSlotToInventory(self, slotname);
			fromInventoryToSlot(self, slotname, newItem);
			foundNew = true;
		end
		isntEmpty = true;
	elseif newItem then
		print("Was not equiped")
		fromInventoryToSlot(self, slotname, newItem);
		isntEmpty = true;
		foundNew = true;
	end
	return isntEmpty,foundNew;
end
---------------------------------------------------------------------------------------
-- Стандартные команды, которые могут отдаваться персонажу
---------------------------------------------------------------------------------------
CharacterTemplate.standardActions = nil;

function CharacterTemplate:callStandardAction(actionName, params)
	assert(actionName != nil and isstring(actionName), "Wrong action name")	
	-- для персонажа в целом
	
	if self.data.isDead then print("Character is "..self:tag().." nearly dead. Can't call standard action "..actionName) return end
	
	if self == avatar and Skills[actionName] then
		local skill = globalGameState.state.io.avatarSkillsList[actionName]
		if not skill or not Skills[actionName].executeChecker() then
			return false;
		end
	end
		
	local flag = false;
	if self.standardActions and self.standardActions[actionName] then
		flag = self.standardActions[actionName](self, params);
	end
	
	-- для текущего состояния 
	local state = self:getState();
	if state then
		if state.standardActions and state.standardActions[actionName] then
			flag = state.standardActions[actionName](self, params);
		end
	end	
	return flag;
end

function CharacterTemplate:checkEndActionFunction(actionName)
	assert(self.actions[actionName], self:tag().." There is no such action as '"..actionName.."'  "..utils.traceback())
	for i, v in pairs(self.effectors) do
		if v.actionName	== actionName and v.action.endCallback then				
			return true;
		end
	end
	return false;
end

function CharacterTemplate:addEndActionFunction(actionName, func, params)
	assert(actionName, "actionName cant be nil");
	assert(self.actions[actionName], "There is no such action as '"..actionName.."'")
	for i, v in pairs(self.effectors) do	
		if v.actionName	== actionName then				
			v.action.endCallback = {};
			v.action.endCallback.func = func;
			tinsert(params, 1, self);
			v.action.endCallback.params = params
			--print("Callback on "..actionName.." action was successfully added!!!")
			return;
		end
	end
	--print(self:tag().." No such action "..actionName.." to add function!!!!!!    "..utils.traceback())
end


function CharacterTemplate:clearEndActionFunction(actionName)
	for i, v in pairs(self.effectors) do	
		if v.actionName	== actionName then				
			v.action.endCallback = nil;
			return;
		end
	end
end


-- ф-цЫи для установки критерия выбора противника
function CharacterTemplate:setEnemySelectionCriteria(criteria)
	self.memory:setEnemySelectionCriteria(criteria);
end

function CharacterTemplate:setEnemiesList(list)
	self.memory:setEnemiesList(list)
end
	
	
function CharacterTemplate:getEnemyDistance()
	return self.memory:getEnemyDistance()
end	

function CharacterTemplate:getPitch()
	--if self:isPlayerControlled() then
		return CharacterTemplate.Parent.getPitch(self)
	--else
		--return 0;
	--end
end

-- в состоянии бега
function CharacterTemplate:isRunning()
	return self:getState().moveRun == self:getState().move;
end

-- переход между бегом и ходьбой
function CharacterTemplate:runMode(isRunning)
	if(isRunning == true) then
		self.data.walkMode = nil;
		if(self:getState().moveRun) then
			self:getState().move = self:getState().moveRun;
		end
	else
		self.data.walkMode = true;
		if(self:getState().moveWalk) then
			self:getState().move = self:getState().moveWalk;
		end
	end
end

function CharacterTemplate:allowAttack(attackName, flag)
	assert(self.attackInfos[attackName], "Wrong attack name!!!!")
	self.attackInfos[attackName] ["allowed"] = flag;
end

function CharacterTemplate:checkAllowedAttacks(attackName)
	if self.data.allowedAttacks and table.getn(self.data.allowedAttacks) > 0 then
		if inTable(self.data.allowedAttacks, attackName) then
			return true
		end	
	end	
	return false
end

-- вызывается при изменениях инвентаря для проверки возможности выполнения аттаки (проверка наличия стрел и гранат, мечей и пр.)
function CharacterTemplate:weaponChecker()
	if not self.attackInfos then return end
	-- print("CharacterTemplate:weaponChecker for "..self:tag());
	for i, v in pairs(self.attackInfos) do
		-- print("i = ", i)					
		if not v.weaponType or self.inventory:findByType(v.weaponType) or self:getEquiped(v.weaponType) then
			if self.attackInfos[i] ["specified"] then
				self:allowAttack(i, self:checkAllowedAttacks(i))
			else
				self:allowAttack(i, true)
			end
																					
			if v.ammoType then				
				local allowed = v.allowed and (self.inventory:findByType(v.ammoType) != nil or self:getEquiped(v.ammoType) != nil);
				self:allowAttack(i, allowed)
				self:allowAttack("meleeAttack", not allowed)
			end
			
			if self.data.disallowedAttacks and inTable(self.data.disallowedAttacks, i) then
				self:allowAttack(i, false)
			end
		else
			--print("allowed false")
			self:allowAttack(i, false)
		end
	end
end

function CharacterTemplate:canMove(flag)	
	-- print("CharacterTemplate:canMove()	for",self:tag()," ",flag);
	-- print(utils.traceback())
	self.data.cantMove = not flag
end

function CharacterTemplate:canUse(flag)
	self.data.cantUse = not flag
end

function CharacterTemplate:calm()
	-- self:setEnemySelectionCriteria(nil);
	-- self:setEnemiesList(nil);	
	self.memory.enemyObject = nil
	self.memory.enemyFrame = nil
	self:resetAction("fight")
	self:destroyAction("rangeFight")
	self:destroyAction("meleeFight")
	self:clearEndActionFunction("attack");
	self:destroyAction("attack")	
	self:setAim(nil);
	self:enablePerception(false);	
	if self:getStateName() != "normalState" then
		--self:callStandardAction("drawWeapon")
		self:quickHidingWeapon()
	end
	self:halt();
end

function CharacterTemplate:alert(enemy)
	--print("CharacterTemplate:alert(enemy) ",utils.traceback());
	if math.random(2) == 2 and not self.data.blockAlertVisual then
		addTimeEvent(self.setAction, {self, "alert"}, math.random(1, 5)/10);
	end
	
	self:enable(true);
	self:enableHitBoxes(true);
	
	self.data.enablePerception = true;	
	
	if isuserdata(enemy) then
		if enemy.data.team then
			self:setEnemySelectionCriteria("byTeam");
			self:setEnemiesList({enemy.data.team});
		else
			self:setEnemySelectionCriteria("byTag");
			self:setEnemiesList({enemy:tag()});
		end
		
		self.memory:addFrame(enemy, "damage", getGameTime(), "character");
	else
		self:setEnemySelectionCriteria("byTag");
		if type(enemy) == "string" then
			self:setEnemiesList({enemy});
		elseif type(enemy) == "table" then
			self:setEnemiesList(enemy);
		end
	end
end

function CharacterTemplate:onCollWithChar(collidedChar)
	if self.data.isMovingByWP and not self:isPlayerControlled() and not self.data.ignoreCollision then --and collidedChar == GO("Avatar") 
		self:wait();
		self:signal("onCollWithChar",{collidedChar});
	end
end

function CharacterTemplate:onCollWithWall()
	--print("onCollWithWall");
	self.data.wallAhead = true;
end

function CharacterTemplate:wait(needToWait)
	if needToWait == nil or needToWait == true then
		self.data.isWaiting = true;
	else	
		self.data.isWaiting = nil;
	end	
end

function CharacterTemplate:enablePerception(flg)
	self.data.enablePerception = flg;
end

function CharacterTemplate:quickHidingWeapon()
	--print("quick hiding");
	--print("self:tag() = ", self:tag())
	--print(utils.traceback())
	local slot = self:getActiveSlot();
	local weapon = self:getEquiped(slot);
	
	--прячем оружие не вызывая ActionWeaponHide
	if weapon and weapon.onHide then weapon:onHide(); end	
	
	--print("slot = ", slot)
	--print("weapon: ",weapon:tag(),"  ",weapon.type);


	-- если у нас в руке стрела, ее нужно уничтожить - но она уничтожится чуть дальше на коллбеке прятания оружия
	-- if weapon and weapon.data.arrow then
		-- safeDestroy(weapon.data.arrow)
	-- end

	-- if weapon and weapon.data.type == "fakeWeapon" then
		-- print("hide unarmed");
		-- local slot,slot2 = self:getActiveSlot();
		-- self:unEquip(weapon);
		-- self:unEquip(self:getEquiped(slot2));
		-- self:setState("normalState");
	-- end
	
	--прервать перезарядку (был глюк когда лук вынимается  из слота во время перезарядки)
	self:resetAction("reload");
	self:resetAction("shoot");	
	
	local vs = self:getState().visualTables.hideWeapon and self:getState().visualTables.hideWeapon[1].visual or nil;
	if vs and self.visualStates[vs].animation.callbacks then   --переходим в normalState на коллбеке
		--print("playcallback");
		-- Если у нас есть второй callback, то скорее всего первый - проигрывание звука, и он нам не интересен
		if self.visualStates[vs].animation.callbacks[2] then
			self.visualStates[vs].animation.callbacks[2].func(self, 0)
		else
			self.visualStates[vs].animation.callbacks[1].func(self, 0)
		end
		--[[for i, v in ipairs(self.visualStates[vs].animation.callbacks) do
			v.func(self, 0);		
		end]]
	else														--переходим  сразу в normalState
		self:setState("normalState");
	end



end




function CharacterTemplate:hide()
	self:enablePhysics(false);
	self:enableHitBoxes(false)
end

function CharacterTemplate:unhide()
	self:enablePhysics(true);	
	self:enableHitBoxes(true)	
end		


function CharacterTemplate:onActivate(isActivate)
	self.data.enablePerception = true;
	if self.data.isDead then return end
	if not isActivate and self:getStateName()!="normalState" and self:getStateName()!="hidingState" then
		for i, v in pairs(self.effectors) do
			self:releaseEffectors({i});
		end
		if not self.data.isPassive then
			self:setAction("think");
		end
		self:setAction("move");
		self:quickHidingWeapon();
		self:calm();
	end
	self:callStandardAction("onActivate", isActivate);
end

function CharacterTemplate:createActivationFx()
	assert(self.data.activateFx, "Wrong activationFx "..self:tag().."!!!!!!!!!!!!")
	EffectsManager.playEffect(self.data.activateFx, {self:getPosition()});
end

function CharacterTemplate:restoreHp()
	self:setHp(self:getMaxHp());
end

function CharacterTemplate:onMissionLeave()
	--print("Warning! character leave mission BB ",self:tag());
	-- если персонажа выкинуло за пределы уровня, то damage-им его
	self:damage(20, "fall");
end



function CharacterTemplate:setTmByWaypoint(waypointName, alignCameraForAvatar)
	local waypoint = nil;
	if type(waypointName) == "string" then
		waypoint = GO(waypointName)
	else
		waypoint = waypointName;
	end
	assert(waypoint);

	self:setPosition(waypoint:getTm());
	
	if alignCameraForAvatar and self == avatar then
		twController.attachCamera('Avatar');
	end
end

-- вкл/выкл бленда анимаций
function CharacterTemplate:animBlendOn()
	if(self.data.originalAnimBlendTime) then
		self:setAnimBlendTime(-1, self.data.originalAnimBlendTime);
		self.data.originalAnimBlendTime = nil;
	end	
end
function CharacterTemplate:animBlendOff()
	self.data.originalAnimBlendTime = self:setAnimBlendTime(-1, 0);
end

-- событие потери контроля камеры
function CharacterTemplate:onCameraControl(isAquired)
end

function CharacterTemplate:hp(maxhp)
	self:setMaxHp(maxhp);
	self:setHp(maxhp);
end


function CharacterTemplate:createFireball(kind)
	if self.data.fireball then return self.data.fireball end 
	kind = self.data.currentFireball and self.data.currentFireball or kind
	assert(kind, "Fireball prototype not specified")
	self.data.fireball = Editor.createObjectByPrototype(kind);
	self.data.fireball:needToSave(false);
	self.data.fireball:enable(true);
	self.data.fireball:enablePhysics(false);
	self.data.fireball:show(true);
	self.data.fireball:setOwner(self);
	
	return self.data.fireball;
end

function CharacterTemplate:precashSummons(amount)
	if not self.data.summonsPrototypes or table.getn(self.data.summonsPrototypes) == 0 then
		return
	end
	
	self.data.summons = self.data.summons and self.data.summons or {}
	local n = table.getn(self.data.summonsPrototypes)
	amount = amount and amount or 20
	
	for i = 1, amount do			
		local monsterPrototype = self.data.summonsPrototypes[math.random(n)]		
		local obj = nil
		local uniqueName = self:tag().."Summon"..getGameTime()..tostring(i)

		-- Защита и прямой поиск: берем данные напрямую из глобальной таблицы prototypes,
		-- которая содержит все данные из файлов skeletonParams.lua
		local protoData = _G.prototypes and _G.prototypes[monsterPrototype] or nil
		
		if protoData and type(protoData) == "table" then
			local templateName = protoData.templateName or "CharacterSkeleton"
			local data = protoData.data or {}
			
			-- Создаем объект напрямую через ядро GameScene движка TrueWorld 2
			obj = GameScene.createObject(uniqueName, templateName, data)
		end
	
		-- Если объект успешно создался — инициализируем его как скрытого спутника игрока
		if obj then
			-- Безопасно выставляем имя прототипа, чтобы у скелета подгрузились его меши и оружие
			if obj.setPrototypeName then
				obj:setPrototypeName(monsterPrototype)
			end
			
			obj:setPosition(0, 0, 0)
			obj:enablePhysics(false)
			obj:enable(false)
			obj:show(false)
			obj:needToSave(false)
			obj:enableHitBoxes(false)
			obj:enableAutoActivation(false)
					
			obj.data.parent = self
			obj:addEvent("onDeath", {"! local parent = self.data.parent if GameScene.checkObject(parent) then parent.data.activeSummons = parent.data.activeSummons - 1 end", 0})
			
			table.insert(self.data.summons, obj)
		end
	end	
	self.data.currentSummon = 1
end


function CharacterTemplate:summonMonster()
	-- Если призыв делает игрок, инициализируем ему правильный список прототипов со слэшем!
	if self:isPlayerControlled() then
		if not self.data.summonsPrototypes or table.getn(self.data.summonsPrototypes) == 0 then
			-- Прописываем ТОЧНОЕ имя из базы данных skeletonParams.lua
			self.data.summonsPrototypes = {"Monsters/AvatarSummonZombie"} 
		end
		
		-- Если кэш существ пуст — генерируем его в реальном времени
		if not self.data.summons or table.getn(self.data.summons) == 0 then
			self:precashSummons(3) -- кэшируем 3 скелета для теста
		end
	end
	
	-- Железная проверка: если призывать некого, мягко выходим без краша
	if not self.data.summons or table.getn(self.data.summons) == 0 then
		return 
	end
	
	local lookDir = {self:getLookDir()}
	local pos = {self:getPosition()}
	
	-- Рассчитываем точку спавна перед лицом персонажа
	lookDir[1] = lookDir[1] * 2
	lookDir[2] = lookDir[2] * 2
	pos[1] = pos[1] + lookDir[1]
	pos[2] = pos[2] + lookDir[2]
	pos[3] = pos[3] + 2 -- небольшое смещение по высоте, чтобы не провалился под текстуры
	
	local t = physicTrace(pos, {0, -1, 0}, 10)	
	local spawnPos = t and t.position or pos
	
	-- Если дошли до конца лимита кэша, генерируем следующую партию скелетов
	if self.data.currentSummon > table.getn(self.data.summons) then
		self:precashSummons(3) 
	end
	
	local obj = self.data.summons[self.data.currentSummon]
	if obj and GameScene.checkObject(obj) then
		self.data.currentSummon = self.data.currentSummon + 1	
		
		self.data.activeSummons = self.data.activeSummons and self.data.activeSummons or 0
		self.data.activeSummons = self.data.activeSummons + 1
		
		-- Перемещаем скелета к игроку и активируем его
		obj:setPosition(spawnPos[1], spawnPos[2], spawnPos[3])
		obj:enablePhysics(true)
		obj:enable(true)
		obj:show(true)
		
		-- Настраиваем фракцию (team): заставляем скелета встать на сторону игрока!
		if self.data.team then
			obj.data.team = self.data.team
		else
			obj.data.team = "avatar" -- дефолтная фракция Аватара, если self.data.team пустой
		end
		
		-- Включаем встроенную в шаблон CharacterSkeleton анимацию красивого появления из дыма
		if obj.onActivate then
			obj:onActivate(true)
		else
			obj:enableHitBoxes(true)
			obj:enablePerception(true)
			obj:createActivationFx()
		end
		
		-- Если у игрока есть цель в памяти, заставляем скелета сразу атаковать её
		if self.memory and self.memory:getEnemy() then
			obj:alert(self.memory:getEnemy())
		end
		
		self.data.summonsList = self.data.summonsList and self.data.summonsList or {}
		table.insert(self.data.summonsList, obj:tag())
	end
end

function CharacterTemplate:setMagicSlot(slotname,withoutTip)
	local scroll = self:getEquiped(slotname);
	if scroll and not withoutTip then
		GAME_SCREEN.showAmmoTip(Res_Table[scroll.data.name])
	end
	self.data.magicSlot = slotname;
	onChooseMagicSlot(slotname);
end
function CharacterTemplate:getMagicSlot()
	return self.data.magicSlot;
end

function CharacterTemplate:terminateAllActions()
	for i, v in pairs(self.ALL_EFFECTORS) do
		local effector = self.effectors[v];
		if effector.action  and effector.actionName != "die" then
			effector.action:terminate();
		end
	end
end

DUST_DIST = 10;
function CharacterTemplate:createDust(animIdx)
	if (avatar and getDistSq2D({avatar:getPosition()}, {self:getPosition()}) > DUST_DIST * DUST_DIST) 
		or not self:isOnGround()
	then
		return;
	end
	local effectName = "simpleStep";
	EffectsManager.playEffect(effectName, {self:getPosition()})

	do return end
	
	local surface = self:getCollSurface();
	local pos = {self:getPosition()};
	if surface and surfaceProperties and surfaceProperties[surface] and surfaceProperties[surface].stepEffect then
		EffectsManager.playEffect(surfaceProperties[surface].stepEffect,pos);
	end
end

function CharacterTemplate:onRagDollColl(pos)
	if not self.data.firstRagDollColl then
		local effectName = "bodyFall";
		EffectsManager.playEffect(effectName, pos)
		self.data.firstRagDollColl = true;
	end
end
function CharacterTemplate:printItems()
	print("CharacterTemplate:printItems()");
	self.inventory:printInventory();
	self.slot:printSlot();	
end
function CharacterTemplate:printActions()
	print("CharacterTemplate:printActions() ",self:tag());
	for i, v in pairs(self.effectors) do
		if v.action then
			print("Effector: ",i," action: ",v.actionName);
		end;
	end
end
function CharacterTemplate:printVisuals()
	print("CharacterTemplate:printVisuals() ",self:tag());
	for i, v in pairs(self.effectors) do
		if v.visualTableName then
			print("Effector: ",i," action: ",v.visualTableName);
		end;
	end
end
require("engine/templates/alertState.lua");

