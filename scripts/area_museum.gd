extends Node2D

@export var cop_dialogue: DialogueResource
@export_file("*.tscn") var street_scene

func _ready() -> void:
	GameState.last_area = "museum"
	if not GameState.seen_museum_intro:
		$IntroAnim.play("portal_intro")
	else:
		$Music.play()
		$Player.global_position.x = $Background/Doors.global_position.x
		
func _on_intro_anim_animation_finished(_anim_name: StringName) -> void:
	GameState.seen_museum_intro = true

func _on_cop_animation_finished(animation: String):
	if animation == "museum_cop_enter":
		DialogueManager.show_dialogue_balloon(cop_dialogue, "start", [self])
	if animation == "museum_cop_leave":
		GameState.seen_cop_anim = true
	
func cop_leave():
	$CopAnim.play("museum_cop_leave")

func _on_shrine_activated() -> void:
	if not GameState.shrine_repaired:
		if not GameState.seen_cop_anim:
			$CopAnim.play("museum_cop_enter")

func _on_doors_activated() -> void:
	if not GameState.seen_cop_anim:
		$Background/Doors/ClickAudio.play()
		$Background/Doors.is_triggerable = true
		$Background/Doors/Label.visible = true
		return
		
	get_tree().change_scene_to_file(street_scene)
