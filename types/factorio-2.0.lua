---@meta
-- ============================================================
-- Factorio 2.0 Runtime API — EmmyLua Stubs
-- Generated from: https://lua-api.factorio.com/2.0.75/runtime-api.json
-- Version: 2.0.75  |  Updated: 2026-02-19
--
-- 【重要迁移说明 v1.x → v2.0】
--   ✗ global.xxx              → 改用 storage.xxx
--   ✗ on_recipe_finished      → 2.0 已删除，无机器制作完成事件
--   ✗ event.created_entity    → 改为 event.entity（on_built_entity）
--   ✗ defines.inventory.furnace_source/result  → 改为 crafter_input/output
--   ✗ defines.inventory.assembling_machine_*   → 改为 crafter_*
--   ✗ entity.active = false   → 改用 entity.disabled_by_script = true
-- ============================================================

-- ============================================================
-- §1  原始类型别名
-- ============================================================

---@alias uint8   integer
---@alias uint16  integer
---@alias uint32  integer
---@alias uint64  integer
---@alias int8    integer
---@alias int16   integer
---@alias int32   integer
---@alias int64   integer
---@alias float   number
---@alias double  number

---@alias EntityID       string   # 实体 prototype 名称
---@alias ItemID         string   # 物品 prototype 名称
---@alias RecipeID       string   # 配方 prototype 名称
---@alias TechnologyID   string   # 科技 prototype 名称
---@alias ForceID        string|uint32   # 势力名称或 index
---@alias PlayerIdentification string|uint32   # 玩家名称或 index
---@alias SurfaceIdentification string|uint32  # 地表名称或 index
---@alias SpaceLocationID string
---@alias QualityID string
---@alias ItemWithQualityID string | {name:string, quality:string}
---@alias EntityWithQualityID string | {name:string, quality:string}
---@alias TrivialSmokeID string
---@alias DecorativeID string
---@alias ParticleID string
---@alias TileID string
---@alias LuaEventType integer  # defines.events 值（本质 integer，与 defines.events 可互换）
---@alias Tags table<string, string|boolean|number>
---@alias LocalisedString string|{string, ...}
---@alias LuaEventFilter table   # 事件过滤器（见各事件文档）

-- ============================================================
-- §2  常用结构体
-- ============================================================

---@class MapPosition
---@field x double
---@field y double

---@class TilePosition
---@field x integer
---@field y integer

---@class ChunkPosition
---@field x integer
---@field y integer

---@class Vector
---@field x double
---@field y double

---@class BoundingBox
---@field left_top  MapPosition
---@field right_bottom MapPosition

---@class ItemStackIdentification
---@field name  string
---@field count uint32

---@class ItemWithQualityCount
---@field name    string
---@field count   uint32
---@field quality string

---@class ItemWithQualityCounts table<string, uint32>

---@class SignalID
---@field name    string
---@field type    string  # "item"|"fluid"|"virtual"

---@class Fluid
---@field name        string
---@field amount      double
---@field temperature double|nil

---@class Tile
---@field name     string
---@field position TilePosition

---@class OldTileAndPosition
---@field old_tile LuaTilePrototype
---@field position TilePosition

---@class EntitySearchFilters
---@field area         BoundingBox|nil
---@field position     MapPosition|nil
---@field radius       double|nil
---@field name         string|string[]|nil
---@field type         string|string[]|nil
---@field force        ForceID|ForceID[]|nil
---@field limit        uint32|nil
---@field invert       boolean|nil

---@class PrintSettings
---@field color        {r:float,g:float,b:float,a:float}|nil
---@field game_state   boolean|nil
---@field skip        boolean|nil
---@field sound       boolean|nil

---@class PlaySoundSpecification
---@field path         string
---@field position     MapPosition|nil
---@field volume_modifier double|nil
---@field override_sound_type string|nil

---@class BlueprintInventoryWithFilters table

-- ============================================================
-- §3  defines
-- ============================================================

---@class defines
defines = {}

