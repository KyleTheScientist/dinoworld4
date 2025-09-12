class_name InspectOverlay
extends CanvasLayer

var should_peek: bool = true

func _ready():
	GameState.inspect_overlay = self
	visible = false
	for child in $RevealContainer.get_children():
		child.visible = false
		child.connect("gui_input", close)
		child.connect("mouse_entered", on_hovered)
		child.connect("mouse_exited", on_unhovered)

func _process(delta: float) -> void:
	$RevealContainer.scale = lerp($RevealContainer.scale, Vector2.ONE, delta * 6)
	if $RevealContainer.scale.x > .99:
		$RevealContainer.scale = Vector2.ONE

func reveal(_name: String):
	should_peek = _name != "HatsPoster"
	$RevealContainer.scale = Vector2.ZERO
	visible = true
	GameState.player.in_animation = true
	for node in $RevealContainer.get_children():
		node.visible = node.name == _name
	
func close(event: InputEvent):
	if event.is_action_pressed("interact"):
		GameState.player.in_animation = false
		visible = false
		if should_peek:
			GameState.inventory_overlay.peek()

func on_hovered():
	GameState.set_cursor(1)

func on_unhovered():
	GameState.set_cursor(0)
