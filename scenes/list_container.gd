extends Control

var lst = preload("res://scenes/list.tscn")
var path = Global.source

func _ready() -> void:
	
	
	#var a = FileAccess.open(path,FileAccess.READ)
	#var b = FileAccess.get_file_as_string(path)
	#print (b)
	
	var dir = DirAccess.open(path)
	var list_plugin = dir.get_directories()
	
	var total = list_plugin.size()
	
	
	for i in total:
		$ScrollContainer/VBoxContainer.add_child(lst.instantiate())
		
	var a = get_parent().find_child("VBoxContainer").get_children()
	var y = 0
	for i in a:
		i.change_label(str(list_plugin[y]))
		i.load_save_data(str(list_plugin[y]))
		y += 1
		pass
