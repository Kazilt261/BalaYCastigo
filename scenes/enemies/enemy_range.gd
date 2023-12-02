extends CharacterBody2D

var speed = 0
var acceleration = 50000

@export var bullet: PackedScene
@onready var marker_2d = $Pivot/Marker2D
@onready var marker_2d_2 = $Pivot/Marker2D2
@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer
@onready var pivot = $Pivot

var is_attacking = false
var is_hurt = false
var max_health = 100
var health = 100:
	set(value):
		health = clamp(value, 0, max_health)
		if health == 0:
			animation_player.play("death")
			
func _physics_process(delta):
	if is_attacking or is_hurt:
		pass
	else:
		velocity.x = move_toward(velocity.x, -pivot.scale.x * speed/10, acceleration * delta)
		animation_player.play("walk")
		
		move_and_slide()
func shooting():
	is_attacking = true
	animation_player.play("shot")
	
func take_damage(damage):
	if health != 0:
		is_hurt = true
		is_attacking = false
		animation_player.play("hurt")
		health -= damage
		
func fire():
	if not bullet: 
		return
	var bulletL = bullet.instantiate()
	get_parent().add_child(bulletL)
	bulletL.global_position = marker_2d.global_position
	bulletL.global_rotation = marker_2d.global_rotation
	var bulletR = bullet.instantiate()
	get_parent().add_child(bulletR)
	bulletR.global_position = marker_2d_2.global_position
	bulletR.global_rotation = marker_2d_2.global_rotation

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death": 
		queue_free()
	else:
		if anim_name == "shot":
			is_attacking = false
			is_hurt = false
			timer.start(randf_range(1,2))
		if anim_name == "hurt":
			is_hurt = false
			is_attacking = false
			timer.start()
