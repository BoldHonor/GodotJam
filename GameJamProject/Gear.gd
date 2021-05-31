extends Node2D


export (int) var part_number=1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	tween = $Tween
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.collision_layer != 16384:
		return
	body.parts.append(part_number)
	tween.interpolate_property($AnimatedSprite,"scale",$AnimatedSprite.scale,Vector2(0,0),1,Tween.TRANS_LINEAR)
	tween.start()
	$gear1.visible = false
	
	pass # Replace with function body.


func _on_Tween_tween_completed(object, key):
	queue_free()
	pass # Replace with function body.
