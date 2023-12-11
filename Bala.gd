extends Area2D

@export var speed = 200
var damage = 25

func _ready():
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float):
	position += transform.x * -speed * delta

func _on_body_entered(body: Node2D):
	queue_free()
	if body.has_method("sufrir_daño"):
		if body.health <= damage:
			Game.enemy_kill.emit()
			body.sufrir_daño(damage)
		else:
			body.sufrir_daño(damage)
