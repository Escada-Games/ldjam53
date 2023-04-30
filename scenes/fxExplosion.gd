extends Node2D

signal done

onready var nTwn:Tween = $tween
onready var nSprite:Sprite = $sprite

func _ready() -> void:
	nSprite.scale = Vector2()
	var _v = nTwn.interpolate_property(nSprite, 'scale', Vector2(), Vector2.ONE*5, 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, 0.1)
	_v = nTwn.start()
	
	yield(nTwn,"tween_all_completed")
	
	emit_signal("done")
	_v = nTwn.interpolate_property(nSprite, 'modulate:a', 1, 0, 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN, 0.1)
	_v = nTwn.start()
	
	yield(nTwn,"tween_all_completed")
	
	self.queue_free()
