extends Node2D
@export_file("*.tscn") var street_scene

@export var turtle_minigame: TurtleMinigame

func _ready() -> void:
	GameState.last_area = "sewer"
	$Background/TurtleTable/Turtle.visible = not (GameState.has_turtle or GameState.turtle_returned)
	$Background/TurtleTable/Turtlette.visible = not (GameState.has_turtle or GameState.turtle_returned)
	$Background/TurtleTable/Interactable.is_triggerable = not (GameState.has_turtle or GameState.turtle_returned)

func _on_ladder_activated() -> void:
	get_tree().change_scene_to_file(street_scene)


func _on_turtle_activated() -> void:
	$Background/TurtleTable/Turtle.visible = false
	$Background/TurtleTable/Turtlette.visible = false
	turtle_minigame.visible = true
	turtle_minigame.start()
	$Background/Music.stop()
	
func _on_turtle_minigame_finished() -> void:
	GameState.has_turtle = true
	turtle_minigame.visible = false
	$Player/DinoAnimator/Turtles.visible = true
	$Background/Music.play()


func _on_cave_door_activated() -> void:
	pass # Replace with function body.
