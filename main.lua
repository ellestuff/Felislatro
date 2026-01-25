local config = SMODS.current_mod.config

censor_suffix = {".png", "_censored.png", "_featureless.png"}
joker_atlases = {
	"sophie"
}

--		[[ Atlases ]]
SMODS.Atlas {
	key = "jokers",
	path = "jokers.png",
	px = 71,
	py = 95,
}

for _,v in ipairs(joker_atlases) do
	SMODS.Atlas {
		key = v,
		path = v..censor_suffix[config.censor],
		px = 71, py = 95
	}
end

--		[[ Sounds ]]
-- planing on adding sfx

-- Add sophie stuff
SMODS.Joker:take_ownership('elle_sophie', {
	atlas = 'sophie',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	update = function(self, card, dt) card.children.floating_sprite:set_sprite_pos({x = math.min(config.scaling_art.sophie and card.ability.extra.charges+1 or 1,7), y = 0}) end
}, true)
SMODS.Joker:take_ownership('elle_fallen', {
	atlas = 'sophie',
	pos = { x = 0, y = 1 },
	soul_pos = { x = 1, y = 1 },
	update = function(self, card, dt) card.children.floating_sprite:set_sprite_pos({x = math.min(config.scaling_art.sophie and card.ability.extra.charges+1 or 1,7), y = 1}) end
}, true)

SMODS.Joker:take_ownership('elle_spearlamp', {
	atlas = 'jokers',
	pos = { x = 1, y = 0 }
}, true)
SMODS.Joker:take_ownership('elle_vivian', {
	atlas = 'jokers',
	pos = { x = 0, y = 0 }
}, true)

--		[[ Config ]]
SMODS.current_mod.config_tab = function()
	return {n = G.UIT.ROOT, config = {
		align = "cm", padding = 0.05, colour = G.C.CLEAR
	}, nodes = {
		create_option_cycle({opt_callback = "conf_felis_censor",
			label = "Card Art Censorship (Requires Restart)",
			options = {"Default", "Censor Bar", "Featureless"},
			current_option = config.censor,
			scale = 0.8,
			info = {
				"How to censor NSFW sprites"
			},
			w = 3
		}),
		create_toggle({opt_callback = "conf_felis_soph_scaling",
			label = "Sophie Scaling Art",
			ref_table = config.scaling_art,
			ref_value = "sophie",
			callback = sophie_scaling
		})
	}}
end

function G.FUNCS.conf_felis_censor(args)
	config.censor = args.cycle_config.current_option
end

local function sophie_scaling()
	config.scaling_art.sophie = not config.scaling_art.sophie
end

-- Make elle joker use alt account's follower count
-- Commented out since i feel like it buffs the joker to numberslop levels :p
--elle_bsky_did = "did:plc:reab4i3ugbxy53chfs34dwhw"
--elle_update_follower_count()