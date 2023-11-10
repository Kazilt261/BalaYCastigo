extends Node2D

@export var enemy_scenes: Array[PackedScene]
@onready var spawn = $Node2D/spawn
@onready var timer_spawn = $TimerSpawn
@onready var timer_erase = $TimerErase
@onready var ray_cast_2d = $Pivot/RayCast2D
@onready var pivot = $Pivot

var speedx = 30
var speedy = 30

func _process(delta):
	self.position.x += speedx * delta
	self.position.y += speedy * delta
	if ray_cast_2d.is_colliding():
			pivot.scale.y *= -1
			speedy *= -1

func spawn_enemy():
	var random_index = randi() % enemy_scenes.size()
	var enemy_scene = enemy_scenes[random_index]
	var enemy = enemy_scene.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = spawn.global_position
	

func erase():
	queue_free()
