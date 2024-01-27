extends "res://Scripts/Selectable_Abstract.gd"

#see if the mouse is hovering over the area selected
#var mouseHovering = false
#var exists = false #if the window exists



# Called when the node enters the scene tree for the first time.
func _ready():
	mouseHovering = false
	exists = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !frameOneLoad:
		IDX = get_parent().NorthernRockiesIDX
		frameOneLoad = true


func _on_area_2d_mouse_entered():
	mouseHovering = true
	if !exists:
		$NorthernRockiesRegion.frame = 1


func _on_area_2d_mouse_exited():
	mouseHovering = false
	if !exists:
		$NorthernRockiesRegion.frame = 0


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and mouseHovering and !exists:
		#print("CLICKED")
		#FOR NORTHERN ROCKIES
		GameData.AUDIO.get_child(2).play()
		get_parent().get_child(IDX).visible = true #index is based on where the window node is from "GameMap" node
		exists = true
