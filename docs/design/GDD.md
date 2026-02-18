# Lego City Mod - Game Design Document (GDD)
## Final Unified Version

---

## I. Document Basic Information

| Project | Details |
|---------|---------|
| **Mod Name** | Lego City |
| **Core Positioning** | Lightweight expansion mod that integrates city simulation (population/building management) gameplay with Factorio's core automation mechanics. Uses "Lego citizens" as the core production carrier, building a positive feedback loop: "Factory Production → City Operation → Feedback to Factory". Fully compatible with Factorio 2.0+ (including Space Age DLC), does not disrupt vanilla gameplay rhythm, low performance overhead. |
| **Compatible Version** | Factorio 2.0 and above (compatible with base game and Space Age DLC, compatible with basic functional and decorative mods) |
| **Design Priority** | 1. Stability (no bugs, no lag); 2. Loop fluency (core gameplay without bottlenecks); 3. Integration with vanilla (fits tech tree, operation logic); 4. Development feasibility (simplify complex logic, prioritize MVP implementation) |
| **Target Audience** | Vanilla Factorio players who enjoy automated production lines and want to experience city simulation "population management, building planning" fun, prefer lightweight gameplay over heavy expansion. |

---

## II. Design Motivation and Background

Factorio's core fun lies in "automated production line construction and optimization", but in vanilla production, furnaces, miners, and other equipment are all "lifeless, non-interactive" cold machinery, lacking the "population management, resource cycling" fun of simulation games. Meanwhile, existing city simulation mods are mostly heavy expansions that easily disconnect from vanilla tech tree, or have issues like excessive performance overhead and complex operations.

Based on this, this mod uses "Lego citizens" as the core carrier, lightly integrating city simulation's "building planning, population management" into vanilla Factorio gameplay, solving three core pain points: 1. Vanilla production lacks "warm interaction" - using Lego citizens (transportable items) to replace the coldness of mechanical production; 2. City simulation mods have low integration with vanilla - this mod's tech and resources are fully bound to vanilla red/green/blue/purple/yellow/white science tech tree; 3. Population (items) are difficult to track limits - using "building total limit" instead, reducing development difficulty and bug risk while retaining city simulation's core "building planning" experience.

This mod's core design philosophy: lightweight, high integration, strong loop, allowing players to add a "city management" dimension without abandoning vanilla automation fun, achieving bidirectional benefits of "factory feeds city, city feeds factory", enhancing game immersion and long-term playability.

---

## III. Core Gameplay Overview

This mod's core gameplay is the bidirectional linkage between "factory production" and "city management", using Lego citizens as the core link to build a complete resource circulation loop. Players first unlock city-related buildings and functions through vanilla science packs, then obtain population quota through building planning, recruit Lego citizens, let citizens enter dedicated furnaces to participate in smelting production. Production output is partially supplied to vanilla factory lines to advance tech research, and partially exchanged for money at the market. Money is used to recruit more citizens. Meanwhile, citizens consume stamina when working and need to rest in houses to recover. Players can upgrade tech and expand buildings to increase population quota and production efficiency, ultimately achieving the positive cycle: "Tech Upgrade → City Expansion → Production Increase → Faster Tech Upgrade".

MVP version focuses on core loop, simplifies non-essential functions, only retains adult citizens and tired citizens, 4 core buildings, 3 basic techs, prioritizing gameplay fluency and stability. Future iterations can expand lifecycle, advanced tech, decoration, etc. based on this version.

---

## IV. Core System Detailed Design

### 4.1 Population and Lego Citizen System (Core Carrier)

Lego citizens are this mod's core carrier, existing as "transportable items" that can be transported via belts and vanilla logistics systems, serving as "catalysts" for smelting production (not consuming the entity, only consuming stamina). Their quantity is limited by building total corresponding population quota, no need to track individual citizen items, simplifying technical implementation.

#### 4.1.1 Citizen Forms and Attributes (MVP Version)

| Form Name | Item ID | Core Attributes | Form Description | Interaction Logic |
|-----------|---------|-----------------|------------------|-------------------|
| Adult Citizen | `lego-citizen` | Max stamina 10, normal work speed, can participate in production | Lego-style citizen icon, stackable (max 50), can move on belts | 1. Can be recruited by City Hall (consumes money); 2. Can enter Lego Furnace to participate in smelting work; 3. Loses 1 stamina per work completion, transforms to tired citizen when stamina reaches 0; 4. No extra space, limited by population quota |
| Tired Citizen | `lego-citizen-tired` | Stamina 0, cannot participate in production | Tired Lego citizen icon (distinguished from adult citizen), stackable (max 50), can move on belts | 1. Cannot enter Lego Furnace to work; 2. Sent to regular house to complete rest recipe, recovers to full stamina adult citizen; 3. Also occupies population quota, switches form after recovery |

