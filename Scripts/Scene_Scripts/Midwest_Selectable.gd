extends "res://Scripts/Selectable_Abstract.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !frameOneLoad:
		IDX = get_parent().MidwestIDX
		frameOneLoad = true


func _on_area_2d_mouse_entered():
	mouseHovering = true
	if !exists:
		$MidwestRegion.frame = 0


func _on_area_2d_mouse_exited():
	mouseHovering = false
	if !exists:
		$MidwestRegion.frame = 1


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and mouseHovering and !exists:
		#print("CLICKED")
		#FOR MIDWEST
		GameData.AUDIO.get_child(2).play()
		get_parent().get_child(IDX).visible = true #index is based on where the window node is from "GameMap" node
		exists = true
