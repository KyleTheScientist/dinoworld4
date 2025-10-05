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

@export_category("Museum")
@export var seen_museum_intro: bool = false
@export var seen_museum_outro: bool = false
@export var seen_cop_anim: bool = false
@export var player_clothed: bool = false
@export var poster_torn: bool = false
@export var shrine_repaired: bool = false
@export var drumsticks_collected: int = 0
@export var shrine_activated: bool = false

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
@export var mayor_quest_complete: bool = false

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

@export_subgroup("Nibbles")
@export var nibbles_encountered: bool = false
@export var has_coin: bool = false

@export_category("Cafe")
@export var shopkeep_encountered: bool = false
@export var shopkeep_angry: bool = false
@export var shopkeep_quest_given: bool = false
@export var has_cafe_drumstick: bool = false

@export_category("Sewer")
@export var has_turtle: bool = false
@export var turtle_returned: bool = false
@export var fishing_rod_reeled: bool = false
@export var has_magnet: bool = false
@export var coin_in_water: bool = false
@export var ring_in_water: bool = false
@export var used_magnet: bool = false
@export var knows_combination: bool = false
@export var cave_unlocked: bool = false
var combination_lock_code: Array = []
var combination_string: String

@export_category("Precinct")
@export var prisoners_encountered: bool = false
@export var has_wallet: bool = false
@export var has_candy: bool = false
@export var knows_password: bool = false
@export var has_precinct_drumstick: bool = false

@export_category("Speakeasy")
@export var has_speakeasy_drumstick: bool = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	generate_lock_code()

func generate_lock_code():
	if len(combination_lock_code) == 0:
		combination_lock_code = [0, 5, 10, 15, 20, 25, 30, 35]
		combination_lock_code.shuffle()
		while len(combination_lock_code) > 3:
			combination_lock_code.remove_at(randi() % len(combination_lock_code))
		combination_string = str(combination_lock_code).replace("[", "").replace("]", "")

func reset() -> void:
	seen_museum_intro = false
	seen_museum_outro = false
	seen_cop_anim = false
	player_clothed = false
	poster_torn = false
	shrine_repaired = false
	drumsticks_collected = 0
	shrine_activated = false
	last_area = "museum"
	cop_fed = false
	cop_encountered = false
	has_donuts = false
	has_bribe = false
	mayor_encountered = false
	trash_disposed_of = false
	has_trash = false
	trash_removed = 0
	has_autograph = false
	mayor_quest_complete = false
	shady_encountered = false
	shady_quest_complete = false
	ring_thrown = false
	bouncer_encountered = false
	has_ring = false
	gave_bribe = false
	gave_password = false
	cart_moved = false
	nibbles_encountered = false
	has_coin = false
	shopkeep_encountered = false
	shopkeep_angry = false
	shopkeep_quest_given = false
	has_cafe_drumstick = false
	has_turtle = false
	turtle_returned = false
	fishing_rod_reeled = false
	has_magnet = false
	coin_in_water = false
	ring_in_water = false
	used_magnet = false
	knows_combination = false
	cave_unlocked = false
	prisoners_encountered = false
	has_wallet = false
	has_candy = false
	knows_password = false
	has_precinct_drumstick = false
	has_speakeasy_drumstick = false
	combination_lock_code = []
	generate_lock_code()

func set_cursor(state: int):
	if state == 0:
		Input.set_custom_mouse_cursor(cursor_idle)
		cursor = cursor_idle_small
	elif state == 1:
		Input.set_custom_mouse_cursor(cursor_hover)
		cursor = cursor_hover_small

func reveal_item(item: String, store: bool = true):
	inspect_overlay.reveal(item, store)
	if store:
		inventory_overlay.add(item)
	
func remove_item(item: String):
	inventory_overlay.remove(item)

func on_npc_spoke(_letter: String, _letter_index, _speed: float):
	if _letter in [" ", ".", "*", '"']:
		$Speak.pitch_scale = voice_pitch
		$Speak.play()	

func on_npc_started_speaking():
	$Speak.pitch_scale = voice_pitch
	$Speak.play()	

func change_scene(scene: String):
	$SceneTransition/AnimationPlayer.play("resolve")
	await $SceneTransition/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(scene)
	
func show_scene():
	$SceneTransition/AnimationPlayer.play("dissolve")
