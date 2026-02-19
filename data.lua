-- Lego City Mod - Data Definitions
-- MVP Version: Core items, buildings, recipes, and technologies

-- ============================================================================
-- ITEM GROUP & SUBGROUPS  (Lego City crafting tab)
-- ============================================================================

data:extend({
  -- Main tab icon
  {
    type = "item-group",
    name = "lego-city",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64,
    order = "z[lego-city]"
  },
  -- Row 1: Citizens & currency
  {
    type = "item-subgroup",
    name = "lego-city-units",
    group = "lego-city",
    order = "a"
  },
  -- Row 2: Buildings
  {
    type = "item-subgroup",
    name = "lego-city-buildings",
    group = "lego-city",
    order = "b"
  },
  -- Row 3: Lego smelting recipes
  {
    type = "item-subgroup",
    name = "lego-city-smelting",
    group = "lego-city",
    order = "c"
  },
  -- Row 4: Market / exchange recipes
  {
    type = "item-subgroup",
    name = "lego-city-market",
    group = "lego-city",
    order = "d"
  }
})

-- ============================================================================
-- ITEMS
-- ============================================================================

-- Adult Citizen
data:extend({
  {
    type = "item",
    name = "lego-citizen",
    icon = "__base__/graphics/icons/construction-robot.png",  -- Placeholder: citizen worker
    icon_size = 64,
    icon_mipmaps = 4,
    stack_size = 50,
    subgroup = "lego-city-units",
    order = "a[lego-citizen]"
  },
  -- Tired Citizen
  {
    type = "item",
    name = "lego-citizen-tired",
    icon = "__base__/graphics/icons/battery.png",  -- Placeholder: low energy / tired
    icon_size = 64,
    icon_mipmaps = 4,
    stack_size = 50,
    subgroup = "lego-city-units",
    order = "b[lego-citizen-tired]"
  },
  -- Money
  {
    type = "item",
    name = "money",
    icon = "__base__/graphics/icons/coin.png",
    icon_size = 64,
    icon_mipmaps = 4,
    stack_size = 500,
    subgroup = "lego-city-units",
    order = "c[money]"
  },
  -- City Hall Item
  {
    type = "item",
    name = "city-hall",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "lego-city-buildings",
    order = "a[city-hall]",
    place_result = "city-hall",
    stack_size = 20
  },
  -- House Item
  {
    type = "item",
    name = "house",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "lego-city-buildings",
    order = "b[house]",
    place_result = "house",
    stack_size = 50
  },
  -- Lego Furnace Item
  {
    type = "item",
    name = "lego-furnace",
    icon = "__base__/graphics/icons/electric-furnace.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "lego-city-buildings",
    order = "c[lego-furnace]",
    place_result = "lego-furnace",
    stack_size = 50
  },
  -- Market Item
  {
    type = "item",
    name = "lego-market",
    icon = "__base__/graphics/icons/market.png",  -- Placeholder: market building
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "lego-city-buildings",
    order = "d[lego-market]",
    place_result = "lego-market",
    stack_size = 20
  }
})

-- ============================================================================
-- BUILDINGS
-- ============================================================================

-- City Hall
data:extend({
  {
    type = "assembling-machine",
    name = "city-hall",
    icon = "__base__/graphics/icons/assembling-machine-1.png",  -- Placeholder
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.2, result = "city-hall"},
    max_health = 300,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "assembling-machine-1-explosion",
    resistances = {
      {type = "fire", percent = 70}
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    drawing_box = {{-1.5, -1.5}, {1.5, 1.5}},
    animation = data.raw["assembling-machine"]["assembling-machine-1"].animation,
    open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.85},
    close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.75},
    vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
    working_sound = {
      sound = {
        {filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.8},
        {filename = "__base__/sound/assembling-machine-t1-2.ogg", volume = 0.8}
      },
      idle_sound = {filename = "__base__/sound/idle1.ogg", volume = 0.6},
      apparent_volume = 1.5
    },
    crafting_categories = {"crafting"},
    crafting_speed = 1.0,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 2 }
    },
    energy_usage = "100kW",
    ingredient_count = 1,
    module_specification = nil,
    allowed_effects = {},
    fluid_boxes = {},
    module_slots = 0
  }
})

