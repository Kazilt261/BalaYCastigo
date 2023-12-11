extends Area2D


@export var speed = 100
var damage 

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_body_entered(body: Node2D):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(damage)
		if body.health <= 0:
			Game.enemy_kill.emit()
