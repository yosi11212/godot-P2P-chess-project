extends Node3D



# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVariables.status[self.name] = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GlobalVariables.status[self.name] == true: 
		self.add_to_group("FreeGameGrid")
		$selected.visible = true
	else: 
		$selected.visible = false
		self.remove_from_group("FreeGameGrid")
	pass


func _on_rigid_body_3d_mouse_entered():
	GlobalVariables.status[self.name] = true
	pass # Replace with function body.
	


func _on_rigid_body_3d_mouse_exited():
	GlobalVariables.status[self.name] = false
	pass # Replace with function body.


func _on_child_order_changed():
	#for i in range(1,64):
		#GlobalVariables.status[str(i)] = false
	#GlobalVariables.status[self.name] = true
	#if $GamePiece: GlobalVariables.occupied[self.name] = $GamePiece.get_meta("Type")
	#else: GlobalVariables.occupied[self.name] = ' '
	pass # Replace with function body.
