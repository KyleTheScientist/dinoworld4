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

var voice_pitch: float:
	set(value):
		var sig = 1 / (1 + 20 ** (-value + 1))
		voice_pitch = remap(sig, 0, 1, .4, 1.2)

@export_category("Museum Interior")
var seen_museum_intro: bool = false
var seen_cop_anim: bool = false
var player_clothed: bool = false
var poster_torn: bool = false
var shrine_repaired: bool = false

@export_category("Street")
var last_area = "museum"

@export_subgroup("Cop")
var cop_fed: bool = false
var cop_encountered: bool = false
var has_donuts: bool = false
var has_bribe: bool = false

@export_subgroup("Mayor")
var mayor_encountered: bool = false
var trash_disposed_of: bool = false
var has_trash: bool = false
var trash_removed: int = 0
var has_autograph: bool = false

@export_subgroup("Shady")
var shady_encountered: bool = false
var shady_quest_complete: bool = false
var ring_thrown: bool = false
var has_ring: bool = false

@export_subgroup("Bouncer")
var bouncer_encountered: bool = false
var gave_password: bool = false
var gave_bribe: bool = false
var gave_ring: bool = false

@export_subgroup("Cart")
var cart_moved: bool = false
var wedge_l_removed: bool = false
var wedge_r_removed: bool = false

@export_subgroup("Nibbles")
var nibbles_encountered: bool = false
var has_coin: bool = false

@export_category("Cafe")
var shopkeep_encountered: bool = false
var shopkeep_angry: bool = false
var shopkeep_quest_given: bool = false

@export_category("Sewer")
var has_turtle: bool = false
var turtle_returned: bool = false
var fishing_rod_reeled: bool = false
var has_magnet: bool = false
var coin_in_water: bool = false
var ring_in_water: bool = false
var used_magnet: bool = false

@export_category("Precinct")
var prisoners_encountered: bool = false
var has_wallet: bool = false
var has_candy: bool = false
var knows_password: bool = false

func set_cursor(state: int):
	if state == 0:
		Input.set_custom_mouse_cursor(cursor_idle)
		cursor = cursor_idle_small
	elif state == 1:
		Input.set_custom_mouse_cursor(cursor_hover)
		cursor = cursor_hover_small

func reveal_item(item: String):
	inspect_overlay.reveal(item)

func on_npc_spoke(_letter: String, _letter_index, _speed: float):
	if _letter in [" ", ".", "*"]:
		$Speak.pitch_scale = voice_pitch
		$Speak.play()	