---@class defines.events
---所有游戏事件的 ID（整数）
---
---【⚠ 2.0 已删除】
---  - on_recipe_finished: 已删除，无替代事件
---
---【新增】
---  - on_cargo_pod_*: 太空舱相关
---  - on_space_platform_*: 太空平台相关
---  - on_segmented_unit_*: 蠕虫形单位相关
---  - on_territory_*: 领地相关
defines.events = {
  -- ── 建筑 / 实体 ──────────────────────────────────────────────
  ---@type integer
  on_built_entity              = 0,  -- event.entity (⚠ 1.x 为 event.created_entity)
  ---@type integer
  on_robot_built_entity        = 0,  -- event.entity, event.robot, event.stack
  ---@type integer
  on_space_platform_built_entity = 0,
  ---@type integer
  on_entity_died               = 0,  -- event.entity, event.cause, event.loot
  ---@type integer
  on_entity_damaged            = 0,
  ---@type integer
  on_entity_cloned             = 0,
  ---@type integer
  on_entity_color_changed      = 0,
  ---@type integer
  on_entity_renamed            = 0,
  ---@type integer
  on_entity_settings_pasted    = 0,
  ---@type integer
  on_entity_spawned            = 0,
  ---@type integer
  on_entity_logistic_slot_changed = 0,
  ---@type integer
  on_biter_base_built          = 0,
  ---@type integer
  on_trigger_created_entity    = 0,
  ---@type integer
  on_trigger_fired_artillery   = 0,
  ---@type integer
  on_marked_for_deconstruction = 0,
  ---@type integer
  on_marked_for_upgrade        = 0,
  ---@type integer
  on_cancelled_deconstruction  = 0,
  ---@type integer
  on_cancelled_upgrade         = 0,
  ---@type integer
  on_object_destroyed          = 0,

  -- ── 科研 ────────────────────────────────────────────────────
  ---@type integer
  on_research_started          = 0,  -- event.research: LuaTechnology
  ---@type integer
  on_research_finished         = 0,  -- event.research: LuaTechnology, event.by_script
  ---@type integer
  on_research_cancelled        = 0,
  ---@type integer
  on_research_reversed         = 0,
  ---@type integer
  on_research_moved            = 0,
  ---@type integer
  on_research_queued           = 0,
  ---@type integer
  on_technology_effects_reset  = 0,

  -- ── 玩家 ────────────────────────────────────────────────────
  ---@type integer
  on_player_created            = 0,
  ---@type integer
  on_player_joined_game        = 0,
  ---@type integer
  on_player_left_game          = 0,
  ---@type integer
  on_player_removed            = 0,
  ---@type integer
  on_player_died               = 0,
  ---@type integer
  on_player_respawned          = 0,
  ---@type integer
  on_player_changed_position   = 0,
  ---@type integer
  on_player_changed_surface    = 0,
  ---@type integer
  on_player_changed_force      = 0,
  ---@type integer
  on_player_mined_entity       = 0,
  ---@type integer
  on_player_mined_item         = 0,
  ---@type integer
  on_player_mined_tile         = 0,
  ---@type integer
  on_player_built_tile         = 0,
  ---@type integer
  on_player_crafted_item       = 0,  -- ✅ 仅玩家手工合成，机器制作无事件
  ---@type integer
  on_player_cancelled_crafting = 0,
  ---@type integer
  on_pre_player_crafted_item   = 0,
  ---@type integer
  on_player_cursor_stack_changed = 0,
  ---@type integer
  on_player_main_inventory_changed = 0,
  ---@type integer
  on_player_ammo_inventory_changed = 0,
  ---@type integer
  on_player_armor_inventory_changed = 0,
  ---@type integer
  on_player_gun_inventory_changed = 0,
  ---@type integer
  on_player_trash_inventory_changed = 0,
  ---@type integer
  on_player_dropped_item       = 0,
  ---@type integer
  on_player_dropped_item_into_entity = 0,
  ---@type integer
  on_player_picked_up_item     = 0,
  ---@type integer
  on_player_fast_transferred   = 0,
  ---@type integer
  on_player_promoted           = 0,
  ---@type integer
  on_player_demoted            = 0,
  ---@type integer
  on_player_banned             = 0,
  ---@type integer
  on_player_unbanned           = 0,
  ---@type integer
  on_player_kicked             = 0,
  ---@type integer
  on_player_muted              = 0,
  ---@type integer
  on_player_unmuted            = 0,
  ---@type integer
  on_player_pipette            = 0,
  ---@type integer
  on_player_rotated_entity     = 0,
  ---@type integer
  on_player_flipped_entity     = 0,
  ---@type integer
  on_player_repaired_entity    = 0,
  ---@type integer
  on_player_controller_changed = 0,
  ---@type integer
  on_player_cheat_mode_enabled = 0,
  ---@type integer
  on_player_cheat_mode_disabled = 0,
  ---@type integer
  on_player_selected_area      = 0,
  ---@type integer
  on_player_alt_selected_area  = 0,
  ---@type integer
  on_player_reverse_selected_area = 0,
  ---@type integer
  on_player_alt_reverse_selected_area = 0,
  ---@type integer
  on_selected_entity_changed   = 0,
  ---@type integer
  on_pre_build                 = 0,

  -- ── 地图 / 地块 ─────────────────────────────────────────────
  ---@type integer
  on_chunk_generated           = 0,
  ---@type integer
  on_chunk_charted             = 0,
  ---@type integer
  on_chunk_deleted             = 0,
  ---@type integer
  on_pre_chunk_deleted         = 0,
  ---@type integer
  on_surface_created           = 0,
  ---@type integer
  on_surface_deleted           = 0,
  ---@type integer
  on_surface_cleared           = 0,
  ---@type integer
  on_surface_imported          = 0,
  ---@type integer
  on_surface_renamed           = 0,
  ---@type integer
  on_sector_scanned            = 0,

  -- ── 时钟 ────────────────────────────────────────────────────
  ---@type integer
  on_tick                      = 0,  -- ⚠ 每帧触发，慎用，影响性能

  -- ── 势力 ────────────────────────────────────────────────────
  ---@type integer
  on_force_created             = 0,
  ---@type integer
  on_forces_merging            = 0,
  ---@type integer
  on_forces_merged             = 0,
  ---@type integer
  on_force_reset               = 0,
  ---@type integer
  on_force_friends_changed     = 0,
  ---@type integer
  on_force_cease_fire_changed  = 0,

  -- ── 机器人 ──────────────────────────────────────────────────
  ---@type integer
  on_robot_built_tile          = 0,
  ---@type integer
  on_robot_mined               = 0,
  ---@type integer
  on_robot_mined_entity        = 0,
  ---@type integer
  on_robot_mined_tile          = 0,
  ---@type integer
  on_robot_pre_mined           = 0,
  ---@type integer
  on_robot_exploded_cliff      = 0,
  ---@type integer
  on_worker_robot_expired      = 0,

  -- ── 火车 ────────────────────────────────────────────────────
  ---@type integer
  on_train_created             = 0,
  ---@type integer
  on_train_changed_state       = 0,
  ---@type integer
  on_train_schedule_changed    = 0,

  -- ── 火箭 / 太空 ─────────────────────────────────────────────
  ---@type integer
  on_rocket_launch_ordered     = 0,
  ---@type integer
  on_rocket_launched           = 0,
  ---@type integer
  on_cargo_pod_delivered_cargo = 0,
  ---@type integer
  on_cargo_pod_finished_ascending = 0,
  ---@type integer
  on_cargo_pod_finished_descending = 0,
  ---@type integer
  on_cargo_pod_started_ascending = 0,
  ---@type integer
  on_space_platform_changed_state = 0,
  ---@type integer
  on_space_platform_built_tile = 0,
  ---@type integer
  on_space_platform_mined_entity = 0,
  ---@type integer
  on_space_platform_mined_item = 0,
  ---@type integer
  on_space_platform_mined_tile = 0,
  ---@type integer
  on_space_platform_pre_mined  = 0,

  -- ── Script Raised（mod 间通信）─────────────────────────────
  ---@type integer
  script_raised_built          = 0,  -- event.entity
  ---@type integer
  script_raised_destroy        = 0,  -- event.entity
  ---@type integer
  script_raised_revive         = 0,  -- event.entity
  ---@type integer
  script_raised_set_tiles      = 0,
  ---@type integer
  script_raised_teleported     = 0,
  ---@type integer
  script_raised_destroy_segmented_unit = 0,

  -- ── 其他 ────────────────────────────────────────────────────
  ---@type integer
  on_gui_click                 = 0,
  ---@type integer
  on_gui_opened                = 0,
  ---@type integer
  on_gui_closed                = 0,
  ---@type integer
  on_gui_text_changed          = 0,
  ---@type integer
  on_gui_checked_state_changed = 0,
  ---@type integer
  on_gui_selection_state_changed = 0,
  ---@type integer
  on_gui_selected_tab_changed  = 0,
  ---@type integer
  on_gui_switch_state_changed  = 0,
  ---@type integer
  on_gui_value_changed         = 0,
  ---@type integer
  on_gui_elem_changed          = 0,
  ---@type integer
  on_gui_location_changed      = 0,
  ---@type integer
  on_gui_hover                 = 0,
  ---@type integer
  on_gui_leave                 = 0,
  ---@type integer
  on_gui_confirmed             = 0,
  ---@type integer
  on_market_item_purchased     = 0,
  ---@type integer
  on_script_trigger_effect     = 0,
  ---@type integer
  on_script_inventory_resized  = 0,
  ---@type integer
  on_script_path_request_finished = 0,
  ---@type integer
  on_runtime_mod_setting_changed = 0,
  ---@type integer
  on_resource_depleted         = 0,
  ---@type integer
  on_picked_up_item            = 0,
  ---@type integer
  on_pre_entity_settings_pasted = 0,
  ---@type integer
  on_pre_ghost_deconstructed   = 0,
  ---@type integer
  on_pre_ghost_upgraded        = 0,
  ---@type integer
  on_pre_player_mined_item     = 0,
  ---@type integer
  on_pre_scenario_finished     = 0,
  ---@type integer
  on_pre_surface_cleared       = 0,
  ---@type integer
  on_pre_surface_deleted       = 0,
  ---@type integer
  on_lua_shortcut              = 0,
  ---@type integer
  on_mod_item_opened           = 0,
  ---@type integer
  on_singleplayer_init         = 0,
  ---@type integer
  on_multiplayer_init          = 0,
  ---@type integer
  on_game_created_from_scenario = 0,
  ---@type integer
  on_undo_applied              = 0,
  ---@type integer
  on_redo_applied              = 0,
  ---@type integer
  on_post_entity_died          = 0,
  ---@type integer
  on_entity_color_changed      = 0,
  ---@type integer
  on_combat_robot_expired      = 0,
  ---@type integer
  on_land_mine_armed           = 0,
  ---@type integer
  on_string_translated         = 0,
  ---@type integer
  on_ai_command_completed      = 0,
  ---@type integer
  on_unit_added_to_group       = 0,
  ---@type integer
  on_unit_removed_from_group   = 0,
  ---@type integer
  on_unit_group_created        = 0,
  ---@type integer
  on_unit_group_finished_gathering = 0,
  ---@type integer
  on_spider_command_completed  = 0,
  ---@type integer
  on_territory_created         = 0,
  ---@type integer
  on_territory_destroyed       = 0,
  ---@type integer
  on_tower_mined_plant         = 0,
  ---@type integer
  on_tower_planted_seed        = 0,
  ---@type integer
  on_tower_pre_mined_plant     = 0,
  ---@type integer
  on_segment_entity_created    = 0,
  ---@type integer
  on_segmented_unit_created    = 0,
  ---@type integer
  on_segmented_unit_damaged    = 0,
  ---@type integer
  on_segmented_unit_died       = 0,
  ---@type integer
  on_post_segmented_unit_died  = 0,
  ---@type integer
  CustomInputEvent             = 0,
}

