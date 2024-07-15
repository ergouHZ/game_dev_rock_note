extends Node

#主要用于存档的脚本

# Function to save game
func save_game(file_path: String = "user://savegame.dat") -> void:
	var save_data = {
		"player_stats": {
			"money": PlayerStats.get_stat("money"),
			##添加其他
		},
		"location": "",
		"story_data": 0
	}
	save_data["story_data"] = StoryManager.save_story()

	var file = FileAccess.open(file_path, FileAccess.ModeFlags.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()

# Function to load game
func load_game(file_path: String = "user://savegame.dat") -> void:
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.ModeFlags.READ)
		if file:
			var save_data = JSON.parse_string(file.get_as_text())
			if save_data.error == OK:
				var save_dict = save_data.result
				if typeof(save_dict) == TYPE_DICTIONARY:
					PlayerStats.load_stats(save_dict.get("player_stats", {}))
					StoryManager.load_story(save_dict.get("story_data", {}))
			else:
				print("Failed to parse JSON: ", save_data.error_string)
			file.close()
	else:
		print("Save file not found!")

# Optionally, you can add functions to reset or initialize the game state
func new_game() -> void:
	PlayerStats.reset_to_default()
	StoryManager.new_game()
	# Add any additional initialization logic.

func _ready() -> void:
	# Add initialization logic if needed.
	pass
