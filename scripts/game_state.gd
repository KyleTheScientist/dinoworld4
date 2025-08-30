extends Node

signal player_registered(Dino)

@onready var cursor_idle: Texture2D = load("res://sprites/cursor_idle.png")
@onready var cursor_hover: Texture2D = load("res://sprites/cursor_hover.png")

var player: Dino:
	set(value):
		player = value
		player_registered.emit(value)

# Museum intro scene
var seen_museum_intro: bool = false
var seen_cop_anim: bool = false
var player_clothed: bool = false
var shrine_repaired: bool = false

# Street
var last_area = "museum"
var cop_exhausted: bool = true # This should be true by default
var cop_encountered: bool = false
var has_donuts: bool = false
var has_coin: bool = false

# Cafe
var shopkeep_encountered: bool = false
var shopkeep_angry: bool = false
var shopkeep_quest_given: bool = false
var crowbar_collected: bool = false
var has_turtle: bool = false
var turtle_returned: bool = false
