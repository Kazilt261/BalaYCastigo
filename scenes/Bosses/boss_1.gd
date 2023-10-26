extends CharacterBody2D

var speedx = 100
var speedy = 0
var acceleration = 10000

@onready var animation_player = $AnimationPlayer
@onready var frente = $Pivot/Frente
@onready var node_2d = $Pivot/Node2D
@onready var pivot = $Pivot
@onready var abajo = $Pivot/Abajo
@onready var timer = $Timer
@onready var attack = $Pivot/HitBox/attack
@onready var sprite_2d = $Pivot/Node2D/Sprite2D
@onready var collision_shape_2d_2 = $CollisionShape2D2
@onready var hit_box = $Pivot/HitBox
@onready var boss_bar = $CanvasLayer/MarginContainer/BossBar

@export var win_scene: PackedScene
var is_attacking = false
var out_car = false
var is_death = false
var is_hurt = false
var max_health = 100
var health = 100:
	set(value):
		health = clamp(value, 0, max_health)
		if(boss_bar):
			boss_bar.value = health
		if health == 0:
			if out_car:
				animation_player.play("death")
			else:
				if pivot.scale.x > 0:
					animation_player.play("bajarse")
				elif pivot.scale.x < 0:
					animation_player.play("other_bajarse")
				
func _ready()-> void:
	health = max_health
	
func _physics_process(delta):
	
	if out_car:
		if is_hurt or is_attacking:
			pass
		else:
			if frente.is_colliding():
				pivot.scale.x *= -1
				collision_shape_2d_2.position.x *= -1
				speedy = randf_range(200,400)
			elif abajo.is_colliding():
				pivot.scale.y *= -1
				node_2d.scale.y *= -1
				hit_box.scale.y *= -1
			else:
				velocity.x = move_toward(velocity.x, -pivot.scale.x * speedx/2, acceleration * delta)
				velocity.y = move_toward(velocity.y, pivot.scale.y * speedy/5, acceleration * delta)
				animation_player.play("walk")
			move_and_slide()
	else:
		if is_hurt or is_attacking:
			pass
		else:
			if frente.is_colliding():
				pivot.scale.x *= -1
				collision_shape_2d_2.position.x *= -1
				speedy = randf_range(100,200)
			elif abajo.is_colliding():
				pivot.scale.y *= -1
				node_2d.scale.y *= -1
				hit_box.scale.y *= -1
			else:
				velocity.x = move_toward(velocity.x, -pivot.scale.x * speedx, acceleration * delta)
				velocity.y = move_toward(velocity.y, pivot.scale.y * speedy, acceleration * delta)
				animation_player.play("run")
			move_and_slide()
	
func _on_body_entered_boss(body: Node):
	if out_car:
		if body.has_method("sufrir_daño"):
			body.sufrir_daño(30)
	if not out_car:
		if body.has_method("sufrir_daño"):
			body.sufrir_daño(30)
		
func take_damage(damage):
	if health != 0:
		is_hurt = true
		if out_car:
			animation_player.play("hurt2")
		else:
			animation_player.play("hurt")
		health -= damage

func attacking():
	if health != 0 and out_car:
		is_attacking = true
		animation_player.play("attack")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()
		get_tree().change_scene_to_packed(win_scene)
	elif anim_name == "bajarse" or anim_name == "other_bajarse":
		out_car = true
		is_hurt = false
		health = max_health
	else:
		if anim_name == "attack":
			is_attacking = false
			is_hurt = false
			timer.start(randf_range(1,2))
		if anim_name == "hurt2" or anim_name == "hurt":
			is_hurt = false
			is_attacking = false
