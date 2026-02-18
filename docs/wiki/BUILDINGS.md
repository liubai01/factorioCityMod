# Buildings Reference

Complete reference guide for all buildings in the Lego City Mod.

## City Hall

**Item Name**: `city-hall`  
**Type**: Assembling Machine  
**Unlock**: City Settlement (Red Science ×30)

### Properties

| Property | Value |
|----------|-------|
| Health | 300 HP |
| Mining Time | 0.2 seconds |
| Power Consumption | 100kW |
| Power Type | Electric |
| Crafting Speed | 1.0 |
| Module Slots | 0 (MVP) |
| Input Slots | 1 |
| Output Slots | 1 |

### Function

Recruits new adult citizens by consuming money.

**Recipe**: `recruit-lego`
- Input: 10 Money
- Output: 1 Adult Citizen
- Time: 2 seconds
- **Note**: Subject to population quota limit

### Population Quota

Provides **+5 population quota** per building.

### Building Limits

- **City Settlement**: 1 building
- **Town Services**: 1 building
- **City Management**: 2 buildings

### Usage Tips

- Place near money production for easy automation
- Connect to power grid early
- Use inserters to automate:
  - Money input (from Market)
  - Citizen output (to production lines)
- Consider building multiple City Halls after researching City Management for faster recruitment

---

## Regular House

**Item Name**: `house`  
**Type**: Assembling Machine  
**Unlock**: City Settlement (Red Science ×30)

### Properties

| Property | Value |
|----------|-------|
| Health | 200 HP |
| Mining Time | 0.2 seconds |
| Power Consumption | 20kW |
| Power Type | Electric |
| Crafting Speed | 1.0 |
| Module Slots | 0 (MVP) |
| Input Slots | 1 |
| Output Slots | 1 |

### Function

Restores tired citizens to full stamina.

**Recipe**: `rest-lego`
- Input: 1 Tired Citizen
- Output: 1 Adult Citizen (full stamina: 10)
- Time: 1 second
- No additional resource consumption

### Population Quota

Provides **+3 population quota** per building.

### Building Limits

- **City Settlement**: 2 buildings
- **Town Services**: 5 buildings
- **City Management**: 8 buildings

### Usage Tips

- Place between furnaces and City Hall for efficient routing
- Build more houses as your citizen count grows
- Use filter inserters to route tired citizens automatically
- Create dedicated rest areas with multiple houses for high-throughput production

---

## Lego Furnace

**Item Name**: `lego-furnace`  
**Type**: Furnace  
**Unlock**: Town Services (Red Science ×50 + Green Science ×50)

### Properties

| Property | Value |
|----------|-------|
| Health | 300 HP |
| Mining Time | 0.2 seconds |
| Power Consumption | 100kW |
| Power Type | Electric |
| Crafting Speed | 1.0 (same as electric furnace) |
| Module Slots | 0 (MVP) |
| Input Slots | 2 (ore + citizen) |
| Output Slots | 2 (product + citizen) |

### Function

Universal smelting furnace that uses citizens as catalysts. Compatible with all vanilla smelting recipes.

### How It Works

1. Accepts ore and 1 adult citizen
2. Performs smelting (same speed as electric furnace)
3. Outputs smelted product and the citizen
4. Citizen loses 1 stamina point per operation
5. If citizen stamina reaches 0, outputs tired citizen instead of adult citizen

### Supported Recipes

All vanilla smelting recipes are automatically supported:
- Iron ore → Iron plate
- Copper ore → Copper plate
- Iron plate → Steel plate
- Stone → Stone brick
- And all other vanilla furnace recipes

### Usage Tips

- Use filter inserters to separate products from citizens
- Route tired citizens to houses, send adult citizens back to furnaces
- Works identically to electric furnace, just requires citizens
- Citizens are not consumed, only stamina is reduced
- Can be used in any production line that needs smelting

---

## Market

**Item Name**: `market`  
**Type**: Assembling Machine  
**Unlock**: Town Services (Red Science ×50 + Green Science ×50)

### Properties

| Property | Value |
|----------|-------|
| Health | 300 HP |
| Mining Time | 0.2 seconds |
| Power Consumption | 50kW |
| Power Type | Electric |
| Crafting Speed | 1.0 |
| Module Slots | 0 (MVP) |
| Input Slots | 1 |
| Output Slots | 1 |

### Function

Exchanges products for money.

### Exchange Recipes

**Iron Plate Exchange**: `sell-iron-plate`
- Input: 1 Iron Plate
- Output: 1 Money
- Time: 0.5 seconds

**Copper Plate Exchange**: `sell-copper-plate`
- Input: 1 Copper Plate
- Output: 2 Money
- Time: 0.5 seconds

### Usage Tips

- Place near production lines for easy automation
- Copper plates are twice as valuable as iron plates
- Use splitters to divert some products to market while keeping production going
- Connect to City Hall with belts for automated recruitment
- Consider dedicating one production line to money generation

---

## Building Comparison Table

| Building | Quota | Power | Health | Primary Function |
|----------|-------|-------|--------|------------------|
| City Hall | +5 | 100kW | 300 | Recruit citizens |
| Regular House | +3 | 20kW | 200 | Restore stamina |
| Lego Furnace | 0 | 100kW | 300 | Smelting production |
| Market | 0 | 50kW | 300 | Exchange for money |

---

## Power Requirements Summary

**Minimum Power Setup** (City Settlement):
- 1 City Hall: 100kW
- 2 Houses: 40kW
- **Total**: 140kW

**Full Setup** (City Management):
- 2 City Halls: 200kW
- 8 Houses: 160kW
- **Total**: 360kW (plus furnaces and markets as needed)

---

## Building Placement Strategy

### Early Game Layout

```
[Power] → [City Hall] → [House] → [House]
                ↓
           [Citizens]
```

### Mid Game Layout

```
[Market] → [City Hall] → [Furnace] → [House] → [Furnace]
   ↑           ↓            ↓           ↓           ↓
[Products]  [Money]    [Citizens]  [Rest]    [Citizens]
```

### Optimal Layout Tips

1. **Centralized Power**: Place all buildings near your power production
2. **Citizen Loops**: Create dedicated loops for citizen routing
3. **Product Separation**: Use filter inserters to keep products and citizens separate
4. **Scalability**: Leave room for expansion as you research new techs

---

## Future Building Ideas (Post-MVP)

The following buildings may be added in future versions:
- Schools (increase work efficiency)
- Hospitals (faster stamina recovery)
- Entertainment Facilities (citizen happiness)
- Advanced Markets (more exchange options)
- Citizen Training Centers (specialized citizens)
