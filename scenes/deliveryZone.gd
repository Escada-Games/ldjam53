extends Node2D
class_name DeliveryZone

signal DeliveryMade

export var strNextStage := "res://scenes/debugRoot.tscn"

export var wants := 'SmallBox'
var targetWants:RigidBody2D = null

onready var nArea2d:Area2D = $area2D

func _ready() -> void:
	var _v = nArea2d.connect("body_entered", self, 'onBodyEnter')
	_v = nArea2d.connect("body_exited", self, 'onBodyExit')
	set_process(true)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_reset"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("ui_debug"):
		if OS.is_debug_build():
			print('OK')
			emit_signal("DeliveryMade")
			set_process(false)
			
			global.changeSceneTo(strNextStage)
	
	if targetWants:
		if targetWants.mode == RigidBody2D.MODE_RIGID:
			print('OK')
			emit_signal("DeliveryMade")
			set_process(false)
			
			global.changeSceneTo(strNextStage)
			

func onBodyEnter(b:Node) -> void:
	if b.get_class() == wants:
		targetWants = b

func onBodyExit(b:Node) -> void:
	if b == targetWants:
		targetWants = null
