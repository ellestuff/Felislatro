local config = SMODS.current_mod.config

sophie_atlas = {"sophie.png", "sophie_censored.png", "sophie_featureless.png"}

--		[[ Atlases ]]
SMODS.Atlas {
	key = "jokers",
	path = "jokers.png",
	px = 71,
	py = 95,
}
SMODS.Atlas {
	key = "sophie",
	path = sophie_atlas[config.sophie.censor],
	px = 71,
	py = 95,
}

--		[[ Sounds ]]
	-- planing on adding sophie sfx

felis_sophie_scaling = {
	function(mult,mod) return 0 end,
	function(mult,mod) return math.floor(math.sqrt(to_number(mult)/(100*mod))) end,
	function(mult,mod) return to_number(mult/mod)<1 and 0 or math.floor(math.sqrt(to_number(math.log(mult/mod)/2))) end,
	function(mult,mod) return to_number(mult/mod)<1 and 0 or math.floor(math.sqrt(to_number(math.log(math.log(mult/mod))))) end,
	function(mult,mod) return to_number(mult/mod)<1 and 0 or math.floor(math.sqrt(to_number(math.log(math.log(math.log(mult/mod)))))) end
}

-- Add sophie stuff
SMODS.Joker:take_ownership('elle_sophie',
    {
		atlas = 'sophie',
		pos = { x = 0, y = 0 },
		soul_pos = { x = 1, y = 0 },
		update = function(self, card, dt)
			local scale = felis_sophie_scaling[config.sophie.scaling]
			local stage = math.min(math.max(scale(card.ability.extra.mult, card.ability.extra.mult_mod),0),6)+1
			card.children.floating_sprite:set_sprite_pos({x = stage, y = 0})
		end
	},
    true
)
SMODS.Joker:take_ownership('elle_fallen',
    {
		atlas = 'sophie',
		pos = { x = 0, y = 1 },
		soul_pos = { x = 1, y = 1 },
		update = function(self, card, dt)
			local scale = felis_sophie_scaling[config.sophie.scaling]
			local stage = math.min(math.max(scale(card.ability.extra.mult, card.ability.extra.mult_mod),0),6)+1
			card.children.floating_sprite:set_sprite_pos({x = stage, y = 1})
		end
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
SMODS.Joker:take_ownership('elle_vivian',
    {
		atlas = 'jokers',
		pos = { x = 0, y = 0 }
	},
    true
)

--		[[ Config ]]
SMODS.current_mod.config_tab = function()
	return {n = G.UIT.ROOT, config = {
		align = "cm", padding = 0.05, colour = G.C.CLEAR
	}, nodes = {
		create_option_cycle({opt_callback = "conf_felis_soph_censor",
			label = "Sophie Censorship (Requires Restart)",
			options = {"Default", "Censor Bar", "Featureless"},
			current_option = config.sophie.censor,
			scale = 0.8,
			info = {
				"How to censor Sophie's sprites"
			},
			w = 3
		}),
		create_option_cycle({opt_callback = "conf_felis_soph_scaling",
			label = "Sophie Scaling",
			options = {"Off", "Vanilla - sqrt(mult/100)", "Extreme - sqrt(log(mult)/2)", "Cryptid - sqrt(log(log(mult)))", "WTF - sqrt(log#3(mult))"},
			current_option = config.sophie.scaling,
			scale = 0.8,
			info = {
				"How fast Sophie and Fallen Angel scale between stages"
			},
			w = 7
		})
	}}
end

function G.FUNCS.conf_felis_soph_censor(args)
	config.sophie.censor = args.cycle_config.current_option
end

function G.FUNCS.conf_felis_soph_scaling(args)
	config.sophie.scaling = args.cycle_config.current_option
end