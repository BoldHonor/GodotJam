extends RigidBody2D


#Predefined Variables


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_up"):
		print("jump")
		apply_central_impulse(Vector2(0,-80))
	
	pass
