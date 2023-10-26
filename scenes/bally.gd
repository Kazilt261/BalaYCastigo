extends CharacterBody2D

@export var speed = 80

var acceleration = 1000
var gravity = 400
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot: Node2D = $Pivot
@onready var cheese_spawn: Marker2D = $Pivot/CheeseSpawn
@onready var timer = $Timer
@export var cheese_scene: PackedScene
@onready var health_bar = $CanvasLayer/GUI/HealthBar

@export var gameOver_scene: PackedScene

var is_hurt = false
var count = 0
var damage = 50
var is_alive = true
var max_health = 100
var health = 100:
	set(value):
		health = clamp(value, 0, max_health)
		if(health_bar):
			health_bar.value = health
		if health == 0:
			is_alive = false
			animation_tree.active = false
			animation_player.play("death")
			
		


func _ready() -> void:
	health = max_health
	animation_tree.active = true
	Game.enemy_kill.connect(on_enemy_kill)


func _physics_process(delta: float) -> void:
	var movex_input = Input.get_axis("move_left", "move_right")
	var movey_input = Input.get_axis("move_up", "move_down")
	if is_hurt:
		pass
	elif is_alive:
		if (Input.is_action_pressed("move_left") and (Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"))):
			velocity.x = move_toward(velocity.x, speed * movex_input/1.41421356237, acceleration * delta)
			velocity.y = move_toward(velocity.y, speed * movey_input/1.41421356237, acceleration * delta)
		if (Input.is_action_pressed("move_right") and (Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"))):
			velocity.x = move_toward(velocity.x, speed * movex_input/1.41421356237, acceleration * delta)
			velocity.y = move_toward(velocity.y, speed * movey_input/1.41421356237, acceleration * delta)
		else:
			velocity.x = move_toward(velocity.x, speed * movex_input, acceleration * delta)
			velocity.y = move_toward(velocity.y, speed * movey_input, acceleration * delta)
		
		move_and_slide()
	
		if Input.is_action_just_pressed("click_left"):
			timer.wait_time = clamp(timer.wait_time - 0.1, 0.1, 1)
		if Input.is_action_just_pressed("click_right"):
			timer.wait_time = clamp(timer.wait_time + 0.1, 0.1, 1)
		# animation	
	
		if velocity.x != 0:
			pivot.scale.x = sign(velocity.x)
			
		
		if abs(velocity.x) > 10 or movex_input or abs(velocity.y) > 10 or movey_input:
			playback.travel("run")
		else:
			playback.travel("idle")
		


func fire():
	var cheese = cheese_scene.instantiate()
	get_parent().add_child(cheese)
	cheese.global_position = cheese_spawn.global_position
	cheese.damage = damage
	cheese.scale.x = pivot.scale.x

func on_enemy_kill():
	if damage != 1:
		damage /= 2
	else:
		damage = 1

	
func sufrir_daño(daño):
	is_hurt = true
	animation_player.play("hurt")
	health -= daño

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death": 
		get_tree().change_scene_to_packed(gameOver_scene)
	else:
		if anim_name == "hurt":
			is_hurt = false
