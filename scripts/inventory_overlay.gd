class_name InventoryOverlay
extends CanvasLayer

var hovered: bool = false
var peeking: bool = false
@onready var panel = $VBoxContainer/HoverZone/InventoryPanel


func _ready() -> void:
	GameState.inventory_overlay = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var y = 0.0 if hovered or peeking else panel.size.y + 20.0
	panel.position.y = lerp(panel.position.y, y, 4 * delta)

func peek() -> void:
	peeking = true
	await get_tree().create_timer(2).timeout
	peeking = false

func add(_name: String):
	if _name == "HatsPoster":
		return
	panel.get_node("HBoxContainer/%s" % _name).visible = true

func remove(_name: String):
	panel.get_node("HBoxContainer/%s" % _name).visible = false

func _on_hover_entered() -> void:
	hovered = true

func _on_hover_exited() -> void:
	hovered = false