---@class defines.inventory
---库存槽位索引。
---⚠ Factorio 2.0 部分已废弃，用 crafter_* 代替。
defines.inventory = {
  -- ── 容器 ────────────────────────────────────────────────────
  ---@type defines.inventory
  chest                        = 0,

  -- ── 角色 ────────────────────────────────────────────────────
  ---@type defines.inventory
  character_main               = 0,
  ---@type defines.inventory
  character_guns               = 0,
  ---@type defines.inventory
  character_ammo               = 0,
  ---@type defines.inventory
  character_armor              = 0,
  ---@type defines.inventory
  character_vehicle            = 0,
  ---@type defines.inventory
  character_trash              = 0,
  ---@type defines.inventory
  character_corpse             = 0,

  -- ── 制造机器（2.0 新名称）───────────────────────────────────
  ---@type defines.inventory
  crafter_input                = 0,  -- 取代 assembling_machine_input / furnace_source
  ---@type defines.inventory
  crafter_output               = 0,  -- 取代 assembling_machine_output / furnace_result
  ---@type defines.inventory
  crafter_modules              = 0,  -- 取代 assembling_machine_modules / furnace_modules
  ---@type defines.inventory
  crafter_trash                = 0,  -- 取代 assembling_machine_trash / furnace_trash
  ---@type defines.inventory
  crafter_dump                 = 0,  -- 取代 assembling_machine_dump

  -- ── 制造机器（废弃别名，仍可用）────────────────────────────
  ---@deprecated 使用 crafter_input 替代
  ---@type defines.inventory
  assembling_machine_input     = 0,
  ---@deprecated 使用 crafter_output 替代
  ---@type defines.inventory
  assembling_machine_output    = 0,
  ---@deprecated 使用 crafter_modules 替代
  ---@type defines.inventory
  assembling_machine_modules   = 0,
  ---@deprecated 使用 crafter_trash 替代
  ---@type defines.inventory
  assembling_machine_trash     = 0,
  ---@deprecated 使用 crafter_dump 替代
  ---@type defines.inventory
  assembling_machine_dump      = 0,

  -- ── 熔炉（废弃别名，仍可用）────────────────────────────────
  ---@deprecated 使用 crafter_input 替代
  ---@type defines.inventory
  furnace_source               = 0,
  ---@deprecated 使用 crafter_output 替代
  ---@type defines.inventory
  furnace_result               = 0,
  ---@deprecated 使用 crafter_modules 替代
  ---@type defines.inventory
  furnace_modules              = 0,
  ---@deprecated 使用 crafter_trash 替代
  ---@type defines.inventory
  furnace_trash                = 0,

  -- ── 其他机器 ────────────────────────────────────────────────
  ---@type defines.inventory
  fuel                         = 0,
  ---@type defines.inventory
  burnt_result                 = 0,
  ---@type defines.inventory
  beacon_modules               = 0,
  ---@type defines.inventory
  lab_input                    = 0,
  ---@type defines.inventory
  lab_modules                  = 0,
  ---@type defines.inventory
  car_trunk                    = 0,
  ---@type defines.inventory
  car_ammo                     = 0,
  ---@type defines.inventory
  car_trash                    = 0,
  ---@type defines.inventory
  cargo_wagon                  = 0,
  ---@type defines.inventory
  turret_ammo                  = 0,
  ---@type defines.inventory
  artillery_turret_ammo        = 0,
  ---@type defines.inventory
  artillery_wagon_ammo         = 0,
  ---@type defines.inventory
  spider_trunk                 = 0,
  ---@type defines.inventory
  spider_ammo                  = 0,
  ---@type defines.inventory
  spider_trash                 = 0,
  ---@type defines.inventory
  item_main                    = 0,
  ---@type defines.inventory
  hub_main                     = 0,
  ---@type defines.inventory
  hub_trash                    = 0,
  ---@type defines.inventory
  cargo_landing_pad_main       = 0,
  ---@type defines.inventory
  cargo_landing_pad_trash      = 0,
  ---@type defines.inventory
  cargo_unit                   = 0,
  ---@type defines.inventory
  asteroid_collector_output    = 0,
  ---@type defines.inventory
  agricultural_tower_input     = 0,
  ---@type defines.inventory
  agricultural_tower_output    = 0,
  ---@type defines.inventory
  god_main                     = 0,
  ---@type defines.inventory
  editor_main                  = 0,
  ---@type defines.inventory
  editor_guns                  = 0,
  ---@type defines.inventory
  editor_ammo                  = 0,
  ---@type defines.inventory
  editor_armor                 = 0,
}

