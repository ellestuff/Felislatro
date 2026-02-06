local config = SMODS.current_mod.config

censor_suffix = {".png", "_censored.png", "_featureless.png"}

--		[[ Atlases ]]
SMODS.Atlas {
	key = "jokers",
	path = "jokers.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "sophie",
	path = "sophie"..censor_suffix[config.censor],
	px = 71, py = 95
}

--		[[ Sounds ]]
-- planing on adding sfx

-- Add sophie stuff
SMODS.Joker:take_ownership('elle_sophie', {
	--soul_pos = {x = 0, y = 0, draw = function(card, scale_mod, rotate_mod) slimeutils.large_soul.draw(card, scale_mod, rotate_mod) end},
	update = function(self, card, _front)
		card.children.floating_sprite.atlas = G.ASSET_ATLAS.felis_sophie
		card.children.floating_sprite:set_sprite_pos({x = math.min(config.scaling_art.sophie and card.ability and card.ability.extra.charges or 0,6), y = 0})
		--slimeutils.large_soul.update(self, card)
	end
}, true)

SMODS.Joker:take_ownership('elle_fallen', {
	--soul_pos = {x = 0, y = 0, draw = function(card, scale_mod, rotate_mod) slimeutils.large_soul.draw(card, scale_mod, rotate_mod) end},
	update = function(self, card, _front)
		card.children.floating_sprite.atlas = G.ASSET_ATLAS.felis_sophie
		card.children.floating_sprite:set_sprite_pos({x = math.min(config.scaling_art.sophie and card.ability and card.ability.extra.charges or 0,6), y = 1})
		--slimeutils.large_soul.update(self, card)
	end
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
-- Commented out since i feel like it buffs the joker too much lol
--elle_bsky_did = "did:plc:reab4i3ugbxy53chfs34dwhw"
--elle_update_follower_count()