extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player : Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../Player/Node2D")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_instance_valid(player)):
		global_position = player.global_position
	pass
