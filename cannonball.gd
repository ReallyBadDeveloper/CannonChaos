class_name Cannonball
extends RigidBody2D

const speed = 900
const JUMP_VELOCITY = -400

const scene = preload("res://cannonball.tscn")

var is_from_sky: bool = false

@export var already_split: bool = false

var direction: float = 0

var player: Cannon

var death_timer = 0
var is_dead = false
@export var fully_dead = false

@export var images = [preload("res://ball.png"),preload("res://fireball.png"),preload("res://splitball.png")]

@export var type: Ammo.types = Ammo.types.STANDARD

static var skrompting = false

func _ready() -> void:
	player = get_parent().get_parent().get_node("Cannon")
	if not is_from_sky:
		set_axis_velocity(Vector2(cos(direction)*speed,sin(direction)*speed))
	
	match type:
		Ammo.types.STANDARD:
			$Ball.texture = images[0]
			pass
		Ammo.types.EXPLOSIVE:
			$Ball.texture = images[1]
			pass
		Ammo.types.SPLITSHOT:
			$Ball.texture = images[2]
			pass
	pass

func _process(delta: float) -> void:
	if is_dead:
		death_timer += delta
		if death_timer > 3:
			kill()
	if fully_dead:
		queue_free.call_deferred()
	$RayCast2D.target_position = linear_velocity/20

func _physics_process(delta: float) -> void:
	$Ball.rotation = -rotation
	$Skrompt.rotation = -rotation
	if skrompting:
		$Skrompt.visible = true
		$Ball.visible = false
	else:
		$Skrompt.visible = false
		$Ball.visible = true
	$RayCast2D.rotation = -rotation
	if ($RayCast2D.is_colliding() or position.x < 0) and type == Ammo.types.SPLITSHOT and not already_split:
		$AudioStreamPlayer2D.play()
		already_split = true
		get_parent().add_child(Cannonball.new_self(position+Vector2(0,0),deg_to_rad(rad_to_deg(atan2(linear_velocity.y,linear_velocity.x))-25),false,true,Ammo.types.SPLITSHOT))
		get_parent().add_child(Cannonball.new_self(position+Vector2(0,0),deg_to_rad(rad_to_deg(atan2(linear_velocity.y,linear_velocity.x))+25),false,true,Ammo.types.SPLITSHOT))
	pass

static func new_self(position:Vector2,direction:float,from_sky:bool,split:bool,type:Ammo.types) -> Cannonball:
	var new_self = scene.instantiate()
	new_self.position = position
	new_self.direction = direction
	new_self.is_from_sky = from_sky
	new_self.already_split = split
	new_self.type = type
	return new_self

func kill() -> void:
	is_dead = true
	$AnimationPlayer.play("die")

func _on_body_entered(body: Node) -> void:
	if type == Ammo.types.EXPLOSIVE and not body is Cannonball and not is_dead:
		get_parent().get_parent().get_node("Explosions").add_child(Explosion.new_self(position))
		kill()
		#queue_free.call_deferred()
		pass
	is_dead = true
	if body is BreakableBlock:
		player.change_score(10)
		player.change_time(0.125)
	pass # Replace with function body.

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body is Cannon:
		kill()
		player.change_score(-50)
	pass # Replace with function body.
