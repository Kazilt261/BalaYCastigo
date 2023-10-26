extends StaticBody2D


var speed = 0

func _process(delta):
	self.position.x += speed * delta
