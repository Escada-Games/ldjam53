extends Node2D

export var iRepeatOnXEqualTo := 0
export var fSpeed := 120.0
func _ready() -> void:
	set_process(true)

func _process(delta: float) -> void:
	self.position.x -= fSpeed * delta
	if self.position.x <= -iRepeatOnXEqualTo:
		self.position.x = 0
