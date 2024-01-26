extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	#go to the map
	#TODO: make sure the textboxhas a valid name in it and save it to a data file.
	var name = $Player_Name.get_text()
	const ALLOWED = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM0123456789"
	print("r" in ALLOWED)
	var good = true
	for c in name:
		print(c)
		if c not in ALLOWED:
			good = false
			break
	
	if name.length() > 16:
		good = false
	
	if good:
		GameData.playerName = $Player_Name.get_text()
		print(GameData.playerName)
		GameData.AUDIO.get_child(0).play()
		get_tree().change_scene_to_file("res://Game_Scenes/Game_Map.tscn")
		
	else:
		$Warn.visible = true
	#print($Player_Name.get_text())
	
