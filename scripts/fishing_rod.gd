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
	$Hook.is_triggerable = false
	await get_tree().create_timer(1).timeout
	$Interactable.is_triggerable = true
	
func _on_hook_activated() -> void:
	if coin_hooked:
		GameState.coin_in_water = false
		GameState.has_coin = true
		GameState.reveal_item("Coin")
		coin_hooked = false
		if stuffs_hooked > 1:
			$Hook/Magnet/Loot2.visible = false
		else:
			$Hook/Magnet/Loot1.visible = false
		stuffs_hooked -= 1
	elif ring_hooked:
		GameState.ring_in_water = false
		GameState.has_ring = true
		GameState.reveal_item("Ring")
		coin_hooked = false
		$Hook/Magnet/Loot1.visible = false
		stuffs_hooked -= 1
	
	$Hook.is_triggerable = stuffs_hooked > 0
	
	if GameState.has_magnet:
		has_magnet = true
		GameState.remove_item("Magnet")
		GameState.has_magnet = false
		GameState.used_magnet = true
		$Hook/Magnet.visible = true
	

func _on_reel_animation_finished(anim_name: StringName) -> void:
	if not has_magnet:
		$Hook.is_triggerable = GameState.has_magnet
		$Hook/Shine.visible = GameState.has_magnet
	else:
		$Hook.is_triggerable = stuffs_hooked > 0
	if has_magnet and anim_name == "cast":
		stuffs_hooked = 0
		if GameState.coin_in_water:
			stuffs_hooked += 1
			coin_hooked = true
		if GameState.ring_in_water:
			stuffs_hooked += 1
			ring_hooked = true
		
		$Hook/Magnet/Loot1.visible = stuffs_hooked > 0
		$Hook/Magnet/Loot2.visible = stuffs_hooked > 1
	
		
		
		
