extends Node2D


#Permanent varibles 
var Player : PackedScene
var MainPlayer : RigidBody2D
var ProjectileScene : PackedScene
var Projectile : Node2D
var LeftPlayer : RigidBody2D
var FollowNode : Node2D
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
		prepareLaunch()
		
		
	if Input.is_action_pressed("aim"):
		FollowNode.look_at(get_global_mouse_position())
		
	pass


func prepareLaunch():
	Projectile = ProjectileScene.instance()
	FollowNode = MainPlayer.get_node("Node2D")
	
	FollowNode.get_node("Position2D").add_child(Projectile)
	
	Projectile.global_position = FollowNode.get_node("Position2D").global_position
	
	
	pass
