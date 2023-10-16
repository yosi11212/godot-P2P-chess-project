extends Camera3D 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#recognise what object is being hovered on
	var hoveringObject = _raycast()
	if hoveringObject != null :
		print(hoveringObject)
		var parent = hoveringObject.get_parent()
		#var parentmaterial = parent.find_children('',"MeshInstance3D")[0]
		if parent is MeshInstance3D or Node3D :
			print(parent)
			if parent.get_meta("Piece") != null: print(parent.get_meta("Piece"))
		#	print(parent.material_override.albedo_color) #Color(0,0,0,0)

		
		

	pass

func _raycast():
	var camera = get_tree().get_nodes_in_group("Camera")[0]
	var mousePos = get_viewport().get_mouse_position()
	var rayLength = 100
	var from = camera.project_ray_origin(mousePos)
	var to = from + camera.project_ray_normal(mousePos) * rayLength
	var space = get_world_3d().direct_space_state
	var rayQuery = PhysicsRayQueryParameters3D.new()
	rayQuery.from = from
	rayQuery.to = to
	rayQuery.collide_with_areas = true
	var result = space.intersect_ray(rayQuery)
	if result.size() > 1:
		return result.collider

