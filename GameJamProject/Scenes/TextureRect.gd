extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var blinking
var tween :Tween
onready var tween_values = [Color(1, 1, 1, 1),Color(0.58, 0.28, 0.28, 1)]
var started : bool =false
# Called when the node enters the scene tree for the first time.
func _ready():
	tween = get_node("Tween")
	
	pass # Replace with function body.

func _process(delta):
	
	pass
	
func change_color():
	if started:
		return
	tween.interpolate_property(self,"modulate",tween_values[0],tween_values[1]	,1,Tween.TRANS_LINEAR)
	tween.start()
	started =true
	pass

func stop_change_color():
	if !started :
		return
	tween.stop_all()
	started=false
	modulate =Color(1,1,1,1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Tween_tween_completed(object, key):
	tween_values.invert()
	tween.interpolate_property(self,"modulate",tween_values[0],tween_values[1]	,1,Tween.TRANS_LINEAR)
	tween.start()
	pass # Replace with function body.
