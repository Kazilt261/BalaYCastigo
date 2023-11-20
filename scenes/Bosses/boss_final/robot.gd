extends CharacterBody2D

var speedx = 0
var speedy = 60
var acceleration = 10000

@onready var animation_player = $AnimationPlayer
@onready var pivot = $Pivot
@onready var timer = $Timer
@onready var attack = $Pivot/HitBox/attack
@onready var collision_shape_2d_2 = $CollisionShape2D
@onready var hit_box = $Pivot/HitBox
@onready var boss_bar = $CanvasLayer/MarginContainer/BossBar
@onready var abajo = $Pivot/Abajo
@onready var node_2d = $Pivot/Node2D

@export var win_scene: PackedScene

var is_attacking = false
var is_death = false
var is_on = false
var is_halflife = false
var max_health = 100
var health = 100:
	set(value):
		health = clamp(value, 0, max_health)
		if(boss_bar):
			boss_bar.value = health
		if health == max_health/2:
			Debug.dprint("B")
			animation_player.play("reduced_hp")
		if health == 0:
			Debug.dprint("A")
			animation_player.play("death")
				
func _ready()-> void:
	health = max_health
	hit_box.body_entered.connect(_on_body_entered_boss)
	timer.timeout.connect(attacking)
	
func _physics_process(delta):
	if health == 0:
		return
	if is_attacking or is_halflife:
		pass
	else:
		if is_on:
			if abajo.is_colliding():
				pivot.scale.y *= -1
				abajo.scale.y *= 0.5
				node_2d.scale.y *= -1
				hit_box.scale.y *= -1
			else:
				velocity.x = move_toward(velocity.x, -pivot.scale.x * speedx/2, acceleration * delta)
				velocity.y = move_toward(velocity.y, pivot.scale.y * speedy/5, acceleration * delta)
				animation_player.play("run")
				move_and_slide()
		else:
			animation_player.play("encenderse")

	
func _on_body_entered_boss(body: Node):
	if body.has_method("sufrir_daño"):
		body.sufrir_daño(30)
		
func take_damage(damage):
	if health != 0:
		health -= damage

func attacking():
	if health != 0:
		is_attacking = true
		var tween = create_tween()
		animation_player.play("attack")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()
		get_tree().change_scene_to_packed(win_scene)
	if anim_name == "attack":
		is_attacking = false
		timer.start(randf_range(1,2))
	if anim_name == "encenderse":
		is_on = true
	if anim_name == "reduced_hp":
		is_attacking = false
		is_halflife = true
		speedx*=2
		speedy*=2
	
