class_name NPCController
extends Node2D

signal dialogue_finished
@export var dialogue: DialogueResource
@export var face_player: bool = false

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialogue_finished)
	
func _on_npc_activated() -> void:
	show_dialogue("start")
	
func show_dialogue(name: String):
	if face_player:
		$NPCAnimator.flip_h = GameState.player.global_position.x < global_position.x
	DialogueManager.show_dialogue_balloon(dialogue, name)
	
func _on_dialogue_finished(_dialogue: DialogueResource):
	if _dialogue == self.dialogue:
		$Interactable.is_triggerable = true
		dialogue_finished.emit()
