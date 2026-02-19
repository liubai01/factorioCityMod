-- Lego City Mod - Control Logic
-- Factorio 2.0 compatible
--
-- KEY NOTES for Factorio 2.0:
--   • Persistent mod data uses `storage` (not the old `global`).
--   • on_load MUST NOT modify game state / storage.
--   • on_recipe_finished was removed; stamina loop is handled purely by
--     recipe design (furnace always outputs tired-citizen; house restores).

-- ============================================================================
-- DATA INITIALIZATION
-- ============================================================================

local DEFAULT_LIMITS = {
  ["city-hall"] = 1,
  ["house"]     = 2,
}

--- Ensure storage tables exist (safe to call multiple times).
local function ensure_storage()
  if not storage.building_limits then
    storage.building_limits = {}
    for k, v in pairs(DEFAULT_LIMITS) do
      storage.building_limits[k] = v
    end
  end
end

-- on_init: first time mod is added to a save
script.on_init(function()
  ensure_storage()
end)

-- on_configuration_changed: mod version updated or settings changed
script.on_configuration_changed(function()
  ensure_storage()
end)

-- on_load: ONLY for re-registering conditional handlers.
-- MUST NOT touch storage or any game state.

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

--- Count a specific building on a surface.
local function count_building(surface, name)
  return surface.count_entities_filtered{ name = name }
end

--- Calculate population quota = city-hall × 5 + house × 3
local function calculate_population_quota(surface)
  surface = surface or game.surfaces[1]
  if not surface then return 0 end
  return count_building(surface, "city-hall") * 5
       + count_building(surface, "house")     * 3
end

--- Check whether a building placement exceeds its tech-driven limit.
--- Returns true if the placement should be REJECTED.
local function exceeds_building_limit(entity)
  local limit = storage.building_limits[entity.name]
  if not limit then return false end  -- no limit for this building (e.g. lego-furnace)
  local current = count_building(entity.surface, entity.name)
  return current > limit  -- current already includes the just-placed entity
end

-- ============================================================================
-- BUILDING LIMIT ENFORCEMENT
-- ============================================================================

--- Shared handler: reject building if it exceeds the tech limit.
local function on_building_placed(event)
  local entity = event.entity
  if not entity or not entity.valid then return end

  -- Only enforce limits on city-hall and house
  if entity.name ~= "city-hall" and entity.name ~= "house" then return end

  if not exceeds_building_limit(entity) then return end

  -- Over limit → destroy entity and refund the item
  local item_name = entity.name
  local position  = entity.position
  local surface   = entity.surface

  entity.destroy()

  -- Refund: return to player inventory or spill on ground
  if event.player_index then
    local player = game.get_player(event.player_index)
    if player then
      player.insert{ name = item_name, count = 1 }
      player.create_local_flying_text{
        text = {"", "[Lego City] ",
                {"entity-name." .. item_name},
                " limit reached (",
                tostring(storage.building_limits[item_name]),
                ")"},
        position = position,
        color = {r = 1, g = 0.3, b = 0.3},
      }
    end
  else
    -- Robot placement → spill item for logistics to pick up
    surface.spill_item_stack(position, { name = item_name, count = 1 }, true)
  end
end

-- Player places building
script.on_event(defines.events.on_built_entity, on_building_placed)
-- Robot places building
script.on_event(defines.events.on_robot_built_entity, on_building_placed)
-- Script places building (other mods / commands)
script.on_event(defines.events.script_raised_built, on_building_placed)

-- ============================================================================
-- TECHNOLOGY RESEARCH → UPDATE BUILDING LIMITS
-- ============================================================================

script.on_event(defines.events.on_research_finished, function(event)
  local tech = event.research
  if not tech then return end

  -- Each tech level sets absolute limits (not incremental)
  if tech.name == "lego-city-settlement" then
    storage.building_limits["city-hall"] = 1
    storage.building_limits["house"]     = 2

  elseif tech.name == "lego-city-service" then
    storage.building_limits["city-hall"] = 1
    storage.building_limits["house"]     = 5

  elseif tech.name == "lego-city-management" then
    storage.building_limits["city-hall"] = 2
    storage.building_limits["house"]     = 8
  end
end)
