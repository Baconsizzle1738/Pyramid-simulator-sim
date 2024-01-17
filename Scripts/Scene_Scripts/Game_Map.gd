extends Node2D

var frameOneLoad = false


var choosing = true
var showing_popup = false

var legit = 75
var cash = 1000000.0
var FBIsus = 0

@onready var PacificIDX
@onready var NorthernRockiesIDX
@onready var SouthwestIDX
@onready var NorthernPlainsIDX
@onready var SouthernPlainsIDX
@onready var GulfCoastIDX
@onready var MidwestIDX
@onready var AppalachiaIDX
@onready var SouthAtlanticIDX
@onready var NorthAtlanticIDX
@onready var NewEnglandIDX


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
	if !frameOneLoad:
		PacificIDX = $PacificWindow.get_index()
		NorthernRockiesIDX = $NorthernRockiesWindow.get_index()
		SouthwestIDX = $SouthwestWindow.get_index()
		NorthernPlainsIDX = $NorthernPlainsWindow.get_index()
		SouthernPlainsIDX = $SouthernPlainsWindow.get_index()
		GulfCoastIDX = $GulfCoastWindow.get_index()
		MidwestIDX = $MidwestWindow.get_index()
		AppalachiaIDX = $AppalachiaWindow.get_index()
		SouthAtlanticIDX = $SouthAtlanticWindow.get_index()
		NorthAtlanticIDX = $NorthAtlanticWindow.get_index()
		NewEnglandIDX = $NewEnglandWindow.get_index()
		
		#print(PacificIndex)
		frameOneLoad = true
	
	#other stuff


#window closing stuff
func _on_pacific_window_close_requested():
	$PacificWindow.visible = false
	$PacificRegionSelectable.exists = false

func _on_northern_rockies_window_close_requested():
	$NorthernRockiesWindow.visible = false
	$NorthernRockiesSelectable.exists = false

func _on_southwest_window_close_requested():
	$SouthwestWindow.visible = false
	$SouthwestSelectable.exists = false

func _on_northern_plains_window_close_requested():
	$NorthernPlainsWindow.visible = false
	$NorthernPlainsSelectable.exists = false

func _on_southern_plains_window_close_requested():
	$SouthernPlainsWindow.visible = false
	$SouthernPlainsSelectable.exists = false

func _on_gulf_coast_window_close_requested():
	$GulfCoastWindow.visible = false
	$GulfCoastSelectable.exists = false

func _on_midwest_window_close_requested():
	$MidwestWindow.visible = false
	$MidwestSelectable.exists = false

func _on_appalachia_window_close_requested():
	$AppalachiaWindow.visible = false
	$AppalachiaSelectable.exists = false

func _on_south_atlantic_window_close_requested():
	$SouthAtlanticWindow.visible = false
	$SouthAtlanticSelectable.exists = false

func _on_north_atlantic_window_close_requested():
	$NorthAtlanticWindow.visible = false
	$NorthAtlanticSelectable.exists = false

func _on_new_england_window_close_requested():
	$NewEnglandWindow.visible = false
	$NewEnglandSelectable.exists = false