-- Regular House
data:extend({
  {
    type = "assembling-machine",
    name = "house",
    icon = "__base__/graphics/icons/assembling-machine-1.png",  -- Placeholder
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.2, result = "house"},
    max_health = 200,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "assembling-machine-1-explosion",
    resistances = {
      {type = "fire", percent = 70}
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    drawing_box = {{-1.5, -1.5}, {1.5, 1.5}},
    animation = data.raw["assembling-machine"]["assembling-machine-1"].animation,
    open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.85},
    close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.75},
    vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
    working_sound = {
      sound = {
        {filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.8},
        {filename = "__base__/sound/assembling-machine-t1-2.ogg", volume = 0.8}
      },
      idle_sound = {filename = "__base__/sound/idle1.ogg", volume = 0.6},
      apparent_volume = 1.5
    },
    crafting_categories = {"crafting"},
    crafting_speed = 1.0,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 1 }
    },
    energy_usage = "20kW",
    ingredient_count = 1,
    module_specification = nil,
    allowed_effects = {},
    fluid_boxes = {},
    module_slots = 0
  }
})

-- Lego Furnace
data:extend({
  {
    type = "furnace",
    name = "lego-furnace",
    icon = "__base__/graphics/icons/electric-furnace.png",  -- Placeholder
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.2, result = "lego-furnace"},
    max_health = 300,
    corpse = "electric-furnace-remnants",
    dying_explosion = "electric-furnace-explosion",
    resistances = {
      {type = "fire", percent = 70}
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    working_visualisations = data.raw["furnace"]["electric-furnace"].working_visualisations,
    animation = data.raw["furnace"]["electric-furnace"].animation,
    working_sound = data.raw["furnace"]["electric-furnace"].working_sound,
    source_inventory_size = 1,  -- Ore only (citizen managed via results)
    result_inventory_size = 1,  -- Product only (citizen output handled by control.lua)
    crafting_categories = {"smelting"},
    crafting_speed = 1.0,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 2 }
    },
    energy_usage = "100kW",
    module_specification = nil,
    allowed_effects = {},
    module_slots = 0
  }
})

-- Market
data:extend({
  {
    type = "assembling-machine",
    name = "lego-market",
    icon = "__base__/graphics/icons/market.png",  -- Placeholder: market building
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.2, result = "lego-market"},
    max_health = 300,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "assembling-machine-1-explosion",
    resistances = {
      {type = "fire", percent = 70}
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    drawing_box = {{-1.5, -1.5}, {1.5, 1.5}},
    animation = data.raw["assembling-machine"]["assembling-machine-1"].animation,
    open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.85},
    close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.75},
    vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
    working_sound = {
      sound = {
        {filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.8},
        {filename = "__base__/sound/assembling-machine-t1-2.ogg", volume = 0.8}
      },
      idle_sound = {filename = "__base__/sound/idle1.ogg", volume = 0.6},
      apparent_volume = 1.5
    },
    crafting_categories = {"crafting"},
    crafting_speed = 1.0,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 1 }
    },
    energy_usage = "50kW",
    ingredient_count = 1,
    module_specification = nil,
    allowed_effects = {},
    fluid_boxes = {},
    module_slots = 0
  }
})

-- ============================================================================
-- RECIPES
-- ============================================================================

