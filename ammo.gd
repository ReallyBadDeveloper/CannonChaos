class_name Ammo
extends TextureRect

enum types {STANDARD,EXPLOSIVE,SPLITSHOT}

@export var type: types = types.STANDARD

static var skrompting = false

var images = [preload("res://ball.png"),preload("res://fireball.png"),preload("res://splitball.png")]

const scene: PackedScene = preload("res://ammo.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match type:
		types.STANDARD:
			texture = images[0]
		types.EXPLOSIVE:
			texture = images[1]
		types.SPLITSHOT:
			texture = images[2]
	if skrompting:
		texture = preload('res://skrompt.png')
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if skrompting:
		texture = preload('res://skrompt.png')
	pass
	
static func new_self(type: types) -> Ammo:
	var new_self = scene.instantiate()
	new_self.type = type
	return new_self
