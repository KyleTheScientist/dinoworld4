extends Node2D
@export var debug: bool

@export_file("*.tscn") var street_scene
@export_file("*.tscn") var sewer_scene
@export var turtle_minigame: TurtleMinigame

func _ready() -> void:
	if debug:
		GameState.has_magnet = true
		GameState.coin_in_water = true
		GameState.ring_in_water = true
	GameState.last_area = "sewer"
	$Background/TurtleTable/Turtle.visible = not (GameState.has_turtle or GameState.turtle_returned)
	$Background/TurtleTable/Turtlette.visible = not (GameState.has_turtle or GameState.turtle_returned)
	$Background/TurtleTable/Interactable.is_triggerable = not (GameState.has_turtle or GameState.turtle_returned)
	$Background/CaveDoor/AnimatedSprite2D.play("unlocked" if GameState.cave_unlocked else "locked")
	$Background/CaveDoor.is_triggerable = not GameState.shrine_repaired
	GameState.show_scene()

func _on_ladder_activated() -> void:
	GameState.change_scene(street_scene)

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
	$Background/CaveDoor.is_triggerable = true
	if GameState.cave_unlocked:
		GameState.change_scene(sewer_scene)
		return
	$Player.in_animation = true
	$LockOverlay.visible = true

func _on_combination_lock_unlocked() -> void:
	GameState.cave_unlocked = true
	GameState.player.in_animation = false
	$Background/CaveDoor/AnimatedSprite2D.play("unlocked")
	