-- Recruit Lego Citizen
data:extend({
  {
    type = "recipe",
    name = "city-hall",
    enabled = false,
    subgroup = "lego-city-buildings",
    order = "a[city-hall]",
    ingredients = {
      {type = "item", name = "iron-plate", amount = 20},
      {type = "item", name = "electronic-circuit", amount = 5}
    },
    results = {
      {type = "item", name = "city-hall", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "house",
    enabled = false,
    subgroup = "lego-city-buildings",
    order = "b[house]",
    ingredients = {
      {type = "item", name = "iron-plate", amount = 10}
    },
    results = {
      {type = "item", name = "house", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "lego-furnace",
    enabled = false,
    subgroup = "lego-city-buildings",
    order = "c[lego-furnace]",
    ingredients = {
      {type = "item", name = "steel-plate", amount = 10},
      {type = "item", name = "stone-brick", amount = 10},
      {type = "item", name = "advanced-circuit", amount = 5}
    },
    results = {
      {type = "item", name = "lego-furnace", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "lego-market",
    enabled = false,
    subgroup = "lego-city-buildings",
    order = "d[lego-market]",
    ingredients = {
      {type = "item", name = "iron-plate", amount = 15},
      {type = "item", name = "electronic-circuit", amount = 5}
    },
    results = {
      {type = "item", name = "lego-market", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "recruit-lego",
    category = "crafting",
    enabled = false,
    subgroup = "lego-city-units",
    order = "d[recruit-lego]",
    energy_required = 2,
    ingredients = {
      {type = "item", name = "money", amount = 10}
    },
    results = {
      {type = "item", name = "lego-citizen", amount = 1}
    }
  }
})

-- Citizen Rest Recovery
data:extend({
  {
    type = "recipe",
    name = "rest-lego",
    category = "crafting",
    enabled = false,
    subgroup = "lego-city-units",
    order = "e[rest-lego]",
    energy_required = 1,
    ingredients = {
      {type = "item", name = "lego-citizen-tired", amount = 1}
    },
    results = {
      {type = "item", name = "lego-citizen", amount = 1}
    }
  }
})

-- Market Exchange Recipes
data:extend({
  {
    type = "recipe",
    name = "sell-iron-plate",
    category = "crafting",
    enabled = false,
    subgroup = "lego-city-market",
    order = "a[sell-iron-plate]",
    energy_required = 0.5,
    ingredients = {
      {type = "item", name = "iron-plate", amount = 1}
    },
    results = {
      {type = "item", name = "money", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "sell-copper-plate",
    category = "crafting",
    enabled = false,
    subgroup = "lego-city-market",
    order = "b[sell-copper-plate]",
    energy_required = 0.5,
    ingredients = {
      {type = "item", name = "copper-plate", amount = 1}
    },
    results = {
      {type = "item", name = "money", amount = 2}
    }
  }
})

-- Dynamic Smelting Recipes (for Lego Furnace)
-- Generate recipes for all vanilla smelting recipes
local function get_result_name(result_entry)
  if type(result_entry) ~= "table" then
    return nil
  end
  if result_entry.name then
    return result_entry.name
  end
  if type(result_entry[1]) == "string" then
    return result_entry[1]
  end
  return nil
end

local function get_product_icon(product_name)
  if not product_name then
    return nil, nil, nil
  end

  local item_prototype_types = {
    "item",
    "ammo",
    "capsule",
    "gun",
    "module",
    "armor",
    "tool",
    "item-with-entity-data"
  }

  for _, prototype_type in pairs(item_prototype_types) do
    local proto_group = data.raw[prototype_type]
    if proto_group and proto_group[product_name] then
      local proto = proto_group[product_name]
      return proto.icon, proto.icon_size, proto.icons
    end
  end

  if data.raw.fluid and data.raw.fluid[product_name] then
    local fluid = data.raw.fluid[product_name]
    return fluid.icon, fluid.icon_size, fluid.icons
  end

  return nil, nil, nil
end

local smelting_recipe_snapshot = {}
for recipe_name, recipe in pairs(data.raw.recipe) do
  if string.sub(recipe_name, 1, 5) ~= "lego-" then
    table.insert(smelting_recipe_snapshot, {name = recipe_name, recipe = recipe})
  end
end

for _, entry in pairs(smelting_recipe_snapshot) do
  local recipe_name = entry.name
  local recipe = entry.recipe
  if recipe.category == "smelting" and recipe.ingredients and (recipe.results or recipe.result) then
    local lego_recipe = table.deepcopy(recipe)
    lego_recipe.name = "lego-" .. recipe_name
    lego_recipe.category = "smelting"
    lego_recipe.subgroup = "lego-city-smelting"
    lego_recipe.order = recipe_name
    lego_recipe.localised_description = nil
    
    -- Keep original ingredients (ore only; citizen slot removed since furnace source_inventory_size = 1)
    -- Citizen is consumed/returned via control.lua stamina logic, not as a recipe ingredient

    -- Add citizen to results (will be modified in control.lua based on stamina)
    local new_results = {}
    local base_product_name = recipe.result
    if recipe.results then
      for _, result in pairs(recipe.results) do
        table.insert(new_results, result)
        if (not base_product_name) and get_result_name(result) ~= "lego-citizen" then
          base_product_name = get_result_name(result)
        end
      end
    else
      table.insert(new_results, {
        type = "item",
        name = recipe.result,
        amount = recipe.result_count or 1
      })
      lego_recipe.result = nil
      lego_recipe.result_count = nil
    end
    table.insert(new_results, {type = "item", name = "lego-citizen", amount = 1})
    lego_recipe.results = new_results

    -- Use the base product's item-name as the recipe display name to avoid locale "Unknown key".
    if base_product_name then
      lego_recipe.localised_name = {"item-name." .. base_product_name}
    end

    -- Recipes with multiple outputs need explicit icon/icons.
    if (not lego_recipe.icon) and (not lego_recipe.icons) then
      local icon, icon_size, icons = get_product_icon(base_product_name)
      if icons then
        lego_recipe.icons = table.deepcopy(icons)
      elseif icon then
        lego_recipe.icon = icon
        lego_recipe.icon_size = icon_size or 64
      end
    end
    
    data:extend({lego_recipe})
  end
end

-- ============================================================================
-- TECHNOLOGIES
-- ============================================================================

-- City Settlement
data:extend({
  {
    type = "technology",
    name = "lego-city-settlement",
    icon = "__base__/graphics/technology/automation-1.png",  -- Placeholder
    icon_size = 256,
    icon_mipmaps = 4,
    effects = {
      {
        type = "unlock-recipe",
        recipe = "recruit-lego"
      },
      {
        type = "unlock-recipe",
        recipe = "rest-lego"
      },
      {
        type = "unlock-recipe",
        recipe = "city-hall"
      },
      {
        type = "unlock-recipe",
        recipe = "house"
      }
    },
    prerequisites = {},
    unit = {
      count = 30,
      ingredients = {
        {"automation-science-pack", 1}
      },
      time = 30
    },
    order = "a-a"
  }
})

-- Town Services
data:extend({
  {
    type = "technology",
    name = "lego-city-service",
    icon = "__base__/graphics/technology/logistics-1.png",  -- Placeholder
    icon_size = 256,
    icon_mipmaps = 4,
    effects = {
      {
        type = "unlock-recipe",
        recipe = "sell-iron-plate"
      },
      {
        type = "unlock-recipe",
        recipe = "sell-copper-plate"
      },
      {
        type = "unlock-recipe",
        recipe = "lego-market"
      },
      {
        type = "unlock-recipe",
        recipe = "lego-furnace"
      }
    },
    prerequisites = {"lego-city-settlement"},
    unit = {
      count = 50,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    order = "a-b"
  }
})

-- City Management
data:extend({
  {
    type = "technology",
    name = "lego-city-management",
    icon = "__base__/graphics/technology/chemical-science-pack.png",  -- Placeholder
    icon_size = 256,
    icon_mipmaps = 4,
    effects = {
      {
        type = "nothing",
        effect_description = {"", "Improve city operation efficiency."}
      }
      -- Work speed bonus will be applied in control.lua
    },
    prerequisites = {"lego-city-service"},
    unit = {
      count = 80,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    order = "a-c"
  }
})
