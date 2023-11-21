extends Node2D

@onready var dron = $Dron
@onready var timer = $Timer
@onready var robot_animation = $".."

func _ready():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(26, -13), 4)
	tween.tween_property(dron, "position", Vector2(10, robot_animation.dron_last), 1)
	
func _on_timer_timeout():
	dron.queue_free()
	#brazo_i.queue_free()
