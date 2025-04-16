extends TileMapLayer

var rng: RandomNumberGenerator

var cooldown: float = 3

var cd_time: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng = RandomNumberGenerator.new()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var redblocks = get_used_cells_by_id(-1,Vector2i(0,0))
	for block in redblocks:
		erase_cell(block)
		get_parent().get_node("Blocks").add_child(BreakableBlock.new_self(Vector2(block.x*64+32,block.y*64+32),0))
	var yellowblocks = get_used_cells_by_id(-1,Vector2i(1,0))
	for block in yellowblocks:
		erase_cell(block)
		get_parent().get_node("Blocks").add_child(BreakableBlock.new_self(Vector2(block.x*64+32,block.y*64+32),1))
	var greenblocks = get_used_cells_by_id(-1,Vector2i(0,1))
	for block in greenblocks:
		erase_cell(block)
		get_parent().get_node("Blocks").add_child(BreakableBlock.new_self(Vector2(block.x*64+32,block.y*64+32),2))
	var blueblocks = get_used_cells_by_id(-1,Vector2i(1,1))
	for block in blueblocks:
		erase_cell(block)
		get_parent().get_node("Blocks").add_child(BreakableBlock.new_self(Vector2(block.x*64+32,block.y*64+32),3))
	var purpleblocks = get_used_cells_by_id(-1,Vector2i(0,2))
	for block in purpleblocks:
		erase_cell(block)
		get_parent().get_node("Blocks").add_child(BreakableBlock.new_self(Vector2(block.x*64+32,block.y*64+32),4))
	var grayblocks = get_used_cells_by_id(-1,Vector2i(1,2))
	for block in grayblocks:
		erase_cell(block)
		get_parent().get_node("Blocks").add_child(BreakableBlock.new_self(Vector2(block.x*64+32,block.y*64+32),5))
	
	cd_time += delta
	if cd_time > cooldown:
		cd_time = 0
		match randi_range(1,3):
			1:
				get_parent().get_node("Cannonballs").add_child(Cannonball.new_self(Vector2(rng.randf_range(216,352),-232),deg_to_rad(-90),true,false,Ammo.types.STANDARD if rng.randf_range(0,1) > 0.5 else Ammo.types.STANDARD))
			2:
				get_parent().get_node("Cannonballs").add_child(Cannonball.new_self(Vector2(rng.randf_range(216,352),-232),deg_to_rad(-90),true,false,Ammo.types.STANDARD if rng.randf_range(0,1) > 0.5 else Ammo.types.EXPLOSIVE))
			3:
				get_parent().get_node("Cannonballs").add_child(Cannonball.new_self(Vector2(rng.randf_range(216,352),-232),deg_to_rad(-90),true,false,Ammo.types.STANDARD if rng.randf_range(0,1) > 0.5 else Ammo.types.SPLITSHOT))
