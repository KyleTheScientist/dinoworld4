extends Camera2D

@export var player: Dino
@export var bounds: Vector4 = Vector4(-1000, -1000, 1000, 1000)

var shake_duration: float
var shake_power: float

func _ready() -> void:
	global_position.x = player.global_position.x

func _process(_delta: float) -> void:
	if $ShakeTimer.is_stopped(): 
		offset = Vector2.ZERO
		shake_duration = 0
	else:
		offset = Vector2(randf() * shake_power, randf() * shake_power)
	
	if not player.in_animation:
		global_position.x = player.global_position.x
		#global_position.x = lerp(global_position.x, player.global_position.x, 20 * _delta)
		if global_position.x < bounds.x:
			global_position.x = bounds.x
		if global_position.x > bounds.z:
			global_position.x = bounds.z

func shake(time: float, power: float):
	shake_power = power
	shake_duration = time
	$ShakeTimer.stop()
	$ShakeTimer.start(time)
