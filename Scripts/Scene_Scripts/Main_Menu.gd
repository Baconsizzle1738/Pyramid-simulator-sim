extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_start_button_pressed():
	print("START PRESSED")
	GameData.AUDIO.get_child(0).play()
	get_tree().change_scene_to_file("res://Game_Scenes/Choose_Name.tscn")
	#go to name screen


func _on_quit_button_pressed():
	#exit the game
	GameData.AUDIO.get_child(0).play()
	get_tree().quit()
	
