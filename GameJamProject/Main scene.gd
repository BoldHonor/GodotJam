extends Node2D


#predefines 
export (float) var POWER_RATIO =0.5
export (float) var MIN_SCALE = 0.6
export (float) var GROWTH = 200

export (float) var MAX_SCALE = 0.9
export (float) var MIN_SCALE_LIMIT = 0.4


#Permanent varibles 
var Player : PackedScene
var MainPlayer : RigidBody2D
var ProjectileScene : PackedScene
var Projectile : Node2D
var LeftPlayer : RigidBody2D
var FollowNode : Node2D
var previous_player : RigidBody2D
var launch_direction :Vector2
var prepare_launch : bool = false
var initial_scale :float 

#tempvariables
var initial_point : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	Player = preload("res://Scenes//Player.tscn")
	MainPlayer = $Player
	FollowNode = MainPlayer.get_node("Node2D")
	ProjectileScene = preload("res://Scenes//LaunchSprite.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("aim"):
		print("creating")
		prepareLaunch(delta)
		
		
	if Input.is_action_pressed("aim"):
		charge(delta)	
	
	if (Input.is_action_just_released("aim") && prepare_launch):
		launch()
		
	
	pass


func prepareLaunch(delta =1):
	
	FollowNode  = MainPlayer.get_node("Node2D")
	initial_scale = FollowNode.scale.x
	if (FollowNode.scale.x < MIN_SCALE_LIMIT):
		prepare_launch =false
		return
	initial_point = get_node("Camera2D").get_local_mouse_position()
	prepare_launch =true
	Projectile = ProjectileScene.instance()
	Projectile.scale = Vector2(0,0)
	FollowNode.get_node("Position2D").add_child(Projectile)
	Projectile.global_position = FollowNode.get_node("Position2D").global_position
	pass

func launch():
	print("Launching")
	if Projectile.scale.x *FollowNode.scale.x < MIN_SCALE:
		Projectile.queue_free()
		return
	
	previous_player = MainPlayer
	previous_player.start_timers()
	var launch_power  = POWER_RATIO  * previous_player.mass
	print("launch power : " + String(launch_power))
	previous_player.set_process(false)
	previous_player.set_physics_process(false)
	MainPlayer = Player.instance()
	
	MainPlayer.global_position = Projectile.global_position
	get_tree().get_root().add_child(MainPlayer)
	get_tree().get_root().move_child(MainPlayer,0)
	MainPlayer.change_scale(Projectile.scale*initial_scale)
	var impulse_direction = (FollowNode.get_node("Position2D").global_position - FollowNode.global_position ).normalized()
	MainPlayer.apply_central_impulse(impulse_direction * launch_power / MainPlayer.mass)
	previous_player.apply_central_impulse(-1*impulse_direction * launch_power/ (1.6 -MainPlayer.mass))
	Projectile.queue_free()
	prepare_launch =false
	$Camera2D.player = MainPlayer
	get_node("Camera2D/TextureRect").stop_change_color()
	pass

func charge(delta =1 ):
	if(!prepare_launch || FollowNode == null):
		return
	launch_direction  = get_node("Camera2D").get_local_mouse_position() -initial_point
	FollowNode.look_at(launch_direction + FollowNode.global_position)
	if(Projectile.scale.x < MAX_SCALE && Projectile.scale.x * initial_scale < MAX_SCALE):
		Projectile.scale.x += GROWTH*delta
		Projectile.scale.y += GROWTH*delta
		MainPlayer.can_grow=false
		
	if Projectile.scale.x *FollowNode.scale.x  > MIN_SCALE:
		get_node("Camera2D/TextureRect").change_color()
	pass
