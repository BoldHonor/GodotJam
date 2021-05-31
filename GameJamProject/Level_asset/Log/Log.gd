extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (bool) var breakable= false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if !breakable:
		return
	if body.collision_layer != 16384:
		return
	
	if body.linear_velocity.length() > 500 && ((global_position-body.global_position)).normalized().dot(body.linear_velocity.normalized()) > 0.8:
			queue_free()
	pass # Replace with function body.
