class_name GravityHandler
extends Node2D

signal falling_started
signal touched_floor

@export var gravity: float = 1000.0
var is_falling: bool = false
var was_on_floor: bool = false

func handle_gravity(body: CharacterBody2D, delta: float) -> void:
	if not was_on_floor and body.is_on_floor():
		touched_floor.emit()
	was_on_floor = body.is_on_floor()
	
	if not body.is_on_floor():
		var fall_modifier = 1.1 if body.velocity.y > 0 else 1
		body.velocity.y += gravity * fall_modifier * delta
	
	var was_falling = is_falling
	is_falling = body.velocity.y > 0 and not body.is_on_floor()
	if not was_falling and is_falling:
		falling_started.emit()
		
