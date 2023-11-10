extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var dron = $"."

func _ready():
	# Iniciar la animación de correr indefinidamente
	animation_player.play("run")

