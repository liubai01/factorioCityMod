-- Lego City Mod - Data Definitions
-- MVP Version: Core items, buildings, recipes, and technologies

-- ============================================================================
-- CUSTOM RECIPE CATEGORIES
-- Each building only accepts its own category, preventing vanilla recipes
-- from appearing in city buildings.
-- ============================================================================

data:extend({
  { type = "recipe-category", name = "city-hall-crafting" },  -- recruit-lego only
  { type = "recipe-category", name = "house-crafting" },      -- rest-lego only
  { type = "recipe-category", name = "market-crafting" },     -- sell-* only
  { type = "recipe-category", name = "lego-smelting" },       -- lego-* smelting (citizen + ore)
})

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
    icon = "__base__/graphics/icons/assembling-machine-3.png",
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
    icon = "__base__/graphics/icons/assembling-machine-2.png",  -- Placeholder: market building
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

-- City Hall  (placeholder graphics: assembling-machine-3)
local am3 = data.raw["assembling-machine"]["assembling-machine-3"]
data:extend({
  {
    type = "assembling-machine",
    name = "city-hall",
    icon = "__base__/graphics/icons/assembling-machine-3.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.2, result = "city-hall"},
    max_health = 300,
    corpse = am3.corpse,
    dying_explosion = am3.dying_explosion,
    resistances = {
      {type = "fire", percent = 70}
    },
    collision_box = am3.collision_box,
    selection_box = am3.selection_box,
    drawing_box = am3.drawing_box,
    graphics_set = table.deepcopy(am3.graphics_set),
    open_sound = am3.open_sound,
    close_sound = am3.close_sound,
    vehicle_impact_sound = am3.vehicle_impact_sound,
    working_sound = am3.working_sound,
    crafting_categories = {"city-hall-crafting"},
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

-- Regular House  (placeholder graphics: assembling-machine-1)
local am1 = data.raw["assembling-machine"]["assembling-machine-1"]
data:extend({
  {
    type = "assembling-machine",
    name = "house",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.2, result = "house"},
    max_health = 200,
    corpse = am1.corpse,
    dying_explosion = am1.dying_explosion,
    resistances = {
      {type = "fire", percent = 70}
    },
    collision_box = am1.collision_box,
    selection_box = am1.selection_box,
    drawing_box = am1.drawing_box,
    graphics_set = table.deepcopy(am1.graphics_set),
    open_sound = am1.open_sound,
    close_sound = am1.close_sound,
    vehicle_impact_sound = am1.vehicle_impact_sound,
    working_sound = am1.working_sound,
    crafting_categories = {"house-crafting"},
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

-- Lego Furnace  (placeholder graphics: electric-furnace)
-- NOTE: Using assembling-machine type instead of furnace because Factorio 2.0
-- restricts furnace source_inventory_size to 1. assembling-machine with
-- crafting_categories = {"smelting"} supports multiple ingredient slots (ore + citizen).
local ef = data.raw["furnace"]["electric-furnace"]
data:extend({
  {
    type = "assembling-machine",
    name = "lego-furnace",
    icon = "__base__/graphics/icons/electric-furnace.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.2, result = "lego-furnace"},
    max_health = 300,
    corpse = ef.corpse,
    dying_explosion = ef.dying_explosion,
    resistances = {
      {type = "fire", percent = 70}
    },
    collision_box = ef.collision_box,
    selection_box = ef.selection_box,
    drawing_box = ef.drawing_box,
    graphics_set = table.deepcopy(ef.graphics_set),
    open_sound = ef.open_sound,
    close_sound = ef.close_sound,
    vehicle_impact_sound = ef.vehicle_impact_sound,
    working_sound = ef.working_sound,
    crafting_categories = {"lego-smelting"},
    crafting_speed = 1.0,
    ingredient_count = 2,  -- Ore slot + Citizen slot
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 2 }
    },
    energy_usage = "100kW",
    module_specification = nil,
    allowed_effects = {},
    fluid_boxes = {},
    module_slots = 0
  }
})

-- Market  (placeholder graphics: assembling-machine-2)
local am2 = data.raw["assembling-machine"]["assembling-machine-2"]
data:extend({
  {
    type = "assembling-machine",
    name = "lego-market",
    icon = "__base__/graphics/icons/assembling-machine-2.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.2, result = "lego-market"},
    max_health = 300,
    corpse = am2.corpse,
    dying_explosion = am2.dying_explosion,
    resistances = {
      {type = "fire", percent = 70}
    },
    collision_box = am2.collision_box,
    selection_box = am2.selection_box,
    drawing_box = am2.drawing_box,
    graphics_set = table.deepcopy(am2.graphics_set),
    open_sound = am2.open_sound,
    close_sound = am2.close_sound,
    vehicle_impact_sound = am2.vehicle_impact_sound,
    working_sound = am2.working_sound,
    crafting_categories = {"market-crafting"},
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
    category = "city-hall-crafting",
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
    category = "house-crafting",
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
    category = "market-crafting",
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
    category = "market-crafting",
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
    lego_recipe.category = "lego-smelting"
    lego_recipe.subgroup = "lego-city-smelting"
    lego_recipe.order = recipe_name
    lego_recipe.localised_description = nil
    
    -- Per design: citizen is a required ingredient (catalyst), consumed and returned
    -- after smelting.  The citizen always exits as lego-citizen-tired (simplified
    -- stamina model; House recipe converts tired → adult, completing the loop).
    local new_ingredients = {}
    for _, ing in pairs(lego_recipe.ingredients) do
      table.insert(new_ingredients, ing)
    end
    table.insert(new_ingredients, {type = "item", name = "lego-citizen", amount = 1})
    lego_recipe.ingredients = new_ingredients

    -- Build results: smelting product(s) + tired citizen output
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
    -- Always output tired citizen (stamina consumed by work); House restores them
    table.insert(new_results, {type = "item", name = "lego-citizen-tired", amount = 1})
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
