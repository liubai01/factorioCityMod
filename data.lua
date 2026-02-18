-- Lego City Mod - Data Definitions
-- MVP Version: Core items, buildings, recipes, and technologies

-- ============================================================================
-- ITEMS
-- ============================================================================

-- Adult Citizen
data:extend({
  {
    type = "item",
    name = "lego-citizen",
    icon = "__base__/graphics/icons/character.png",  -- Placeholder, replace with custom icon
    icon_size = 64,
    icon_mipmaps = 4,
    stack_size = 50,
    subgroup = "intermediate-product",
    order = "a[lego-citizen]",
    flags = {"goes-to-quickbar"}
  },
  -- Tired Citizen
  {
    type = "item",
    name = "lego-citizen-tired",
    icon = "__base__/graphics/icons/character.png",  -- Placeholder, replace with custom icon
    icon_size = 64,
    icon_mipmaps = 4,
    stack_size = 50,
    subgroup = "intermediate-product",
    order = "a[lego-citizen-tired]",
    flags = {"goes-to-quickbar"}
  },
  -- Money
  {
    type = "item",
    name = "money",
    icon = "__base__/graphics/icons/coin.png",
    icon_size = 64,
    icon_mipmaps = 4,
    stack_size = 500,
    subgroup = "intermediate-product",
    order = "b[money]",
    flags = {"goes-to-quickbar"}
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
      emissions_per_minute = 2
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
      emissions_per_minute = 1
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
    source_inventory_size = 2,  -- Ore + Citizen
    result_inventory_size = 2,  -- Product + Citizen
    crafting_categories = {"smelting"},
    crafting_speed = 1.0,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 2
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
    name = "market",
    icon = "__base__/graphics/icons/assembling-machine-1.png",  -- Placeholder
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.2, result = "market"},
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
      emissions_per_minute = 1
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
    name = "recruit-lego",
    category = "crafting",
    enabled = false,
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
for recipe_name, recipe in pairs(data.raw.recipe) do
  if recipe.category == "smelting" and recipe.ingredients and recipe.results then
    local lego_recipe = table.deepcopy(recipe)
    lego_recipe.name = "lego-" .. recipe_name
    lego_recipe.category = "smelting"
    
    -- Add citizen to ingredients
    local new_ingredients = {}
    for _, ingredient in pairs(recipe.ingredients) do
      table.insert(new_ingredients, ingredient)
    end
    table.insert(new_ingredients, {type = "item", name = "lego-citizen", amount = 1})
    lego_recipe.ingredients = new_ingredients
    
    -- Add citizen to results (will be modified in control.lua based on stamina)
    local new_results = {}
    for _, result in pairs(recipe.results) do
      table.insert(new_results, result)
    end
    table.insert(new_results, {type = "item", name = "lego-citizen", amount = 1})
    lego_recipe.results = new_results
    
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
    icon = "__base__/graphics/technology/automation.png",  -- Placeholder
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
        type = "building-limit",
        building = "city-hall",
        limit = 1
      },
      {
        type = "building-limit",
        building = "house",
        limit = 2
      }
    },
    prerequisites = {},
    unit = {
      count = 30,
      ingredients = {
        {type = "item", name = "automation-science-pack", amount = 1}
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
    icon = "__base__/graphics/technology/logistics.png",  -- Placeholder
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
        type = "building-limit",
        building = "city-hall",
        limit = 1
      },
      {
        type = "building-limit",
        building = "house",
        limit = 5
      }
    },
    prerequisites = {"lego-city-settlement"},
    unit = {
      count = 50,
      ingredients = {
        {type = "item", name = "automation-science-pack", amount = 1},
        {type = "item", name = "logistic-science-pack", amount = 1}
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
        type = "building-limit",
        building = "city-hall",
        limit = 2
      },
      {
        type = "building-limit",
        building = "house",
        limit = 8
      }
      -- Work speed bonus will be applied in control.lua
    },
    prerequisites = {"lego-city-service"},
    unit = {
      count = 80,
      ingredients = {
        {type = "item", name = "automation-science-pack", amount = 1},
        {type = "item", name = "logistic-science-pack", amount = 1},
        {type = "item", name = "chemical-science-pack", amount = 1}
      },
      time = 30
    },
    order = "a-c"
  }
})
