extends Node2D
@export_file("*.tscn") var street_scene

func _ready() -> void:
	GameState.last_area = "precinct"
	$Background/Magnet.visible = not (GameState.has_magnet or GameState.used_magnet)
	if not GameState.shrine_repaired:
		$Background/Mayor.hide_and_disable()
	if not GameState.cop_fed or GameState.shrine_repaired:
		$Cop.hide_and_disable()
	GameState.show_scene()

func _on_precinct_door_activated() -> void:
	GameState.change_scene(street_scene)
	
func _on_magnet_activated() -> void:
	GameState.reveal_item("Magnet")
	GameState.has_magnet = true
	$Background/Magnet.visible = false
