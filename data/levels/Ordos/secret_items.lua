-- секретные итемы
GameScene.createObject("ItemGiver5", "ItemGiver", {
	["tm"] ={
		[1] = -0.002559243934229,
		[2] = 0,
		[3] = 0.99999672174454,
		[4] = 0,
		[5] = 0.65576106309891,
		[6] = 0.7549666762352,
		[7] = 0.001678258064203,
		[8] = 0,
		[9] = -0.75496417284012,
		[10] = 0.65576326847076,
		[11] = -0.0019321436993778,
		[12] = 0,
		[13] = 57.049808502197,
		[14] = -27.079336166382,
		[15] = 71.704605102539,
		[16] = 1,
	},
	["prototypeName"] ="ItemGiver",
	["scale"] ={
		[1] = 1,
		[2] = 1,
		[3] = 1,
	},
	["geomType"] =1,
	["isEnabledPhysics"] =false,
	["angVel"] =1,
	["itemPrototype"] ="staff_1",
	["effectName1"] ="itemGiverIdle",
	["isEnable"] =false,
	["effectName2"] ="itemGiverTake",
	["itemOffsetY"] =1,
	["isGameStateSave"] =false,
	["events"] ={
		["checkEnter"] ={
			[1] = "! for i,v in pairs(other) do if (v:tag() == 'Avatar') then return true else return false end end",
			[2] = 1,
		},
		["onEnter"] ={
			[1] = "! print('onEnter'); self:enter(other);",
			[2] = 0,
		},
		["onLeave"] ={
			[1] = "! print('onLeave'); self:leave();",
			[2] = 0,
		},
	},
	["invisible"] =true,
});
	