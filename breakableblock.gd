class_name BreakableBlock
extends RigidBody2D

const scene = preload("res://breakableblock.tscn")

@onready var player: Cannon = get_parent().get_parent().get_node("Cannon")

var type = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Breakabletiles.frame = type
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


static func new_self(position:Vector2,type:int) -> BreakableBlock:
	var new_self = scene.instantiate()
	new_self.position = position
	new_self.type = type 
	return new_self


func _on_body_entered(body: Node) -> void:
	if body is Cannon:
		queue_free.call_deferred()
		player.change_score(-50)
	pass # Replace with function body.
