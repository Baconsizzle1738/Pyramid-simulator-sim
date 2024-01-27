extends "res://Scripts/Basic_City_Data.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	population = 9459000
	HQBaseCost = population * HQ_COST_MULT
	$Name.text = self.get_name()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
