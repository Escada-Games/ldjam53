extends RigidBody2D
class_name RigidBody2DWithSound

func _ready() -> void:
	self.can_sleep = false
	self.contact_monitor = true
	self.contacts_reported = 3
	var _v = self.connect("body_entered", self, '_onBodyEnter')
	
func _onBodyEnter(b:Node) -> void:
	if self.mode == self.MODE_KINEMATIC:
		return
		
	if (self.linear_velocity*Vector2(0.5,0.5)).length() <= 1.0:
		return
		
	if b is TileMap or b is RigidBody2D:
		AudioManager.playSfx(AudioManager.sfxObjectLanded)
	
	onBodyEnter(b)

func onBodyEnter(_b:Node) -> void:
	pass