#### 4.1.2 Stamina Rules (No on_tick, Event-Triggered)

Stamina is the core prerequisite for citizens to participate in production. No high-frequency tick loops throughout, only triggered by "production completion" events, reducing performance overhead. Specific rules:

1. **Stamina Reduction**: Only when Lego Furnace completes 1 smelting recipe, reduce 1 stamina from participating adult citizen; if stamina is 1, directly transform to tired citizen after reduction.

2. **Stamina Recovery**: Tired citizen sent to regular house, after completing rest recipe (takes 1 second), automatically recovers to full stamina (10 points) adult citizen, form switches simultaneously.

3. **Special Note**: Tired citizens cannot participate in any production work. If mistakenly sent to Lego Furnace, the furnace cannot start production, need to route them to houses via belts.

#### 4.1.3 Population Quota Rules (Core Fix: Building Total Limit)

To solve the problem of "population (items) being difficult to track limits", this mod uses "building total × fixed coefficient" to calculate population quota, no need to track individual citizen items in real-time, only check when recruiting citizens, simplifying code and reducing bug risk. Specific rules:

1. **Quota Calculation Formula**: Total Population Quota = City Hall count × 5 + Regular House count × 3

2. **Quota Limitation**: Total quantity of all adult citizens + tired citizens on current map cannot exceed total population quota; if exceeds quota, City Hall cannot recruit new citizens

3. **Dynamic Quota Adjustment**: When adding/deleting City Hall or regular houses, total quota adjusts in real-time; when deleting buildings causes quota reduction, existing citizens won't disappear, but cannot recruit new citizens until citizens leave due to future lifecycle iterations, releasing quota

4. **Quota Check Timing**: Only when City Hall completes "recruit citizen" recipe, count current total citizen quantity and total quota, compare and judge, not real-time counting, reducing performance overhead

### 4.2 City Building System (MVP Version)

Buildings are the core of city management and the main source of population quota. MVP version only retains 4 core buildings, all require vanilla science packs to unlock, no redundant buildings. All buildings fit vanilla operation logic (placement, power supply, recipe production). Specific design:

| Building Name | Item ID | Unlock Tech | Building Type | Quantity Limit (MVP) | Core Function | Population Quota Coefficient | Basic Attributes |
|---------------|---------|-------------|---------------|---------------------|---------------|----------------------------|------------------|
| City Hall | `city-hall` | City Settlement (Red ×30) | Recruitment Building | Initial 1, max 3 after tech upgrade | 1. Consume money to recruit adult citizens (1 citizen = 10 money); 2. Check population quota when recruiting, cannot recruit if exceeds quota; 3. Requires power to operate | 1 = 5 quota | HP 300, mining time 0.2s, power 100kW, electric power type, no production speed bonus |
| Regular House | `house` | City Settlement (Red ×30) | Recovery Building | Initial limit 2, max 8 after tech upgrade | 1. Receive tired citizens, complete rest recipe (takes 1 second), recover them to full stamina adult citizens; 2. Increase population quota; 3. Requires power to operate | 1 = 3 quota | HP 200, mining time 0.2s, power 20kW, electric power type, rest recipe has no extra consumption |
| Lego Furnace | `lego-furnace` | Town Services (Red ×50 + Green ×50) | Furnace Building | No limit | 1. Universal smelting furnace, compatible with all vanilla furnace recipes (iron plate, copper plate, steel, etc.); 2. Requires 1 adult citizen as catalyst (not consumed, only stamina reduced); 3. After production, outputs smelting product and corresponding state citizen (adult/tired); 4. Requires power to operate | No quota | HP 300, mining time 0.2s, power 100kW, electric power type, smelting speed same as vanilla electric furnace, 1 input slot, 2 output slots (product + citizen) |
| Market | `market` | Town Services (Red ×50 + Green ×50) | Trading Building | No limit | 1. Receive vanilla smelting products (MVP only supports iron plate, copper plate), exchange for money; 2. Product exchange ratio fixed (can be improved through future tech); 3. Requires power to operate | No quota | HP 300, mining time 0.2s, power 50kW, electric power type, exchange speed 1 second/time, no extra consumption |

### 4.3 Tech System (MVP Version, Bound to Vanilla Tech Tree)

Tech system is the core connecting vanilla gameplay and mod gameplay. All city-related techs require vanilla science packs to unlock. Tech unlocks can increase building quantity limits, population quota, production efficiency, achieving "tech → city → production" positive cycle. MVP version only retains 3 basic techs, future iterations can expand advanced techs. Specific design:

