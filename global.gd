extends Node

const scnLayerTransition := preload("res://scenes/layers/layerTransition.tscn")

func _ready() -> void:
	#if not OS.is_debug_build():
	AudioManager.playMusic(AudioManager.musicBossaNova)

# Thanks to https://www.youtube.com/watch?v=44YpRF5FZDc
func frameFreeze() -> void:
	Engine.time_scale = 0.05
	yield(get_tree().create_timer(0.4 * Engine.time_scale),"timeout")
	Engine.time_scale = 1

func changeSceneTo(strPath:String) -> void:
	AudioManager.playSfxWithoutPitchShift(AudioManager.sfxStageOk)
	
	var i:LayerTransition = scnLayerTransition.instance()
	i.strTransitionTo = strPath
	i.strFadeMode = 'FadeIn'
	get_tree().root.add_child(i)
