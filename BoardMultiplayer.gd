extends MultiplayerSpawner

#func _on_spawned(node):
	#if node.name == "Board":
		#var GridBlocks = get_tree().get_nodes_in_group("GameGrid")
		#for block in GridBlocks:
			#GlobalVariables.occupied[str(block.name)] = block.get_meta("Piece")
	#pass # Replace with function body.
