extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (Vector2) var initial_point
export (Vector2) var final_point
export (int) var MOVEMENT_SPEED_PLATFORM = 3000

export (int)var threshold= 0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_point = self.global_position
	final_point =initial_point +final_point
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(abs((final_point - self.global_position).length())  < threshold  ):
		var  temp = final_point
		final_point = initial_point
		initial_point =temp
		
	self.move_and_slide((final_point - initial_point).normalized() * MOVEMENT_SPEED_PLATFORM*delta)
	pass
