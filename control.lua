-- Lego City Mod - Control Logic
-- MVP Version: Event handlers for stamina, quota, and recipe management

-- ============================================================================
-- GLOBAL DATA INITIALIZATION
-- ============================================================================

script.on_init(function()
  global.stamina = {}  -- Key: citizen unit_number, Value: stamina (0-10)
  global.building_limits = {
    ["city-hall"] = 1,
    ["house"] = 2
  }
end)

script.on_load(function()
  -- Ensure global tables exist
  global.stamina = global.stamina or {}
  global.building_limits = global.building_limits or {
    ["city-hall"] = 1,
    ["house"] = 2
  }
end)

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

-- Calculate population quota based on building counts
local function calculate_population_quota()
  local surface = game.surfaces[1]
  if not surface then return 0 end
  
  local city_halls = surface.count_entities_filtered{name = "city-hall"}
  local houses = surface.count_entities_filtered{name = "house"}
  
  return city_halls * 5 + houses * 3
end

-- Count total citizens (adult + tired) in the world
local function count_citizens()
  local surface = game.surfaces[1]
  if not surface then return 0 end
  
  local count = 0
  
  -- Count citizens in inventories (chests, buildings, etc.)
  for _, entity in pairs(surface.find_entities_filtered{type = {"container", "assembling-machine", "furnace", "inserter"}}) do
    if entity.get_inventory(defines.inventory.chest) then
      local inv = entity.get_inventory(defines.inventory.chest)
      if inv then
        count = count + inv.get_item_count("lego-citizen")
        count = count + inv.get_item_count("lego-citizen-tired")
      end
    end
    if entity.get_inventory(defines.inventory.assembling_machine_input) then
      local inv = entity.get_inventory(defines.inventory.assembling_machine_input)
      if inv then
        count = count + inv.get_item_count("lego-citizen")
        count = count + inv.get_item_count("lego-citizen-tired")
      end
    end
    if entity.get_inventory(defines.inventory.furnace_source) then
      local inv = entity.get_inventory(defines.inventory.furnace_source)
      if inv then
        count = count + inv.get_item_count("lego-citizen")
        count = count + inv.get_item_count("lego-citizen-tired")
      end
    end
  end
  
  -- Count citizens on belts and ground
  for _, entity in pairs(surface.find_entities_filtered{type = "item-entity"}) do
    if entity.stack.name == "lego-citizen" or entity.stack.name == "lego-citizen-tired" then
      count = count + entity.stack.count
    end
  end
  
  return count
end

-- Check if can recruit new citizen
local function can_recruit_citizen()
  local quota = calculate_population_quota()
  local current = count_citizens()
  return current < quota
end

-- Get or initialize stamina for a citizen
local function get_citizen_stamina(citizen_stack)
  if not citizen_stack or not citizen_stack.valid_for_read then
    return 10  -- Default stamina for new citizens
  end
  
  -- Use stack position as unique identifier (simplified for MVP)
  local key = citizen_stack.position.x .. "_" .. citizen_stack.position.y
  
  -- Try to find existing stamina entry
  for unit_number, stamina in pairs(global.stamina) do
    -- For MVP, we'll use a simpler approach: track by item count in stack
    -- This is a simplification - in full version would use proper entity tracking
  end
  
  -- For MVP: assume new citizens have full stamina
  -- In full version, would track by proper entity unit_number
  return global.stamina[key] or 10
end

-- Set stamina for a citizen
local function set_citizen_stamina(citizen_stack, stamina)
  if not citizen_stack or not citizen_stack.valid_for_read then
    return
  end
  
  local key = citizen_stack.position.x .. "_" .. citizen_stack.position.y
  global.stamina[key] = math.max(0, math.min(10, stamina))
end

-- ============================================================================
-- EVENT HANDLERS
-- ============================================================================

