extends ColorRect

var _colorr = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_example_cube_mouse_entered():
	color = Color.from_ok_hsl(_colorr, 1, 0.5, 1)
	_colorr -= 0.2
	if _colorr < 0:
		_colorr  = 1
	pass # Replace with function body.
