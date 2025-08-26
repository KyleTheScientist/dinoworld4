extends Node2D

@export_file("*.tscn") var museum_scene
@export_file("*.tscn") var cafe_scene

func _ready() -> void:
	if GameState.last_area == "museum":
		$Player.global_position.x = $Background/MuseumDoor.global_position.x
	elif GameState.last_area == "cafe":
		$Player.global_position.x = $Background/CafeDoor.global_position.x
	
	GameState.last_area = "street"

	if GameState.cop_exhausted:
		$Cop/NPCAnimator.animation = "exhausted"

func _on_museum_door_activated() -> void:
	get_tree().change_scene_to_file(museum_scene)
	
func _on_cafe_door_activated() -> void:
	get_tree().change_scene_to_file(cafe_scene)
