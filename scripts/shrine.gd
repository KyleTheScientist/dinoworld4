extends Interactable

func _process(delta: float) -> void:
	super._process(delta)
	$ChickenUI.visible = GameState.shrine_repaired and hovered
	if hovered:
		$ChickenUI.frame = clamp(GameState.drumsticks_collected, 0, 3)
		$ChickenUI.offset.y = sin(Time.get_ticks_msec() / 250.0) * 2
