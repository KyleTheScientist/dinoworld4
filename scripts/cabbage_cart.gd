extends Sprite2D

var rolling: bool = false

func _ready() -> void:
	visible = not GameState.cart_moved
	$WedgeL.visible = not GameState.wedge_l_removed
	$WedgeR.visible = not GameState.wedge_r_removed

func _process(_delta: float) -> void:
	if not rolling: 
		return
	
	$WheelR.rotation_degrees = int(position.x * 3)
	$WheelL.rotation_degrees = int(position.x * 3)
	
func _on_wedge_activated(node: Interactable) -> void:
	node.visible = false
	$Click.play()
	if node == $WedgeL:
		GameState.wedge_l_removed = true
	if node == $WedgeR:
		GameState.wedge_r_removed = true

	if not $WedgeL.visible and not $WedgeR.visible:
		rolling = true
		GameState.cart_moved = true
		$AnimationPlayer.play("roll_away")
