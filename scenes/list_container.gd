extends Control

var lst = preload("res://scenes/list.tscn")
var path = "C:/Users/Rova/Documents/test plugin manager/copy file"

func _ready() -> void:
	
	
	#var a = FileAccess.open(path,FileAccess.READ)
	#var b = FileAccess.get_file_as_string(path)
	#print (b)
	
	var dir = DirAccess.open(path)
	var list_plugin = dir.get_directories()
	var x = dir.get_files()
	
	var total = list_plugin.size()
	
	for i in list_plugin :
		print(i)
	for i in x :
		print(i)
	
	
	
	for i in total:
		$ScrollContainer/VBoxContainer.add_child(lst.instantiate())
		
	var a = get_parent().find_child("VBoxContainer").get_children()
	var y = 0
	for i in a:
		i.change_label(str(list_plugin[y]))
		y += 1
		pass
