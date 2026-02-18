# Lego City Mod - Technical Design Documentation

## Overview

This document provides technical implementation details for the Lego City Mod MVP version. It covers data structures, event handling, performance considerations, and code organization.

## Table of Contents

1. [Architecture](#architecture)
2. [File Structure](#file-structure)
3. [Data Definitions](#data-definitions)
4. [Control Logic](#control-logic)
5. [Performance Considerations](#performance-considerations)
6. [Event System](#event-system)
7. [Population Quota System](#population-quota-system)
8. [Stamina System](#stamina-system)

---

## Architecture

The mod follows Factorio's standard mod structure with three core files:

- **info.json**: Mod metadata and dependencies
- **data.lua**: Static data definitions (items, buildings, recipes, technologies)
- **control.lua**: Runtime logic and event handlers

### Design Principles

1. **No High-Frequency Loops**: All logic triggered by events, no `on_tick` handlers
2. **Minimal Data Storage**: Only store essential stamina data in global table
3. **Event-Driven**: Use Factorio's event system for all dynamic behavior
4. **Vanilla Compatibility**: No modifications to base game data

---

## File Structure

```
lego-city/
├── info.json          # Mod metadata
├── data.lua           # Static data definitions
├── control.lua        # Runtime logic
├── README.md          # User documentation
├── GDD.md             # Game Design Document
└── DESIGN.md          # This file
```

---

## Data Definitions

### Items

#### Adult Citizen (`lego-citizen`)
- **Type**: Item
- **Stack Size**: 50
- **Icon**: Custom Lego-style citizen icon
- **Flags**: `["goes-to-quickbar"]`
- **Subgroup**: `intermediate-product`

#### Tired Citizen (`lego-citizen-tired`)
- **Type**: Item
- **Stack Size**: 50
- **Icon**: Tired variant of citizen icon
- **Flags**: `["goes-to-quickbar"]`
- **Subgroup**: `intermediate-product`

#### Money (`money`)
- **Type**: Item
- **Stack Size**: 500
- **Icon**: Vanilla coin icon (`__base__/graphics/icons/coin.png`)
- **Flags**: `["goes-to-quickbar"]`
- **Subgroup**: `intermediate-product`

### Buildings

#### City Hall (`city-hall`)
- **Type**: Assembling Machine
- **Category**: `crafting`
- **Energy Usage**: 100kW
- **Crafting Speed**: 1.0
- **Module Slots**: 0 (MVP)
- **Input Slots**: 1
- **Output Slots**: 1
- **Recipe**: `recruit-lego` (Money ×10 → Adult Citizen ×1, 2 seconds)

#### Regular House (`house`)
- **Type**: Assembling Machine
- **Category**: `crafting`
- **Energy Usage**: 20kW
- **Crafting Speed**: 1.0
- **Module Slots**: 0 (MVP)
- **Input Slots**: 1
- **Output Slots**: 1
- **Recipe**: `rest-lego` (Tired Citizen ×1 → Adult Citizen ×1, 1 second)

#### Lego Furnace (`lego-furnace`)
- **Type**: Furnace
- **Category**: `smelting`
- **Energy Usage**: 100kW
- **Crafting Speed**: 1.0 (same as electric furnace)
- **Module Slots**: 0 (MVP)
- **Input Slots**: 2 (ore + citizen)
- **Output Slots**: 2 (product + citizen)
- **Recipes**: All vanilla smelting recipes (dynamically generated)

#### Market (`market`)
- **Type**: Assembling Machine
- **Category**: `crafting`
- **Energy Usage**: 50kW
- **Crafting Speed**: 1.0
- **Module Slots**: 0 (MVP)
- **Input Slots**: 1
- **Output Slots**: 1
- **Recipes**: 
  - `sell-iron-plate` (Iron Plate ×1 → Money ×1, 0.5 seconds)
  - `sell-copper-plate` (Copper Plate ×1 → Money ×2, 0.5 seconds)

### Technologies

#### City Settlement (`lego-city-settlement`)
- **Prerequisites**: None
- **Science Packs**: `[{"automation-science-pack", 30}]`
- **Effects**: 
  - Unlocks City Hall (limit: 1)
  - Unlocks Regular House (limit: 2)

#### Town Services (`lego-city-service`)
- **Prerequisites**: `lego-city-settlement`
- **Science Packs**: 
  - `[{"automation-science-pack", 50}, {"logistic-science-pack", 50}]`
- **Effects**: 
  - Unlocks Lego Furnace
  - Unlocks Market
  - Increases City Hall limit to 1
  - Increases Regular House limit to 5

#### City Management (`lego-city-management`)
- **Prerequisites**: `lego-city-service`
- **Science Packs**: 
  - `[{"automation-science-pack", 80}, {"logistic-science-pack", 80}, {"chemical-science-pack", 80}]`
- **Effects**: 
  - Increases City Hall limit to 2
  - Increases Regular House limit to 8
  - Adult citizen work speed +10% (applied to furnace recipes)

---

## Control Logic

### Global Data Structure

```lua
global = {
    stamina = {},  -- Key: citizen entity unit_number, Value: current stamina (0-10)
    building_limits = {
        ["city-hall"] = 1,
        ["house"] = 2
    }
}
```

### Event Handlers

#### `on_init` / `on_load`
- Initialize global data structures
- Set default building limits

#### `on_recipe_finished`
- **Lego Furnace**: 
  - Check if recipe used adult citizen
  - Reduce stamina by 1
  - If stamina reaches 0, output tired citizen instead of adult citizen
- **City Hall**: 
  - Check population quota before allowing recruitment
  - If quota exceeded, cancel recipe completion
- **Regular House**: 
  - Reset stamina to 10 for recovered citizen
  - Update global stamina table

#### `on_built_entity` / `on_entity_died`
- Track building counts for quota calculation
- Update building limits based on researched technologies

#### `on_research_finished`
- Update building limits based on technology effects
- Apply work speed bonuses if applicable

---

## Performance Considerations

### Optimization Strategies

1. **No Tick Loops**: All logic event-driven, no `on_tick` handlers
2. **Lazy Quota Calculation**: Only calculate when needed (recruitment time)
3. **Minimal Data Storage**: Only store stamina for active citizens
4. **Efficient Entity Filtering**: Use `find_entities_filtered` with specific filters

### Quota Calculation Performance

```lua
function calculate_population_quota()
    local city_halls = count_buildings("city-hall")
    local houses = count_buildings("house")
    return city_halls * 5 + houses * 3
end

function count_citizens()
    -- Only called during recruitment check
    local surface = game.surfaces[1]
    local adult = surface.find_entities_filtered{
        name = "item-on-ground",
        -- Filter for lego-citizen items
    }
    local tired = surface.find_entities_filtered{
        name = "item-on-ground",
        -- Filter for lego-citizen-tired items
    }
    return count_items(adult) + count_items(tired)
end
```

**Performance Impact**: 
- Quota calculation: O(n) where n = number of buildings (typically < 20)
- Citizen counting: O(m) where m = number of citizen items (typically < 100)
- Called only during recruitment: ~1-2 times per minute in normal gameplay

---

## Event System

### Recipe Completion Flow

```
on_recipe_finished triggered
    ↓
Check building type
    ↓
┌─────────────────┬─────────────────┬─────────────────┐
│  Lego Furnace   │   City Hall     │ Regular House   │
│                 │                 │                 │
│ 1. Get citizen  │ 1. Check quota  │ 1. Get tired    │
│ 2. Get stamina  │ 2. Count        │    citizen      │
│ 3. Reduce by 1  │    citizens     │ 2. Reset        │
│ 4. If 0, output │ 3. If OK,       │    stamina to 10│
│    tired citizen │    complete     │ 3. Output adult │
│ 5. Update       │ 4. If fail,     │    citizen      │
│    global.stamina│    cancel       │ 4. Update       │
│                 │                 │    global.stamina│
└─────────────────┴─────────────────┴─────────────────┘
```

### Building Limit Enforcement

Building limits are enforced through technology effects:

```lua
-- In data.lua technology effects
{
    type = "building-limit",
    building = "city-hall",
    limit = 1  -- Updated by tech research
}
```

Factorio's built-in building limit system handles enforcement automatically.

---

## Population Quota System

### Quota Formula

```
Total Quota = (City Hall Count × 5) + (Regular House Count × 3)
```

### Quota Check Implementation

```lua
function can_recruit_citizen()
    local quota = calculate_population_quota()
    local current = count_citizens()
    return current < quota
end

-- Called in on_recipe_finished for City Hall
if event.recipe.name == "recruit-lego" then
    if not can_recruit_citizen() then
        -- Cancel recipe, refund money
        cancel_recipe(event.entity)
        return
    end
end
```

### Quota Updates

- **Building Built**: Quota increases immediately
- **Building Removed**: Quota decreases, but existing citizens remain
- **Tech Research**: Building limits change, quota recalculated on next recruitment

---

## Stamina System

### Stamina Storage

```lua
-- Key: entity.unit_number (unique per citizen item)
-- Value: stamina (0-10)
global.stamina[unit_number] = 10  -- Initial value
```

### Stamina Reduction

```lua
function reduce_stamina(citizen_entity)
    local unit_number = citizen_entity.unit_number
    local current = global.stamina[unit_number] or 10
    
    if current > 0 then
        global.stamina[unit_number] = current - 1
        return current - 1
    end
    return 0
end
```

### Stamina Recovery

```lua
function recover_stamina(citizen_entity)
    local unit_number = citizen_entity.unit_number
    global.stamina[unit_number] = 10
end
```

### Citizen State Management

- **Adult Citizen**: `global.stamina[unit_number] > 0`
- **Tired Citizen**: `global.stamina[unit_number] == 0` or not in table

State is determined by item name:
- `lego-citizen` = adult (can work)
- `lego-citizen-tired` = tired (cannot work)

---

## Recipe Generation

### Dynamic Smelting Recipes

All vanilla smelting recipes are duplicated for Lego Furnace:

```lua
-- In data.lua
for _, recipe in pairs(data.raw.recipe) do
    if recipe.category == "smelting" then
        local lego_recipe = table.deepcopy(recipe)
        lego_recipe.name = "lego-" .. recipe.name
        lego_recipe.category = "smelting"
        lego_recipe.ingredients = {
            {recipe.ingredients[1][1], recipe.ingredients[1][2]},
            {"lego-citizen", 1}
        }
        lego_recipe.results = {
            {recipe.results[1][1], recipe.results[1][2]},
            {"lego-citizen", 1}  -- Will be modified in control.lua based on stamina
        }
        data:extend({lego_recipe})
    end
end
```

### Recipe Result Modification

In `control.lua`, recipe results are modified based on stamina:

```lua
function modify_recipe_result(recipe, citizen_stamina)
    if citizen_stamina > 0 then
        recipe.results[2] = {"lego-citizen", 1}
    else
        recipe.results[2] = {"lego-citizen-tired", 1}
    end
end
```

---

## Testing Checklist

### Core Functionality

- [ ] Mod loads without errors
- [ ] All items appear in creative menu
- [ ] All buildings can be placed
- [ ] All technologies can be researched
- [ ] Recipes work correctly

### Population Quota

- [ ] Quota calculated correctly
- [ ] Recruitment blocked when quota exceeded
- [ ] Quota updates when buildings added/removed
- [ ] Existing citizens not removed when quota decreases

### Stamina System

- [ ] Stamina reduces after work
- [ ] Citizen becomes tired when stamina reaches 0
- [ ] Tired citizens cannot work
- [ ] Rest restores stamina to 10
- [ ] Stamina persists across saves

### Economic Loop

- [ ] Market exchanges products for money
- [ ] City Hall recruits citizens with money
- [ ] Full loop works: Money → Citizens → Products → Money

### Performance

- [ ] No lag with 50+ citizens
- [ ] No memory leaks after extended play
- [ ] Save/load works correctly

---

## Future Enhancements

### Post-MVP Features

1. **Lifecycle System**: Age, reproduction, death
2. **Advanced Buildings**: Schools, hospitals, entertainment
3. **More Products**: Support more market exchange items
4. **Building Upgrades**: Upgrade buildings for better efficiency
5. **Decorations**: Visual enhancements for city building

### Code Improvements

1. **Modular Structure**: Split into multiple files for better organization
2. **Configuration Options**: Settings file for customizable values
3. **Localization**: Support for multiple languages
4. **Advanced Logging**: Debug mode for troubleshooting

---

**Document Version**: 1.0  
**Last Updated**: 2024  
**Status**: MVP Development Phase
