extends Control

#动画方法在这里编辑
const FADE_TO_BLACK = preload("res://addons/scene_manager/test/change_scene/transition/fade_to_black.tres")
const RADIAL_TO_BLACK = preload("res://addons/scene_manager/test/change_scene/transition/radial_to_black.tres")
const CONICAL_TO_BLACK = preload("res://addons/scene_manager/test/change_scene/transition/conical_to_black.tres")

var target_scene: String = "res://addons/scene_manager/test/change_scene/other_scene.tscn"

func _ready() -> void:
	process_mode = PROCESS_MODE_DISABLED
	get_node("/root/SceneManager").transition_start(FADE_TO_BLACK, true).finished.connect(func():
		process_mode = PROCESS_MODE_INHERIT
	)
	
#实际调用的切换方法，这里带动画
func on_fade_to_change_scene(scene_path) -> void:
	target_scene = scene_path
	process_mode = PROCESS_MODE_DISABLED
	get_node("/root/SceneManager").transition_start(CONICAL_TO_BLACK).finished.connect(_on_change_scene)


func _on_change_scene() -> void:
	var scene_manager = get_node("/root/SceneManager")
	scene_manager.change_scene_to_file(target_scene)
