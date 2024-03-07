extends Node

var PiecesDictionary = {
	#black---
	"r": "res://Assets/BlackRook.tscn",#black rook
	"b": "res://Assets/BlackBishop.tscn",#black bishop
	"n": "res://Assets/BlackKnight.tscn",#black knight
	"q": "res://Assets/BlackQueen.tscn",#black queen
	"k": "res://Assets/BlackKing.tscn",#black king
	"p": "res://Assets/BlackPawn.tscn",#black pawn
	"m": "res://Assets/BlackChecker.tscn",#BlackChecker Board
	#white---
	"R": "res://Assets/WhiteRook.tscn",#white rook
	"B": "res://Assets/WhiteBishop.tscn",#white bishop
	"N": "res://Assets/WhiteKnight.tscn",#white knight
	"Q": "res://Assets/WhiteQueen.tscn",#white queen
	"K": "res://Assets/WhiteKing.tscn",#white king
	"P": "res://Assets/WhitePawn.tscn",#white pawn
	"M": "res://Assets/whiteChecker.tscn"#WhiteCheckers Pieces
}

var status = {
	1: false,
	2: false,
	3: false,
	4: false,
	5: false,
	6: false,
	7: false,
	8: false,
	9: false,
	10: false,
	11: false,
	12: false,
	13: false,
	14: false,
	15: false,
	16: false,
	17: false,
	18: false,
	19: false,
	20: false,
	21: false,
	22: false,
	23: false,
	24: false,
	25: false,
	26: false,
	27: false,
	28: false,
	29: false,
	30: false,
	31: false,
	32: false,
	33: false,
	34: false,
	35: false,
	36: false,
	37: false,
	38: false,
	39: false,
	40: false,
	41: false,
	42: false,
	43: false,
	44: false,
	45: false,
	46: false,
	47: false,
	48: false,
	49: false,
	50: false,
	51: false,
	52: false,
	53: false,
	54: false,
	55: false,
	56: false,
	57: false,
	58: false,
	59: false,
	60: false,
	61: false,
	62: false,
	63: false,
	64: false
}

var occupied = {
}

var occupiedBy = {
}
var globalPieces = {
	
}
var globalBoardCubes = {
	
}

var GlobalTurn = "White"
