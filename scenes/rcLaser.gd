extends RayCast2D
class_name RayCast2DLaser

onready var nLine2d:Line2D = $line2D
onready var nEmissionParticles:CPUParticles2D = $cPUParticles2D
onready var nHitParticles:CPUParticles2D = $hitParticles
export var fTargetLineWidth := 8.0
export var bShowEmissionParticles := true
var bActive := false
var nLastCollider:Object

func _ready() -> void:
	nEmissionParticles.emitting = false
	nHitParticles.emitting = false
	set_physics_process(true)

func _physics_process(_delta: float) -> void:
	if not bActive:
		nEmissionParticles.emitting = false
		nLine2d.width = lerp(nLine2d.width, 0.0, 0.2)
		freeLastCollider()
		return
	
	if bShowEmissionParticles:
		nEmissionParticles.emitting = true
	
	nLine2d.width = lerp(nLine2d.width, fTargetLineWidth, 0.2)
	nLine2d.points[1] = self.to_local(self.get_collision_point()) if self.is_colliding() else self.cast_to
	
	var nCollider := get_collider()
	if nCollider:
		if nLastCollider != nCollider:
			freeLastCollider()
		
		if nCollider.has_method('onLaserHit'):
			nLastCollider = nCollider
			
			#var bShouldParticlesBeReleased = nCollider.onLaserHit(self.get_collision_point(), self.cast_to.rotated(self.global_rotation))
			var bShouldParticlesBeReleased = nCollider.onLaserHit(self.get_collision_point(), self.cast_to.rotated(self.global_rotation))
			
			if bShouldParticlesBeReleased:
				nHitParticles.emitting = true
				nHitParticles.global_position = self.get_collision_point()
				nHitParticles.rotation = (-self.cast_to).angle()
			else:
				nHitParticles.emitting = false
	else:
		nHitParticles.emitting = false

func freeLastCollider() -> void:
	nHitParticles.emitting = false
	if nLastCollider:
		if nLastCollider.has_method('onLaserStopHit'):
			nLastCollider.onLaserStopHit()
		nLastCollider = null
		
		
