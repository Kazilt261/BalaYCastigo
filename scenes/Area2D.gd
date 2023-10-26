extends Area2D

@onready var area_2d = $"."
@onready var camara = $".."

# Called when the node enters the scene tree for the first time.
func _on_CameraArea_body_exited(body: Node2D):
	if body.is_in_group("enemies"):
		if body.health != 0:
			body.queue_free()

func free_enemies():
	for body in area_2d.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			camara.speed = 0
			body.take_damage(body.health)
		
	
