extends Node2D
@export_file("*.tscn") var street_scene

func _ready() -> void:
	GameState.last_area = "cafe"
	$Turtles.visible = GameState.turtle_returned
	GameState.show_scene()

func _on_cafe_door_activated() -> void:
	GameState.change_scene(street_scene)
	
func _on_shopkeep_dialogue_finished() -> void:
	$Player/DinoAnimator/Turtles.visible = GameState.has_turtle
	$Turtles.visible = GameState.turtle_returned
	
