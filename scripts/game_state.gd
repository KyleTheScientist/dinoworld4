extends Node

signal player_registered(Dino)

var player: Dino:
	set(player):
		player = player
		player_registered.emit(player)

# Museum intro scene
var seen_museum_intro: bool = false
var player_clothed: bool = false
var shrine_repaired: bool = false
var seen_cop_anim: bool = false

# Street
var last_area = "museum"
var cop_exhausted: bool = true
var spoken_to_cop: bool = false
