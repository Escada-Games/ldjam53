extends Area2D

signal activated

var bActivated := false setget setActivated
func setActivated(bValue) -> void:
	bActivated = bValue
	$awaitingKeycard.visible = not bActivated
	$keycardOk.visible = bActivated
	if bActivated:
		emit_signal('activated')

func _ready() -> void:
	self.bActivated = false
	self.connect("body_entered",self,'onBodyEnter')

func onBodyEnter(b:PhysicsBody2D) -> void:
	if b.is_in_group('Keycard'):
		self.bActivated = true
		AudioManager.playSfxWithoutPitchShift(AudioManager.sfxKeycardOk)
