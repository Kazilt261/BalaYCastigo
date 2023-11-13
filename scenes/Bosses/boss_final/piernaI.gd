extends Node2D

@onready var pierna_i = $PiernaI
@onready var dron = $Dron
@onready var timer = $Timer

func _ready():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(-7, -4), 2)
	tween.tween_property(dron, "position", Vector2(10, -100), 1)
	
func _on_timer_timeout():
	dron.queue_free()
	#pierna_i.queue_free()
