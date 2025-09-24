extends Node2D

@export var cop_intro_dialogue: DialogueResource
@export var cop_ending_dialogue: DialogueResource

@export_file("*.tscn") var street_scene
@export_file("*.tscn") var victory_scene

@export var poster: Interactable

func _ready() -> void:
	GameState.last_area = "museum"
	
	if GameState.prisoners_encountered:
		poster.get_node("Sprite").play("rustle")
	poster.is_triggerable = GameState.prisoners_encountered
	poster.visible = not GameState.poster_torn
	
	$Background/Shrine.is_triggerable = GameState.shrine_repaired or not GameState.seen_museum_intro
	if GameState.shrine_repaired:
		$Background/Shrine/ShrineSprite.animation = "fixed"
		
	if not GameState.seen_museum_intro:
		$CopAnim.play("RESET")
		$IntroAnim.play("portal_intro")
	elif not GameState.seen_museum_outro and GameState.shrine_repaired:
		GameState.show_scene()
		GameState.player.in_animation = true
		$Music.play()
		$EndingAnim.play("arrive")
		await get_tree().create_timer(1).timeout
		DialogueManager.show_dialogue_balloon(cop_ending_dialogue, "cutscene")
		return
	else:
		$Music.play()
		$Player.global_position.x = $Background/Doors.global_position.x
		if not GameState.shrine_repaired:
			$Cop.hide_and_disable()
	
	GameState.show_scene()
		
func _on_intro_anim_animation_finished(_anim_name: StringName) -> void:
	GameState.seen_museum_intro = true

func _on_cop_animation_finished(animation: String):
	if animation == "museum_cop_enter":
		DialogueManager.show_dialogue_balloon(cop_intro_dialogue, "start", [self])
	if animation == "museum_cop_leave":
		GameState.seen_cop_anim = true
	
func cop_leave():
	$CopAnim.play("museum_cop_leave")

func _on_shrine_activated() -> void:
	if GameState.shrine_repaired and GameState.drumsticks_collected >= 3:
		$EndingAnim.play("spawn_portal")
		$Portal/Interactable.is_triggerable = true
		GameState.shrine_activated = true
		return
	elif not GameState.seen_cop_anim:
		$CopAnim.play("museum_cop_enter")
	$Background/Shrine.is_triggerable = true
	$Background/Shrine/Error.play()

func _on_doors_activated() -> void:
	if not GameState.seen_cop_anim:
		$Background/Doors/ClickAudio.play()
		$Background/Doors.is_triggerable = true
		return
		
	GameState.change_scene(street_scene)

func _on_poster_activated() -> void:
	if GameState.poster_torn:
		GameState.reveal_item("Wallet")
		GameState.has_wallet = true
	else:
		poster.get_node("Sprite").visible = false
		poster.get_node("Change").play()
		poster.is_triggerable = true
		GameState.poster_torn = true

func _on_portal_activated() -> void:
	$EndingAnim.play("slurp_player")
	await $EndingAnim.animation_finished
	get_tree().change_scene_to_file(victory_scene)
