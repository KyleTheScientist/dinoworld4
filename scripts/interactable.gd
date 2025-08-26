class_name Interactable extends Area2D

signal activated

@export var is_triggerable: bool = true
var in_range: bool = false

func _ready() -> void:
	$Label.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _input(event: InputEvent) -> void:
	if in_range and is_triggerable and event.is_action_pressed("interact"):
		is_triggerable = false
		$Label.visible = false
		activated.emit()
		
func _on_body_entered(body: Node2D) -> void:
	if not is_triggerable: 
		return
	if body.name == "Player":
		in_range = true
		$Label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if not is_triggerable: 
		return
	if body.name == "Player":
		in_range = false
		$Label.visible = false
