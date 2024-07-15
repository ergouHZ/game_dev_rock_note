extends Area2D

@export_file("*.tscn") var next_scene_path: String = "res://NewScene.tscn"
@export var spawn_point :String = ""
func _on_area_entered(area):
	print("enterd")
	var area_name:String = area.get_parent().name
	if area_name == "player":
		SceneManager.change_scene_to_packed(load(next_scene_path))
	pass # Replace with function body.
