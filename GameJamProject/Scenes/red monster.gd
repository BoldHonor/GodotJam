extends Enemy


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (Vector2) var initial_point
export (Vector2) var final_point
export (int) var MOVEMENT_SPEED_ENEMY = 3000

export (int)var threshold =0.05


# Called when the node enters the scene tree for the first time.
func _ready():
	initial_point = self.global_position
	final_point =initial_point +final_point
	health_bar= $HealthBar
	health_bar.value = health
	pass # Replace with function body.


func die():
	queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if health <= 0:
		var anim = $AnimatedSprite
		anim.animation = "Death"
		anim.connect("animation_finished",self,"die")
		pass
	if(abs((final_point - self.global_position).length())  < threshold  ):
		var  temp = final_point
		final_point = initial_point
		initial_point =temp
		
	self.move_and_slide((final_point - initial_point).normalized() * MOVEMENT_SPEED_ENEMY*delta)
	pass


func _on_Area2D_body_entered(body):
	if(body.collision_layer == 16384):
		give_damage(body)
	elif (body.damage != null):
		take_damage(body.damage)
	pass # Replace with function body.
	
	

