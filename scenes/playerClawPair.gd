extends Node2D

const scnFxClawGrab := preload("res://scenes/fxClawGrab.tscn")

onready var spring:DampedSpringJoint2D = $springPlayerClaw
onready var player:Player = $player
onready var claw:RigidBody2D = $claw
onready var nClawArea2d:Area2D = $claw/area2D


var bOpenClaw := false
var vForceGrabbedBodyLv:=Vector2()
var nGrabbedBody:RigidBody2D
var vGrabbedBodyOffset := Vector2()
var vClawTipPosition := Vector2()

func _ready() -> void:
	var _v = player.connect("damaged", self, 'onPlayerDamaged')
	set_process(true)

func onPlayerDamaged() -> void:
	#if nGrabbedBody:
	#	nGrabbedBody.linear_velocity.x *= -2
	vForceGrabbedBodyLv = -2*player.vVelocity
	bOpenClaw = true
	
	#clawOpen()
	pass

func _process(_delta: float) -> void:
	update()
	
	spring.global_position = player.global_position
	vClawTipPosition = claw.get_node("sprite/tipPosition").global_position
	#vClawTipPosition = claw.get_node("/tipPosition").global_position
	
	if nGrabbedBody:
		claw.get_node("sprite").frame = 1
		player.fCargoWeight = nGrabbedBody.weight if not nGrabbedBody.test_motion(Vector2(0,2)) else 0.0

		#nGrabbedBody.rotation = lerp(nGrabbedBody.rotation, claw.rotation, 0.1)
		nGrabbedBody.rotation = lerp_angle(nGrabbedBody.rotation, (nGrabbedBody.global_position-claw.global_position).angle() - PI/2, 0.1)
		
		var vTargetPosition := vClawTipPosition - vGrabbedBodyOffset
		nGrabbedBody.global_position = vTargetPosition
		#nGrabbedBody.global_position.x = vTargetPosition.x
		#nGrabbedBody.global_position.y = vTargetPosition.y
		
		#if not nGrabbedBody.test_motion(Vector2(0,1)*(vTargetPosition - nGrabbedBody.global_position).y):
		#	nGrabbedBody.global_position.y = vTargetPosition.y
		#else:
			#claw.get_node('sprite').position.y = lerp(claw.get_node('sprite').position.y, nGrabbedBody.global_position.y - vTargetPosition.y, 0.1)
		

		if Input.is_action_just_pressed("ui_claw") or bOpenClaw:
			bOpenClaw = false
			if vForceGrabbedBodyLv != Vector2():
				nGrabbedBody.linear_velocity = vForceGrabbedBodyLv
				vForceGrabbedBodyLv = Vector2()
			clawOpen()
			
			
	else:
		claw.get_node("sprite").frame = 0
		player.fCargoWeight = 0.0

		if Input.is_action_just_pressed("ui_claw"):
			for a in nClawArea2d.get_overlapping_areas():
				if a.is_in_group('GrabbableRing'):
					vGrabbedBodyOffset = a.position
					var b = a.get_parent()
					if not (b is RigidBody2D):
						vGrabbedBodyOffset = b.position
						b = b.get_parent()
					nGrabbedBody = b
					b.mode = RigidBody2D.MODE_KINEMATIC
					
					var i = scnFxClawGrab.instance()
					i.global_position = claw.global_position - vGrabbedBodyOffset
					get_parent().add_child(i)
					
					AudioManager.playSfx(AudioManager.sfxClawGrabAlt)
	
	bOpenClaw = false
	vForceGrabbedBodyLv = Vector2()
	
func clawOpen() -> void:
#nGrabbedBody.linear_velocity *= 1.5
	nGrabbedBody.mode = RigidBody2D.MODE_RIGID
	nGrabbedBody = null
	AudioManager.playSfx(AudioManager.sfxClawRelease)
	bOpenClaw = false
	

func _draw() -> void:
	for idx in range(3):
		var p1:Vector2 = to_local(player.get_node("animatedSprite/cablePositions/" + str(idx)).global_position)
		var p2:Vector2 = to_local(claw.get_node("sprite/cablePositions/" + str(idx)).global_position)
		draw_line(p1, p2, Color.black, 3.0, false)
		draw_line(p1, p2, Color.white, 1.0, false)
	#draw_line(player.position, claw.position, Color.white, 8.0, true)
