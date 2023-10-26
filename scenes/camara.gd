extends Camera2D

var speed = 30

func _process(delta):
	self.position.x += speed * delta
