extends Camera3D 

var whatisheld = []
var held = false

@rpc("any_peer")
func HandleReprentOfPiece(whatisHeld,closest):
	var whatsHeld = whatisHeld

	closest = get_tree().get_nodes_in_group("GameGrid")[int(String(closest)) - 1]

	whatsHeld = get_tree().get_nodes_in_group("GameGrid")[int(String(whatisHeld)) - 1].find_child("GamePiece")

	#clear ovccupied and accupied by
	GlobalVariables.occupied[str(whatsHeld.get_meta("BelongsTo"))] = ' '
	GlobalVariables.occupiedBy[str(whatsHeld.get_meta("BelongsTo"))] = ' '
	
	#if not clear then need to eat | eating function
	print("lookinforthis ",GlobalVariables.occupied)
	if GlobalVariables.occupied[closest.name] != ' ':
		print(closest.name," IS PREGNONT ",GlobalVariables.occupied[closest.name])
		print(GlobalVariables.occupiedBy[closest.name].global_position)
		GlobalVariables.occupiedBy[closest.name].global_position = closest.global_position + Vector3(0,-3,0)
	
	#set ovccupied and accupiedby to updated stuff
	print(closest," ",closest.name)
	print("SHLOP ",GlobalVariables.occupied)
	GlobalVariables.occupied[closest.name] = whatsHeld.get_meta("Type")
	GlobalVariables.occupiedBy[closest.name] = whatsHeld

	#update piece metadata to reflect position
	whatsHeld.set_meta("BelongsTo",closest.name)
	whatsHeld.set_meta("Moves",whatsHeld.get_meta("Moves")+1)
	
	#set piece position to new position
	whatsHeld.global_position = closest.global_position + Vector3(0,3,0)
	pass

func ClearSelectables():
	print("CLEAR!")
	for i in range(1,64):
		GlobalVariables.status[str(i)] = false


func _input(event): #drag game piece
	#when mouse if clicked
	if held == false and Input.is_action_pressed("LeftMouse"):
		held = true
		#check if raycase succsessfull and hit a gamepiece
		if _raycast(false) != null and _raycast(false).get_parent().name == "GamePiece":
			whatisheld = [_raycast(false)]

			if whatisheld[0].get_parent().name == "GamePiece":
				##_ set location of game piece to cursor
				while Input.is_action_pressed("LeftMouse"):
					#print("AHHHHH",_raycast(true),whatisheld) #DEBUG
					if _raycast(true) != null:
						whatisheld[0].get_parent().global_position = _raycast(true)
					await get_tree().create_timer(0.001).timeout
				## find closest clear grid spot
				var closest = ClosestFromArray(whatisheld[0],get_tree().get_nodes_in_group("FreeGameGrid"))
				#if targeting a different square than current one
				if closest.name != whatisheld[0].get_parent().get_meta("BelongsTo"):
					rpc("HandleReprentOfPiece",whatisheld[0].get_parent().get_parent().name,closest.name)
					HandleReprentOfPiece(whatisheld[0].get_parent().get_parent().name,closest.name)
				#set global position of gamepiece
				whatisheld[0].get_parent().global_position = closest.global_position + Vector3(0,3,0) #happens in closest now
		held = false
		whatisheld = []
		ClearSelectables()

func ClosestFromArray(object,array):
	var mostFar = 999
	var isClosest
	for i in array:
		if object.global_position.distance_to(i.global_position) < mostFar:
			mostFar = object.global_position.distance_to(i.global_position) 
			isClosest = i
	return isClosest


func _raycast(PosOrCollide): #false returns collider, true returns position
	var camera = get_tree().get_nodes_in_group("Camera")[0]
	var mousePos = get_viewport().get_mouse_position()
	var rayLength = 100
	var from = camera.project_ray_origin(mousePos)
	var to = from + camera.project_ray_normal(mousePos) * rayLength
	var space = get_world_3d().direct_space_state
	var rayQuery = PhysicsRayQueryParameters3D.new()

	rayQuery.exclude = whatisheld
	rayQuery.from = from
	rayQuery.to = to
	rayQuery.collide_with_areas = true
	var result = space.intersect_ray(rayQuery)
	if result.size() > 1:
		if PosOrCollide == true:
			return result.position
		if PosOrCollide == false:
			return result.collider




func _on_board_multiplayer_spawned(node):
	pass # Replace with function body.
