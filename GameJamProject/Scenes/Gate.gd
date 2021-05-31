extends KinematicBody2D

export (int) var GATE_NUMBER =1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if(body.collision_layer != 16384):
		return
	if body.find_key(GATE_NUMBER) != -1:
		print("opening")
		queue_free()
	print( body.find_key(GATE_NUMBER))
	pass # Replace with function body.
