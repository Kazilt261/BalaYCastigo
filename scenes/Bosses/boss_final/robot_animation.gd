extends Node2D

@onready var brazo_i = $brazoI

signal complete
# Called when the node enters the scene tree for the first time.
func _ready():
	brazo_i.brazo_complete.connect(brazo_completed)
	

func brazo_completed(): 
	complete.emit()
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
