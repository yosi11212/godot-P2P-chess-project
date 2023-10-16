extends Node3D

func ifClearCanEat():
	pass



var whites = ['P','R','Q','K','B','N']
var blacks = ['p','r','q','k','b','n']

func isClear(lookingfor,atlocation):
	print(atlocation)
	if lookingfor == 'O': #checking for movement, color doesnt matter
		if GlobalVariables.occupied[str(atlocation)] != ' ':
			return false
	if lookingfor == 'B':
		if blacks.has(GlobalVariables.occupied[str(atlocation)]):
			return false
	if lookingfor == 'W':
		if whites.has(GlobalVariables.occupied[str(atlocation)]):
			return false

	return true



func calcuateMove(type, position, moves ,status):
	print("SCREAM ECHO")
	position = int(str(position)) 
	if type == 'P':#white pawn
			if isClear('O',position - 8): #movement
				GlobalVariables.status[str(position - 8)] = status
				if moves == 0 && isClear('O',position - 16):
					GlobalVariables.status[str(position - 16)] = status
			if position % 8 != 0 and !isClear('B',position -7):
				GlobalVariables.status[str(position - 7)] = status
			if !isClear('B',position -9):
				GlobalVariables.status[str(position - 9)] = status
				
	if type == 'p':#black pawn
			if isClear('O',position + 8): #movement
				GlobalVariables.status[str(position + 8)] = status
				if moves == 0 && isClear('O',position + 16):
					GlobalVariables.status[str(position + 16)] = status
			if !isClear('W',position +7):
				GlobalVariables.status[str(position + 7)] = status
			if position % 8 != 0 and !isClear('W',position +9):
				GlobalVariables.status[str(position + 9)] = status
	pass
