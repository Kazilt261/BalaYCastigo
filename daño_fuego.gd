extends Node2D

@onready var hit_box = $HitBox
@onready var timer = $Timer

var player
func _ready():
	hit_box.body_entered.connect(_on_body_entered_enemy)
	hit_box.body_exited.connect(_on_body_exited_enemy_body)
	timer.timeout.connect(_fire_timer)
	
func _on_body_entered_enemy(body: Node):
	timer.start()
	if body.has_method("sufrir_daño"):
		player = body
		
func _on_body_exited_enemy_body(body: Node):
	timer.stop()

func _fire_timer():
	if player:
		player.sufrir_daño(10)

