
minetest.register_node("zest:steel_chest", {
	description = "Steel Chest",
	
	tiles = {
		"zest_steel_chest_up.png",
		"zest_steel_chest_up.png",
		"zest_steel_chest_side.png",
		"zest_steel_chest_side.png",
		"zest_steel_chest_side.png",
		"zest_steel_chest_front.png",
	},

	groups = { cracky=2 },

	on_rightclick = function(pos, node, player, itemstack, pointed_thing) -- Open inventory
		local meta = minetest.get_meta(pos)
		local playerName = player:get_player_name()
		local inv = meta:get_inventory()
		local posString = pos.x .. "," .. pos.y .. "," .. pos.z
		inv:set_size("main", 9*5)
		minetest.show_formspec(
			playerName,
			"zest:steel_chest",
			"size[10,9]" ..
			default.gui_bg ..
			default.gui_bg_img ..
			"list[nodemeta:" .. posString .. ";main;0.5,0;9,5;]" ..
			"list[current_player;main;1,5.25;8,4;]"
		)
	end,

	on_dig = function(pos, node, player) -- Prevent break if inventory is not empty
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local posString = pos.x .. "," .. pos.y .. "," .. pos.z
		if inv:is_empty("main") then
			minetest.node_dig(pos, node, player)
		end
	end
})

minetest.register_craft({
	output = "zest:steel_chest",
	
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:chest", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
	}

})
