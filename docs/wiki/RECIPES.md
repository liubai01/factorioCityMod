# Recipes Reference

Complete reference guide for all recipes in the Lego City Mod.

## Recruitment Recipes

### Recruit Lego Citizen

**Recipe ID**: `recruit-lego`  
**Building**: City Hall  
**Category**: Crafting  
**Unlock**: City Settlement

| Input | Output | Time |
|-------|--------|------|
| 10 Money | 1 Adult Citizen | 2 seconds |

**Notes**:
- Subject to population quota limit
- Cannot recruit if quota is exceeded
- New citizens start with full stamina (10 points)

---

## Recovery Recipes

### Citizen Rest Recovery

**Recipe ID**: `rest-lego`  
**Building**: Regular House  
**Category**: Crafting  
**Unlock**: City Settlement

| Input | Output | Time |
|-------|--------|------|
| 1 Tired Citizen | 1 Adult Citizen (full stamina) | 1 second |

**Notes**:
- No additional resource consumption
- Restores stamina to maximum (10 points)
- Tired citizens cannot work until rested

---

## Smelting Recipes

### Universal Smelting

**Recipe Pattern**: `lego-{vanilla-recipe-name}`  
**Building**: Lego Furnace  
**Category**: Smelting  
**Unlock**: Town Services

All vanilla smelting recipes are automatically available with the prefix `lego-`.

**General Format**:
| Input | Output | Time |
|-------|--------|------|
| Ore/Resource + 1 Adult Citizen | Product + Citizen (adult/tired) | 0.5 seconds |

### Example Recipes

#### Iron Plate Smelting

**Recipe ID**: `lego-iron-plate`  
**Building**: Lego Furnace

| Input | Output | Time |
|-------|--------|------|
| 1 Iron Ore + 1 Adult Citizen | 1 Iron Plate + Citizen | 0.5s |

#### Copper Plate Smelting

**Recipe ID**: `lego-copper-plate`  
**Building**: Lego Furnace

| Input | Output | Time |
|-------|--------|------|
| 1 Copper Ore + 1 Adult Citizen | 1 Copper Plate + Citizen | 0.5s |

#### Steel Plate Smelting

**Recipe ID**: `lego-steel-plate`  
**Building**: Lego Furnace

| Input | Output | Time |
|-------|--------|------|
| 5 Iron Plate + 1 Adult Citizen | 1 Steel Plate + Citizen | 17.5s |

#### Stone Brick Smelting

**Recipe ID**: `lego-stone-brick`  
**Building**: Lego Furnace

| Input | Output | Time |
|-------|--------|------|
| 2 Stone + 1 Adult Citizen | 1 Stone Brick + Citizen | 0.5s |

### Citizen State After Smelting

- **If citizen stamina > 0**: Outputs adult citizen (stamina reduced by 1)
- **If citizen stamina = 0**: Outputs tired citizen (cannot work)

**Stamina Rules**:
- Citizens start with 10 stamina
- Lose 1 stamina per smelting operation
- When stamina reaches 0, become tired citizens
- Tired citizens must rest before working again

---

## Market Exchange Recipes

### Iron Plate Exchange

**Recipe ID**: `sell-iron-plate`  
**Building**: Market  
**Category**: Crafting  
**Unlock**: Town Services

| Input | Output | Time |
|-------|--------|------|
| 1 Iron Plate | 1 Money | 0.5 seconds |

**Exchange Rate**: 1:1

### Copper Plate Exchange

**Recipe ID**: `sell-copper-plate`  
**Building**: Market  
**Category**: Crafting  
**Unlock**: Town Services

| Input | Output | Time |
|-------|--------|------|
| 1 Copper Plate | 2 Money | 0.5 seconds |

**Exchange Rate**: 1:2 (more valuable than iron)

---

## Recipe Summary Table

| Recipe | Building | Input | Output | Time | Unlock |
|--------|----------|-------|--------|------|--------|
| Recruit Citizen | City Hall | 10 Money | 1 Adult Citizen | 2s | City Settlement |
| Rest Citizen | Regular House | 1 Tired Citizen | 1 Adult Citizen | 1s | City Settlement |
| Smelt Iron | Lego Furnace | 1 Iron Ore + 1 Citizen | 1 Iron Plate + Citizen | 0.5s | Town Services |
| Smelt Copper | Lego Furnace | 1 Copper Ore + 1 Citizen | 1 Copper Plate + Citizen | 0.5s | Town Services |
| Sell Iron | Market | 1 Iron Plate | 1 Money | 0.5s | Town Services |
| Sell Copper | Market | 1 Copper Plate | 2 Money | 0.5s | Town Services |

---

## Recipe Automation Tips

### Recruitment Automation

```
Market → [Money] → City Hall → [Citizens] → Production
```

### Rest Automation

```
Furnace → [Tired Citizens] → House → [Adult Citizens] → Furnace
```

### Production Loop

```
Ore → Furnace (with Citizen) → [Product + Citizen]
                                  ↓
                            Splitter
                            ↙      ↘
                    [Product]    [Citizen]
                         ↓           ↓
                      Market    Check Stamina
                         ↓           ↓
                      [Money]   [Route to House if Tired]
```

### Complete Economic Loop

```
1. Ore + Adult Citizen → Furnace → Product + Citizen
2. Product → Splitter → Market → Money
3. Money → City Hall → New Citizen
4. Tired Citizen → House → Adult Citizen
5. Repeat from step 1
```

---

## Recipe Efficiency

### Money Generation Rates

**Iron Plate Route**:
- 1 Iron Ore → 1 Iron Plate → 1 Money
- Time: 0.5s (smelt) + 0.5s (sell) = 1s per money
- **Rate**: 60 money/minute per furnace

**Copper Plate Route**:
- 1 Copper Ore → 1 Copper Plate → 2 Money
- Time: 0.5s (smelt) + 0.5s (sell) = 1s per 2 money
- **Rate**: 120 money/minute per furnace

**Conclusion**: Copper plates are twice as efficient for money generation.

### Citizen Recruitment Cost

- **Cost**: 10 Money per citizen
- **Time**: 2 seconds per citizen
- **Rate**: 30 citizens/minute per City Hall (if money supply is sufficient)

### Citizen Work Capacity

- **Stamina**: 10 points per citizen
- **Work Rate**: 1 operation per 0.5 seconds (when stamina > 0)
- **Total Work**: 10 operations before rest needed
- **Rest Time**: 1 second
- **Cycle Time**: 5 seconds (work) + 1 second (rest) = 6 seconds
- **Effective Rate**: ~10 operations per 6 seconds = 100 operations/minute per citizen

---

## Future Recipe Ideas (Post-MVP)

Potential recipes that may be added:
- More market exchange options (steel, stone, etc.)
- Advanced citizen training recipes
- Building upgrade recipes
- Specialized production recipes
- Citizen reproduction (lifecycle system)
