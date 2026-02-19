-- Lego City Mod - Control Logic
-- Factorio 2.0 compatible
-- NOTE: In Factorio 2.0, persistent mod data uses `storage` (not `global`).
-- NOTE: on_recipe_finished was removed in 2.0; machine-craft completion has no
--       equivalent event. Stamina / quota enforcement is handled passively via
--       recipe design rather than runtime interception.

-- ============================================================================
-- GLOBAL DATA INITIALIZATION
-- ============================================================================

script.on_init(function()
  storage.building_limits = {
    ["city-hall"] = 1,
    ["house"] = 2
  }
end)

script.on_load(function()
  storage.building_limits = storage.building_limits or {
    ["city-hall"] = 1,
    ["house"] = 2
  }
end)

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

-- Calculate population quota based on city buildings on surface 1
local function calculate_population_quota(surface)
  surface = surface or game.surfaces[1]
  if not surface then return 0 end
  local city_halls = surface.count_entities_filtered{name = "city-hall"}
  local houses     = surface.count_entities_filtered{name = "house"}
  return city_halls * 5 + houses * 3
end

-- ============================================================================
-- EVENT HANDLERS
-- ============================================================================

-- Handle building placement: nothing immediate needed, quota recalculated live
-- API 2.0: event field is `entity` (was `created_entity` in 1.x)
script.on_event(defines.events.on_built_entity, function(event)
  local entity = event.entity
  if not entity or not entity.valid then return end

  if entity.name == "city-hall" or entity.name == "house" then
    -- Quota will be recalculated on next recruitment check
    -- (No immediate action needed in MVP)
  end
end)

-- Handle building removal via robot
script.on_event(defines.events.on_robot_built_entity, function(event)
  local entity = event.entity
  if not entity or not entity.valid then return end

  if entity.name == "city-hall" or entity.name == "house" then
    -- Quota will be recalculated on next recruitment check
  end
end)

-- Handle building destruction
script.on_event(defines.events.on_entity_died, function(event)
  local entity = event.entity
  if not entity or not entity.valid then return end

  if entity.name == "city-hall" or entity.name == "house" then
    -- Existing citizens remain (as per design)
  end
end)

-- Handle technology research: update stored building limits
script.on_event(defines.events.on_research_finished, function(event)
  local research = event.research
  if not research then return end

  if research.name == "lego-city-settlement" then
    storage.building_limits["city-hall"] = 1
    storage.building_limits["house"] = 2
  elseif research.name == "lego-city-service" then
    storage.building_limits["city-hall"] = 1
    storage.building_limits["house"] = 5
  elseif research.name == "lego-city-management" then
    storage.building_limits["city-hall"] = 2
    storage.building_limits["house"] = 8
  end
end)

-- Handle script-created entities (e.g. from other mods or commands)
script.on_event(defines.events.script_raised_built, function(event)
  -- Reserved for future use
end)

-- Handle script-destroyed entities
script.on_event(defines.events.script_raised_destroy, function(event)
  -- Reserved for future use
end)
