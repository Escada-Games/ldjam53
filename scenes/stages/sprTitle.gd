extends Sprite

func _ready() -> void:
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_claw"):
		global.changeSceneTo("res://scenes/stages/0.tscn")
