class_name Dino
extends CharacterBody2D

@onready var animation_handler: DinoAnimator = $DinoAnimator

@export var speed = 100.0
@export var in_animation: bool:
	set(value):
		$CollisionShape2D.disabled = value
		in_animation = value

var horizontal_input: float
var was_on_floor: bool = false

func _ready() -> void:
	GameState.player = self
	DialogueManager.dialogue_started.connect(func(_d): in_animation = true)
	DialogueManager.dialogue_ended.connect(func(_d): in_animation = false)

func _physics_process(delta: float) -> void:
	if _can_move():
		velocity.x = horizontal_input * delta * speed * 100
		velocity.y += 1000 * delta
	else:
		velocity.x = 0
		
	move_and_slide()
	was_on_floor = is_on_floor()
	
func _process(_delta: float) -> void:
	horizontal_input = Input.get_axis("move_left", "move_right")
	if not in_animation:
		animation_handler.handle_animation(self)

func _can_move() -> bool:
	return not in_animation
