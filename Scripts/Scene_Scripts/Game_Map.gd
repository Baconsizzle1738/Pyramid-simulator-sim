extends Node2D

var choosing = true
var showing_popup = false

var legit = 75
var cash = 1000000.0
var FBIsus = 0

func reset():
	choosing = true
	showing_popup = false
	legit = 75
	cash = 1000000.0
	FBIsus = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pacific_window_close_requested():
	$PacificWindow.visible = false
	$PacificRegionSelectable.exists = false
