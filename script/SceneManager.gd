extends Node

var current_scene = null
var player_scene = preload("res://characters/player.tscn")  # 预加载玩家场景
var is_transitioning = false #防止多次切换触发

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	

func goto_scene(path,spawn_point):
	Global.player_is_movable = false #切换场景，角色不可移动
	if is_transitioning:
		return
	is_transitioning = true
	Global.next_spawn_point = spawn_point #确认切换之后要出现的出生点
	save_player_data()
	var player = get_tree().get_nodes_in_group("player")[0]  # 玩家在 "player" 组
	player.fade_out() #动画
	await get_tree().create_timer(0.45).timeout  # 等待淡出完成
	
	# 这个函数将负责切换场景
	call_deferred("_deferred_goto_scene", path)
	pass

func _deferred_goto_scene(path):
	# 卸载当前场景
	if current_scene:
		current_scene.free()
	# 加载新场景
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()  # 使用 instantiate() 而不是 instance()
	# 将新场景添加到场景树中
	get_tree().root.add_child(current_scene)
	# 可选：将新场景设置为当前场景
	get_tree().current_scene = current_scene
	await get_tree().process_frame

	# 在新场景中创建玩家
	call_deferred("_spawn_player")

func _spawn_player():
	var spawn_point = current_scene.find_child(Global.next_spawn_point, true, false)
	if spawn_point:
		var player = get_tree().get_nodes_in_group("player")[0]
		player.fade_in()
		player.global_position = spawn_point.global_position
				
		is_transitioning = false #避免重复加载
		## 恢复玩家数据
		#player.health = GlobalData.player_data.get("health", player.health)
		#player.inventory = GlobalData.player_data.get("inventory", player.inventory)
		## 恢复其他需要的玩家数据
	Global.next_spawn_point = ""
	Global.player_is_movable = true #切换完毕 可以移动
	return


func save_player_data():
	#Global.player_data = {
		#"health": player.health,
		#"inventory": player.inventory,
		## 添加其他需要保存的玩家数据
	#}
	pass
	

