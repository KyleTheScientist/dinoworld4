extends Node2D

@export var dialogue: DialogueResource

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialogue_finished)
	
func _on_npc_activated() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, "start")
	
func _on_dialogue_finished(_dialogue: DialogueResource):
	if _dialogue == self.dialogue:
		$Interactable.is_triggerable = true
		$Interactable/Label.visible = true
