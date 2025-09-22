extends Node2D

@export var mayor_dialogue: DialogueResource
@export var cop_dialogue: DialogueResource
@export_file("*.tscn") var museum_scene

func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_minecart_activated() -> void:
	$Cutscene.play("discover_drumstick")

func _on_animation_finished(anim: String) -> void:
	if anim == "discover_drumstick":
		DialogueManager.show_dialogue_balloon(mayor_dialogue, "start")
	if anim == "stick_em_up":
		DialogueManager.show_dialogue_balloon(cop_dialogue, "start")

func _on_dialogue_ended(dialogue: DialogueResource) -> void:
	if dialogue == mayor_dialogue:
		$Cutscene.play("stick_em_up")
	if dialogue == cop_dialogue:
		GameState.change_scene(museum_scene)
