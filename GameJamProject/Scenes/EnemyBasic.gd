extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
class_name Enemy

var health = 100
var damage = 10
var health_bar :TextureProgress

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func give_damage(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		
func take_damage(dam):
	health = health - dam
	health_bar.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
