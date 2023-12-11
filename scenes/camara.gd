extends Camera2D

@onready var timer = $Timer
@onready var fuegos = $Fuegos


var speed = 30

func _process(delta):
	self.position.x += speed * delta
	
func _ready():
	timer.timeout.connect(boss_fight)

func boss_fight():
	fuegos.queue_free()
