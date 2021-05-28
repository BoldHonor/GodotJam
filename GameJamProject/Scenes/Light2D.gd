extends Light2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sprite : AnimatedSprite 

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite =$AnimatedSprite
	pass # Replace with function body.

func play():
	self.visible =true
	sprite.playing =true

func stop():
	self.visible=false
	sprite.playing =false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