-- ============================================================
-- §4  事件数据 class（常用事件）
-- ============================================================

---@class EventData                  # 所有事件的公共字段
---@field name    defines.events     # 事件 ID
---@field tick    uint32             # 触发时的游戏刻

---@class EventData.on_built_entity : EventData
---@field entity         LuaEntity    # ⚠ 2.0 改名（1.x 为 created_entity）
---@field player_index   uint32
---@field consumed_items LuaInventory
---@field tags           Tags|nil

---@class EventData.on_robot_built_entity : EventData
---@field entity   LuaEntity
---@field robot    LuaEntity
---@field stack    LuaItemStack
---@field tags     Tags|nil

---@class EventData.on_entity_died : EventData
---@field entity      LuaEntity
---@field cause       LuaEntity|nil
---@field force       LuaForce|nil
---@field loot        LuaInventory
---@field damage_type LuaDamagePrototype|nil

---@class EventData.on_research_finished : EventData
---@field research   LuaTechnology
---@field by_script  boolean

---@class EventData.on_research_started : EventData
---@field research      LuaTechnology
---@field last_research LuaTechnology|nil

---@class EventData.on_player_crafted_item : EventData
---@field item_stack   LuaItemStack
---@field player_index uint32
---@field recipe       LuaRecipe

---@class EventData.on_player_mined_entity : EventData
---@field entity       LuaEntity
---@field player_index uint32
---@field buffer       LuaInventory

