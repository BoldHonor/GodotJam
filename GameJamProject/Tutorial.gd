extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var enemy : KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy =$RedMonster
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	print("entered")
	print(enemy)
	if(!is_instance_valid(enemy)):
		get_tree().change_scene("res://Scenes/Tile_set.tscn")
	pass # Replace with function body.


func _on_playArea_body_exited(body):
	
	pass # Replace with function body.


func _on_playArea_body_entered(body):
	get_tree().reload_current_scene()
	pass # Replace with function body.
