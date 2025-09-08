extends Node2D
@export_file("*.tscn") var street_scene

func _ready() -> void:
	GameState.last_area = "precinct"

func _on_precinct_door_activated() -> void:
	get_tree().change_scene_to_file(street_scene)
	
