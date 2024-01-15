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
	print($Player_Name.get_text())
	get_tree().change_scene_to_file("res://Game_Scenes/Game_Map.tscn")
