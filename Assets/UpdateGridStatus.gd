extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rigid_body_3d_mouse_entered():
	#GlobalVariables.status[self.get_meta("BelongsTo")] = true
	MovesCalculator.calcuateMove(self.get_meta("Type"),self.get_meta("BelongsTo"),self.get_meta("Moves"),true)
	pass # Replace with function body.


func _on_rigid_body_3d_mouse_exited():
	#GlobalVariables.status[self.get_meta("BelongsTo")] = false
	MovesCalculator.calcuateMove(self.get_meta("Type"),self.get_meta("BelongsTo"),self.get_meta("Moves"),false)
	pass # Replace with function body.
