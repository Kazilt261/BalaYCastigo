extends MarginContainer

@onready var start: Button = %Start
@onready var exit: Button = %Exit
@onready var credits: Button = %Credits

func _ready():
	start.pressed.connect(_on_start_pressed)
	exit.pressed.connect(_on_exit_pressed)
	credits.pressed.connect(_on_credits_pressed)

func _on_start_pressed():
	LevelManager.start_game()


func _on_exit_pressed():
	Debug.dprint("A")
	get_tree().quit()

func _on_credits_pressed():
	LevelManager.go_to_credits()
