GameScene.createObject("Mission", "missionTemplate", {
	["isGameStateSave"] = false,
	["events"]= {
		["onAllSpawned"] ={
			[1] = "! if not globalGameState.state.io.Quest16ArrivedInItt then \
						globalGameState.state.io.Quest16ArrivedInItt = true; \
						addTimeEvent(checkPoint, {'checkpoint_ToIt'}, 1, true); \
					end",
			[2] = 0,
		},
	},
	["isEnable"] = true,
	["sceneFile"] = "$levels/It_City/It_City.scene.xml",
	["skyFile"] = "xml/sky_it_city.xml",
	["lightGridFile"] = "$levels/It_City/It_City_LG_1.lgrd",
	["dayLengthInSeconds"] = -1,
	["startHour"] = 20,
	["ambientSong"] = 19632,
	["spawnPoints"]= {
			[1]={x= -280.32,y=-25.86,z=0.28, dirX=-1, dirY=0, dirZ=0},
		},
		
	["refPoints"] = {sx=-470, sz=130, ex=-210, ez=-70},
	["mapID"] = 22512,
	["namePlace"] = "It_streets",
});

--[[
function a()
	GO('itCamera02'):play(); 
end 
function q()
	GO("itCamera02_mummy"):playAnimation(Character.BODY, "scene_it_eating_and_screaming", false, nil, nil, LOCK_AT_END)
	
end

function qq()
	--GO("itCamera02_mummy"):playAnimation(Character.BODY, "scene_it_eating_and_screaming", false, nil, nil, LOCK_AT_END)
	local x,y,z = GO("itCamera02_mummy"):getBonePosition("Bip01",Character.BODY)
	print(" x ",x, " y ",y," z ",z);
	
end
--]]

--v.object:playAnimation(v.visualIdx and v.visualIdx or Character.BODY, v.animName, false --[[]loop]], nil --[[]speed]], nil--[[]callback]], LOCK_AT_END);



-- [[
dofile(levelspath.."/It_City/Quest_Scene.lua");
dofile(levelspath.."/It_City/It_barriers.lua");
dofile(levelspath.."/It_City/It_monsters.lua");

dofile(levelspath.."/It_City/It_breakables_boxes.lua");
dofile(levelspath.."/It_City/It_breakables_barrels.lua");

dofile(levelspath.."/It_City/surrounds.lua");

dofile(levelspath.."/It_City/It_camera1.lua");
dofile(levelspath.."/It_City/It_camera2.lua");


dofile(levelspath.."/It_City/mouse.lua");
dofile(levelspath.."/It_City/It_trader_scene.lua");
--]]