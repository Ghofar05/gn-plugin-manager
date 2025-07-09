extends Node2D


@onready var this: AnimatedSprite2D = $"."


func _process(delta: float) -> void:
	this.play("default")
	global_position = lerp(global_position,get_global_mouse_position(),0.01)
	
	
	var dir = get_global_mouse_position().x - global_position.x
	if dir > 0 :
		this.flip_h = false
	else:
		this.flip_h = true
	
		
