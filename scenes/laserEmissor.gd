extends RigidBody2D

onready var nRcLaser:RayCast2DLaser = $rcLaser
onready var nLine2D:Line2D = $rcLaser/line2D

func _ready() -> void:
	nRcLaser.bActive = true
