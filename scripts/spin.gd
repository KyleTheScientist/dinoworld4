extends AnimatedSprite2D

@export var spin_rate: float
@export_range(0, 1) var scale_rate: float
@export_range(0, 1) var scale_min: float
@export_range(0, 1) var scale_max: float

func _process(delta: float) -> void:
	rotation += delta * spin_rate
	var scale_time = Time.get_ticks_msec() / 100.0 * scale_rate
	var scalar = remap(sin(scale_time), -1, 1, scale_min, scale_max)
	scale.x = scalar
	scale.y = scalar
