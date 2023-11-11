extends Node2D

@onready var pecho = $Pecho
@onready var dron = $Dron
@onready var timer = $Timer

func _ready():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(2, -18), 3)
	tween.tween_property(dron, "position", Vector2(10, -100), 1)

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	dron.queue_free()
	#pecho.queue_free()
