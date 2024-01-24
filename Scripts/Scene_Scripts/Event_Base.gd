extends Control

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func setImage(path:String) -> void:
	$NinePatchRect/VBoxContainer/Image.texture = load(path)

func setTitle(text:String) -> void:
	$NinePatchRect/VBoxContainer/Title.text = text

func setArticle(text:String) -> void:
	$NinePatchRect/VBoxContainer/Article.text = text

func setButtonText(text:String) -> void:
	$NinePatchRect/VBoxContainer/CloseButton/ButtonText.text = text
