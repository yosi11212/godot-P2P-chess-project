extends Control

var count = 0;
var IsWhiteBool = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var WGridBlock = load("res://Assets/Mesh/WhiteBoardGridPiece.tscn")
var BGridBlock = load("res://Assets/Mesh/BlackBoardGridPiece.tscn")

#/ translate chess standard notation FEN to game board
func PieceGenerator(input): #rnbqkbnrpppppppp8888PPPPPPPPRNBQKBNR
	var output = ""
	for _i in input:
		var flag = true
		if _i == '/':
			flag = false
		if int(_i) > 0 and int(_i) < 9:
			flag = false
			for n in int(_i): output += ' '
		if flag: output += _i
	return output

func CreateBoard(FEN):
	var mone = 1
	var x = -21
	var z = -21
	for o in 8:
		x = -21
		for n in 8:
			IsWhiteBool = false
			if ((n + o) % 2) == 0: IsWhiteBool = true
			var newInstance = WGridBlock.instantiate()
			if !IsWhiteBool:
				newInstance = BGridBlock.instantiate()

			print("x:" + str(x) +" z:" +  str(z)+ " piece:" +  $LineEdit.text[n])
			newInstance.position.x = x
			newInstance.position.z = z
			newInstance.name = str(mone)
			newInstance.set_meta("Piece",FEN[mone-1]) #what the piece is supposed to be
			$Board.add_child(newInstance)
			x += 6
			mone += 1
		z += 6
	pass

func SetPieces():
	var GridBlocks = get_tree().get_nodes_in_group("GameGrid")
	print(GridBlocks)
	for block in GridBlocks:
		var piece = block.get_meta("Piece")
		print(str(block) + block.get_meta("Piece"))
		GlobalVariables.occupied[str(block.name)] = block.get_meta("Piece")
		if block.get_meta("Piece") != ' ':
			await get_tree().create_timer(0.03).timeout
			var newInstance = load(GlobalVariables.PiecesDictionary[block.get_meta("Piece")]).instantiate()
			newInstance.position.x = block.position.x / 1300
			newInstance.position.z = block.position.z / 1300
			newInstance.name = "GamePiece"
			newInstance.set_meta("BelongsTo",block.name)
			newInstance.set_meta("Type",block.get_meta("Piece"))
			newInstance.set_meta("Moves",0)
			block.add_child(newInstance)

		
		
	pass

func _on_button_pressed(): 
	var pieceInstruction = PieceGenerator($LineEdit.text)
	print(PieceGenerator($LineEdit.text))
	CreateBoard(pieceInstruction)
	SetPieces()
	pass # Replace with function body.

func _on_use_recommended_pressed(): #FEN of standard chess game
	$LineEdit.text = "rnbqkbnrpppppppp8888PPPPPPPPRNBQKBNR"
	pass # Replace with function body.
