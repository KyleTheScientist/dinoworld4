extends Sprite2D

var rolling: bool = false

func _ready() -> void:
	visible = not GameState.cart_moved
	$Tie.visible = not GameState.cart_moved

func _process(_delta: float) -> void:
	if not rolling: 
		return
	
	$WheelR.rotation_degrees = int(position.x * 3)
	$WheelL.rotation_degrees = int(position.x * 3)
	
func _on_tie_activated() -> void:
	$Tie.visible = false
	$Click.play()
	rolling = true
	GameState.cart_moved = true
	$AnimationPlayer.play("roll_away")
