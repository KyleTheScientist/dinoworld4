extends Control

signal unlocked

@export var bar: TextureRect
@export var root: CanvasLayer
@export var combination_label: RichTextLabel

var mouse_start: Vector2
var rotation_offset: float
var dragging: bool
var code: Array = []
var direction = -5
var went_right_way: bool = false
var _unlocked = false
var last = 0

func _ready() -> void:
	$Dial.gui_input.connect(_on_gui_input)
	$Dial.mouse_entered.connect(_on_mouse_entered)
	$Dial.mouse_exited.connect(_on_mouse_exited)
	combination_label.visible = GameState.knows_combination
	combination_label.text = "[wave]%s[/wave]" % GameState.combination_string
		
func _process(delta: float) -> void:
	if _unlocked:
		return
		
	if not dragging:
		return
	
	rotation = get_mouse_angle()
	var number = floor(remap(rotation, 0, PI * 2, 0, 8)) * 5
	if number != last:
		$Click.play()
		last = number
		
	if not GameState.knows_combination:
		return
	# check if we've gone past the number *next* to the next combination number
	# this is how we tell if we've gone the right way
	if number == next(code[0], direction):
		went_right_way = true
	
	if number == code[0]:
		if not went_right_way:
			reset()
		else:
			code.pop_front()
			direction *= -1
			went_right_way = false
			if len(code) == 0:
				unlock()
				return
	
func unlock():
	bar.position.y = 30
	_unlocked = true
	$Clock.play()
	await get_tree().create_timer(1).timeout
	root.visible = false
	unlocked.emit()
	
func reset():
	code = GameState.combination_lock_code.duplicate()
	direction = -5
	
func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		reset()
		dragging = true
	if event.is_action_released("interact"):
		dragging = false

func _on_mouse_entered() -> void:
	GameState.set_cursor(1)

func _on_mouse_exited() -> void:
	GameState.set_cursor(0)

func get_mouse_angle():
	var mpos = get_global_mouse_position()
	var pos = get_global_transform().origin
	var angle = (mpos - pos).angle() + PI / 2
	if angle < 0:
		angle += PI * 2
	return angle
	
func next(number, direction):
	var result = number + direction
	if result < 0:
		return 35
	if result > 35:
		return 0
	return result
