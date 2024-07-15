extends Node

# Player stats with default values and upper limits
var stamina : int = 100                    # 体力
var practice : int = 0                     # 练习度
var libido : int = 20                       # 性欲
var money : int = 500                        # 金钱
var action_points : int = 3                # 行动点
var skill_points : int = 0                 # 技能点

# Maximum limits for stats
var max_stamina : int = 100                # 体力上限
var max_libido : int = 100                 # 性欲上限

# Function to load player stats from a save file
func load_stats(file_path: String) -> void:
	var file = FileAccess.open(file_path, FileAccess.ModeFlags.READ)
	if file:
		stamina = file.get_32()
		practice = file.get_32()
		libido = file.get_32()
		money = file.get_32()
		action_points = file.get_32()
		skill_points = file.get_32()
		max_stamina = file.get_32()
		max_libido = file.get_32()
		file.close()
		_clamp_stats()

# Function to save player stats to a save file
func save_stats(file_path: String) -> void:
	var file = FileAccess.open(file_path, FileAccess.ModeFlags.WRITE)
	if file:
		file.store_32(stamina)
		file.store_32(practice)
		file.store_32(libido)
		file.store_32(money)
		file.store_32(action_points)
		file.store_32(skill_points)
		file.store_32(max_stamina)
		file.store_32(max_libido)
		file.close()

# Function to get a specific stat
func get_stat(stat_name: String) -> int:
	match stat_name:
		"stamina": return stamina
		"practice": return practice
		"libido": return libido
		"money": return money
		"action_points": return action_points
		"skill_points": return skill_points
		"max_stamina": return max_stamina
		"max_libido": return max_libido
		_:
			print("Error: Invalid stat name.")
			return 0

# Function to set a specific stat
func set_stat(stat_name: String, value: int) -> void:
	match stat_name:
		"stamina": stamina = clamp(value, 0, max_stamina)
		"practice": practice = clamp(value, 0, 100)
		"libido": libido = clamp(value, 0, max_libido)
		"money": money = value
		"action_points": action_points = value
		"skill_points": skill_points = value
		"max_stamina": max_stamina = value
		"max_libido": max_libido = value
		_:
			print("Error: Invalid stat name.")

# Function to adjust a specific stat by a delta value
func adjust_stat(stat_name: String, delta: int) -> void:
	match stat_name:
		"stamina":
			stamina = clamp(stamina + delta, 0, max_stamina)
		"practice":
			practice = clamp(practice + delta, 0, 100)
		"libido":
			libido = clamp(libido + delta, 0, max_libido)
		"money":
			money += delta
		"action_points":
			action_points += delta
		"skill_points":
			skill_points += delta
		_:
			print("Error: Invalid stat name.")

# 确保数值不会超过上限
func _clamp_stats() -> void:
	stamina = clamp(stamina, 0, max_stamina)
	practice = clamp(practice, 0, 100)
	libido = clamp(libido, 0, max_libido)
	
	### 使用示例
#在游戏的其他部分中，您可以使用上述脚本中的方法来获取、设置或调整角色状态。例如：
#
#```gdscript
## Example usage in another script
#
## 调整体力
#PlayerStats.adjust_stat("stamina", -10)
#
## 获取金钱
#var current_money = PlayerStats.get_stat("money")
#
## 设置练习度
#PlayerStats.set_stat("practice", 50)
#
## 保存玩家状态
#PlayerStats.save_stats("user://savegame.dat")
#
## 加载玩家状态
#PlayerStats.load_stats("user://savegame.dat")
#
## 提升体力上限
#PlayerStats.set_stat("max_stamina", PlayerStats.get_stat("max_stamina") + 10)
