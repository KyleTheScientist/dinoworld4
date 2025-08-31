class_name TurtleMinigame
extends Node2D

signal finished

var move: bool = false
@export var speed = 7
var attempts:int = 0
var flipping: bool = false
var flip_height: float
var flip_direction: float
@onready var flip_time = $Turtle/FlipTimer.wait_time * .9
@onready var base_y = $Turtle.position.y

func start():
	$SPEED.visible = false
	$Music.play()
	$CatchThatTurt.play()
	GameState.player.in_animation = true

func _process(delta: float) -> void:
	if move:
		$Turtle.position.x -= speed * delta
	if flipping:
		$Turtle.position.y = base_y - max(sin($Turtle/FlipTimer.time_left / flip_time * PI), 0) * flip_height
		$Turtle.rotation = $Turtle/FlipTimer.time_left / flip_time * PI * 2 * flip_direction
	else:
		$Turtle.position.y = base_y
		$Turtle.rotation = 0
	$SPEED.position = $Turtle.position

func _on_catch_that_turt_animation_finished() -> void:
	move = true
	$Turtle/TurtleAnimation.play("run")
	$CatchThatTurt.visible = false
	GameState.player.in_animation = false
	$Turtle.is_triggerable = true
	

func _on_catch_that_turt_frame_changed() -> void:
	get_viewport().get_camera_2d().shake(.1, 1)
	$CatchThatTurt/Crash.play()

func _on_flip_timer_timeout() -> void:
	flipping = false
	$Turtle.is_triggerable = true

func flip():
	flipping = true
	flip_height = lerp(60, 10, attempts / 30.0)
	flip_direction = 1 if randf() < .5 else -1
	$Turtle/FlipTimer.start()
	attempts += 1

func _on_turtle_activated() -> void:
	if flipping: 
		return
	
	if attempts == 15:
		$SPEED.visible = true
		$SpeedUp.play()
		speed *= 1.5
	
	if attempts < 30:
		flip()
		return
	
	$Music.stop()
	finished.emit()
