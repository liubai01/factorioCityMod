# Changelog

All notable changes to the Lego City Mod will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned Features
- Lifecycle system (citizen age, reproduction, death)
- Advanced buildings (schools, hospitals, entertainment)
- More market exchange options
- Building upgrades
- Decorative elements
- UI improvements (population counter, etc.)

## [0.1.0] - 2024-XX-XX

### Added - MVP Release

#### Core Systems
- **Population System**: Lego citizens (adult and tired variants)
- **Stamina System**: Citizens lose stamina when working, recover in houses
- **Population Quota**: Building-based quota system (City Hall ×5 + House ×3)
- **Economic System**: Money currency, market exchange, recruitment system

#### Buildings
- **City Hall**: Recruits citizens (consumes money)
  - Provides +5 population quota
  - Power: 100kW
  - Building limit: 1-2 (based on tech)
  
- **Regular House**: Restores tired citizens
  - Provides +3 population quota
  - Power: 20kW
  - Building limit: 2-8 (based on tech)
  
- **Lego Furnace**: Universal smelting furnace
  - Uses citizens as catalysts
  - Compatible with all vanilla smelting recipes
  - Power: 100kW
  - No building limit
  
- **Market**: Exchanges products for money
  - Iron Plate → 1 Money
  - Copper Plate → 2 Money
  - Power: 50kW
  - No building limit

#### Technologies
- **City Settlement** (Red Science ×30)
  - Unlocks City Hall and Regular House
  - Initial building limits: 1 City Hall, 2 Houses
  - Initial population quota: 11
  
- **Town Services** (Red ×50 + Green ×50)
  - Unlocks Lego Furnace and Market
  - Increases House limit to 5
  - Population quota: 20
  
- **City Management** (Red ×80 + Green ×80 + Blue ×80)
  - Increases City Hall limit to 2
  - Increases House limit to 8
  - +10% work speed for adult citizens
  - Population quota: 34

#### Recipes
- **Recruitment**: 10 Money → 1 Adult Citizen (2s)
- **Rest**: 1 Tired Citizen → 1 Adult Citizen (1s)
- **Smelting**: All vanilla smelting recipes (with citizen requirement)
- **Market Exchange**: Iron Plate → Money, Copper Plate → Money

#### Items
- **lego-citizen**: Adult citizen (stack 50)
- **lego-citizen-tired**: Tired citizen (stack 50)
- **money**: Currency (stack 500)

#### Technical
- Event-driven architecture (no on_tick loops)
- Minimal data storage (stamina tracking only)
- Full automation support
- Compatible with Factorio 2.0+
- Compatible with Space Age DLC

#### Documentation
- Complete Game Design Document (GDD)
- Technical Design Documentation
- Player Guide
- Buildings Reference
- Recipes Reference
- FAQ

### Known Issues
- No UI counter for population quota (calculate manually)
- Module support not available in MVP
- Simplified stamina tracking (may be improved in future)

---

## Version History

### [0.1.0] - MVP Release
Initial release with core gameplay loop:
- Population management system
- Economic cycle
- 4 core buildings
- 3 technologies
- Full automation support

---

## Future Roadmap

### Version 0.2.0 (Planned)
- Lifecycle system
- Advanced buildings
- More market options

### Version 0.3.0 (Planned)
- Building upgrades
- Decorative elements
- UI improvements

### Version 1.0.0 (Planned)
- Complete feature set
- Full localization support
- Performance optimizations

---

**Note**: This changelog will be updated with each release. Check back regularly for updates!
