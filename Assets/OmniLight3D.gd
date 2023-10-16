extends OmniLight3D
var _colorr = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	light_color = Color.from_ok_hsl(_colorr, 1, 0.5, 1)
	_colorr -= 0.005
	if _colorr < 0:
		_colorr  = 1
	#print(light_color)
	pass
