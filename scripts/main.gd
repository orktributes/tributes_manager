extends Control

func _ready() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(6969, 20)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_player_connected)
func _process(delta: float) -> void:
	pass

func _on_player_connected():
	print("ff")
