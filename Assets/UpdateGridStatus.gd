extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func updatePosition(Position):
	self.get_global_position()
pass

func _on_rigid_body_3d_mouse_entered():
	print("bogos binted")
	#GlobalVariables.status[self.get_meta("BelongsTo")] = true
	MovesCalculator.calcuateMove(self.get_meta("Type"),self.get_meta("BelongsTo"),self.get_meta("Moves"),true)
	pass # Replace with function body.


func _on_rigid_body_3d_mouse_exited():
	#GlobalVariables.status[self.get_meta("BelongsTo")] = false
	MovesCalculator.calcuateMove(self.get_meta("Type"),self.get_meta("BelongsTo"),self.get_meta("Moves"),false)
	print("leftMe")
	pass # Replace with function body.


func _on_child_entered_tree(node):
	if node.name == "GamePiece":
		node.global_position = self.global_position + Vector3(0,3,0)
	pass # Replace with function body.

