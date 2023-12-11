extends CanvasLayer

@export var mainMenu: PackedScene

func _on_restart_pressed():
	LevelManager.current_level = 0
	get_tree().change_scene_to_packed(mainMenu)


func _on_quit_pressed():
	get_tree().quit()
