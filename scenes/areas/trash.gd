extends AnimatedSprite2D

var thrown: bool = false
var busted: bool = false
@export var impulse: Vector2
var velocity: Vector2

func _process(delta: float) -> void:
	var gravity = .5 if velocity.y < 0 else .9
	velocity.y += gravity
	if not thrown:
		return
	
	position += velocity * delta * 60
	animate(velocity.y)
	
	if position.y >= 0:
		$Interactable.is_triggerable = true
		velocity = Vector2.ZERO
		frame = 4
		position.y = 0
		thrown = false
		busted = true
	
func animate(y_vel: float):
	if y_vel < -5:
		frame = 0
	elif y_vel < 5:
		frame = 1
	else:
		frame = 2

func throw():
	thrown = true
	velocity = impulse
	animation = "toss"
	pause()
