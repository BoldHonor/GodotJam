extends Node2D


#predefines 
export (float) var POWER_RATIO =0.5
export (float) var MIN_SCALE = 0.6
export (float) var GROWTH = 1.06

export (float) var MAX_SCALE = 0.9

#Permanent varibles 
var Player : PackedScene
var MainPlayer : RigidBody2D
var ProjectileScene : PackedScene
var Projectile : Node2D
var LeftPlayer : RigidBody2D
var FollowNode : Node2D

var prepare_launch : bool = false

#tempvariables
var initial_point : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	Player = preload("res://Player.tscn")
	MainPlayer = $Player
	ProjectileScene = preload("res://LaunchSprite.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("aim"):
		print("creating")
		prepareLaunch(delta)
		
		
	if Input.is_action_pressed("aim"):
		charge()	
	
	if (Input.is_action_just_released("aim") && prepare_launch):
		launch()
		
	pass


func prepareLaunch(delta =1):
	initial_point = get_global_mouse_position()
	prepare_launch =true
	Projectile = ProjectileScene.instance()
	Projectile.scale = Vector2(MIN_SCALE,MIN_SCALE)
	FollowNode = MainPlayer.get_node("Node2D")
	FollowNode.get_node("Position2D").add_child(Projectile)
	Projectile.global_position = FollowNode.get_node("Position2D").global_position
	pass

func launch():
	print("Launching")
	var launch_power  = (get_global_mouse_position()-initial_point).length() * POWER_RATIO
	var previous_player = MainPlayer
	previous_player.set_process(false)
	previous_player.set_physics_process(false)
	MainPlayer = Player.instance()
	MainPlayer.global_position = Projectile.global_position
	get_tree().get_root().add_child(MainPlayer)
	get_tree().get_root().move_child(MainPlayer,0)
	MainPlayer.apply_central_impulse(( FollowNode.get_node("Position2D").global_position - FollowNode.global_position ).normalized() * launch_power)
	Projectile.queue_free()
	pass

func charge(delta =1 ):
	FollowNode.look_at(get_global_mouse_position())
	if(Projectile.scale.x < MAX_SCALE):
		Projectile.scale.x *= GROWTH*delta
		Projectile.scale.y *= GROWTH*delta
	pass
