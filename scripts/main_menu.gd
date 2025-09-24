extends Node2D

@export_file("*.tscn") var museum_scene

func _ready() -> void:
	GameState.show_scene()

func _on_portal_activated() -> void:
	GameState.change_scene(museum_scene)