| Tech Name | Tech ID | Vanilla Science Pack Requirements | Unlock Buildings/Functions | Building Quantity Limit Adjustment | Population Quota Limit (Reference) | Core Benefits | Corresponding Vanilla Game Stage |
|-----------|---------|-----------------------------------|----------------------------|-------------------------------------|-------------------------------------|--------------|----------------------------------|
| City Settlement | `lego-city-settlement` | Red ×30 | City Hall, Regular House | City Hall: 1; Regular House: 2 | 1×5 + 2×3 = 11 | Opens city basic functions, can recruit citizens, recover citizen stamina, unlocks basic population quota | Red science (Automation) stage, early foundation |
| Town Services | `lego-city-service` | Red ×50 + Green ×50 | Lego Furnace, Market | City Hall: 1; Regular House: 5 | 1×5 + 5×3 = 20 | Opens core loop (citizen production → product exchange for money), can obtain money through market to recruit more citizens | Green science (Logistics) stage, core gameplay opens |
| City Management | `lego-city-management` | Red ×80 + Green ×80 + Blue ×80 | No new buildings, optimize existing functions | City Hall: 2; Regular House: 8 | 2×5 + 8×3 = 34 | Adult citizen work speed +10%, increase population quota, accelerate resource circulation efficiency, pave way for future advanced tech | Blue science (Chemical) stage, mid-game optimization |

### 4.4 Economic System (MVP Version)

Economic system is the core of city operation, using "Money" as the only currency (item form), achieving "product → money → citizen → product" loop circulation. MVP version simplifies economic logic, only retains core acquisition and consumption methods, no extra rewards. Specific design:

#### 4.4.1 Currency Setting

| Currency Name | Item ID | Form | Stack Limit | Acquisition Method | Consumption Method | Icon Reference |
|---------------|---------|------|-------------|---------------------|-------------------|----------------|
| Money | `money` | Stackable item, can be transported via belts, logistics systems | 500 | Market exchange: 1 iron plate = 1 money, 1 copper plate = 2 money (MVP only supports these two products) | City Hall recruit citizen: 1 adult citizen = 10 money | Vanilla coin icon (`__base__/graphics/icons/coin.png`) |

#### 4.4.2 Economic Circulation Rules

1. **Money Acquisition**: Player sends iron plate, copper plate produced by Lego Furnace to market via belts, market completes exchange recipe, outputs corresponding quantity of money

2. **Money Consumption**: Player sends money to City Hall, City Hall completes recruitment recipe, outputs adult citizen (must satisfy population quota limit)

3. **Circulation Loop**: Money → Recruit citizen → Citizen produces product → Product exchanges for money, no need for extra vanilla resource input (except smelting required ores), achieving self-circulation

4. **Special Note**: MVP version does not add other money acquisition/consumption methods (like pension, building upgrades), future iterations can expand

### 4.5 Recipe System (MVP Version)

All recipes fit vanilla logic, must be completed in corresponding buildings, consume corresponding resources, fixed time consumption, no complex recipes. Core divided into "recruitment recipe, production recipe, recovery recipe, exchange recipe" four categories. Specific design:

| Recipe Name | Recipe ID | Corresponding Building | Recipe Type | Consumed Resources | Output Resources | Time Consumption | Notes |
|-------------|-----------|----------------------|-------------|-------------------|-----------------|------------------|-------|
| Recruit Lego Citizen | `recruit-lego` | City Hall | Recruitment Recipe | Money ×10 | Adult Citizen ×1 | 2 seconds | Limited by population quota, no output if exceeds quota |
| Lego Smelting (Universal) | `lego-smelt-generic` | Lego Furnace | Production Recipe | Corresponding ore ×1 + Adult Citizen ×1 | Corresponding smelting product ×1 + Adult Citizen/Tired Citizen ×1 | 0.5 seconds | Compatible with all vanilla furnace recipes, product same as vanilla, citizen state depends on stamina |
| Citizen Rest Recovery | `rest-lego` | Regular House | Recovery Recipe | Tired Citizen ×1 | Adult Citizen ×1 (full stamina) | 1 second | No extra consumption, only recovers citizen stamina and form |
| Iron Plate Exchange for Money | `sell-iron-plate` | Market | Exchange Recipe | Iron Plate ×1 | Money ×1 | 0.5 seconds | MVP version core exchange method |
| Copper Plate Exchange for Money | `sell-copper-plate` | Market | Exchange Recipe | Copper Plate ×1 | Money ×2 | 0.5 seconds | Copper plate exchange profit higher than iron plate, encourages more copper production |

---

## V. Core Gameplay Loop (Text Description, No Diagrams)

This mod's core gameplay loop is divided into 6 steps, fully automatable, fits vanilla operation logic, no bottlenecks. Specific flow:

1. **Early Preparation**: Player advances vanilla tech, unlocks "City Settlement" tech through Red ×30, unlocks City Hall and Regular House, builds basic power system (adapts to building power requirements)

2. **Building Planning**: Place 1 City Hall and 2 Regular Houses, calculate initial population quota according to quota formula (1×5 + 2×3 = 11), determine maximum number of citizens that can be recruited

