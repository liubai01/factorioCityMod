# Frequently Asked Questions (FAQ)

Common questions and answers about the Lego City Mod.

## General Questions

### Q: What is the Lego City Mod?

**A**: The Lego City Mod is a lightweight expansion mod for Factorio 2.0+ that adds city simulation gameplay elements. It introduces Lego citizens that work in furnaces, a population management system, and an economic loop that integrates seamlessly with vanilla Factorio.

### Q: Is this mod compatible with Factorio 2.0?

**A**: Yes! This mod is specifically designed for Factorio 2.0 and above, including Space Age DLC compatibility.

### Q: Will this mod work with other mods?

**A**: Yes, the mod is designed to be compatible with the base game and most functional/decorative mods. It doesn't modify any vanilla data, only adds new content.

### Q: Is this mod performance-intensive?

**A**: No, the mod is designed with performance in mind. It uses event-driven architecture (no on_tick loops) and minimal data storage to ensure low performance overhead.

---

## Installation & Setup

### Q: How do I install the mod?

**A**: 
1. Download the mod from the Factorio Mod Portal or GitHub
2. Place it in your Factorio mods directory:
   - Windows: `%APPDATA%\Factorio\mods\`
   - Linux: `~/.factorio/mods/`
   - macOS: `~/Library/Application Support/factorio/mods/`
3. Enable it in Factorio's mod menu
4. Start a new game or load an existing save

### Q: Can I add this mod to an existing save?

**A**: Yes, you can add it to an existing save. However, you'll need to research the technologies to unlock the buildings and recipes.

### Q: Will removing the mod break my save?

**A**: If you remove the mod, any Lego City buildings, items, and recipes will be removed from your save. It's recommended to remove all mod items before uninstalling.

---

## Gameplay Questions

### Q: Why can't I recruit more citizens?

**A**: You've reached your population quota. Your quota is determined by:
- City Halls: +5 quota each
- Regular Houses: +3 quota each

Build more buildings to increase your quota, or research technologies that increase building limits.

### Q: How do I know my current population quota?

**A**: Calculate it manually: (City Halls × 5) + (Houses × 3). The mod doesn't provide a UI counter in MVP version, but this may be added in future updates.

### Q: My citizens aren't working. Why?

**A**: Check the following:
- Are you using **adult citizens** (`lego-citizen`), not tired citizens?
- Do your furnaces have power?
- Are ores being fed to the furnaces?
- Are citizens being routed correctly with inserters?

### Q: What's the difference between adult and tired citizens?

**A**: 
- **Adult citizens** (`lego-citizen`): Can work, have stamina (0-10)
- **Tired citizens** (`lego-citizen-tired`): Cannot work, stamina is 0, must rest

Tired citizens must be sent to a Regular House to recover before they can work again.

### Q: How does the stamina system work?

**A**: 
- Citizens start with 10 stamina points
- Each smelting operation reduces stamina by 1
- When stamina reaches 0, the citizen becomes tired
- Tired citizens must rest in a Regular House (1 second) to recover to full stamina

### Q: Are citizens consumed when working?

**A**: No! Citizens are never consumed. They only lose stamina. After resting, they can work again indefinitely.

### Q: Can I automate citizen routing?

**A**: Yes! Use filter inserters:
- Set one to "lego-citizen" (adult) → route to furnaces
- Set one to "lego-citizen-tired" (tired) → route to houses
- Use splitters with filters for more complex routing

---

## Buildings & Recipes

### Q: How many buildings can I build?

**A**: Building limits depend on researched technologies:
- **City Settlement**: 1 City Hall, 2 Houses
- **Town Services**: 1 City Hall, 5 Houses
- **City Management**: 2 City Halls, 8 Houses

Lego Furnaces and Markets have no limits.

### Q: Do buildings need power?

**A**: Yes, all buildings require electricity:
- City Hall: 100kW
- Regular House: 20kW
- Lego Furnace: 100kW
- Market: 50kW

### Q: Can I use modules in Lego Furnaces?

**A**: Not in MVP version. Module support may be added in future updates.

### Q: What recipes are available?

**A**: 
- All vanilla smelting recipes work in Lego Furnaces (automatically)
- Market exchange: Iron Plate → Money, Copper Plate → Money
- City Hall: Money → Citizens
- House: Tired Citizen → Adult Citizen

### Q: Why is copper plate worth more than iron plate?

**A**: Gameplay balance. Copper plates exchange for 2 money vs 1 money for iron plates, encouraging players to produce copper for the economic loop.

---

## Technical Questions

### Q: How does the mod track citizen stamina?

**A**: The mod uses a global data structure that tracks stamina by citizen entity. This is stored in the save file and persists across game sessions.

### Q: What happens if I delete a building?

**A**: Your population quota decreases, but existing citizens remain. You just won't be able to recruit new citizens until you build more buildings or your population naturally decreases (in future versions with lifecycle system).

### Q: Can I use circuit networks with this mod?

**A**: Yes! You can use circuit networks to:
- Count citizens on belts
- Control recruitment based on citizen count
- Automate routing decisions
- Monitor money production

### Q: Are there any known bugs?

**A**: The MVP version is in active development. If you encounter bugs, please report them on the mod's GitHub repository or Mod Portal page.

---

## Strategy & Tips

### Q: What's the best early game strategy?

**A**: 
1. Research City Settlement early (Red Science ×30)
2. Build 1 City Hall and 2 Houses
3. Use vanilla furnaces to produce iron plates
4. After researching Town Services, build a Market
5. Exchange plates for money, recruit 5-6 citizens
6. Gradually transition to Lego Furnaces

### Q: Should I focus on iron or copper?

**A**: Copper is more valuable (2 money vs 1 money), but you'll need both for vanilla production. Consider dedicating one production line to copper for money generation.

### Q: How many houses do I need?

**A**: It depends on your citizen count and production rate. As a rule of thumb:
- 1 house per 5-10 active citizens
- More houses = faster recovery = higher throughput
- Build houses close to furnaces to minimize transport time

### Q: What's the optimal citizen-to-furnace ratio?

**A**: Since citizens can work 10 times before resting, and rest takes 1 second:
- 1 citizen can support ~1.67 furnaces continuously (with proper routing)
- For safety, use 1 citizen per furnace, with extra citizens in reserve

### Q: How do I scale up production?

**A**: 
1. Research City Management for more buildings
2. Build more City Halls for faster recruitment
3. Build more Houses for faster recovery
4. Create dedicated production lines
5. Optimize citizen routing with filter inserters

---

## Troubleshooting

### Q: Citizens aren't moving on belts

**A**: 
- Check that you're using the correct item names
- Ensure inserters are set to the right filters
- Verify belts have power (if using electric inserters)
- Check for gaps in belt routing

### Q: Furnace not producing

**A**: 
- Ensure adult citizens are being fed (not tired citizens)
- Check power supply to furnace
- Verify ore input
- Check that recipe is unlocked

### Q: Can't recruit despite having money

**A**: 
- Check population quota (build more buildings)
- Verify City Hall has power
- Ensure recipe is unlocked (research City Settlement)
- Check that money is being inserted correctly

### Q: Citizens disappearing

**A**: 
- Check if they're stuck in an inventory
- Verify belt routing for gaps
- Check if they're being consumed by mistake (shouldn't happen)
- Look for routing errors in your automation

### Q: Mod not loading

**A**: 
- Check Factorio version (must be 2.0+)
- Verify mod is in correct directory
- Check for conflicting mods
- Review Factorio log for error messages

---

## Future Features

### Q: What features are planned for future versions?

**A**: Potential features include:
- Lifecycle system (citizen age, reproduction, death)
- Advanced technologies
- More building types (schools, hospitals, etc.)
- More market exchange options
- Building upgrades
- Decorative elements
- UI improvements (population counter, etc.)

### Q: When will new features be released?

**A**: The mod is currently in MVP (Minimum Viable Product) phase. Future updates will be released based on community feedback and development progress.

---

## Support

### Q: Where can I get help?

**A**: 
- Check this FAQ first
- Read the Player Guide (`docs/wiki/PLAYER_GUIDE.md`)
- Visit the mod's GitHub repository
- Check the Factorio Mod Portal page
- Report bugs on GitHub Issues

### Q: How can I contribute?

**A**: 
- Report bugs and issues
- Suggest new features
- Contribute code (if open source)
- Share your builds and designs
- Help improve documentation

---

**Still have questions?** Feel free to ask on the mod's discussion page or GitHub repository!
