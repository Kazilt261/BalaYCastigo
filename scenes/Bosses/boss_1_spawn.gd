extends Node2D

@export var boss_scene: PackedScene
@onready var spawn = $Node2D/spawn
@onready var ray_cast_2d = $Pivot/RayCast2D
@onready var pivot = $Pivot

var speedy = 30

func _process(delta):
	self.position.y += speedy * delta
	if ray_cast_2d.is_colliding():
			pivot.scale.y *= -1
			speedy *= -1


func spawn_boss():
	var boss = boss_scene.instantiate()
	get_parent().add_child(boss)
	boss.global_position = spawn.global_position
