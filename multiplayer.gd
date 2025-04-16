extends Node2D

var port = 8080
var max_clients = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(port, max_clients)
	multiplayer.multiplayer_peer = peer
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
