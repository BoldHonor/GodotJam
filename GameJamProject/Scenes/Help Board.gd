extends Node2D

enum Tutorial {SHOOT_OFFSPRING, STACKING, HIT_ENEMIES}
export  (Tutorial) var teach =  0
var animations = []
var instructions = []

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var offspring_animation = $shootOfspring
	var stacking_animation = $stacking
	var hit_animation = $hitEnemies
	animations.append_array([offspring_animation,stacking_animation,hit_animation])
	instructions.append_array([$instruction,$instruction2,$instruction3])
	instructions[teach].visible =true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	animations[teach].visible =true
	animations[teach].playing =true
	instructions[teach].visible =false
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	animations[teach].visible =!true
	animations[teach].playing =!true
	instructions[teach].visible =!false
	pass # Replace with function body.
