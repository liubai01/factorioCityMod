# Lego City Mod — Feature Implementation Status

> Auto-generated from code audit on 2026-02-19.
> Compares GDD design spec against actual `data.lua` + `control.lua`.

---

## Legend

| Symbol | Meaning |
|--------|---------|
| ✅ | Fully implemented and matches design |
| ⚠️ | Partially implemented or simplified from design |
| ❌ | Not implemented yet |
| 🔧 | Intentionally deferred (technical constraint) |

---

## 1. Items

| Feature | Status | Notes |
|---------|--------|-------|
| `lego-citizen` (Adult Citizen) item | ✅ | Stack 50, placeholder icon (construction-robot) |
| `lego-citizen-tired` (Tired Citizen) item | ✅ | Stack 50, placeholder icon (battery) |
| `money` (Currency) item | ✅ | Stack 500, uses vanilla coin icon |
| `city-hall` item (placeable) | ✅ | |
| `house` item (placeable) | ✅ | |
| `lego-furnace` item (placeable) | ✅ | |
| `lego-market` item (placeable) | ✅ | |
| Custom item group "Lego City" tab | ✅ | All mod items/recipes in dedicated tab |
| Locale (EN + ZH-CN) for all items | ✅ | |

---

## 2. Buildings

| Feature | Status | Notes |
|---------|--------|-------|
| City Hall — assembling machine | ✅ | 100kW, crafting_speed 1.0 |
| City Hall — exclusive `city-hall-crafting` category | ✅ | Only `recruit-lego` recipe |
| House — assembling machine | ✅ | 20kW, crafting_speed 1.0 |
| House — exclusive `house-crafting` category | ✅ | Only `rest-lego` recipe |
| Lego Furnace — assembling machine (was furnace) | ✅ | 100kW, `lego-smelting` category, 2 input slots |
| Lego Furnace — exclusive `lego-smelting` category | ✅ | Vanilla smelting recipes blocked |
| Market — assembling machine | ✅ | 50kW, `market-crafting` category |
| Market — exclusive `market-crafting` category | ✅ | Only `sell-*` recipes |
| All buildings use `graphics_set` (Factorio 2.0) | ✅ | Placeholder: am1, am2, am3, electric-furnace |
| Locale (EN + ZH-CN) for all entities | ✅ | |

---

## 3. Recipes

| Feature | Status | Notes |
|---------|--------|-------|
| `recruit-lego` — Money ×10 → Citizen ×1 | ✅ | 2 sec, `city-hall-crafting` |
| `rest-lego` — Tired ×1 → Citizen ×1 | ✅ | 1 sec, `house-crafting` |
| `sell-iron-plate` — Iron Plate ×1 → Money ×1 | ✅ | 0.5 sec, `market-crafting` |
| `sell-copper-plate` — Copper Plate ×1 → Money ×2 | ✅ | 0.5 sec, `market-crafting` |
| `city-hall` build recipe | ✅ | Iron ×20 + Circuit ×5 |
| `house` build recipe | ✅ | Iron ×10 |
| `lego-furnace` build recipe | ✅ | Steel ×10 + StoneBrick ×10 + AdvCircuit ×5 |
| `lego-market` build recipe | ✅ | Iron ×15 + Circuit ×5 |
| Dynamic `lego-*` smelting recipes | ✅ | Auto-generated for all vanilla smelting recipes |
| `lego-*` recipes require citizen as ingredient | ✅ | Ore + Citizen → Product + Tired-Citizen |
| `lego-*` recipes have correct icon & localised_name | ✅ | Inherits base product's icon and name |

---

## 4. Technologies

| Feature | Status | Notes |
|---------|--------|-------|
| `lego-city-settlement` — Red ×30 | ✅ | Unlocks: city-hall, house, recruit-lego, rest-lego |
| `lego-city-service` — Red ×50 + Green ×50 | ✅ | Unlocks: lego-furnace, lego-market, sell-* |
| `lego-city-management` — R×80 + G×80 + B×80 | ⚠️ | Exists, but only has `type="nothing"` placeholder effect |
| Tech locale (EN + ZH-CN) | ✅ | |

---

## 5. Stamina System

| Feature | Design Spec | Status | Notes |
|---------|------------|--------|-------|
| Citizen max stamina = 10 | GDD §4.1.2 | ❌ | **Not implemented** |
| Each smelting cycle = −1 stamina | GDD §4.1.2 | ❌ | Currently: 1 work = immediately tired |
| Stamina 0 → transform to tired citizen | GDD §4.1.2 | ⚠️ | Simplified: always output tired after 1 work |
| Tired citizen → House → full stamina citizen | GDD §4.1.2 | ⚠️ | Works, but restores from "1 work" not "10 works" |
| `storage.stamina` tracking per citizen | GDD §VI.3 | ❌ | No stamina data stored |

### Root Cause

Factorio 2.0 removed `on_recipe_finished` — the event that would have
been used to intercept furnace completion and decrement stamina. Without
this event, there is **no runtime hook** to modify recipe outputs based
on dynamic state.

