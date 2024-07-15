extends Node

# Example storyline data
var current_chapter : int = 1
var decisions : Array = []

# Function to load story data from a Dictionary
func load_story(data: Dictionary) -> void:
	current_chapter = data.get("current_chapter", 1)
	decisions = data.get("decisions", [])

# Function to save story data to a Dictionary
func save_story() -> Dictionary:
	var data = {}
	data["current_chapter"] = current_chapter
	data["decisions"] = decisions
	return data
