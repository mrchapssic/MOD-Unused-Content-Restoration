Dialogs = {
	["Haircut"] = {
		["OnStart"] = "! npc.data.isTalking = true;",
		["node"] = {
			[1] = {
				["Phrase"] = {
					["textId"] = "Ciric_0", -- "Приветсвую почтенного гиазира, желаете подстричься ? "
					["OnShow"] = "! doRemark(npc, 'CLOSEUP_LEFT', nil, 'talk', 'sounds/test/Ciric-_2_.ogg');",
				},
				["Replies"] = {
					[1] = {
						["textId"] = "Orvin_1", -- "Да"
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 'sounds/Dialogs/Side/Side_Standards_Tradesman_1_1.ogg');",
						["leadTo"] = 2, -- Переход к списку причесок
					},
					[2] = {
						["textId"] = "Orvin_2", -- "Нет, спасибо"
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 'Sounds/Dialogs/Q06/Q06_TerTrader_3_2.ogg');",
						["leadTo"] = -1, -- Выход из диалога
					},
				},
			},
			[2] = {
				["Phrase"] = {
					["textId"] = "Ciric_01",
					["OnShow"] = "! doRemark(npc, 'CLOSEUP_LEFT', nil, 'talk', 'sounds/test/Ciric-_1_.ogg');",
				},
				["Replies"] = {
					[1] = {
						["textId"] = "Ciric_1", -- "Лысина"
						["OnClick"] = "!  loseGold(10); avatar:changeBodyPart('hair', '', 0);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[2] = {
						["textId"] = "Ciric_2", -- "Деревенщина"
						["OnClick"] = "! loseGold(20); avatar:changeBodyPart('hair', 'models/70_humans/h23700_hair_m3/h2370_hair_m3.OBJ.XML', 0);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[3] = {
						["textId"] = "Ciric_3", -- "Сено"
						["OnClick"] = "! loseGold(20); avatar:changeBodyPart('hair', 'models/70_humans/h23700_hair_m3/h2370_hair_m3.OBJ.XML', 1);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[4] = {
						["textId"] = "Ciric_4", -- "Под горшок"
						["OnClick"] = "! loseGold(15); avatar:changeBodyPart('hair', 'models/70_humans/h33700_hair_m3/h3370_hair_m3.OBJ.XML', 0);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[5] = {
						["textId"] = "Ciric_5", -- "Брауни"
						["OnClick"] = "! loseGold(15); avatar:changeBodyPart('hair', 'models/70_humans/h33700_hair_m3/h3370_hair_m3.OBJ.XML', 1);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[6] = {
						["textId"] = "Ciric_6", -- "Блонди"
						["OnClick"] = "! loseGold(50); avatar:changeBodyPart('hair', 'models/70_humans/h23700_hair_m1/h2370_hair_m1.OBJ.XML', 1);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[7] = {
						["textId"] = "Ciric_7", -- "Гиазир"
						["OnClick"] = "! loseGold(50); avatar:changeBodyPart('hair', 'models/70_humans/h23700_hair_m1/h2370_hair_m1.OBJ.XML', 0);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[8] = {
						["textId"] = "Ciric_8", -- "Светлые волосы"
						["OnClick"] = "! loseGold(100); avatar:changeBodyPart('hair', 'models/70_humans/h33850_Egin_hair/h3385_Egin_hair.OBJ.XML', 0);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[9] = {
						["textId"] = "Ciric_9", -- "Выщуп"
						["OnClick"] = "! loseGold(200); avatar:changeBodyPart('hair', 'models/70_humans/h18700_hair_tacit/h1870_hair_tacit.OBJ.XML', 0);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[10] = {
						["textId"] = "Ciric_10", -- "Прямые волосы"
						["OnClick"] = "! loseGold(250); avatar:changeBodyPart('hair', 'models/70_humans/h33850_Lagha_hair/h3385_Lagha_hair.OBJ.XML', 0);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[11] = {
						["textId"] = "Ciric_11", -- "С заколкой"
						["OnClick"] = "! loseGold(100); avatar:changeBodyPart('hair', 'models/70_humans/h33850_Orvin_pri4eska/h3385_Orvin_pri4eska.OBJ.XML', 0);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[12] = {
						["textId"] = "Ciric_12", -- "Рыжий"
						["OnClick"] = "! loseGold(200); avatar:changeBodyPart('hair', 'models/70_humans/h33850_Giron_hair/h3385_Giron_hair.OBJ.XML', 0);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[13] = {
						["textId"] = "Ciric_13", -- "Пепел"
						["OnClick"] = "! loseGold(250); avatar:changeBodyPart('hair', 'models/70_humans/h33700_hair_m2/h3370_hair_m2_sl.OBJ.XML', 0);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[14] = {
						["textId"] = "Ciric_14", -- "Базлан"
						["OnClick"] = "! loseGold(25); avatar:changeBodyPart('hair', 'models/70_humans/h33700_hair_m1/h3370_hair_m1.OBJ.XML', 0);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[15] = {
						["textId"] = "Ciric_15", -- "Шпона"
						["OnClick"] = "! loseGold(25); avatar:changeBodyPart('hair', 'models/70_humans/h33700_hair_m1/h3370_hair_m1.OBJ.XML', 1);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[16] = {
						["textId"] = "Ciric_16", -- "Шпона"
						["OnClick"] = "! loseGold(150); avatar:changeBodyPart('hair', 'models/70_humans/h12700_irokez/h1270_irokez.OBJ.XML', 2);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[17] = {
						["textId"] = "Ciric_17", -- "Шпона"
						["OnClick"] = "! loseGold(150); avatar:changeBodyPart('hair', 'models/70_humans/h12700_irokez/h1270_irokez.OBJ.XML', 0);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[18] = {
						["textId"] = "Ciric_18", -- "Шпона"
						["OnClick"] = "! loseGold(150); avatar:changeBodyPart('hair', 'models/70_humans/h12700_irokez/h1270_irokez.OBJ.XML', 1);",
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 23059);",
						["leadTo"] = -1,
					},
					[19] = {
						["textId"] = "Orvin_2", -- "Нет, спасибо"
						["OnShow"] = "! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', 'Sounds/Dialogs/Q06/Q06_TerTrader_3_2.ogg');",
						["leadTo"] = -1, -- Выход из диалога
					},
				},
			},
		},
	},
}
