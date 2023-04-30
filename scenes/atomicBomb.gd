extends RigidBody2DWithSound
class_name AtomicBomb
func get_class(): return "AtomicBomb"

var bDied := false

const scnFxExplosion := preload("res://scenes/fxExplosion.tscn")

func onBodyEnter(b:Node) -> void:
	print((self.linear_velocity*Vector2(0.5,0.5)).length())
	if b is TileMap:
		
		if (self.linear_velocity*Vector2(0.5,0.5)).length() >= 16.0:
			explode()

func onLaserHit(_vGlobalHitPosition:=Vector2(), _vLaserDirection:=Vector2()) -> bool:
	explode()
	return true

func explode() -> void:
	if bDied:
		return
	bDied = true
	
	$sprite.modulate = Color('#ff5b5b')
	
	print('kabum')
	global.frameFreeze()
	AudioManager.playSfx(AudioManager.sfxExplosion)
	
	var i := scnFxExplosion.instance()
	i.global_position = self.global_position
	get_parent().add_child(i)
	yield(i, 'done')
	
	var _v = get_tree().reload_current_scene()
