extends Node2D

@onready var pecho = $Pecho
@onready var dron = $Dron
@onready var timer = $Timer
@onready var robot_animation = $".."

func _ready():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(2, -18), 3)
	tween.tween_property(dron, "position", Vector2(10, robot_animation.dron_last), 1)

func _on_timer_timeout():
	dron.queue_free()
	#pecho.queue_free()