-- Handle recipe completion
script.on_event(defines.events.on_recipe_finished, function(event)
  local entity = event.entity
  if not entity or not entity.valid then return end
  
  local recipe = event.recipe
  if not recipe then return end
  
  -- Handle Lego Furnace smelting
  if entity.name == "lego-furnace" and string.find(recipe.name, "lego-") then
    local source_inv = entity.get_inventory(defines.inventory.furnace_source)
    local result_inv = entity.get_inventory(defines.inventory.furnace_result)
    
    if source_inv and result_inv then
      -- Find citizen in source inventory
      local citizen_stack = nil
      for i = 1, #source_inv do
        local stack = source_inv[i]
        if stack.valid_for_read and stack.name == "lego-citizen" then
          citizen_stack = stack
          break
        end
      end
      
      if citizen_stack then
        -- Get current stamina
        local stamina = get_citizen_stamina(citizen_stack)
        
        -- Reduce stamina by 1
        stamina = math.max(0, stamina - 1)
        set_citizen_stamina(citizen_stack, stamina)
        
        -- Modify result: output tired citizen if stamina is 0, otherwise adult citizen
        -- Note: This is simplified - in full version would properly track entity
        -- For MVP, we'll output based on stamina value
        if stamina == 0 then
          -- Find citizen in result and change to tired
          for i = 1, #result_inv do
            local stack = result_inv[i]
            if stack.valid_for_read and stack.name == "lego-citizen" then
              stack.set_stack({name = "lego-citizen-tired", count = 1})
              break
            end
          end
        end
      end
    end
  end
  
  -- Handle City Hall recruitment
  if entity.name == "city-hall" and recipe.name == "recruit-lego" then
    if not can_recruit_citizen() then
      -- Cancel recipe, refund money
      local input_inv = entity.get_inventory(defines.inventory.assembling_machine_input)
      local output_inv = entity.get_inventory(defines.inventory.assembling_machine_output)
      
      if input_inv and output_inv then
        -- Refund money
        local money_stack = output_inv.find_item_stack("money")
        if not money_stack then
          output_inv.insert({name = "money", count = 10})
        else
          money_stack.count = money_stack.count + 10
        end
        
        -- Remove citizen if created
        local citizen_stack = output_inv.find_item_stack("lego-citizen")
        if citizen_stack then
          citizen_stack.clear()
        end
      end
      
      -- Stop the recipe
      entity.active = false
      return
    else
      -- Initialize stamina for new citizen
      local output_inv = entity.get_inventory(defines.inventory.assembling_machine_output)
      if output_inv then
        local citizen_stack = output_inv.find_item_stack("lego-citizen")
        if citizen_stack then
          set_citizen_stamina(citizen_stack, 10)
        end
      end
    end
  end
  
  -- Handle Regular House rest recovery
  if entity.name == "house" and recipe.name == "rest-lego" then
    local output_inv = entity.get_inventory(defines.inventory.assembling_machine_output)
    if output_inv then
      local citizen_stack = output_inv.find_item_stack("lego-citizen")
      if citizen_stack then
        -- Restore stamina to 10
        set_citizen_stamina(citizen_stack, 10)
      end
    end
  end
end)

-- Handle building placement (update quota tracking)
script.on_event(defines.events.on_built_entity, function(event)
  local entity = event.created_entity
  if not entity or not entity.valid then return end
  
  if entity.name == "city-hall" or entity.name == "house" then
    -- Quota will be recalculated on next recruitment check
    -- No immediate action needed
  end
end)

-- Handle building removal
script.on_event(defines.events.on_entity_died, function(event)
  local entity = event.entity
  if not entity or not entity.valid then return end
  
  if entity.name == "city-hall" or entity.name == "house" then
    -- Quota will be recalculated on next recruitment check
    -- Existing citizens remain (as per design)
  end
end)

-- Handle technology research (update building limits)
script.on_event(defines.events.on_research_finished, function(event)
  local research = event.research
  if not research then return end
  
  -- Update building limits based on researched tech
  if research.name == "lego-city-settlement" then
    global.building_limits["city-hall"] = 1
    global.building_limits["house"] = 2
  elseif research.name == "lego-city-service" then
    global.building_limits["city-hall"] = 1
    global.building_limits["house"] = 5
  elseif research.name == "lego-city-management" then
    global.building_limits["city-hall"] = 2
    global.building_limits["house"] = 8
    
    -- Apply work speed bonus to adult citizens (simplified for MVP)
    -- In full version, would modify recipe crafting speed
  end
end)

-- ============================================================================
-- ADDITIONAL EVENT HANDLERS FOR ROBUSTNESS
-- ============================================================================

-- Handle script errors gracefully
script.on_event(defines.events.script_raised_built, function(event)
  -- Handle any script-created entities if needed
end)

script.on_event(defines.events.script_raised_destroy, function(event)
  -- Handle any script-destroyed entities if needed
end)
