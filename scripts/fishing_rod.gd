extends AnimatedSprite2D

var has_magnet: bool = false
var cast: bool = true
var coin_hooked: bool = false
var ring_hooked: bool = false
var stuffs_hooked: int = 0

func _ready() -> void:
	$AnimationPlayer.play("reel" if GameState.fishing_rod_reeled else "cast")
	cast = not GameState.fishing_rod_reeled
	has_magnet = GameState.used_magnet
	$Hook/Magnet.visible = GameState.used_magnet
	$Hook.is_triggerable = not GameState.used_magnet
	

func _on_interactable_activated() -> void:
	$AnimationPlayer.play("reel" if cast else "cast")
	cast = not cast
	GameState.fishing_rod_reeled = not cast
	$Interactable.is_triggerable = true
	
func _on_hook_activated() -> void:
	if coin_hooked:
		GameState.coin_in_water = false
		GameState.has_coin = true
		GameState.reveal_item("Wallet")
		coin_hooked = false
		if stuffs_hooked > 1:
			$Hook/Magnet/Loot2.visible = false
		else:
			$Hook/Magnet/Loot1.visible = false
		stuffs_hooked -= 1
	elif ring_hooked:
		GameState.ring_in_water = false
		GameState.has_ring = true
		GameState.reveal_item("Watch")
		coin_hooked = false
		$Hook/Magnet/Loot1.visible = false
		stuffs_hooked -= 1
	
	$Hook.is_triggerable = stuffs_hooked > 0
	
	if GameState.has_magnet:
		has_magnet = true
		GameState.has_magnet = false
		GameState.used_magnet = true
		$Hook/Magnet.visible = true
	

func _on_reel_animation_finished(anim_name: StringName) -> void:
	if has_magnet and anim_name == "cast":
		stuffs_hooked = 0
		if GameState.coin_in_water:
			stuffs_hooked += 1
			coin_hooked = true
		if GameState.ring_in_water:
			stuffs_hooked += 1
			ring_hooked = true
		
		$Hook.is_triggerable = stuffs_hooked > 0
		$Hook/Magnet/Loot1.visible = stuffs_hooked > 0
		$Hook/Magnet/Loot2.visible = stuffs_hooked > 1
		
		
		
