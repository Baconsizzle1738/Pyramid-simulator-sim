extends Node2D

const eventResource = preload("res://Game_Scenes/Popups/Events/Event_Base.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var lose = eventResource.instantiate()
	lose.setTitle("Ringleader Captured")
	lose.setImage("res://Assets/Background/lose.png")
	lose.setArticle("After many weeks, the FBI has finally caught the ringleader of the now infamous pyramid scheme "+GameData.playerName+". They are now in the custody of the FBI and will most likely face prison time due to the mountain of evidence against them.")
	lose.setButtonText("Well shit")
	self.add_child(lose)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_to_menu_pressed():
	GameData.AUDIO.get_child(0).play()
	get_tree().change_scene_to_file("res://Game_Scenes/Main_Menu.tscn")
