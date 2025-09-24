extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child.is_class("Node2D"):
			child.interactable_activated.connect(_on_drawer_opened)
			child.get_node("Sprite").visible = false

func _on_drawer_opened(drawer: Interactable):
	drawer.get_node("Sprite").visible = true
	$Click.play()
	
	if GameState.has_precinct_drumstick:
		return
		
	if drawer.name == "Drawer32":
		GameState.reveal_item("Drumstick")
		GameState.has_precinct_drumstick = true
		GameState.drumsticks_collected += 1
