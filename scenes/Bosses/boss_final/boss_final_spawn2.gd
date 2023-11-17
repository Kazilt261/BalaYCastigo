extends Node2D

@export var boss_scene: PackedScene
@onready var spawn = $Node2D/spawn

var speedx = 30

func _process(delta):
	self.position.x += speedx * delta



func spawn_boss():
	var boss = boss_scene.instantiate()
	get_parent().add_child(boss)
	boss.global_position = spawn.global_position
	Debug.dprint("A")
