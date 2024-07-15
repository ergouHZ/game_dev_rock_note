extends Area2D

@export_file("*.tscn") var next_scene_path: String = "res://NewScene.tscn"
@export var spawn_point :String = ""
func _on_area_entered(area):
	var area_name:String = area.get_parent().name
	if area_name == "player":
		SceneManager.goto_scene(next_scene_path,spawn_point) #插件方法
	pass # Replace with function body.

