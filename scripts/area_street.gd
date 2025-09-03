extends Node2D

@export_file("*.tscn") var museum_scene
@export_file("*.tscn") var cafe_scene
@export_file("*.tscn") var sewer_scene

func _ready() -> void:
	if GameState.last_area == "museum":
		$Player.global_position.x = $Background/MuseumDoor.global_position.x
	elif GameState.last_area == "cafe":
		$Player.global_position.x = $Background/CafeDoor.global_position.x
	elif GameState.last_area == "sewer":
		$Player.global_position.x = $Background/SewerDoor.global_position.x
	
	GameState.last_area = "street"

	if GameState.cop_exhausted:
		$Cop/NPCAnimator.animation = "exhausted"
	
	$Background/Dumpster.is_triggerable = GameState.has_trash
	$Background/TrashPile/Sprite.frame = GameState.trash_removed

func _on_mayor_dialogue_finished() -> void:
	$Background/TrashPile.is_triggerable = not GameState.trash_disposed_of

func _on_trash_activated() -> void:
	if GameState.has_trash:
		return
	GameState.has_trash = true
	GameState.trash_removed += 1
	$Background/Dumpster.is_triggerable = true
	$Player/DinoAnimator/Trash.visible = true
	if GameState.trash_removed == 3:
		$Background/TrashPile.visible = false
		$Background/TrashPile.is_triggerable = false
		return
	$Background/TrashPile.is_triggerable = true	
	$Background/TrashPile/Sprite.frame = GameState.trash_removed

func _on_dumpster_activated() -> void:
	if not GameState.has_trash:
		return
	$Player/DinoAnimator/Trash.visible = false
	$Background/Dumpster/AnimationPlayer.play("insert_trash")
	GameState.has_trash = false
	if GameState.trash_removed == 3:
		GameState.trash_disposed_of = true
		get_tree().create_timer(1).timeout.connect(
			func x():
				$Background/Dumpster/AnimationPlayer.play("pterosaur_escape")
		)

func _on_busted_trash_inspected() -> void:
	$Player.in_animation = true
	$Camera2D/PosterPanel.visible = true
	$Camera2D/PosterPanel/HatsPoster/Interactable.is_triggerable = true

func _on_poster_activated() -> void:
	$Player.in_animation = false
	$Camera2D/PosterPanel.visible = false

func _on_speakeasy_door_activated() -> void:
	$Background/SpeakeasyDoor/AnimatedSprite2D.play("open")
	$Background/SpeakeasyDoor/Click.play()
		
func _on_speakeasy_door_dialogue_finished() -> void:
	$Background/SpeakeasyDoor/AnimatedSprite2D.play("close")
	$Background/SpeakeasyDoor/Click.play()

func _on_museum_door_activated() -> void:
	get_tree().change_scene_to_file(museum_scene)
	
func _on_cafe_door_activated() -> void:
	get_tree().change_scene_to_file(cafe_scene)

func _on_sewer_door_activated() -> void:
	get_tree().change_scene_to_file(sewer_scene)
