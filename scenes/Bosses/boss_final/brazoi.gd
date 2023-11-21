extends Node2D

@onready var brazo_i = $BrazoI
@onready var dron = $Dron
@onready var timer = $Timer
@onready var robot_animation = $".."

signal brazo_complete

func _ready():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(-20, -12), 4)
	tween.tween_property(dron, "position", Vector2(10, robot_animation.dron_last), 1)
	tween.finished.connect(func(): brazo_complete.emit())
	
func _on_timer_timeout():
	dron.queue_free()
	#brazo_i.queue_free()
