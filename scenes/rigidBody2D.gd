extends RigidBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(true)

func _process(delta: float) -> void:
	applied_force = Vector2(0, -1) * weight * 10
	pass
