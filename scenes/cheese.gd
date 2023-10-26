extends Area2D


@export var speed = 200
var damage 

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_body_entered(body: Node2D):
	queue_free()
	if body.has_method("take_damage"):
		if body.health <= damage:
			Game.enemy_kill.emit()
			body.take_damage(damage)
		else:
			body.take_damage(damage)
