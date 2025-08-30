class_name Interactable extends Area2D

signal activated

@export var is_triggerable: bool = true
var hovered: bool = false

func _ready() -> void:
	$Label.visible = false
	#body_entered.connect(_on_body_entered)
	#body_exited.connect(_on_body_exited)
	#mouse_entered.connect(_on_mouse_entered)
	#mouse_exited.connect(_on_mouse_exited)

func _input(event: InputEvent) -> void:
	if hovered and is_triggerable and event.is_action_pressed("interact"):
		is_triggerable = false
		activated.emit()
		
func _process(_delta: float) -> void:
	var pct = _player_can_trigger()
	if hovered and not pct:
		Input.set_custom_mouse_cursor(GameState.cursor_idle)
		hovered = false
	elif not hovered and pct:
		Input.set_custom_mouse_cursor(GameState.cursor_hover)
		hovered = true

func _mouse_overlaps() -> bool:
	return Geometry2D.is_point_in_circle(get_local_mouse_position(), Vector2.ZERO, 25)
		
func _player_in_range() -> bool:
	if GameState.player == null:
		print("null")
		return false
	return global_position.distance_to(GameState.player.global_position) < 100
	
func _player_can_trigger():
	return is_triggerable and _player_in_range() and _mouse_overlaps() 
	
#func _on_body_entered(body: Node2D) -> void:
	#if not is_triggerable: 
		#return
	#if body.name == "Player":
		#in_range = true
		#$Label.visible = true
#
#func _on_body_exited(body: Node2D) -> void:
	#if not is_triggerable: 
		#return
	#if body.name == "Player":
		#in_range = false
		#$Label.visible = false

	
