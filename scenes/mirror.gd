extends RigidBody2DWithSound
class_name Mirror
func get_class(): return "Mirror"

onready var nRcLaser:RayCast2DLaser = $rcLaser
onready var nSolidSides:KinematicBody2D = $solidSides

func _ready() -> void:
	add_collision_exception_with(nSolidSides)
	pass # Replace with function body.

func onLaserHit(vGlobalHitPosition:=Vector2(), vLaserDirection:=Vector2(1,0)) -> bool:
	nRcLaser.bActive = true
	nRcLaser.global_position = vGlobalHitPosition
	nRcLaser.rotation = vLaserDirection.rotated(-PI/2).rotated(self.global_rotation).angle()
	#nRcLaser.rotation = vLaserDirection.rotated(-PI/2).angle()
	#nRcLaser.rotation = vLaserDirection.rotated(-PI/2).rotated(self.global_rotation*sign(-self.scale.x)).angle()
	#nRcLaser.rotation = vLaserDirection.rotated(-PI/2).angle()
	return false

func onLaserStopHit() -> void:
	nRcLaser.bActive = false
	pass
