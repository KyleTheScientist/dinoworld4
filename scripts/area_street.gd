extends Node2D

@export_category("Connected scenes")
@export_file("*.tscn") var museum_scene
@export_file("*.tscn") var cafe_scene
@export_file("*.tscn") var sewer_scene

@export_category("Doors")
@export var museum_door: Node2D
@export var cafe_door: Node2D
@export var sewer_door: Node2D
@export var precinct_door: Node2D
@export var speakeasy_door: Node2D

@export_category("Interactables")
@export var dumpster: Interactable
@export var trash_pile: Interactable


func _ready() -> void:
	if GameState.last_area == "museum":
		$Player.global_position.x = museum_door.global_position.x
	elif GameState.last_area == "cafe":
		$Player.global_position.x = cafe_door.global_position.x
	elif GameState.last_area == "sewer":
		$Player.global_position.x = sewer_door.global_position.x
	
	GameState.last_area = "street"

	if not GameState.cop_fed:
		$Cop/NPCAnimator.animation = "exhausted"
	
	dumpster.is_triggerable = GameState.has_trash
	trash_pile.get_node("Sprite").frame = GameState.trash_removed
	sewer_door.is_triggerable = GameState.cart_moved
	$Shady.visible = GameState.bouncer_encountered and not GameState.shady_quest_complete

func _on_mayor_dialogue_finished() -> void:
	trash_pile.is_triggerable = not GameState.trash_disposed_of

func _on_trash_activated() -> void:
	if GameState.has_trash:
		return
	GameState.has_trash = true
	GameState.trash_removed += 1
	dumpster.is_triggerable = true
	$Player/DinoAnimator/Trash.visible = true
	if GameState.trash_removed == 3:
		trash_pile.visible = false
		trash_pile.is_triggerable = false
		return
	trash_pile.is_triggerable = true	
	trash_pile.get_node("Sprite").frame = GameState.trash_removed

func _on_dumpster_activated() -> void:
	if not GameState.has_trash:
		return
	$Player/DinoAnimator/Trash.visible = false
	dumpster.get_node("AnimationPlayer").play("insert_trash")
	GameState.has_trash = false
	if GameState.trash_removed == 3:
		GameState.trash_disposed_of = true
		await get_tree().create_timer(1).timeout
		dumpster.get_node("AnimationPlayer").play("pterosaur_escape")

func _on_busted_trash_inspected() -> void:
	$InspectOverlay.reveal("HatsPoster")

func _on_shady_dialogue_finished() -> void:
	if GameState.ring_thrown:
		$Shady/NPCAnimator.play("give")
		$Player.in_animation = true
		$Shady/Ring.throw()
		GameState.ring_thrown = false
	if GameState.shady_quest_complete:
		$Shady/Interactable.is_triggerable = false
		$SmokeBomb.visible = true
		$SmokeBomb.play("default")
		$SmokeBomb/Change.play()

func _on_ring_animation_finished() -> void:
	$Shady/NPCAnimator.play("default")
	$Shady.show_dialogue("ring_dropped")

func _on_speakeasy_door_activated() -> void:
	speakeasy_door.get_node("AnimatedSprite2D").play("open")
	speakeasy_door.get_node("Click").play()
		
func _on_speakeasy_door_dialogue_finished() -> void:
	speakeasy_door.get_node("AnimatedSprite2D").play("close")
	speakeasy_door.get_node("Click").play()

func _on_museum_door_activated() -> void:
	get_tree().change_scene_to_file(museum_scene)
	
func _on_cafe_door_activated() -> void:
	get_tree().change_scene_to_file(cafe_scene)

func _on_sewer_door_activated() -> void:
	get_tree().change_scene_to_file(sewer_scene)

func _on_smoke_bomb_frame_changed() -> void:
	if $SmokeBomb.frame == 3:
		$Shady.visible = false
		
