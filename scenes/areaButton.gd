extends Area2D

# warning-ignore:unused_signal
signal pressed
# warning-ignore:unused_signal
signal unpressed

export var fRequiredWeight := 25.0
var nBodyPressing:RigidBody2D
var bPressed := false

func _ready() -> void:
	var _v = self.connect("body_entered", self, 'onBodyEnter')
	_v = self.connect("body_exited", self, 'onBodyExit')
	set_process(true)

func onBodyEnter(b:PhysicsBody2D) -> void:
	if b is RigidBody2D:
		nBodyPressing = b
		if nBodyPressing.weight > fRequiredWeight:
			bPressed = true
		
func onBodyExit(b:PhysicsBody2D) -> void:
	if b == nBodyPressing:
		nBodyPressing = null
		bPressed = false
			

func _process(_delta: float) -> void:
	pass
