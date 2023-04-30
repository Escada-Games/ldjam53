extends KinematicBody2D
class_name Player

signal damaged
export var fSpeed := 220.0

var t := 0
var vVelocity := Vector2()
var vGravity := Vector2(0, 9.8)
var fBaseWeight := 10.0
var fCargoWeight := 0.0
var bCarriesSomething := false
var bDied := false

onready var nSfxPlayerMoving:AudioStreamPlayer = $sfxPlayerMoving
onready var nSprite:AnimatedSprite = $animatedSprite
onready var nSpritePlayerFace:AnimatedSprite = $animatedSprite/facialExpressions/sprite
var nClawArea2d:Area2D

const scnFxExplosion := preload("res://scenes/fxExplosion.tscn")
const fMaxTiltWhileMoving := 30.0

func _ready() -> void:
	nClawArea2d = get_parent().nClawArea2d
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	t += 1
	nSprite.modulate = Color('#ffffff')
	
	var vMotion := Vector2()
	vMotion.x = 1 if Input.is_action_pressed('ui_right') else -1 if Input.is_action_pressed('ui_left') else 0
	vMotion.y = 1 if Input.is_action_pressed('ui_down') else -1 if Input.is_action_pressed('ui_up') else 0
	vMotion = vMotion.normalized()
	
	if vMotion == Vector2():
		nSprite.position.y = lerp(nSprite.position.y, 4*sin(0.05*t), 0.5)
	else:
		nSprite.position.y = lerp(nSprite.position.y, 0.0, 0.1)
	
	nSprite.flip_h = true if vMotion.x < 0 else false if vMotion.x > 0 else nSprite.flip_h
	nSpritePlayerFace.flip_h = nSprite.flip_h
	
	vVelocity = vVelocity.linear_interpolate(vMotion*fSpeed,0.1)
	
	nSpritePlayerFace.animation = 'neutral'
	if fCargoWeight > 0.0:
		nSpritePlayerFace.play('heavy')
		vVelocity += vGravity * (fBaseWeight + fCargoWeight) * delta
	
	if vMotion != Vector2():
		if not nSfxPlayerMoving.playing:
			nSfxPlayerMoving.playing = true
	else:
		nSfxPlayerMoving.playing = false
	
	vVelocity = move_and_slide(vVelocity, Vector2())

	nSprite.rotation = lerp_angle(nSprite.rotation, deg2rad(fMaxTiltWhileMoving*vMotion.x), 0.05 if vMotion != Vector2() else 0.1)
	
	
func onLaserHit(_vGlobalHitPosition:=Vector2(), _vLaserDirection:=Vector2()) -> bool:
	#if bDied:
	#	return true
	#bDied = true
	
	nSpritePlayerFace.play("hurt")
	#set_physics_process(false)
	
	#AudioManager.playSfx(AudioManager.sfxExplosion)
	
	nSfxPlayerMoving.playing = false
	
	nSprite.modulate = Color('#ff5b5b')
	
	#global.frameFreeze()
	emit_signal('damaged')
	#yield(get_tree().create_timer(0.33),"timeout")
#	var i := scnFxExplosion.instance()
#	i.global_position = self.global_position
#	get_parent().get_parent().add_child(i)
#	yield(i, 'done')
#
#	get_tree().reload_current_scene()
	
	return true
	
