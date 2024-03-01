extends Node3D

var whites = ['P','R','Q','K','B','N','W']
var blacks = ['p','r','q','k','b','n','BL']

func isClear(lookingfor,atlocation):
	print(atlocation," at Is:",GlobalVariables.occupied[str(atlocation)])
	if lookingfor == 'O': #checking for movement, color doesnt matter
		if GlobalVariables.occupied[str(atlocation)] != ' ' :
			return false
	if lookingfor == 'BL':
		if blacks.has(GlobalVariables.occupied[str(atlocation)]):
			return false
	if lookingfor == 'W':
		if whites.has(GlobalVariables.occupied[str(atlocation)]):
			return false

	return true

func ifIsClearStatus(lookingfor,atlocation,status):
	if isClear(lookingfor,atlocation):
		GlobalVariables.status[str(atlocation)] = status
	pass

var stopAtLeft = [1,9,17,25,33,41,49,57]
var rightBoundaries = [64,56,48,40,32,24,16,8]

func _recursevlyDiagonal(lookingfor,position,direction,status):
	var antiLookingFor = ' '
	if lookingfor in whites: 
		lookingfor = 'W'
		antiLookingFor = 'BL'
	if lookingfor in blacks: 
		lookingfor = 'BL'
		antiLookingFor = 'W'
	#up rights
	if direction == "upL"  and position > 8 and !(position in stopAtLeft):
		if isClear('O',position - 9):
			GlobalVariables.status[str(position - 9)] = status
			_recursevlyDiagonal(lookingfor,position -9,direction,status)
		else:
			print("toggle " ,lookingfor)
			ifIsClearStatus(lookingfor,position - 9, status)
	
	if direction == "upR" and position % 8 != 0 and position > 8:
		if isClear('O',position - 7) :
			GlobalVariables.status[str(position - 7)] = status
			_recursevlyDiagonal(lookingfor,position -7,direction,status)
		else:
			print("toggle " ,lookingfor)
			ifIsClearStatus(lookingfor,position - 7, status)
	if direction == "downR" and position % 8 !=0 and position < 56:#crashes
		if isClear('O',position + 9) :
			GlobalVariables.status[str(position + 9)] = status
			_recursevlyDiagonal(lookingfor,position + 9,direction,status)
		else:
			print("toggle " ,lookingfor)
			ifIsClearStatus(lookingfor,position + 9, status)
	var blockedLeftDown = [1,9,17,25,33,41,49,57]
	if direction == "downL" and !(position in blockedLeftDown) and position < 56:#crashes
		if isClear('O',position + 7) :
			GlobalVariables.status[str(position + 7)] = status
			_recursevlyDiagonal(lookingfor,position + 7,direction,status)
		else:
			print("toggle " ,lookingfor)
			ifIsClearStatus(lookingfor,position + 7, status)
pass

func _recursevlyStraight(lookingfor,position,direction,status):
	print(lookingfor,position,direction,status,"check")
	var antiLookingFor = ''
	if lookingfor in whites: 
		lookingfor = 'W'
		antiLookingFor = 'BL'
	if lookingfor in blacks: 
		lookingfor = 'BL'
		antiLookingFor = 'W'
	
	if direction == 'U' and position > 8:
		if isClear('O',position - 8):
			GlobalVariables.status[str(position - 8)] = status
			_recursevlyStraight(lookingfor,position -8,direction,status)
		else:
			print("toggle uP;" ,lookingfor)
			ifIsClearStatus(lookingfor,position - 8, status)
	if direction == 'D' and position < 57:
		if isClear('O',position + 8):
			GlobalVariables.status[str(position + 8)] = status
			_recursevlyStraight(lookingfor,position +8,direction,status)
		else:
			print("toggle  D :" ,lookingfor)
			ifIsClearStatus(lookingfor,position + 8, status)

	if direction == 'R' and position % 8 != 0:
		if isClear('O',position + 1):
			GlobalVariables.status[str(position + 1)] = status
			_recursevlyStraight(lookingfor,position +1,direction,status)
		else:
			print("toggle " ,lookingfor)
			ifIsClearStatus(lookingfor,position + 1, status)
	
	if direction == 'L' and !(position in stopAtLeft):
		if isClear('O',position - 1):
			GlobalVariables.status[str(position - 1)] = status
			_recursevlyStraight(lookingfor,position - 1,direction,status)
		else:
			print("toggle " ,lookingfor)
			ifIsClearStatus(lookingfor,position - 1, status)
	pass