---@class EventData.on_entity_settings_pasted : EventData
---@field source       LuaEntity
---@field destination  LuaEntity
---@field player_index uint32

---@class EventData.on_script_trigger_effect : EventData
---@field effect_id      string
---@field surface_index  uint32
---@field source_entity  LuaEntity|nil
---@field source_position MapPosition|nil
---@field target_entity  LuaEntity|nil
---@field target_position MapPosition|nil
---@field cause_entity   LuaEntity|nil
---@field quality        string|nil

---@class EventData.on_tick : EventData
-- (无额外字段)

---@class EventData.script_raised_built : EventData
---@field entity LuaEntity

---@class EventData.script_raised_destroy : EventData
---@field entity LuaEntity

---@class EventData.script_raised_revive : EventData
---@field entity LuaEntity
---@field tags   Tags|nil

---@class EventData.on_chunk_generated : EventData
---@field area     BoundingBox
---@field position ChunkPosition
---@field surface  LuaSurface

---@class EventData.on_runtime_mod_setting_changed : EventData
---@field player_index uint32|nil
---@field setting      string
---@field setting_type string

-- ============================================================
-- §5  LuaInventory
-- ============================================================

---@class LuaInventory
---@field entity_owner    LuaEntity|nil      # 所属实体
---@field equipment_owner table|nil
---@field player_owner    LuaPlayer|nil      # 所属玩家
---@field mod_owner       string|nil
---@field index           defines.inventory  # 这个库存的槽位类型
---@field valid           boolean
---@field object_name     string
---@field name            string
---@field max_weight      double
---@field weight          double
local LuaInventory = {}

---@param items ItemStackIdentification
---@return boolean
function LuaInventory:can_insert(items) end

---@param items ItemStackIdentification
---@return uint32  # 实际插入数量
function LuaInventory:insert(items) end

---@param items ItemStackIdentification
---@return uint32  # 实际移除数量
function LuaInventory:remove(items) end

---@param item ItemWithQualityID|nil
---@return uint32
function LuaInventory:get_item_count(item) end

---@param filter ItemFilter|nil
---@return uint32
function LuaInventory:get_item_count_filtered(filter) end

---@return ItemWithQualityCounts
function LuaInventory:get_contents() end

---@param item ItemWithQualityID|nil
---@return LuaItemStack|nil  # 找到的第一个 stack，找不到返回 nil
function LuaInventory:find_item_stack(item) end

---@param item ItemWithQualityID|nil
---@return LuaItemStack|nil
function LuaInventory:find_empty_stack(item) end

---@return boolean
function LuaInventory:is_empty() end

---@return boolean
function LuaInventory:is_full() end

---@return boolean
function LuaInventory:is_filtered() end

function LuaInventory:clear() end

---@return boolean
function LuaInventory:supports_bar() end

---@return boolean
function LuaInventory:supports_filters() end

---@return uint32
function LuaInventory:get_bar() end

---@param bar uint32
function LuaInventory:set_bar(bar) end

function LuaInventory:sort_and_merge() end

---@param size uint16
function LuaInventory:resize(size) end

function LuaInventory:destroy() end

---@param include_bar      boolean|nil
---@param include_filtered boolean|nil
---@return uint32
function LuaInventory:count_empty_stacks(include_bar, include_filtered) end

---@param item  ItemWithQualityID
---@return uint32
function LuaInventory:get_insertable_count(item) end

-- ============================================================
-- §6  LuaItemStack
-- ============================================================

---@class LuaItemStack
---@field valid_for_read  boolean       # true 时该 stack 包含有效物品
---@field valid           boolean
---@field name            string        # 物品名称
---@field count           uint32        # 数量
---@field type            string        # 物品类型 prototype
---@field quality         LuaQualityPrototype
---@field health          float
---@field is_module       boolean
---@field prototype       LuaItemPrototype
---@field item            LuaItem|nil
---@field object_name     string
---@field spoil_percent   double
---@field spoil_tick      uint32
local LuaItemStack = {}

---@param stack ItemStackIdentification|nil
---@return boolean
function LuaItemStack:set_stack(stack) end

function LuaItemStack:clear() end

---@param stack LuaItemStack
---@return boolean
function LuaItemStack:swap_stack(stack) end

---@param stack ItemStackIdentification
---@return boolean
function LuaItemStack:can_set_stack(stack) end

---@param data string
---@return int32
function LuaItemStack:import_stack(data) end

---@return string
function LuaItemStack:export_stack() end

