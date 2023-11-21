extends Node2D

@onready var brazo_i = $brazoI

var dron_last = -150
 
signal complete
# Called when the node enters the scene tree for the first time.
func _ready():
	brazo_i.brazo_complete.connect(brazo_completed)
	

func brazo_completed(): 
	complete.emit()
	queue_free()