3. **Recruit Citizens**: Player produces iron plates through vanilla production line, sends iron plates to market to exchange for money, then sends money to City Hall, completes recruitment recipe, recruits adult citizens (not exceeding 11)

4. **Production Operation**: Send adult citizens and ores (iron ore/copper ore) together to Lego Furnace, complete smelting recipe, output iron plate/copper plate and corresponding state citizen (stamina reduced, full stamina → adult, stamina 0 → tired)

5. **Stamina Recovery**: Route tired citizens to Regular House via belts, complete rest recipe, recover to full stamina adult citizens, send back to Lego Furnace to participate in production, achieving citizen recycling

6. **Upgrade Iteration**: Produced iron plates/copper plates are partially supplied to vanilla factory, advancing green science, blue science tech research, unlocking "Town Services" and "City Management" techs, increasing building quantity limits and population quota, recruiting more citizens, increasing production efficiency, forming "tech upgrade → city expansion → production increase → faster tech upgrade" positive cycle

**Loop Core Highlights**: No need for manual intervention in citizen state switching and resource transportation, can achieve full automation through vanilla belts, splitters, inserters, both retaining vanilla automation fun and adding city management fun.

---

## VI. Technical Implementation Constraints (MVP Version)

To ensure mod stability, low performance overhead, and development feasibility, MVP version's technical implementation follows these constraints, simplifying complex logic, avoiding bugs. Specific:

1. **Performance Optimization**: No high-frequency on_tick loops throughout, all core logic (stamina reduction, population quota check, citizen form switching) triggered by "recipe completion events" and "building interaction events", maximum 1 trigger per 0.5 seconds, adapts to low-end devices

2. **Population Tracking Simplification**: Only when City Hall completes recruitment recipe, use `game.surfaces[1].find_entities_filtered()` to count current total citizen quantity, compare with population quota, not real-time counting, reducing performance overhead

3. **Data Storage**: Only store citizen stamina data (global variable `global.stamina`, key is citizen unique ID, value is current stamina), no other redundant data, avoiding data too large causing lag

4. **Compatibility Constraints**: Do not modify any vanilla core data (items, buildings, recipes, techs), only add custom items, buildings, techs, and recipes, compatible with vanilla 2.0+ version and basic functional mods (like infinite ore, decorative mods), avoiding conflicts

5. **Code Specification**: Only retain 3 core files (`info.json`, `data.lua`, `control.lua`), total code not exceeding 800 lines, clear logic, complete comments, convenient for future iteration modifications

6. **Bug Prevention**: Focus testing on 3 core links - population quota check (recruitment limit), citizen stamina reduction and recovery, Lego Furnace recipe compatibility, avoiding "quota failure, citizen stamina abnormal, production no output" and other bugs

---

## VII. MVP Acceptance Criteria (Feasible, Testable)

MVP version must meet the following 6 acceptance criteria, ensuring playable, stable, loop fluent, no obvious bugs. Specific:

1. **Runnable**: Mod can be normally recognized by game, no errors after enabling, no lag, no residual data after exiting game, can normally load after restarting game

2. **Loop Fluency**: Recruit citizen → Citizen produces → Product exchanges for money → Expand buildings → Recruit more citizens, fully automatable, no bottlenecks, each step can normally trigger corresponding effects

3. **Quota Effectiveness**: Building total determines population quota, cannot recruit citizens if exceeds quota, quota adjusts in real-time after adding/deleting buildings, existing citizens won't disappear due to quota reduction

4. **Core Functions Normal**:
   - Lego Furnace compatible with all vanilla furnace recipes, can normally output products and corresponding state citizens after production
   - Citizen stamina only reduces after work, tired citizens can normally recover after entering house
   - Market can normally exchange money, City Hall can normally recruit citizens (limited by quota)
   - All buildings require power to operate, cannot trigger recipe production after power loss

5. **Compatibility**: Compatible with vanilla 2.0+ version, no conflicts with basic functional mods (like infinite ore, Dectorio decorative mod)

6. **Performance Stability**: No obvious lag during operation, game frame rate difference not large compared to when mod not enabled, no memory leak issues

---

## VIII. Future Expansion Plans (Post-MVP)

After MVP version is stable and playable, future iterations can expand the following content:

- **Lifecycle System**: Citizens have age, can reproduce, die naturally, adding population management depth
- **Advanced Techs**: Unlock more building types, improve exchange rates, unlock new production recipes
- **Decoration System**: Add decorative buildings, improve city aesthetics
- **Advanced Buildings**: Schools, hospitals, entertainment facilities, etc., providing various bonuses
- **Resource Expansion**: Support more product types for market exchange, expand economic system

---

**Document Version**: 1.0  
**Last Updated**: 2024  
**Status**: MVP Development Phase