-- ============================================================
-- §7  LuaControl（LuaEntity / LuaPlayer 的基类）
-- ============================================================

---@class LuaControl
---@field position        MapPosition
---@field surface         LuaSurface
---@field surface_index   uint32
---@field force           LuaForce
---@field force_index     uint32
---@field vehicle         LuaEntity|nil
---@field driving         boolean
---@field cheat_mode      boolean
---@field character_running_speed double
local LuaControl = {}

---@param inventory defines.inventory
---@return LuaInventory|nil
function LuaControl:get_inventory(inventory) end

---@return LuaInventory|nil
function LuaControl:get_main_inventory() end

---@return defines.inventory
function LuaControl:get_max_inventory_index() end

---@param inventory defines.inventory
---@return string
function LuaControl:get_inventory_name(inventory) end

---@param items ItemStackIdentification
---@return boolean
function LuaControl:can_insert(items) end

---@param items ItemStackIdentification
---@return uint32
function LuaControl:insert(items) end

---@param items ItemStackIdentification
---@return uint32
function LuaControl:remove_item(items) end

---@param item ItemFilter
---@return uint32
function LuaControl:get_item_count(item) end

-- ============================================================
-- §8  LuaEntity（继承 LuaControl）
-- ============================================================

---@class LuaEntity : LuaControl
---@field name                    string           # prototype 名称
---@field type                    string           # prototype 类型
---@field valid                   boolean
---@field object_name             string
---@field unit_number             uint32|nil
---@field position                MapPosition
---@field bounding_box            BoundingBox
---@field direction               defines.direction
---@field health                  float|nil
---@field max_health              float|nil
---@field is_entity_with_health   boolean
---@field is_entity_with_owner    boolean
---@field destructible            boolean
---@field minable                 boolean
---@field minable_flag            boolean
---@field active                  boolean          # ⚠ write 已废弃，改用 disabled_by_script
---@field disabled_by_script      boolean          # 推荐用于 enable/disable 实体
---@field disabled_by_control_behavior boolean
---@field disabled_by_recipe      boolean
---@field operable                boolean
---@field frozen                  boolean
---@field prototype               LuaEntityPrototype
---@field force                   LuaForce
---@field last_user               LuaPlayer|nil
---@field energy                  double
---@field electric_buffer_size    double|nil
---@field productivity_bonus      double
---@field speed_bonus             double
---@field consumption_bonus       double
---@field pollution_bonus         double
---@field crafting_progress       double           # 当前合成进度 [0,1]
---@field crafting_speed          double
---@field is_crafting             fun():boolean    -- 也可当属性看
---@field previous_recipe         LuaRecipePrototype|nil
---@field recipe_locked           boolean
---@field products_finished       uint32
---@field color                   {r:float,g:float,b:float,a:float}|nil
---@field ghost_name              string|nil
---@field ghost_type              string|nil
---@field ghost_prototype         LuaEntityPrototype|nil
---@field proxy_target_inventory  defines.inventory|nil
local LuaEntity = {}

---@return LuaInventory|nil
function LuaEntity:get_output_inventory() end

---@return LuaInventory|nil
function LuaEntity:get_fuel_inventory() end

---@return LuaInventory|nil
function LuaEntity:get_burnt_result_inventory() end

---@return LuaInventory|nil
function LuaEntity:get_module_inventory() end

---@return LuaRecipe|nil
function LuaEntity:get_recipe() end

---@param recipe  RecipeID|nil
---@param quality QualityID|nil
---@return ItemWithQualityCounts
function LuaEntity:set_recipe(recipe, quality) end

---@return boolean
function LuaEntity:is_crafting() end

---@param raise_destroyed boolean|nil
---@param overflow        LuaInventory|nil
---@return boolean
function LuaEntity:mine(force, ignore_minable, inventory, raise_destroyed) end

---@param raise_revive boolean|nil
---@param overflow     LuaInventory|nil
function LuaEntity:revive(overflow, raise_revive) end

---@param raise_destroy boolean|nil
function LuaEntity:destroy(raise_destroy) end

---@param inventory_index defines.inventory
---@return uint32
function LuaEntity:get_inventory_bar(inventory_index) end

---@param bar             uint32
---@param inventory_index defines.inventory
function LuaEntity:set_inventory_bar(bar, inventory_index) end

---@param inventory_index defines.inventory
---@return boolean
function LuaEntity:inventory_supports_bar(inventory_index) end

---@param inventory_index defines.inventory
---@return boolean
function LuaEntity:inventory_supports_filters(inventory_index) end

---@return double
function LuaEntity:get_radius() end

---@param force  ForceID|nil
---@param player PlayerIdentification|nil
---@return boolean
function LuaEntity:order_deconstruction(force, player) end

-- ============================================================
-- §9  LuaSurface
-- ============================================================

---@class LuaSurface
---@field name           string
---@field index          uint32
---@field valid          boolean
---@field object_name    string
---@field daytime        double       # 0.0(日出) - 1.0(下一个日出)
---@field darkness       float
---@field wind_speed     double
---@field wind_orientation float
---@field peaceful_mode  boolean
---@field no_enemies_mode boolean
---@field generate_with_lab_tiles boolean
local LuaSurface = {}

---@param filter EntitySearchFilters
---@return LuaEntity[]
function LuaSurface:find_entities_filtered(filter) end

