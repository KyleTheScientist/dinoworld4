class_name DinoAnimator
extends AnimatedSprite2D

@export var clothed_frames: SpriteFrames
@export var nude_frames: SpriteFrames

func _ready() -> void:
	sprite_frames = clothed_frames if GameState.player_clothed else nude_frames
	play("default")
	$Turtles.visible = GameState.has_turtle

func handle_animation(dino: Dino) -> void:
	if abs(dino.velocity.x) > .1:
		animation = "run"
		flip_h = dino.velocity.x < 0
		$Turtles.flip_h = flip_h
		offset.x = -25 if flip_h else -38
		$LightOccluderL.visible = flip_h
		$LightOccluderR.visible = not flip_h
	else:
		animation = "default"
	
