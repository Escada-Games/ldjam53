extends Area2D

func _ready() -> void:
	if get_parent() is RigidBody2D:
		var nColShape2D = $collisionShape2D.duplicate()
		get_parent().add_child(nColShape2D)
