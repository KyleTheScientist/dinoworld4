class_name InspectOverlay
extends CanvasLayer

func _ready():
	GameState.inspect_overlay = self

func _process(delta: float) -> void:
	$RevealContainer.scale = lerp($RevealContainer.scale, Vector2.ONE, delta * 6)
	if $RevealContainer.scale.x > .99:
		$RevealContainer.scale = Vector2.ONE

func reveal(name: String):
	$RevealContainer.scale = Vector2.ZERO
	visible = true
	GameState.player.in_animation = true
	for node in $RevealContainer.get_children():
		node.visible = node.name == name
	
func close(event: InputEvent):
	if event.is_action_pressed("interact"):
		GameState.player.in_animation = false
		visible = false
