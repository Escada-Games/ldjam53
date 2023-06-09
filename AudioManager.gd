extends Node
const musicBossaNova := "res://resources/music/tekaDeliveryService.ogg"
onready var nMusicPlayer := AudioStreamPlayer.new()
onready var nTwn := Tween.new()

const scnSfxPlayer := preload("res://scenes/sfxPlayer.tscn")

const sfxObjectLanded := [
	"res://resources/sfx/objLand.wav"
]

const sfxClawGrab := "res://resources/sfx/clawGrab.wav"
const sfxClawGrabAlt := "res://resources/sfx/clawGrabAltAlt.wav"
const sfxClawRelease := "res://resources/sfx/clawGrabAlt.wav"
const sfxExplosion := "res://resources/sfx/sfxExplosion.wav"
const sfxStageOk := "res://resources/sfx/sfxStageOk.wav"
const sfxKeycardOk := "res://resources/sfx/sfxKeycardOk.wav"

func _ready() -> void:
	nMusicPlayer.bus = 'music'
	nMusicPlayer.pause_mode = Node.PAUSE_MODE_PROCESS
	add_child(nMusicPlayer)
	add_child(nTwn)
	deactivateMusicLowPass()
	
	
func playMusic(strMusicName:String) -> void:
	# Music fade out
	var _v=nTwn.interpolate_property(nMusicPlayer,'volume_db',nMusicPlayer.volume_db,-100,0.3,Tween.TRANS_CUBIC,Tween.EASE_IN)
	_v=nTwn.start()
	yield(nTwn,"tween_all_completed")
	
	# Changing track
	nMusicPlayer.stream = load(strMusicName)
	nMusicPlayer.play()
	
	# Music fade in
	_v=nTwn.interpolate_property(nMusicPlayer,'volume_db',nMusicPlayer.volume_db,0,0.2,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	_v=nTwn.start()

func stopMusic() -> void:
	var _v=nTwn.interpolate_property(nMusicPlayer,'volume_db',nMusicPlayer.volume_db,-100,0.4,Tween.TRANS_CUBIC,Tween.EASE_IN)
	_v=nTwn.start()
	yield(nTwn,"tween_all_completed")
	nMusicPlayer.stop()

func activateMusicLowPass() -> void:
	var idx := AudioServer.get_bus_index('music')
	AudioServer.set_bus_effect_enabled(idx, 0, true)
	
func deactivateMusicLowPass() -> void:
	var idx := AudioServer.get_bus_index('music')
	AudioServer.set_bus_effect_enabled(idx, 0, false)

func playSfx(sfxName) -> void:
	var i:AudioStreamPlayer = scnSfxPlayer.instance()
	var _sfxName = sfxName
	if sfxName is Array:
		_sfxName = sfxName[randi() % sfxName.size()]
	i.volume_db -= 18
	
	i.stream = load(_sfxName)
	add_child(i)

func playSfxWithoutPitchShift(sfxName) -> void:
	var i:AudioStreamPlayer = scnSfxPlayer.instance()
	var _sfxName = sfxName
	if sfxName is Array:
		_sfxName = sfxName[randi() % sfxName.size()]
	i.volume_db -= 18
			
	i.stream = load(_sfxName)
	i.bPitchShift = false
	add_child(i)
