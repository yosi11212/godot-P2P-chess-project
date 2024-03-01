extends Control

var host = ENetMultiplayerPeer.new()
var ip = "127.0.0.1"



func join_room():
	ip = $IPAddress.text
	host.create_client(ip,6969)
	multiplayer.set_multiplayer_peer(host)
	await get_tree().create_timer(0.001).timeout #wait
	$Panel/ChatInput.text = "JOINED GAME"
	send_message()

func send_message():
	var message = $Panel/ChatInput.text
	var id = multiplayer.get_unique_id()
	rpc("recieve_message",id,message)
	$Panel/ChatLog.text += str(id) + ": " + message + "\n"
	$Panel/ChatInput.text = ''


@rpc("any_peer")	
func recieve_message(id,message):
	$Panel/ChatLog.text += str(id) + ": " + message + "\n"
	if message[0] == '%':
		print("WOW!!!")
		#DetectObjectClicked.HandleReprentOfPiece(message)



func _on_join_room_pressed():
	join_room()
	rpc("recieve_message","New User","JOIND THE GAME")
	pass # Replace with function body.

func _on_chat_input_text_submitted(new_text):
	send_message()
	pass # Replace with function body.

