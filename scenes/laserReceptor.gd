extends RigidBody2D

onready var nSprOkLight:Sprite = $sprOkLight
signal charged
signal discharged
var bIsCharged := false setget setIsCharged
func setIsCharged(bValue):
	if not bIsCharged and bValue:
		emit_signal("charged")
		nSprOkLight.visible = true
	elif bIsCharged and not bValue:
		emit_signal("discharged")
		nSprOkLight.visible = false
	
	bIsCharged = bValue

func onLaserHit(_vGlobalHitPosition:=Vector2(), _vLaserDirection:=Vector2()) -> bool:
	self.bIsCharged = true
	return true

func onLaserStopHit() -> void:
	self.bIsCharged = false
