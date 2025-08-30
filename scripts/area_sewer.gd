extends Node2D
@export_file("*.tscn") var street_scene

func _ready() -> void:
	GameState.last_area = "sewer"
	$Background/TurtleTable/Turtles.visible = not GameState.has_turtle
	$Background/TurtleTable/Interactable.is_triggerable = not GameState.has_turtle

func _on_ladder_activated() -> void:
	get_tree().change_scene_to_file(street_scene)


func _on_turtle_activated() -> void:
	GameState.has_turtle = true
	$Background/TurtleTable/Turtles.visible = false
	$Player/DinoAnimator/Turtles.visible = true
