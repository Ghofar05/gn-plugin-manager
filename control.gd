extends Control

var is_on:bool

func _ready() -> void:
	$Label.add_theme_color_override("font_color",Color.GREEN)

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$Label.add_theme_color_override("font_color",Color.AQUA)
	else:
		$Label.add_theme_color_override("font_color",Color.GREEN)
	
	
