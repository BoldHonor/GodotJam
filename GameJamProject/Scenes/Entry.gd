extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var button : TextureButton
var tween :Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	button = $TextureButton
	tween = $TextureButton/Tween
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_button_down():
	print("Starting...")
	tween.interpolate_property(button,"modulate",Color(1,1,1,1),Color(1,1,1,0),1,Tween.TRANS_LINEAR)
	tween.interpolate_property($Camera2D/kKgyw2,"modulate",Color(0.65,0.58,0.58,1),Color(1,1,1,1),1,Tween.TRANS_LINEAR)
	tween.interpolate_property($text845,"modulate",Color(1,1,1,0),Color(1,1,1,1),1,Tween.TRANS_LINEAR)
	tween.start()
	$"spaceship-01 (1)/AnimationPlayer".current_animation = "float"
		
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Tutorial.tscn")
	pass # Replace with function body.
