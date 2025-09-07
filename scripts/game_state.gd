extends Node

signal player_registered(Dino)

@onready var cursor_idle: Texture2D = load("res://sprites/cursor_idle.png")
@onready var cursor_hover: Texture2D = load("res://sprites/cursor_hover.png")
@onready var cursor_idle_small: Texture2D = load("res://sprites/cursor_idle_small.png")
@onready var cursor_hover_small: Texture2D = load("res://sprites/cursor_hover_small.png")
var cursor: Texture2D

var player: Dino:
	set(value):
		player = value
		player_registered.emit(value)
		
var debugger: Debugger
var inspect_overlay: InspectOverlay

# Museum intro scene
var seen_museum_intro: bool = false
var seen_cop_anim: bool = false
var player_clothed: bool = false
var shrine_repaired: bool = false

# Street
var last_area = "museum"

var cop_fed: bool = false
var cop_encountered: bool = false
var has_donuts: bool = false
var has_bribe: bool = false

var cart_moved: bool = false
var wedge_l_removed: bool = false
var wedge_r_removed: bool = false

var mayor_encountered: bool = false
var trash_disposed_of: bool = false
var has_trash: bool = false
var trash_removed: int = 0
var received_mayor_gift: bool = false

var shady_encountered: bool = false
var shady_quest_complete: bool = false
var ring_thrown: bool = false
var has_ring: bool = false

var bouncer_encountered: bool = false
var knows_password: bool = false
var gave_password: bool = false
var gave_bribe: bool = false

# Cafe
var shopkeep_encountered: bool = false
var shopkeep_angry: bool = false
var shopkeep_quest_given: bool = false
var crowbar_collected: bool = false
var has_turtle: bool = false
var turtle_returned: bool = false

func set_cursor(state: int):
	if state == 0:
		Input.set_custom_mouse_cursor(cursor_idle)
		cursor = cursor_idle_small
	elif state == 1:
		Input.set_custom_mouse_cursor(cursor_hover)
		cursor = cursor_hover_small

func reveal_item(name: String):
	inspect_overlay.reveal(name)
