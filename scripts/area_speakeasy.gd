extends Node2D
@export_file("*.tscn") var street_scene
@export var eavesdrop_dialogue: DialogueResource

func _ready() -> void:
	GameState.last_area = "speakeasy"
	DialogueManager.dialogue_ended.connect(_on_dialogue_finished)
	$Environment/Booths/Interactable.is_triggerable = not GameState.knows_combination

func _on_speakeasy_door_activated() -> void:
	get_tree().change_scene_to_file(street_scene)

	
func _on_booth_activated() -> void:
	$Environment/Booths/AnimationPlayer.play("eavesdrop")

func start_eavesdropping() -> void:
	DialogueManager.show_dialogue_balloon(eavesdrop_dialogue, "start")

func _on_dialogue_finished(dialogue: DialogueResource):
	if dialogue == eavesdrop_dialogue:
		$Environment/Booths/AnimationPlayer.play("uneavesdrop")
