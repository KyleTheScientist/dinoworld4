extends Node2D

var can_click_away: bool
@export_file("*.tscn") var main_menu_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var _material = GameState.get_node("SceneTransition/DissolveRect").material
	_material.set_shader_parameter("time", 1)
	_material.set_shader_parameter("flip", false)
	await get_tree().create_timer(1).timeout
	$Music.play()
	can_click_away = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_click_away:
		GameState.change_scene(main_menu_scene)
		
