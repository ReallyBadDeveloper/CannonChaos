class_name Cannon
extends CharacterBody2D

var speed = 150

var score = 100

var dead = false

var fully_dead = false

var timer = 5

func get_ui() -> Control:
	return get_node("CanvasLayer/Control")
	
func get_ammo() -> HBoxContainer:
	return get_ui().get_node("HBoxContainer")

func _ready() -> void:
	$AnimationPlayer.play("float")

func _process(delta: float) -> void:
	if fully_dead:
		get_tree().reload_current_scene()
	pass

func _physics_process(delta: float) -> void:
	if timer < 0:
		dead = true
		get_node("CanvasLayer/DeathMenu").visible = true
		get_node("CanvasLayer/DeathMenu").process_mode = Node.PROCESS_MODE_ALWAYS
	timer -= delta
	update_score()
	if not dead:
		$CannonBody.look_at(get_global_mouse_position())
		$CannonBody.rotation = deg_to_rad(clamp(rad_to_deg($CannonBody.rotation),-190,-90))
	
	var direction = Input.get_axis("move_left","move_right")
	if direction and not dead:
		velocity.x += direction * speed
		velocity.x = clamp(velocity.x, -direction*speed,direction*speed)
	else:
		velocity.x = move_toward(velocity.x,0,speed/15)
	
	if Input.is_action_just_pressed("fire") and get_ammo().get_child_count() > 0 and not dead:
		change_score(-50)
		$CannonShootSFX.play()
		get_tree().root.get_child(0).get_node("Cannonballs").add_child(Cannonball.new_self($CannonBody/FirePoint.global_position,$CannonBody.rotation,false,false,get_ammo().get_child(0).type))
		get_ammo().get_child(0).queue_free.call_deferred()
		get_parent().get_node("Blocks").add_child(BreakableBlock.new_self(Vector2(-224,-288),randi_range(0,5)))
		get_parent().get_node("Blocks").add_child(BreakableBlock.new_self(Vector2(-160,-288),randi_range(0,5)))
	velocity.y = 0
	position.y = 112
	move_and_slide()


func _on_collection_area_body_entered(body: Node2D) -> void:
	if body is Cannonball and not dead:
		get_ammo().add_child(Ammo.new_self(body.type))
		body.queue_free.call_deferred()
		pass
	pass # Replace with function body.

func update_score() -> void:
	if not dead:
		get_node('Pirateship/Score').text = str(score)
		get_node('CanvasLayer/Control/TimerParent/Label').text = str(int(timer))+"s"

func change_score(change:int) -> void:
	score += change
	update_score()

func change_time(change:float) -> void:
	timer += change
	update_score()

func _on_resume_button_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
	pass # Replace with function body.
