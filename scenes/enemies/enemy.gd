extends CharacterBody2D

var speed
var acceleration = 50000

@onready var animation_player = $AnimationPlayer
@onready var pivot = $Pivot
@onready var hit_box = $HitBox
@onready var enemy_health_bar = $EnemyHealthBar
@onready var sprite_2d = $Pivot/Sprite2D
@onready var timer = $Timer
@onready var abajo = $Abajo

var is_hurt = false
var is_attacking = false
var max_health = 50
var health = 50:
	set(value):
		health = clamp(value, 0, max_health)
		if(enemy_health_bar):
			enemy_health_bar.value = health
		if health == 0:
			animation_player.play("death")
			
func _ready():
	health = max_health
	hit_box.body_entered.connect(_on_body_entered_enemy)
	timer.timeout.connect(attacking)

func _physics_process(delta):
	if is_attacking or is_hurt:
		pass
	else:
		if abajo.is_colliding():
			sprite_2d.scale.y *= -1
			pivot.scale.y *= -1
			abajo.target_position.y *= -1
		
		else:
			speed = randf_range(60,120)
			velocity.x = move_toward(velocity.x, -pivot.scale.x * speed/10, acceleration * delta)
			velocity.y = move_toward(velocity.y, pivot.scale.y * speed, acceleration * delta)
			animation_player.play("walk")
		
		move_and_slide()
		
func _on_body_entered_enemy(body: Node):
	if body.has_method("sufrir_daño"):
		body.sufrir_daño(10)

func attacking():
	if health != 0:
		is_attacking = true
		animation_player.play("attack")
	
func take_damage(damage):
	if health != 0:
		is_hurt = true
		is_attacking = false
		animation_player.play("hurt")
		health -= damage

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death": 
		queue_free()
	else:
		if anim_name == "attack":
			is_attacking = false
			is_hurt = false
			timer.start(randf_range(1,2))
		if anim_name == "hurt":
			is_hurt = false
			is_attacking = false
			timer.start()
	
#randf_range(1,2)
