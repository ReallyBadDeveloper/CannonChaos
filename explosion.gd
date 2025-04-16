class_name Explosion
extends RigidBody2D

@export var dead: bool = false

const scene = preload("res://explosion.tscn")

func _ready() -> void:
	$AnimationPlayer.play("explosion")
	dead = false

func _process(delta: float) -> void:
	if dead:
		queue_free()
		pass
	pass

static func new_self(position: Vector2) -> Explosion:
	var new_self = scene.instantiate()
	new_self.position = position
	return new_self
