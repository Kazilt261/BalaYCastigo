extends Area2D

@onready var balas_robot = $".."

@export var speed = 200

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	position -= transform.x * balas_robot.speed * delta
	position -= transform.y * balas_robot.speed * delta


func _on_body_entered(body: Node2D):
	queue_free()
	if body.has_method("sufrir_daño"):
		if body.health <= balas_robot.damage:
			Game.enemy_kill.emit()
			body.sufrir_daño(balas_robot.damage)
		else:
			body.sufrir_daño(balas_robot.damage)
