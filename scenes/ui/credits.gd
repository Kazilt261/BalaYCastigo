extends MarginContainer

@onready var menu: Button = %Menu

# Called when the node enters the scene tree for the first time.
func _ready():
	menu.pressed.connect(_menu_pressed)

func _menu_pressed():
	LevelManager.go_to_main_menu()
	
func _process(delta):
	pass
