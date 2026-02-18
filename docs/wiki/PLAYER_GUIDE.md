# Lego City Mod - Player Guide

Welcome to the Lego City Mod! This guide will help you understand how to build and manage your city while maintaining your factory production.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Core Concepts](#core-concepts)
3. [Buildings](#buildings)
4. [Recipes](#recipes)
5. [Technologies](#technologies)
6. [Gameplay Loop](#gameplay-loop)
7. [Tips & Strategies](#tips--strategies)
8. [FAQ](#faq)

---

## Getting Started

### Installation

1. Download the mod from the Factorio Mod Portal or clone this repository
2. Place the mod folder in your Factorio mods directory:
   - **Windows**: `%APPDATA%\Factorio\mods\`
   - **Linux**: `~/.factorio/mods/`
   - **macOS**: `~/Library/Application Support/factorio/mods/`
3. Enable the mod in Factorio's mod menu
4. Start a new game or load an existing save

### Requirements

- Factorio 2.0 or higher (compatible with Space Age DLC)
- Compatible with base game and basic functional/decorative mods

---

## Core Concepts

### Lego Citizens

Lego citizens are the heart of this mod. They work in furnaces to produce materials, but they need rest to maintain their stamina.

- **Adult Citizens** (`lego-citizen`): Can work in furnaces, have 10 stamina points
- **Tired Citizens** (`lego-citizen-tired`): Cannot work, need to rest in houses to recover

### Population Quota

Your city's population is limited by the buildings you construct:
- **City Hall**: Provides 5 population quota each
- **Regular House**: Provides 3 population quota each

**Formula**: Total Quota = (City Halls × 5) + (Houses × 3)

You cannot recruit more citizens than your quota allows.

### Stamina System

- Citizens lose 1 stamina point each time they complete a smelting job
- When stamina reaches 0, they become tired citizens
- Tired citizens must rest in a Regular House to recover
- Resting takes 1 second and restores full stamina (10 points)

### Money System

Money is the currency used to recruit new citizens:
- Earn money by selling products at the Market
- Spend money at City Hall to recruit citizens
- 1 Iron Plate = 1 Money
- 1 Copper Plate = 2 Money

---

## Buildings

### City Hall

**Unlock**: City Settlement (Red Science ×30)

**Function**: Recruits new adult citizens

**Recipe**: 10 Money → 1 Adult Citizen (2 seconds)

**Population Quota**: +5 per building

**Power**: 100kW

**Limits**:
- Initial: 1 building
- After Town Services: 1 building
- After City Management: 2 buildings

**Tips**:
- Place near your money production for easy automation
- Connect to your power grid early
- Use inserters to automate money input and citizen output

### Regular House

**Unlock**: City Settlement (Red Science ×30)

**Function**: Restores tired citizens to full stamina

**Recipe**: 1 Tired Citizen → 1 Adult Citizen (1 second)

**Population Quota**: +3 per building

**Power**: 20kW

**Limits**:
- Initial: 2 buildings
- After Town Services: 5 buildings
- After City Management: 8 buildings

**Tips**:
- Place between your furnaces and City Hall for efficient citizen routing
- You'll need more houses as your citizen count grows
- Use splitters and filter inserters to route tired citizens automatically

### Lego Furnace

**Unlock**: Town Services (Red Science ×50 + Green Science ×50)

**Function**: Universal smelting furnace that uses citizens as catalysts

**Power**: 100kW

**How it works**:
- Accepts any vanilla smelting recipe (iron ore, copper ore, steel, etc.)
- Requires 1 adult citizen per smelting operation
- Outputs the smelted product + the citizen (adult or tired, depending on stamina)
- Smelting speed: Same as electric furnace

**Tips**:
- Works with all vanilla furnace recipes automatically
- Citizens are not consumed, only their stamina is reduced
- Use filter inserters to separate products from citizens
- Route tired citizens to houses, send adult citizens back to furnaces

### Market

**Unlock**: Town Services (Red Science ×50 + Green Science ×50)

**Function**: Exchanges products for money

**Recipes**:
- 1 Iron Plate → 1 Money (0.5 seconds)
- 1 Copper Plate → 2 Money (0.5 seconds)

**Power**: 50kW

**Tips**:
- Place near your production lines for easy automation
- Copper plates are more valuable than iron plates
- Use splitters to divert some plates to the market while keeping production going

---

## Recipes

### Recruitment Recipe

**Building**: City Hall  
**Input**: 10 Money  
**Output**: 1 Adult Citizen  
**Time**: 2 seconds  
**Note**: Subject to population quota limit

### Rest Recipe

**Building**: Regular House  
**Input**: 1 Tired Citizen  
**Output**: 1 Adult Citizen (full stamina)  
**Time**: 1 second

### Smelting Recipes

**Building**: Lego Furnace  
**Input**: Ore + 1 Adult Citizen  
**Output**: Smelted Product + Citizen (adult/tired based on stamina)  
**Time**: 0.5 seconds (same as electric furnace)

All vanilla smelting recipes are supported automatically.

### Market Exchange Recipes

**Building**: Market

- **Iron Plate Exchange**: 1 Iron Plate → 1 Money (0.5s)
- **Copper Plate Exchange**: 1 Copper Plate → 2 Money (0.5s)

---

## Technologies

### City Settlement

**Cost**: 30 Red Science Packs  
**Unlocks**:
- City Hall (limit: 1)
- Regular House (limit: 2)
- Recruitment recipe
- Rest recipe

**Initial Population Quota**: 11 (1×5 + 2×3)

This is your starting point. Research this early to begin building your city.

### Town Services

**Cost**: 50 Red Science Packs + 50 Green Science Packs  
**Prerequisites**: City Settlement  
**Unlocks**:
- Lego Furnace
- Market
- Market exchange recipes
- Increases House limit to 5

**Population Quota**: 20 (1×5 + 5×3)

This unlocks the core gameplay loop. You can now produce items with citizens and exchange them for money.

### City Management

**Cost**: 80 Red Science Packs + 80 Green Science Packs + 80 Blue Science Packs  
**Prerequisites**: Town Services  
**Unlocks**:
- Increases City Hall limit to 2
- Increases House limit to 8
- +10% work speed for adult citizens

**Population Quota**: 34 (2×5 + 8×3)

This is the mid-game upgrade that significantly expands your city's capacity.

---

## Gameplay Loop

### Step-by-Step Guide

1. **Research City Settlement**
   - Unlock City Hall and Regular House
   - Build 1 City Hall and 2 Regular Houses
   - You now have 11 population quota

2. **Get Your First Citizens**
   - Produce some iron plates using vanilla furnaces
   - Build a Market (after researching Town Services)
   - Exchange iron plates for money
   - Use money at City Hall to recruit citizens (up to 11)

3. **Set Up Production**
   - Research Town Services
   - Build Lego Furnaces
   - Route citizens and ores to furnaces
   - Use filter inserters to separate products from citizens

4. **Automate the Loop**
   - Route tired citizens to Houses
   - Route recovered citizens back to Furnaces
   - Route some products to Market for money
   - Use money to recruit more citizens (as quota allows)

5. **Expand and Optimize**
   - Research City Management for more buildings
   - Build more City Halls and Houses
   - Increase your population quota
   - Scale up production

### Automation Tips

- Use **filter inserters** to separate citizens from products
- Use **splitters with filters** to route tired citizens to houses
- Use **circuit networks** to control recruitment based on citizen count
- Create dedicated **citizen loops** that cycle between furnaces and houses

---

## Tips & Strategies

### Early Game

- Start with vanilla furnaces while researching City Settlement
- Build your first City Hall near your power production
- Don't recruit all citizens at once - start with 5-6 to test the system
- Keep some vanilla furnaces as backup during transition

### Mid Game

- Focus on copper plate production (more valuable at market)
- Build houses close to furnaces to minimize transport time
- Use underground belts to keep citizen routes organized
- Consider dedicating one furnace line to money production

### Late Game

- Research City Management for maximum population
- Build multiple City Halls for faster recruitment
- Create dedicated citizen rest areas with multiple houses
- Optimize citizen routing with circuit-controlled inserters

### Common Patterns

**Citizen Loop Pattern**:
```
Furnace → Filter Inserter (citizens) → Belt → House → Belt → Furnace
         ↓ (products)
      Product Belt
```

**Money Production Pattern**:
```
Furnace → Splitter → Market (money) → City Hall (recruit)
         ↓ (products)
      Factory Production
```

---

## FAQ

### Q: Why can't I recruit more citizens?

**A**: You've reached your population quota. Build more City Halls or Houses to increase your quota.

### Q: My citizens aren't working in the furnace. Why?

**A**: Make sure you're using **adult citizens** (`lego-citizen`), not tired citizens. Tired citizens cannot work and must rest first.

### Q: How do I automate citizen routing?

**A**: Use filter inserters set to "lego-citizen" and "lego-citizen-tired" to separate them. Route tired citizens to houses, adult citizens to furnaces.

### Q: Can I use this mod with other mods?

**A**: Yes! This mod is designed to be compatible with base game and most functional/decorative mods. It doesn't modify any vanilla data.

### Q: Do citizens consume resources?

**A**: No, citizens are not consumed. They only lose stamina when working. They can be reused indefinitely after resting.

### Q: What happens if I delete a building?

**A**: Your population quota decreases, but existing citizens remain. You just won't be able to recruit new citizens until you build more buildings or some citizens leave (in future versions).

### Q: Can I use modules in Lego Furnaces?

**A**: Not in MVP version. This may be added in future updates.

### Q: How do I know how many citizens I have?

**A**: Check your inventory or use circuit networks to count items on belts. The mod doesn't provide a UI counter in MVP version.

---

## Troubleshooting

### Citizens not moving on belts
- Check that you're using the correct item names
- Ensure inserters are set to the right filters
- Verify belts have power (if using electric inserters)

### Furnace not producing
- Ensure adult citizens are being fed (not tired citizens)
- Check power supply
- Verify ore input

### Can't recruit despite having money
- Check population quota (build more buildings)
- Verify City Hall has power
- Ensure recipe is unlocked (research City Settlement)

### Citizens disappearing
- Check if they're being consumed by mistake (shouldn't happen)
- Verify they're not stuck in an inventory
- Check belt routing for gaps

---

## Support

If you encounter bugs or have suggestions, please report them on the mod's GitHub repository or Factorio Mod Portal page.

**Enjoy building your Lego City!**
