extends Sprite

export (int) var KeyNumber=1

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
	if (body.collision_layer == 16384):
		body.accquire_keys(KeyNumber)
		queue_free()
		var tween = get_node("../Tween")
		tween.interpolate_property(get_node("../AnimatedSprite"),"scale",get_node("../AnimatedSprite").scale,Vector2(0,0),1,Tween.TRANS_LINEAR)
		tween.start()
	pass # Replace with function body.
