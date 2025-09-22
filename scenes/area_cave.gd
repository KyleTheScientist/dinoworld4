extends Node2D

@export var mayor_dialogue: DialogueResource

func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_minecart_activated() -> void:
	$Cutscene.play("discover_drumstick")

func _on_animation_finished(anim: String) -> void:
	if anim == "discover_drumstick":
		DialogueManager.show_dialogue_balloon(mayor_dialogue, "start")

func _on_dialogue_ended(dialogue: DialogueResource) -> void:
	if dialogue == mayor_dialogue:
		$Cutscene.play("stick_em_up")
