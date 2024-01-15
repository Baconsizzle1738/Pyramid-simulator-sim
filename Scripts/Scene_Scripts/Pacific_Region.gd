extends Node2D

#see if the mouse is hovering over the area selected
var mouseHovering = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_mouse_entered():
	mouseHovering = true
	$PacificRegion.frame = 0
	#print("IN")


func _on_area_2d_mouse_exited():
	mouseHovering = false
	$PacificRegion.frame = 1
	#print("OUT")


func _on_area_2d_input_event(viewport, event, shape_idx):
	#event.button_index == MOUSE_BUTTON_LEFT
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and mouseHovering:
		print("CLICKED")
