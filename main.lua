--		[[ Atlases ]]
SMODS.Atlas {
	key = "jokers",
	path = "jokers.png",
	px = 71,
	py = 95,
}
SMODS.Atlas {
	key = "sophie",
	path = "sophie.png",
	px = 71,
	py = 95,
}

--		[[ Sounds ]]
	-- planing on adding sophie sfx

-- Add sophie stuff
SMODS.Joker:take_ownership('elle_sophie',
    {
		--config.extra.felis_stage = 0,
		atlas = 'sophie',
		pos = { x = 0, y = 0 },
		soul_pos = { x = 5, y = 0 }
	},
    true
)
SMODS.Joker:take_ownership('elle_fallen',
    {
		--config.extra.felis_stage = 0,
		atlas = 'sophie',
		pos = { x = 0, y = 1 },
		soul_pos = { x = 5, y = 1 }
	},
    true
)

SMODS.Joker:take_ownership('elle_spearlamp',
    {
		atlas = 'jokers',
		pos = { x = 1, y = 0 }
	},
    true
)