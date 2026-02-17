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
SMODS.Atlas {
	key = "lamps",
	path = "lamps.png",
	px = 71, py = 95
}

--		[[ Sounds ]]
-- planing on adding sfx

local function soph_x(card)
	return math.min(config.scaling_art.sophie and card.ability and card.ability.extra.charges or 0,6)
end

-- Add sophie stuff
SMODS.Joker:take_ownership('elle_sophie', {
	--soul_pos = {x = 0, y = 0, draw = function(card, scale_mod, rotate_mod) slimeutils.large_soul.draw(card, scale_mod, rotate_mod) end},
	update = function(self, card, _front)
		card.children.floating_sprite:set_sprite_pos({x = soph_x(card), y = 0})
		--slimeutils.large_soul.update(self, card)
	end,
	set_sprites = function(self, card, front) card.children.floating_sprite.atlas = G.ASSET_ATLAS.felis_sophie end
}, true)

SMODS.Joker:take_ownership('elle_fallen', {
	--soul_pos = {x = 0, y = 0, draw = function(card, scale_mod, rotate_mod) slimeutils.large_soul.draw(card, scale_mod, rotate_mod) end},
	update = function(self, card, _front)
		card.children.floating_sprite:set_sprite_pos({x = soph_x(card), y = 1})
		--slimeutils.large_soul.update(self, card)
	end,
	set_sprites = function(self, card, front) card.children.floating_sprite.atlas = G.ASSET_ATLAS.felis_sophie end
}, true)

local function quick_resprite(key,pos)
	SMODS.Joker:take_ownership(key, {
		atlas = 'jokers',
		pos = pos
	}, true)
end
quick_resprite('elle_feri', { x = 0, y = 0 })

SMODS.Joker:take_ownership('elle_spearlamp', {
	atlas = 'lamps'
}, true)

-- iterating backwards to make sure things get removed correctly
local remove_puritan = {
	j_elle_feri = true
}
for i=#ellejokers.puritan_cards,1,-1 do
	if remove_puritan[ellejokers.puritan_cards[i]] then table.remove(ellejokers.puritan_cards,i) end
end

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

SMODS.current_mod.menu_cards = function()
    return {
		{
			key = "j_elle_fallen",
			no_edition = true,
			
		},
		
		func = function()
			for k, v in pairs(G.title_top.cards) do
				if v.config.center.key == 'j_elle_fallen' and config.scaling_art.sophie then
					G.E_MANAGER:add_event(Event{delay = 2, func=function()
						for i = 1, 6, 1 do
							G.E_MANAGER:add_event(Event{trigger="after",delay = .5+(i-1)*.1, func=function()
								v.ability.extra.charges = v.ability.extra.charges+1
								v:juice_up()
								play_sound(i==6 and "tarot1" or "tarot2")
							return true end})
						end
					return true end})
					
				end
			end
		end
	}
end

-- Make elle joker use alt account's follower count
-- Commented out since i feel like it buffs the joker too much lol
--elle_bsky_did = "did:plc:reab4i3ugbxy53chfs34dwhw"
--elle_update_follower_count()