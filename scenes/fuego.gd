extends Node2D

@onready var hit_box = $HitBox

func _ready()-> void:
	hit_box.body_entered.connect(_on_body_entered_enemy)
	
func _on_body_entered_enemy(body: Node):
	if body.has_method("sufrir_daño"):
		body.sufrir_daño(10)

