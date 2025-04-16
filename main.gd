extends Node2D

var paused = false

var skrompting = false

@onready var player: Cannon = get_node("Cannon")

func _ready() -> void:
	$Music.play()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		change_pause_state()

func change_pause_state() -> void:
	if not player.dead:
		paused = not paused
		if paused:
			$CanvasLayer.visible = true
			get_tree().paused = true
		else:
			$CanvasLayer.visible = false
			get_tree().paused = false
	pass

func _on_resume_button_pressed() -> void:
	change_pause_state()
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
	pass # Replace with function body.


func _on_skrompt_button_pressed() -> void:
	Cannonball.skrompting = not Cannonball.skrompting
	Ammo.skrompting = not Ammo.skrompting
	pass # Replace with function body.
