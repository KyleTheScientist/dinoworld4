extends Node2D

@export var nude_sprite_frames: SpriteFrames
@export var clothed_sprite_frames: SpriteFrames

var player_anim: AnimatedSprite2D

func _ready() -> void:
	GameState.player_registered.connect(_on_player_registered)

func _on_player_registered(player: Dino):
	player_anim = player.animation_handler
	if GameState.player_clothed:
		$AnimatedSprite2D.animation = "used"
		$Interactable.is_triggerable = false

func _on_interactable_activated() -> void:
	$AnimatedSprite2D.animation = "used"
	if get_node("InteractAudio"):
		$InteractAudio.play()
		player_anim.sprite_frames = clothed_sprite_frames
		player_anim.play()
		GameState.player_clothed = true
