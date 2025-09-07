extends Sprite2D

signal animation_finished

var thrown: bool = false
@export var impulse: Vector2
var velocity: Vector2
var origin: Vector2

func _ready() -> void:
	origin = position

func _process(delta: float) -> void:
	if not thrown:
		return
		
	var gravity = .1 if velocity.y < 0 else .3
	velocity.y += gravity
	
	rotation += delta * 60
	position += velocity * delta * 60
	
	if position.y >= 35:
		velocity = Vector2.ZERO
		visible = false
		thrown = false
		await get_tree().create_timer(1).timeout
		$Plop.play()
		await get_tree().create_timer(1).timeout
		animation_finished.emit()

func throw():
	position = origin
	await get_tree().create_timer(.5).timeout
	thrown = true
	visible = true
	velocity = impulse
	$Coin.play()
