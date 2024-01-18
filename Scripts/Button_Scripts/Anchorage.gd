extends "res://Scripts/Basic_City_Data.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	population = 287125
	HQBaseCost = population * HQ_COST_MULT


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
