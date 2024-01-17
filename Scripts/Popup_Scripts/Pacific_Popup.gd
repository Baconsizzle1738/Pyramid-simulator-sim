extends Control

@export var group: ButtonGroup

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in group.get_buttons():
		i.connect("pressed", button_pressed) #connect all buttons to the buttons_pressed() func

func button_pressed():
	print(group.get_pressed_button().get_name())
	$Data/SelectedCity.text = "Selected: "+group.get_pressed_button().get_name()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
