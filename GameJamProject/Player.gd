extends RigidBody2D


#Predefined Variables
export (Vector2) var JUMP_IMPULSE =Vector2(0,-3000)
export (Vector2) var RUN_IMPULSE = Vector2(4000,0)
export (int) var MAX_VELOCITY =20


var is_change_scale:bool = false
var change_value :Vector2 
var can_move :bool =true
var timer :Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $Timer
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	 
	
	var speed = linear_velocity.length()
	if Input.is_action_just_pressed("ui_up"):
		print("jump")
		apply_central_impulse(JUMP_IMPULSE *delta)
	if Input.is_action_pressed("ui_right") && can_move && speed < MAX_VELOCITY:
		can_move =false
		timer.start()
		apply_central_impulse(RUN_IMPULSE*delta)
	if Input.is_action_pressed("ui_left") && can_move && speed < MAX_VELOCITY:
		can_move =false
		timer.start()
		apply_central_impulse(-1*RUN_IMPULSE *delta)
		
	pass

func _integrate_forces(state):
	if (is_change_scale):
		self.set_scale(change_value)
		mass = change_value.x
		is_change_scale =false
		

		

func change_scale(scale_change_value):
	is_change_scale =true
	change_value = scale_change_value


func _on_Timer_timeout():
	can_move =true
	pass 
