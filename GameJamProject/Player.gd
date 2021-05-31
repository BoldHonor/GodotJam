extends RigidBody2D


#Predefined Variables
export (Vector2) var JUMP_IMPULSE =Vector2(0,-80)
export (Vector2) var JUMP_IMPULSE_FIXED =Vector2(0,-9000)
export (Vector2) var RUN_IMPULSE = Vector2(9000,0)
export (int) var MAX_VELOCITY =20
export (float) var MASS_GROWTH_RATE =0.003
export (float) var MASS_GROWTH = 1.5


var is_change_scale:bool = false

var change_value :Vector2 
var can_move_left :bool =true
var can_move_right :bool =true
var can_jump :bool =true
var can_grow :bool =false
var jump_timer :Timer
var move_right_timer :Timer
var move_left_timer :Timer
var ref_node :Node2D
var area :Area2D

onready var tween_values = [Color(1,1,1, 1),Color(0.54, 0.21, 0.12, 1)]


#player properties 
var health = 100 
var damage =40

var keys =[]
var parts =[]

# Called when the node enters the scene tree for the first time.
func _ready():
	jump_timer =$JumpTmer
	move_left_timer =$MoveLeftTimer
	move_right_timer =$MoveRightTimer
	ref_node =$Node2D
	area =$Area2D
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if area.get_overlapping_bodies().size() >0:
		can_grow =true
	
	
	
	pass
	
func _physics_process(delta):
	 
	
	var speed = linear_velocity.length()
	if Input.is_action_pressed("ui_up") && can_grow &&  can_jump && speed < MAX_VELOCITY:
		print("jump")
		jump_timer.start()
		can_jump =false
		apply_central_impulse(JUMP_IMPULSE_FIXED + JUMP_IMPULSE *mass)
	if Input.is_action_pressed("ui_right") && can_move_right && speed < MAX_VELOCITY && can_grow:
		can_move_right =false
		move_right_timer.start()
		apply_central_impulse(RUN_IMPULSE*mass)
	if Input.is_action_pressed("ui_left") && can_move_left && speed < MAX_VELOCITY && can_grow:
		can_move_left =false
		move_left_timer.start()
		apply_central_impulse(-1*RUN_IMPULSE * mass)
		
	pass

func _integrate_forces(state):
	if (is_change_scale):
		self.set_scale(change_value)
		mass = mass * change_value.x
		is_change_scale =false
		
	if (abs(linear_velocity.x) != 0 ):
		gain_mass()
		

		

func change_scale(scale_change_value):
	is_change_scale =true
	change_value = scale_change_value
	scale_change_value =scale_change_value/ ref_node.scale.x
	mass = mass*scale_change_value.x
	for i in self.get_children():
		if i.get_class() != "Timer":
			i.scale = i.scale * scale_change_value


func _on_Timer_timeout():
	can_jump =true
	pass 
	
func gain_mass (delta =1):
	if !can_grow || mass >= MASS_GROWTH:
		return
	if ref_node.scale.x > MASS_GROWTH:
		return 
	
	for i in get_children():
		if i.get_class() != "Timer":
			i.scale.x *= 1+MASS_GROWTH_RATE*delta
			i.scale.y *= 1+MASS_GROWTH_RATE*delta
	
	mass = ref_node.scale.x 
		
	pass


func change_size (delta =1,scale_change_value =MASS_GROWTH_RATE):
	for i in get_children():
		if i.get_class() != "Timer":
			i.scale.x += scale_change_value*delta
			i.scale.y += scale_change_value*delta
			

func start_timers():
	$DeathTime.start()
	$SolidifyTime.start()



func _on_SolidifyTime_timeout():
	collision_layer = 512
	pass # Replace with function body.

func start_tween():
	$Sprite.visible =true
	$Sprite/Tween.interpolate_property($Sprite,"modulate",tween_values[0],tween_values[1],1,Tween.TRANS_LINEAR)
	$Sprite/Tween.start()
	
	
func _on_DeathTime_timeout():
	queue_free()
	pass # Replace with function body.


func _on_MoveRightTimer_timeout():
	can_move_right =true
	pass # Replace with function body.


func _on_MoveLeftTimer_timeout():
	can_move_left =true
	pass # Replace with function body.
	
	
func take_damage(dam):
	health = health - dam
	print(health)
	
func accquire_keys(number):
	keys.append(number)
	print(keys)
	
func find_key(number) : 
	return keys.find(number)
	
