extends Node3D

var whites = ['P','R','Q','K','B','N','W']
var blacks = ['p','r','q','k','b','n','BL']

var arrToStatus = []

func isClear(lookingfor,atlocation):

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

func ifIsClearStatus(lookingfor,atlocation):
	if isClear(lookingfor,atlocation):
		arrToStatus.append(atlocation)
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
			arrToStatus.append(position - 9)
			_recursevlyDiagonal(lookingfor,position -9,direction,status)
		else:

			ifIsClearStatus(lookingfor,position - 9)
	
	if direction == "upR" and position % 8 != 0 and position > 8:
		if isClear('O',position - 7) :
			arrToStatus.append(position - 7)
			_recursevlyDiagonal(lookingfor,position -7,direction,status)
		else:

			ifIsClearStatus(lookingfor,position - 7)
	if direction == "downR" and position % 8 !=0 and position < 56:#crashes
		if isClear('O',position + 9) :
			arrToStatus.append(position + 9)
			_recursevlyDiagonal(lookingfor,position + 9,direction,status)
		else:

			ifIsClearStatus(lookingfor,position + 9)
	var blockedLeftDown = [1,9,17,25,33,41,49,57]
	if direction == "downL" and !(position in blockedLeftDown) and position < 56:#crashes
		if isClear('O',position + 7) :
			arrToStatus.append(position + 7)
			_recursevlyDiagonal(lookingfor,position + 7,direction,status)
		else:

			ifIsClearStatus(lookingfor,position + 7)
pass

func _recursevlyStraight(lookingfor,position,direction,status):

	var antiLookingFor = ''
	if lookingfor in whites: 
		lookingfor = 'W'
		antiLookingFor = 'BL'
	if lookingfor in blacks: 
		lookingfor = 'BL'
		antiLookingFor = 'W'
	
	if direction == 'U' and position > 8:
		if isClear('O',position - 8):
			arrToStatus.append(position - 8)
			_recursevlyStraight(lookingfor,position -8,direction,status)
		else:

			ifIsClearStatus(lookingfor,position - 8)
	if direction == 'D' and position < 57:
		if isClear('O',position + 8):
			arrToStatus.append(position + 8)
			_recursevlyStraight(lookingfor,position +8,direction,status)
		else:

			ifIsClearStatus(lookingfor,position + 8)

	if direction == 'R' and position % 8 != 0:
		if isClear('O',position + 1):
			arrToStatus.append(position + 1)
			_recursevlyStraight(lookingfor,position +1,direction,status)
		else:

			ifIsClearStatus(lookingfor,position + 1)
	
	if direction == 'L' and !(position in stopAtLeft):
		if isClear('O',position - 1):
			arrToStatus.append(position - 1)
			_recursevlyStraight(lookingfor,position - 1,direction,status)
		else:

			ifIsClearStatus(lookingfor,position - 1)
	pass

func arrayToStatus(status):
	for _position in arrToStatus:
		GlobalVariables.status[str(_position)] = status
	pass

func calcuateMove(type, position, moves ,status):
	
	arrToStatus = []
	
	position = int(str(position)) 
	GlobalVariables.status[str(position)] = status
	
	match type:
		'q','Q': #Queens
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
			
		'P':#white pawn
			if position > 8:
				if isClear('O',position - 8): #movement
					arrToStatus.append(position - 8)
					if moves == 0 && isClear('O',position - 16):
						arrToStatus.append(position - 16)
				if position % 8 != 0 and !isClear('BL',position -7):
					arrToStatus.append(position - 7)
				if position > 9:
					if !isClear('BL',position -9):
						arrToStatus.append(position - 9)
				
		'p':#black pawn
			if position < 57:
				if isClear('O',position + 8): #movement
					arrToStatus.append(position + 8)
					if moves == 0 && isClear('O',position + 16):
						arrToStatus.append(position + 16)
				if !isClear('W',position +7):
					arrToStatus.append(position + 7)
				if position % 8 != 0 and !isClear('W',position +9):
					arrToStatus.append(position + 9)
	
		'R','r':#white rook
			if !(position < 8): #calculate towards black
				_recursevlyStraight(type,position,'U',status)#look up if space
			if !(position > 56):
				_recursevlyStraight(type,position,'D',status)#look down if space
			if (position % 8 > 0):
				_recursevlyStraight(type,position,'R',status)#look right if space
			if !(position in stopAtLeft):
				_recursevlyStraight(type,position,'L',status)#look left if space
	
		'b','B':#bishop

			_recursevlyDiagonal(type,position,'upL',status)
			_recursevlyDiagonal(type,position,'upR',status)
			_recursevlyDiagonal(type,position,'downR',status)
			_recursevlyDiagonal(type,position,'downL',status)
		
		'k','K':#king
			var colortype = "BL"
			if type == 'K': colortype = 'W'
			if position >= 8:#king movement up
				if isClear(colortype,position -8):
					arrToStatus.append(position - 8)
			if position <= 56:#king movement down
					if isClear(colortype,position +8):
						arrToStatus.append(position + 8)
			if !(position in stopAtLeft):#king movement left
					if isClear(colortype,position -1):
						arrToStatus.append(position - 1)
			if !(position in stopAtLeft) and position >= 8:#king movement left up
					if isClear(colortype,position -9):
						arrToStatus.append(position - 9)
			if !(position in stopAtLeft) and position <= 56:#king movement left up
				if isClear(colortype,position + 9):
					arrToStatus.append(position + 9)
			if !(position in rightBoundaries) and position >= 8:#king movement right up
					if isClear(colortype,position - 7):
						arrToStatus.append(position - 7)
			if !(position in rightBoundaries) and position <= 56:#king movement left down
					if isClear(colortype,position + 7):
						arrToStatus.append(position + 7)
			if !(position in rightBoundaries):#king movement right
					if isClear(colortype,position +1):
						arrToStatus.append(position + 1)
	
		'n','N': #nights
			var colortype = "BL"
			if type == 'N': colortype = 'W'
			if position % 8 != 0 and position > 16: #night up right
				if isClear(colortype,position - 15):
					arrToStatus.append(position - 15)
			
			if position % 8 != 1 and position > 16:#night up left
				if isClear(colortype,position - 17):
					arrToStatus.append(position - 17)
					
			if (position % 8 != 7 and position % 8 != 0) and position > 8:#night left up
				if isClear(colortype,position - 6):
					arrToStatus.append(position - 6)
			
			if (position % 8 != 1 and position % 8 != 2) and position > 8:#night right up
				if isClear(colortype,position - 10):
					arrToStatus.append(position - 10)
			
			if position % 8 != 0 and position < 55:#right night down
				if isClear(colortype,position + 10):
					arrToStatus.append(position + 10)
			
			if (position % 8 != 1 and position % 8 != 2) and position < 56:#night left down
				if isClear(colortype,position + 6):
					arrToStatus.append(position + 6)
			
			if position % 8 != 0 and position < 48:#night down right
				if isClear(colortype,position + 17):
					arrToStatus.append(position + 17)
			
			if (position % 8 != 1 and position % 8 != 2) and position < 48:
				if isClear(colortype,position + 15):
					arrToStatus.append(position + 15)
	
	arrayToStatus(status) # set all moves to status / active or not
	return arrToStatus
	pass
