extends Node2D
@export_file("*.tscn") var street_scene

func _ready() -> void:
	GameState.last_area = "precinct"
	$Background/Magnet.visible = not (GameState.has_magnet or GameState.used_magnet)

func _on_precinct_door_activated() -> void:
	get_tree().change_scene_to_file(street_scene)
	
func _on_magnet_activated() -> void:
	GameState.reveal_item("Magnet")
	GameState.has_magnet = true
	GameState.coin_in_water = true
	$Background/Magnet.visible = false