---@param filter EntitySearchFilters
---@return uint32
function LuaSurface:count_entities_filtered(filter) end

---@param area   BoundingBox|nil
---@return LuaEntity[]
function LuaSurface:find_entities(area) end

---@param name     EntityID
---@param position MapPosition
---@return LuaEntity|nil
function LuaSurface:find_entity(name, position) end

---@param params table  # 见 API 文档 LuaSurface::create_entity
---@return LuaEntity|nil
function LuaSurface:create_entity(params) end

---@param position MapPosition
---@return double
function LuaSurface:get_pollution(position) end

---@param source MapPosition
---@param amount double
---@param prototype EntityID|nil
function LuaSurface:pollute(source, amount, prototype) end

---@param x integer
---@param y integer
---@return LuaTile
function LuaSurface:get_tile(x, y) end

---@param center MapPosition
---@param radius double
---@param force  ForceID|nil
---@return LuaEntity[]
function LuaSurface:find_enemy_units(center, radius, force) end

---@return LuaChunkIterator
function LuaSurface:get_chunks() end

---@param chunk_position ChunkPosition
---@return boolean
function LuaSurface:is_chunk_generated(chunk_position) end

---@param message       LocalisedString
---@param print_settings PrintSettings|nil
function LuaSurface:print(message, print_settings) end

-- ============================================================
-- §10  LuaGameScript
-- ============================================================

---@class LuaGameScript
---@field tick              uint32          # 当前游戏刻
---@field ticks_played      uint32
---@field speed             float
---@field tick_paused        boolean
---@field surfaces          table<string|uint32, LuaSurface>
---@field players           table<string|uint32, LuaPlayer>
---@field forces            table<string|uint32, LuaForce>
---@field player            LuaPlayer|nil    # 单人游戏当前玩家
---@field object_name       string
---@field finished          boolean
---@field finished_but_continuing boolean
local LuaGameScript = {}

---@param surface SurfaceIdentification
---@return LuaSurface|nil
function LuaGameScript:get_surface(surface) end

---@param player PlayerIdentification
---@return LuaPlayer|nil
function LuaGameScript:get_player(player) end

---@param tag string
---@return LuaEntity|nil
function LuaGameScript:get_entity_by_tag(tag) end

---@param unit_number uint32
---@return LuaEntity|nil
function LuaGameScript:get_entity_by_unit_number(unit_number) end

---@param force  string
---@return LuaForce
function LuaGameScript:create_force(force) end

---@param gui_title LocalisedString
---@param size      uint16
---@return LuaInventory
function LuaGameScript:create_inventory(gui_title, size) end

---@param name   string
---@param settings table|nil
---@return LuaSurface
function LuaGameScript:create_surface(name, settings) end

---@param message       LocalisedString
---@param print_settings PrintSettings|nil
function LuaGameScript:print(message, print_settings) end

function LuaGameScript:reload_mods() end
function LuaGameScript:reload_script() end

-- ============================================================
-- §11  LuaBootstrap（script 对象）
-- ============================================================

---@class LuaBootstrap
---@field mod_name    string    # 当前 mod 名称
---@field object_name string
---@field active_mods table<string, string>   # mod名 → 版本号
---@field feature_flags table<string, boolean>
local LuaBootstrap = {}

---注册 on_init 回调（首次创建存档时触发）
---@param handler fun()|nil
function LuaBootstrap.on_init(handler) end

---注册 on_load 回调（每次加载存档时触发，不可修改 storage）
---@param handler fun()|nil
function LuaBootstrap.on_load(handler) end

---注册 on_configuration_changed 回调（mod 版本更新时触发）
---@param handler fun(data:{mod_changes:table, migration_applied:boolean})|nil
function LuaBootstrap.on_configuration_changed(handler) end

---注册事件回调
---@param event    integer|integer[]   # defines.events 值（本质 integer）
---@param handler  fun(event:table)|nil  # event 表含 tick, name 及各事件特有字段
---@param filters  LuaEventFilter|nil
function LuaBootstrap.on_event(event, handler, filters) end

---注册每 N 刻触发的回调（避免每刻触发）
---@param tick     uint32|uint32[]
---@param handler  fun(event:{tick:uint32})|nil
function LuaBootstrap.on_nth_tick(tick, handler) end

---@return defines.events   # 新的自定义事件 ID
function LuaBootstrap.generate_event_name() end

---@param event LuaEventType
---@return fun()|nil
function LuaBootstrap.get_event_handler(event) end

---@param event   LuaEventType
---@param filters LuaEventFilter|nil
function LuaBootstrap.set_event_filter(event, filters) end

---@param event LuaEventType
---@return LuaEventFilter|nil
function LuaBootstrap.get_event_filter(event) end

---@param object RegistrationTarget
---@return uint64
function LuaBootstrap.register_on_object_destroyed(object) end

-- ── raise 系列（触发 script_raised_* 事件）────────────────────

---@param entity LuaEntity
function LuaBootstrap.raise_script_built(entity) end

---@param entity LuaEntity
function LuaBootstrap.raise_script_destroy(entity) end

---@param entity LuaEntity
---@param tags   Tags|nil
function LuaBootstrap.raise_script_revive(entity, tags) end

---@param data  table
---@param event LuaEventType
function LuaBootstrap.raise_event(data, event) end

