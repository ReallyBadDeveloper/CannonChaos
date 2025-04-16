extends Area2D

@onready var player: Cannon = get_parent().get_node("Cannon")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_exited(body: Node2D) -> void:
	if body is BreakableBlock:
		player.change_score(50)
		player.change_time(1)
	body.queue_free.call_deferred()
	pass # Replace with function body.
