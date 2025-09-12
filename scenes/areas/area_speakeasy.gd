extends Node2D
@export_file("*.tscn") var street_scene

func _ready() -> void:
	GameState.last_area = "speakeasy"

func _on_speakeasy_door_activated() -> void:
	get_tree().change_scene_to_file(street_scene)

	
