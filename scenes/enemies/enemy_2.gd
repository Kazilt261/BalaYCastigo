extends CharacterBody2D

var speed = 30
var acceleration = 50000

@onready var animation_player = $AnimationPlayer
@onready var pivot = $Pivot
@onready var hit_box = $HitBox
@onready var enemy_health_bar = $EnemyHealthBar
@onready var sprite_2d = $Pivot/Sprite2D

var is_hurt = false
var max_health = 50
var health = 50:
	set(value):
		health = clamp(value, 0, max_health)
		if(enemy_health_bar):
			enemy_health_bar.value = health
		if health == 0:
			animation_player.play("death")
			
func _ready()-> void:
	health = max_health
	hit_box.body_entered.connect(_on_body_entered_enemy)

func _physics_process(delta):
	if is_hurt:
		pass
	else:
		velocity.x = move_toward(velocity.x, pivot.scale.x * speed, acceleration * delta)
		animation_player.play("run")
		move_and_slide()
		
func _on_body_entered_enemy(body: Node):
	if body.has_method("sufrir_daño"):
		body.sufrir_daño(10)

	
func take_damage(damage):
	if health != 0:
		is_hurt = true
		animation_player.play("hurt")
		health -= damage

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death": 
		queue_free()
	else:
		if anim_name == "hurt":
			is_hurt = false
	
#randf_range(1,2)

