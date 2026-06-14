Dialogs = {
	["Side_ClothesTrader3"] ={
		-- Строку OnStart полностью удалили, чтобы избежать багов с высотой
		node ={
			[1] = {
				Phrase ={
					["textId"] ="Side_Standards_Tradesman_1",
					["OnShow"] ="! doRemark(npc, 'CLOSEUP_LEFT', nil, 'talk', sound);",
				},
				Replies ={
					[1] = {
						["textId"] ="Side_Standards_Tradesman_1_1",
						["OnClick"] ="! addTimeEvent(startTrade, {npc:tag()}, .1);",
						["OnShow"] ="! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', sound);",	
					},
					[2] = {
						["textId"] ="Side_Standards_Tradesman_1_2",
						["OnShow"] ="! doRemark(avatar, 'CLOSEUP_RIGHT', nil, 'talk', sound);",
					},
				},
			},
		},
	},
}
