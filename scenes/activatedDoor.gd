extends Node2D

onready var nTwn:Tween = $tween
const f0OriginalY = -27.0
const f1OriginalY = 31.0

func activate() -> void:
	var _v = nTwn.stop_all()
	_v = nTwn.interpolate_property($'0', 'position:y', $"0".position.y, f0OriginalY-64, 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	_v = nTwn.interpolate_property($'1', 'position:y', $"1".position.y, f1OriginalY+64, 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	_v = nTwn.start()
	
func deactivate() -> void:
	var _v = nTwn.stop_all()
	_v = nTwn.interpolate_property($'0', 'position:y', $"0".position.y, f0OriginalY, 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN)
	_v = nTwn.interpolate_property($'1', 'position:y', $"1".position.y, f1OriginalY, 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN)
	_v = nTwn.start()
