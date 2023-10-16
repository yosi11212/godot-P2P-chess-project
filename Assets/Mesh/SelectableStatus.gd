extends Node3D



# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVariables.status[self.name] = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVariables.status[self.name] == true: 
		$selected.visible = true
	else: 
		$selected.visible = false
	pass


func _on_rigid_body_3d_mouse_entered():
	GlobalVariables.status[self.name] = true
	pass # Replace with function body.
	


func _on_rigid_body_3d_mouse_exited():
	GlobalVariables.status[self.name] = false
	pass # Replace with function body.
