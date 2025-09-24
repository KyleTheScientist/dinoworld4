class_name Interactable extends Node2D

signal activated
signal interactable_activated(Interactable)

@export var is_triggerable: bool = true
@export var hover_range: int = 25
var hovered: bool = false

func _input(event: InputEvent) -> void:
	if hovered and is_triggerable and visible and event.is_action_pressed("interact"):
		is_triggerable = false
		activated.emit()
		interactable_activated.emit(self)
		GameState.set_cursor(0)
		
func _process(_delta: float) -> void:
	var pct = _player_can_trigger()
	if hovered and not pct:
		GameState.set_cursor(0)
		hovered = false
	elif (not hovered) and pct:
		GameState.set_cursor(1)
		hovered = true

func _mouse_overlaps() -> bool:
	return Geometry2D.is_point_in_circle(get_local_mouse_position(), Vector2.ZERO, hover_range)
		
func _player_in_range() -> bool:
	if GameState.player == null:
		print("null player")
		return false
	return global_position.distance_to(GameState.player.global_position) < 200
	
func _player_can_trigger():
	if not GameState.player:
		return false
	return \
		not GameState.player.is_busy() and \
		is_triggerable and \
		_player_in_range() and \
		_mouse_overlaps() and \
		visible
