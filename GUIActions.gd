extends Button

var host = ENetMultiplayerPeer.new()
var ip = "127.0.0.1"


func HostMatch_on_pressed():#כפתור יצירת חדר משחק
	self.disabled = true
	$"../JoinMatch".disabled = true
	$"../IPAddress".editable = false
	
	host.create_server(6969,1)
	multiplayer.set_multiplayer_peer(host)
	
	if multiplayer.is_server():
		var board = load("res://Board.tscn").instantiate()
		$"..".add_child(board)
		var GridBlocks = get_tree().get_nodes_in_group("GameGrid")
		for block in GridBlocks:
			GlobalVariables.occupied[str(block.name)] = block.get_meta("Piece")
			if GlobalVariables.occupied[str(block.name)] != ' ':
				GlobalVariables.occupiedBy[str(block.name)] = block.get_child(3)
			else: GlobalVariables.occupiedBy[str(block.name)] = ' '

	pass # Replace with function body.


func JoinMatch_on_pressed():#כפתור כניסה לחדר משחק לפי כתובת אייפי
	$"../HostMatch".disabled = true
	$"../JoinMatch".disabled = true
	$"../IPAddress".editable = false
	
	ip = $"../IPAddress".text #כתובת האייפי שמכניס המשתמש, אליה להתחבר
	host.create_client(ip,6969)
	multiplayer.set_multiplayer_peer(host)
	
	await get_tree().create_timer(0.1).timeout
	
	MoveCamera_on_pressed()#אחראי לשינוי מיקום המצלמה לצד הלוח המתאים
	pass # Replace with function body.

var moved = false
func MoveCamera_on_pressed(): #currently move camera button disabled, uneccessery
	if moved == false:
		$"../../AnimationPlayer".play("MoveCamera")
		moved = true
	else:
		$"../../AnimationPlayer".play_backwards("MoveCamera")
		moved = false
	pass # Replace with function body.


func _on_board_multiplayer_spawned(node):#when board is in scene
	#define global variables on peer client
	var GridBlocks = $"../Board".get_children()
	print("board ",$"../Board".get_children())
	for block in GridBlocks:
		GlobalVariables.occupied[str(block.name)] = block.get_meta("Piece")
		if GlobalVariables.occupied[str(block.name)] != ' ':
			GlobalVariables.occupiedBy[str(block.name)] = block.get_child(3)
		else: GlobalVariables.occupiedBy[str(block.name)] = ' '
	print(GridBlocks)
		
	rpc("updateColor","White")
	updateColor("White")
	
	rpc("ConnectionMade")
	ConnectionMade()
	
	pass # Replace with function body.

@rpc("any_peer")
func updateColor(color):
	GlobalVariables.GlobalTurn = color
	pass

var loadingBar = ["▒▒▒▒▒▒▒▒▒▒","▒▒▒▒▒▒▒▒▒▒","▒▒▒▒▒▒▒▒▒▒","▒▒▒▒▒▒▒▒▒▒","█▒▒▒▒▒▒▒▒▒","██▒▒▒▒▒▒▒▒","███▒▒▒▒▒▒▒","████▒▒▒▒▒▒","█████▒▒▒▒▒","██████▒▒▒▒","███████▒▒▒","████████▒▒","██████████","██████████","██████████","██████████"]

@rpc("any_peer")
func ConnectionMade():
	for load in loadingBar:
		$"../Connection".text = load
		await get_tree().create_timer(0.1).timeout
	$"../Connection".visible = false
	pass

var whites = ['P','R','Q','K','B','N','W']
var blacks = ['p','r','q','k','b','n','BL']

func _on_button_pressed():#show all possible moves of a color
	var checkFor = whites
	match $"../CheckAll".text:
		"BLACK":
			checkFor = blacks
			$"../CheckAll".text = "WHITE"
			GlobalVariables.GlobalTurn = "White"
			print("globl ",GlobalVariables.GlobalTurn)
			
		"WHITE":
			checkFor = whites
			$"../CheckAll".text = "BLACK"
			GlobalVariables.GlobalTurn = "Black"
			print("global ",GlobalVariables.GlobalTurn)
	
	for pawn in GlobalVariables.occupiedBy:
		if typeof(GlobalVariables.occupiedBy[pawn]) == 24 and checkFor.has(GlobalVariables.occupiedBy[pawn].get_meta("Type")):
			var pawnd = GlobalVariables.occupiedBy[pawn]
			print(pawn," ",pawnd," ",pawnd.get_meta_list())
			print(pawnd.get_meta("BelongsTo")," ",pawnd.get_meta("Type")," ",pawnd.get_meta("Moves"))
			MovesCalculator.calcuateMove(pawnd.get_meta("Type"),pawnd.get_meta("BelongsTo"),pawnd.get_meta("Moves"),true)
	pass # Replace with function body.

