extends Node2D
@export_file("*.tscn") var street_scene

func _ready() -> void:
	GameState.last_area = "cafe"
	$Turtles.visible = GameState.turtle_returned

func _on_cafe_door_activated() -> void:
	get_tree().change_scene_to_file(street_scene)
	
func _on_shopkeep_dialogue_finished() -> void:
	$Player/DinoAnimator/Turtles.visible = GameState.has_turtle
	$Turtles.visible = GameState.turtle_returned
