extends Node2D

@export var boss_scene: PackedScene
@onready var spawn = $Node2D/spawn
@onready var timer = $Timer


signal spawn_complete

var speedx = 30

func _process(delta):
	self.position.x += speedx * delta

func _ready():
	timer.timeout.connect(spawn_boss)

func spawn_boss():
	var boss = boss_scene.instantiate()
	boss.complete.connect(on_animation_complete)
	get_parent().add_child(boss)
	boss.global_position = spawn.global_position
	
func on_animation_complete():
	spawn_complete.emit()
	queue_free()
	
func erase():
	speedx = 0
