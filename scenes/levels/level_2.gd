extends Node2D

@onready var boss_1_spawn = $Boss1Spawn
@onready var boss_1_spawn_2 = $Boss1Spawn2

func _ready():
	boss_1_spawn.spawn_complete.connect(func(): boss_1_spawn_2.spawn_boss())