func calcuateMove(type, position, moves ,status):
	print("SCREAM ECHO")
	print(type," ", position, " ", moves ," ", status)
	position = int(str(position)) 
	GlobalVariables.status[str(position)] = status
	
	
	if type == 'q' or type == 'Q':#queen
		if !(position < 8): #calculate towards black
			_recursevlyStraight(type,position,'U',status)#look up if space
		if !(position > 56):
			_recursevlyStraight(type,position,'D',status)#look down if space
		if (position % 8 > 0):
			_recursevlyStraight(type,position,'R',status)#look right if space
		if !(position in stopAtLeft):
			_recursevlyStraight(type,position,'L',status)#look left if space
		_recursevlyDiagonal(type,position,'upL',status)
		_recursevlyDiagonal(type,position,'upR',status)
		_recursevlyDiagonal(type,position,'downR',status)
		_recursevlyDiagonal(type,position,'downL',status)
	
	
	if type == 'P':#white pawn
		
		if position > 8:
			if isClear('O',position - 8): #movement
				GlobalVariables.status[str(position - 8)] = status
				if moves == 0 && isClear('O',position - 16):
					GlobalVariables.status[str(position - 16)] = status
			if position % 8 != 0 and !isClear('BL',position -7):
				GlobalVariables.status[str(position - 7)] = status
			if position > 9:
				if !isClear('BL',position -9):
					GlobalVariables.status[str(position - 9)] = status
			
	if type == 'p':#black pawn

		if position < 57:
			if isClear('O',position + 8): #movement
				GlobalVariables.status[str(position + 8)] = status
				if moves == 0 && isClear('O',position + 16):
					GlobalVariables.status[str(position + 16)] = status
			if !isClear('W',position +7):
				GlobalVariables.status[str(position + 7)] = status
			if position % 8 != 0 and !isClear('W',position +9):
				GlobalVariables.status[str(position + 9)] = status
	
	if type == 'R' or type == 'r':#white rook

		if !(position < 8): #calculate towards black
			_recursevlyStraight(type,position,'U',status)#look up if space
		if !(position > 56):
			_recursevlyStraight(type,position,'D',status)#look down if space
		if (position % 8 > 0):
			_recursevlyStraight(type,position,'R',status)#look right if space
		if !(position in stopAtLeft):
			_recursevlyStraight(type,position,'L',status)#look left if space
	
	if type == 'b' or type == 'B':#bishop

		print('bishop slay detected')
		_recursevlyDiagonal(type,position,'upL',status)
		_recursevlyDiagonal(type,position,'upR',status)
		_recursevlyDiagonal(type,position,'downR',status)
		_recursevlyDiagonal(type,position,'downL',status)
		
	if type == 'K' or type == 'k':#king
		var colortype = "BL"
		if type == 'K': colortype = 'W'
		if position >= 8:#king movement up
			if isClear(colortype,position -8):
				GlobalVariables.status[str(position - 8)] = status
		if position <= 56:#king movement down
				if isClear(colortype,position +8):
					GlobalVariables.status[str(position + 8)] = status
		if !(position in stopAtLeft):#king movement left
				if isClear(colortype,position -1):
					GlobalVariables.status[str(position - 1)] = status
		if !(position in stopAtLeft) and position >= 8:#king movement left up
				if isClear(colortype,position -9):
					GlobalVariables.status[str(position - 9)] = status
		if !(position in stopAtLeft) and position <= 56:#king movement left up
			if isClear(colortype,position + 9):
				GlobalVariables.status[str(position + 9)] = status
		if !(position in rightBoundaries) and position >= 8:#king movement right up
				if isClear(colortype,position - 7):
					GlobalVariables.status[str(position - 7)] = status
		if !(position in rightBoundaries) and position <= 56:#king movement left down
				if isClear(colortype,position + 7):
					GlobalVariables.status[str(position + 7)] = status
		if !(position in rightBoundaries):#king movement right
				if isClear(colortype,position +1):
					GlobalVariables.status[str(position + 1)] = status
	
	if type == 'n' or type == 'N':
		var colortype = "BL"
		if type == 'N': colortype = 'W'
		if position % 8 != 0 and position > 16: #night up right
			if isClear(colortype,position - 15):
				GlobalVariables.status[str(position - 15)] = status
		
		if position % 8 != 1 and position > 16:#night up left
			if isClear(colortype,position - 17):
				GlobalVariables.status[str(position - 17)] = status
				
		if (position % 8 != 7 and position % 8 != 0) and position > 8:#night left up
			if isClear(colortype,position - 6):
				GlobalVariables.status[str(position - 6)] = status
		
		if (position % 8 != 1 and position % 8 != 2) and position > 8:#night right up
			if isClear(colortype,position - 10):
				GlobalVariables.status[str(position - 10)] = status
		
		if position % 8 != 0 and position < 56:#right night down
			if isClear(colortype,position + 10):
				GlobalVariables.status[str(position + 10)] = status
		
		if (position % 8 != 1 and position % 8 != 2) and position < 56:#night left down
			if isClear(colortype,position + 6):
				GlobalVariables.status[str(position + 6)] = status
		
		if position % 8 != 0 and position < 48:#night down right
			if isClear(colortype,position + 17):
				GlobalVariables.status[str(position + 17)] = status
		
		if (position % 8 != 1 and position % 8 != 2) and position < 48:
			if isClear(colortype,position + 15):
				GlobalVariables.status[str(position + 15)] = status
	pass
