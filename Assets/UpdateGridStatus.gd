extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var whites = ['P','R','Q','K','B','N','W']
var blacks = ['p','r','q','k','b','n','BL']

func _on_rigid_body_3d_mouse_entered():
	var ownColor = []
	var isAbleToMoveColor = []
	match multiplayer.is_server():
		true:
			ownColor = whites
		false: 
			ownColor = blacks
	if ownColor.has(self.get_meta("Type")):
		isAbleToMoveColor = ownColor
	

	#GlobalVariables.status[self.get_meta("BelongsTo")] = true

	if isAbleToMoveColor == whites and GlobalVariables.GlobalTurn == "White":
		MovesCalculator.calcuateMove(self.get_meta("Type"),self.get_meta("BelongsTo"),self.get_meta("Moves"),true)
	else: if isAbleToMoveColor == blacks and GlobalVariables.GlobalTurn == "Black":
		MovesCalculator.calcuateMove(self.get_meta("Type"),self.get_meta("BelongsTo"),self.get_meta("Moves"),true)
	pass # Replace with function body.



func _on_rigid_body_3d_mouse_exited():
	#GlobalVariables.status[self.get_meta("BelongsTo")] = false
	print(MovesCalculator.calcuateMove(self.get_meta("Type"),self.get_meta("BelongsTo"),self.get_meta("Moves"),false))

	pass # Replace with function body.


func _on_child_entered_tree(node):
	if node.name == "GamePiece":
		node.global_position = self.global_position + Vector3(0,3,0)
	pass # Replace with function body.

