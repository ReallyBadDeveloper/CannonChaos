extends Button

func _ready() -> void:
	get_tree().paused = false

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
	pass # Replace with function body.
