extends AnimatedSprite

func _ready() -> void:
	self.rotation = rand_range(0, 2*PI)
	self.play("default")
	yield(self,"animation_finished")
	self.queue_free()
