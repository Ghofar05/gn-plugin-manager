extends Node
@onready var label: Label = $Control/Label

# custom mouse pointer
var default = preload("res://assets/pointer_b.png")
var point = preload("res://assets/hand_small_point.png")

# summary
var list_file:Dictionary = {
	"jsfl": [],
	"xml":[],
	"swf":[],
	"total jsfl":0,
	"total xml":0,
	"total swf":0
}


func _ready() -> void:
	var t = get_tree().create_tween().set_loops()
	t.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	t.tween_property(label,"position",Vector2(321.5,5.0),0.5)
	t.tween_property(label,"position",Vector2(321.5,0),0.5)
	
	# check is path exist
	var init = DirAccess.open(Global.source)
	if init:
		print("server connected")
		Global.Device_id = OS.get_unique_id()
		
		var dir = DirAccess.open(Global.target_source_xmljs)
		var listxmljs = dir.get_files()
		for i in listxmljs:
			if ".jsfl" in i:
				list_file["jsfl"].append(i)
			elif ".xml" in i:
				list_file["xml"].append(i)
			elif ".swf" in i:
				list_file["swf"].append(i)
			
			
		dir = DirAccess.open(Global.target_source_swf)
		listxmljs = []
		print(listxmljs)
		listxmljs = dir.get_files()
		for i in listxmljs:
			if ".swf" in i:
				list_file["swf"].append(i)
		
		list_file["total jsfl"] = list_file["jsfl"].size()
		list_file["total xml"] = list_file["xml"].size()
		list_file["total swf"] = list_file["swf"].size()
	else:
		OS.alert("sorry, cannot connect to server")
		get_tree().quit()
	
	

	
	#var file = FileAccess.open("user://test.json",FileAccess.WRITE)
	#var json = JSON.stringify(list_file)
	#file.store_string(json)
	#file.close()
	
	
	
	#var read = FileAccess.open("user://test.json",FileAccess.READ)
	#var yy = read.get_as_text()
	#print(yy)
	#var aa = JSON.parse_string(yy)
	#print(aa)
	
	



func _on_texture_button_pressed() -> void:
	OS.shell_open("https://www.youtube.com/")
	pass # Replace with function body.


func _on_texture_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.


func _on_texture_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(default,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.
