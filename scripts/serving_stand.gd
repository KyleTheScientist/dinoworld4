extends AnimatedSprite2D


func _ready() -> void:
	play("used" if GameState.has_cafe_drumstick else "default")
	$Interactable.is_triggerable = not GameState.has_cafe_drumstick
	
func _on_interactable_activated() -> void:
	GameState.reveal_item("Drumstick")
	GameState.has_cafe_drumstick = true
	GameState.drumsticks_collected += 1
	animation = "used"