-- ============================================================
-- §12  LuaTechnology
-- ============================================================

---@class LuaTechnology
---@field name                     string
---@field enabled                  boolean
---@field researched               boolean
---@field level                    uint32
---@field upgrade                  boolean
---@field force                    LuaForce
---@field prerequisites            table<string, LuaTechnology>
---@field successors               table<string, LuaTechnology>
---@field research_unit_count      uint32
---@field research_unit_count_formula string|nil
---@field research_unit_energy     double
---@field research_unit_ingredients ItemWithQualityCount[]
---@field saved_progress           double
---@field visible_when_disabled    boolean
---@field valid                    boolean
---@field object_name              string
local LuaTechnology = {}

function LuaTechnology:reload() end
function LuaTechnology:research_recursive() end

-- ============================================================
-- §13  LuaForce
-- ============================================================

---@class LuaForce
---@field name           string
---@field index          uint32
---@field valid          boolean
---@field object_name    string
---@field technologies   table<string, LuaTechnology>
---@field recipes        table<string, LuaRecipe>
---@field players        LuaPlayer[]
---@field current_research LuaTechnology|nil
---@field research_progress double
---@field research_queue LuaTechnology[]
---@field research_enabled boolean
---@field friendly_fire  boolean
---@field share_chart    boolean
---@field character_running_speed_modifier double
---@field worker_robots_speed_modifier double
---@field worker_robots_battery_modifier double
---@field worker_robots_storage_bonus uint32
---@field laboratory_speed_modifier double
---@field laboratory_productivity_bonus double
---@field mining_drill_productivity_bonus double
---@field inserter_stack_size_bonus uint32
---@field bulk_inserter_capacity_bonus uint32
local LuaForce = {}

---@param technology TechnologyID
---@return boolean
function LuaForce:add_research(technology) end

function LuaForce:cancel_current_research() end

---@param surface SurfaceIdentification|nil
---@return double
function LuaForce:get_evolution_factor(surface) end

---@param include_disabled boolean|nil
function LuaForce:research_all_technologies(include_disabled) end

function LuaForce:reset_technologies() end
function LuaForce:reset_recipes() end
function LuaForce:reset_technology_effects() end
function LuaForce:enable_all_prototypes() end
function LuaForce:enable_all_recipes() end
function LuaForce:enable_all_technologies() end

---@param message       LocalisedString
---@param print_settings PrintSettings|nil
function LuaForce:print(message, print_settings) end

-- ============================================================
-- §14  其他常用 class（最小 stub）
-- ============================================================

---@class LuaDamagePrototype
---@field valid       boolean
---@field object_name string

---@class LuaTile
---@field name     string
---@field position TilePosition
---@field valid    boolean

---@class LuaTilePrototype
---@field name    string
---@field valid   boolean

---@class LuaItemPrototype
---@field name    string
---@field type    string
---@field valid   boolean

---@class LuaEntityPrototype
---@field name    string
---@field type    string
---@field valid   boolean

---@class LuaRecipe
---@field name          string
---@field enabled       boolean
---@field valid         boolean
---@field force         LuaForce

---@class LuaRecipePrototype
---@field name    string
---@field valid   boolean

---@class LuaQualityPrototype
---@field name    string
---@field valid   boolean

---@class LuaPlayer : LuaControl
---@field name           string
---@field index          uint32
---@field valid          boolean
---@field object_name    string
---@field force          LuaForce
---@field surface        LuaSurface
---@field character      LuaEntity|nil

-- ============================================================
-- §15  全局变量
-- ============================================================

---游戏主对象，访问地表、玩家、势力等。
---@type LuaGameScript
game = {}

---事件注册和 mod 自举对象。
---@type LuaBootstrap
script = {}

---mod 持久化数据（⚠ Factorio 2.0 将 `global` 重命名为 `storage`）。
---在 on_init / on_load 中初始化，在 on_configuration_changed 中迁移。
---@type table
storage = {}

---游戏常量（事件 ID、库存槽位等）。
---@type defines
defines = {}

---辅助工具函数。
---@type LuaHelpers
helpers = {}

---@class LuaHelpers
local LuaHelpers = {}

-- ============================================================
-- §16  已删除 / 废弃 API（方便查阅，勿再使用）
-- ============================================================
-- ┌──────────────────────────────────────────────────────────┐
-- │ 1.x API               │ 2.0 替代                        │
-- ├──────────────────────────────────────────────────────────┤
-- │ global.xxx            │ storage.xxx                      │
-- │ on_recipe_finished    │ 已删除（无机器端替代）           │
-- │ event.created_entity  │ event.entity（on_built_entity）  │
-- │ defines.inventory     │                                  │
-- │   .furnace_source     │   → crafter_input                │
-- │   .furnace_result     │   → crafter_output               │
-- │   .assembling_machine_│   → crafter_*                    │
-- │ entity.active = false │ entity.disabled_by_script = true │
-- │ flags=goes-to-quickbar│ 已删除                           │
-- │ emissions_per_minute=N│ → {pollution=N}（table 格式）    │
-- │ tech.unit.ingredients │ → {{"item-name", count}, ...}    │
-- │   ={name=.., amount=} │   （数组格式，非 key-value）     │
-- │ source_inventory_size │ furnace 最大值为 1               │
-- └──────────────────────────────────────────────────────────┘
