extends AnimatedSprite2D

@export var impulse: Vector2

var thrown: bool = false
var velocity: Vector2


func _process(delta: float) -> void:
	if not thrown:
		return
	delta *= 60
	position += delta * velocity
	rotation += delta * 30
	velocity.y += delta * (.5 if velocity.y < 0 else .9)
	
func throw():
	thrown = true
	velocity = impulse
