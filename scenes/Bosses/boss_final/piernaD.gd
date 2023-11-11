extends Node2D

@onready var dron = $Dron
@onready var timer = $Timer
@onready var pierna_l = $PiernaL

func _ready():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(9, -4), 2)
	tween.tween_property(dron, "position", Vector2(10, -100), 1)

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	dron.queue_free()
	#pierna_l.queue_free()