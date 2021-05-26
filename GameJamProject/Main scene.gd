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

var prepare_launch : bool = false

#tempvariables
var initial_point : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	Player = preload("res://Player.tscn")
	MainPlayer = $Player
	FollowNode = MainPlayer.get_node("Node2D")
	ProjectileScene = preload("res://LaunchSprite.tscn")
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
	print(FollowNode.scale.x)
	if (FollowNode.scale.x < MIN_SCALE_LIMIT):
		prepare_launch =false
		return
	initial_point = get_global_mouse_position()
	prepare_launch =true
	Projectile = ProjectileScene.instance()
	FollowNode = MainPlayer.get_node("Node2D")
	Projectile.scale = Vector2(0,0)*FollowNode.scale 
	FollowNode.get_node("Position2D").add_child(Projectile)
	Projectile.global_position = FollowNode.get_node("Position2D").global_position
	pass

func launch():
	print("Launching")
	if Projectile.scale.x < MIN_SCALE:
		Projectile.queue_free()
		return
	var launch_power  = (get_global_mouse_position()-initial_point).length() * POWER_RATIO
	if(previous_player != null):
		previous_player.collision_layer = 1
	previous_player = MainPlayer
	previous_player.set_process(false)
	previous_player.set_physics_process(false)
	MainPlayer = Player.instance()
	for i in MainPlayer.get_children():
		if i.get_class() != "Timer":
			i.scale = i.scale * Projectile.scale
	MainPlayer.global_position = Projectile.global_position
	get_tree().get_root().add_child(MainPlayer)
	get_tree().get_root().move_child(MainPlayer,0)
	MainPlayer.change_scale(Projectile.scale)
	var impulse_direction = (FollowNode.get_node("Position2D").global_position - FollowNode.global_position ).normalized()
	MainPlayer.apply_central_impulse(impulse_direction * launch_power)
	previous_player.apply_central_impulse(-1*impulse_direction * launch_power)
	Projectile.queue_free()
	prepare_launch =false
	pass

func charge(delta =1 ):
	if(!prepare_launch || FollowNode == null):
		return
	FollowNode.look_at((get_global_mouse_position() - initial_point).normalized() + FollowNode.global_position)
	if(Projectile.scale.x < MAX_SCALE*FollowNode.scale.x):
		Projectile.scale.x += GROWTH*delta
		Projectile.scale.y += GROWTH*delta
	pass
