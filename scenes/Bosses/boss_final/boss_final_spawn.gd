extends Node2D

@export var boss_scene: PackedScene
@onready var spawn = $Node2D/spawn
@onready var ray_cast_2d = $Pivot/RayCast2D
@onready var timer_erase = $TimerErase

var speedx = 30
var speedy = 0

func _process(delta):
	self.position.x += speedx * delta



func spawn_boss():
	var boss = boss_scene.instantiate()
	get_parent().add_child(boss)
	boss.global_position = spawn.global_position

func erase():
	speedx = 0
	speedy = 0
