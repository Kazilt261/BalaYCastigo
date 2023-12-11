extends CharacterBody2D

var speedy = 30
var acceleration = 10000
var damage = 50
@onready var animation_player = $AnimationPlayer
@onready var pivot = $Pivot
@onready var timer = $Timer
@onready var attack = $HitBox/attack
@onready var collision_shape_2d_2 = $CollisionShape2D
@onready var boss_bar = $CanvasLayer/MarginContainer/BossBar
@onready var abajo = $Pivot/Abajo
@onready var arriba = $Pivot/Arriba
@onready var node_2d = $Pivot/Node2D
@onready var spawn = $Spawn
@onready var spawn_2 = $Spawn2
@export var bala: Array[PackedScene]
@export var win_scene: PackedScene
@onready var hit_box = $HitBox

var is_attacking = false
var healing = false
var is_death = false
var is_on = false
var is_halflife = false
var max_health = 250
var health = 250:
	set(value):
		health = clamp(value, 0, max_health)
		if(boss_bar):
			boss_bar.value = health
		if health <= float(max_health) / 2 and not is_halflife:
			is_halflife = true
			animation_player.play("reduced_hp")
		if health == 0:
			animation_player.play("death")
				
func _ready():
	health = max_health
	hit_box.body_entered.connect(_on_body_entered_boss)
	timer.timeout.connect(attacking)
	
	
func _physics_process(delta):
	if health == 0:
		return
	if is_attacking:
		pass
	else:
		if is_on:
			if abajo.is_colliding():
				abajo.position.y *= -1
				pivot.scale.y *= -1
				node_2d.scale.y *= -1
			else:
				velocity.y = move_toward(velocity.y, pivot.scale.y * speedy, acceleration * delta)
				if animation_player.current_animation != "reduced_hp":
					animation_player.play("run")
					move_and_slide()
		else:
			animation_player.play("encenderse")

	
func _on_body_entered_boss(body: Node):
	if body.has_method("sufrir_daño"):
		body.sufrir_daño(30)
		
func take_damage(damage_suffered):
	Debug.dprint("A")
	if healing:
		if health != 0:
			health += damage_suffered
	else:
		if health != 0:
			health -= damage_suffered

func shot():
	if health != 0:
		var balasL = bala[0].instantiate()
		get_parent().add_child(balasL)
		balasL.global_position = spawn.global_position
		balasL.scale.x = pivot.scale.x
		var balasR = bala[0].instantiate()
		get_parent().add_child(balasR)
		balasR.global_position = spawn_2.global_position
		balasR.scale.x = pivot.scale.x
		
func shot2():
	if health != 0:
		for i in range(4):
			var balasL = bala[1].instantiate()
			get_parent().add_child(balasL)
			balasL.global_position = spawn.global_position
			balasL.scale.x = pivot.scale.x

			var balasR = bala[1].instantiate()
			get_parent().add_child(balasR)
			balasR.global_position = spawn_2.global_position
			balasR.scale.x = pivot.scale.x
			await get_tree().create_timer(0.1).timeout

func heal():
	healing = true
func un_heal():
	healing = false
	
func attacking():
	if health != 0:
		if not is_halflife:
			var a = randi() % 2
			if a == 1:
				is_attacking = true
				animation_player.play("attack")
			if a == 0:
				is_attacking = true
				animation_player.play("attack2")
		if is_halflife:
			var a =  randi() % 3
			if a == 2:
				is_attacking = true
				animation_player.play("shield")
			if a == 1:
				is_attacking = true
				animation_player.play("attack")
			if a == 0:
				is_attacking = true
				animation_player.play("attack2")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()
		get_tree().change_scene_to_packed(win_scene)
	if anim_name == "attack2" or anim_name == "attack" or anim_name == "shield":
		is_attacking = false
		timer.start()
	if anim_name == "encenderse":
		is_on = true
	if anim_name == "reduced_hp":
		is_attacking = false
		is_halflife = true
		timer.start()
		speedy*=2
	
