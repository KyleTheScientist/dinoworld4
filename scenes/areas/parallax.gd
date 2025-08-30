extends Sprite2D

@export var parallax_rate = 10
@onready var base_position = global_position.x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x = base_position + -get_viewport().get_camera_2d().global_position.x / parallax_rate
