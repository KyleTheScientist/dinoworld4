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
var inventory_overlay: InventoryOverlay

var voice_pitch: float:
	set(value):
		var sig = 1 / (1 + 20 ** (-value + 1))
		voice_pitch = remap(sig, 0, 1, .4, 1.5)

@export_category("Museum Interior")
@export var seen_museum_intro: bool = false
@export var seen_cop_anim: bool = false
@export var player_clothed: bool = false
@export var poster_torn: bool = false
@export var shrine_repaired: bool = false

@export_category("Street")
@export var last_area = "museum"

@export_subgroup("Cop")
@export var cop_fed: bool = false
@export var cop_encountered: bool = false
@export var has_donuts: bool = false
@export var has_bribe: bool = false

@export_subgroup("Mayor")
@export var mayor_encountered: bool = false
@export var trash_disposed_of: bool = false
@export var has_trash: bool = false
@export var trash_removed: int = 0
@export var has_autograph: bool = false

@export_subgroup("Shady")
@export var shady_encountered: bool = false
@export var shady_quest_complete: bool = false
@export var ring_thrown: bool = false

@export_subgroup("Bouncer")
@export var bouncer_encountered: bool = false
@export var has_ring: bool = false
@export var gave_bribe: bool = false
@export var gave_password: bool = false

@export_subgroup("Cart")
@export var cart_moved: bool = false
@export var wedge_l_removed: bool = false
@export var wedge_r_removed: bool = false

@export_subgroup("Nibbles")
@export var nibbles_encountered: bool = false
@export var has_coin: bool = false

@export_category("Cafe")
@export var shopkeep_encountered: bool = false
@export var shopkeep_angry: bool = false
@export var shopkeep_quest_given: bool = false

@export_category("Sewer")
@export var has_turtle: bool = false
@export var turtle_returned: bool = false
@export var fishing_rod_reeled: bool = false
@export var has_magnet: bool = false
@export var coin_in_water: bool = false
@export var ring_in_water: bool = false
@export var used_magnet: bool = false

@export_category("Precinct")
@export var prisoners_encountered: bool = false
@export var has_wallet: bool = false
@export var has_candy: bool = false
@export var knows_password: bool = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func set_cursor(state: int):
	if state == 0:
		Input.set_custom_mouse_cursor(cursor_idle)
		cursor = cursor_idle_small
	elif state == 1:
		Input.set_custom_mouse_cursor(cursor_hover)
		cursor = cursor_hover_small

func reveal_item(item: String):
	inspect_overlay.reveal(item)
	inventory_overlay.add(item)
	
func remove_item(item: String):
	inventory_overlay.remove(item)

func on_npc_spoke(_letter: String, _letter_index, _speed: float):
	if _letter in [" ", ".", "*", '"']:
		$Speak.pitch_scale = voice_pitch
		$Speak.play()	
