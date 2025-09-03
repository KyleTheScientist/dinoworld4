class_name Debugger
extends CanvasLayer

func _ready() -> void:
	GameState.debugger = self

func write(obj1: Variant, obj2: Variant = null):
	visible = true
	var text = str(obj1)
	if obj2 != null:
		text += "\n" + str(obj2)
	$PanelContainer/Label.text = text
