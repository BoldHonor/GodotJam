extends Area2D

export (int) var damage = 5

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Node2D_body_entered(body):
	
	pass # Replace with function body.


func _on_Node2D_body_shape_entered(body_id, body, body_shape, local_shape):
	if(body.collision_layer == 16384):
		body.take_damage(damage)
	pass # Replace with function body.


func _on_Node2D_area_entered(area):
	var body = area.get_parent()
	if(body.collision_layer == 16384):
		body.take_damage(damage)
	pass # Replace with function body.