### Possible Solutions

| Approach | Pros | Cons |
|----------|------|------|
| **A. Item-chain stamina** — create 10 citizen items (`citizen-10` → `citizen-9` → … → `citizen-1` → `tired`), each with its own recipe set | Pure data-driven, no runtime code, Factorio-native | 10× items, 10× recipes per smelting type = recipe explosion, cluttered UI |
| **B. `on_nth_tick` polling** — periodically scan furnace outputs and swap citizen items | Full design compliance | Polling contradicts "no on_tick" design principle; performance concern |
| **C. Accept simplified model** — 1 work = tired (current) | Zero complexity, stable, no performance cost | Citizens tire too fast; doesn't match GDD's 10-stamina design |
| **D. Reduced item-chain** — 3 levels (`citizen` → `citizen-worn` → `tired`), each works 3–4 times | Reasonable compromise between A and C | Still multiplies recipes, moderate complexity |

### Current Decision: **Option C** (simplified, MVP-acceptable)

---

## 6. Population Quota System

| Feature | Design Spec | Status | Notes |
|---------|------------|--------|-------|
| Quota formula: CityHall×5 + House×3 | GDD §4.1.3 | ✅ | `calculate_population_quota()` in control.lua |
| Quota check at recruitment time | GDD §4.1.3 | 🔧 | **Cannot implement** — no `on_recipe_finished` in 2.0 |
| Quota recalculates on building add/remove | GDD §4.1.3 | ✅ | Function exists, called on demand |
| Existing citizens persist when quota shrinks | GDD §4.1.3 | ✅ | By design: no citizen deletion |

### Root Cause

Same as stamina: `on_recipe_finished` removal means we cannot intercept
City Hall's `recruit-lego` recipe completion to check quota. The building
limit system provides an **indirect cap** on population.

---

## 7. Building Limit System

| Feature | Design Spec | Status | Notes |
|---------|------------|--------|-------|
| City Hall limit: 1 → 1 → 2 (per tech) | GDD §4.3 | ✅ | Enforced in `on_built_entity` |
| House limit: 2 → 5 → 8 (per tech) | GDD §4.3 | ✅ | Enforced in `on_built_entity` |
| Over-limit → destroy + refund item | — | ✅ | Player gets item back + flying text |
| Robot placement limit check | — | ✅ | Item spilled on ground for logistics |
| `on_research_finished` updates limits | GDD §4.3 | ✅ | |
| `on_configuration_changed` data migration | — | ✅ | |
| Lego Furnace / Market — no limit | GDD §4.2 | ✅ | Not checked |

---

## 8. City Management Tech Bonus

| Feature | Design Spec | Status | Notes |
|---------|------------|--------|-------|
| +10% citizen work speed | GDD §4.3 | ❌ | Only `type="nothing"` placeholder |

### Possible Implementation

Increase `lego-furnace` crafting_speed from 1.0 to 1.1 via `control.lua`
when `lego-city-management` is researched — using
`entity.crafting_speed = 1.1` on all existing lego-furnaces. Requires
scanning all surfaces for lego-furnace entities.

---

## 9. Runtime / control.lua

| Feature | Status | Notes |
|---------|--------|-------|
| `storage` instead of `global` (2.0) | ✅ | |
| `on_init` data initialization | ✅ | |
| `on_configuration_changed` migration | ✅ | |
| `on_load` does NOT write state | ✅ | Fixed: removed `on_load` state writes |
| No `on_tick` polling | ✅ | |
| `on_built_entity` building limit check | ✅ | |
| `on_robot_built_entity` building limit check | ✅ | |
| `on_research_finished` limit updates | ✅ | |
| Stamina tracking in control.lua | ❌ | Not possible without `on_recipe_finished` |
| Quota enforcement in control.lua | 🔧 | Deferred: no recipe-completion hook |

---

## Summary

| Category | Total | ✅ Done | ⚠️ Partial | ❌ Missing | 🔧 Deferred |
|----------|-------|---------|------------|-----------|-------------|
| Items | 9 | 9 | 0 | 0 | 0 |
| Buildings | 10 | 10 | 0 | 0 | 0 |
| Recipes | 11 | 11 | 0 | 0 | 0 |
| Technologies | 4 | 3 | 1 | 0 | 0 |
| Stamina System | 5 | 0 | 2 | 3 | 0 |
| Population Quota | 4 | 3 | 0 | 0 | 1 |
| Building Limits | 7 | 7 | 0 | 0 | 0 |
| City Mgmt Bonus | 1 | 0 | 0 | 1 | 0 |
| Runtime | 10 | 8 | 0 | 1 | 1 |
| **Total** | **61** | **51** | **3** | **5** | **2** |

### MVP Completion: **~84%**

### Top 3 Missing Features (by impact)

1. **Stamina system** — citizens tire after 1 work instead of 10
2. **Population quota enforcement** — no recruitment limit check
3. **City Management +10% work speed** — tech has no real effect
