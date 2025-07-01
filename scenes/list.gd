extends HBoxContainer

var default = preload("res://assets/pointer_b.png")
var point = preload("res://assets/hand_small_point.png")
var desc = "res://scenes/description.tscn"

var path = Global.source

var targetPathXMLJS = Global.target_source_xmljs
var targetPathSWF = Global.target_source_swf


var data:Dictionary = {
	"this_name":"",
	"installed_jsfl":[],
	"installed_xml":[],
	"installed_swf":[],
	
	
}
var installed_list_file = []

var is_installed:bool = false

func change_label(nama) -> void:
	name = nama
	data["this_name"] = nama
	$TextureRect/Label.text = nama
	update_file_icon()

func update_file_icon() -> void:
	var dir = DirAccess.open(str(path+"/"+name))
	var file_list = dir.get_files()
	#print(file_list)
	#print(str(name)+"-demo.ogv")
	for i in file_list:
		if ".jsfl" in i:
			$TextureRect/js.show()
		elif ".xml" in i:
			$TextureRect/xml.show()
		elif ".swf" in i:
			$TextureRect/swf.show()
		elif ".ogv" in i:
			$TextureRect/video.show()
	pass


func install_plugin() -> void:
	var newPath = str(path+"/"+name)
	var dir = DirAccess.open(newPath)
	var file_list = dir.get_files()
	var list_name_updatejsxml = []
	var list_name_swf = []
	
	# check apakah ada file yang ga ada, dan akan di update
	for i in file_list:
		if i == str(name)+".jsfl":
			list_name_updatejsxml.append(str(name)+".jsfl")
			data["installed_jsfl"].append(str(name)+".jsfl")
			
		elif i == str(name)+".xml":
			list_name_updatejsxml.append(str(name)+".xml")
			data["installed_xml"].append(str(name)+".xml")
		elif i == str(name)+".swf":
			list_name_swf.append(str(name)+".swf")
			data["installed_swf"].append(str(name)+".swf")
			
	
	installed_list_file.append_array(list_name_updatejsxml)
	installed_list_file.append_array(list_name_swf)
	
	
	
	
	#memulai copy
	for i in list_name_updatejsxml:
		copyfile(i,dir,newPath,targetPathXMLJS)
		
	for i in list_name_swf:
		copyfile(i,dir,newPath,targetPathSWF)
	
	
	print(data)
	print("ini dari data: " + str(data["installed_jsfl"]))
	print("ini installed list file nya : "+str(installed_list_file))


func uninstall_plugin() -> void:
	var dir
	for i in installed_list_file:
		if ".swf" in i:
			dir = DirAccess.open(targetPathSWF)
			delfile(i,dir,targetPathSWF)
			data["installed_swf"].pop_front()
			
		elif ".jsfl" in i:
			dir = DirAccess.open(targetPathXMLJS)
			delfile(i,dir,targetPathXMLJS)
			data["installed_jsfl"].pop_front()
			
		elif ".xml" in i:
			dir = DirAccess.open(targetPathXMLJS)
			delfile(i,dir,targetPathXMLJS)
			data["installed_xml"].pop_front()
			
	
	print(data)
	
	pass



# untuk mencopy file
func copyfile(filename:String,dir:DirAccess,from:String,to:String):
	var is_file_exist = dir.file_exists(to+"/"+filename)
	dir.copy(from+"/"+filename,to+"/"+filename)
	pass

func delfile(filename:String,dir:DirAccess,to:String):
	var is_file_exist = dir.file_exists(to+"/"+filename)
	dir.remove(to+"/"+filename)


func _on_install_mouse_entered() -> void:
	if not is_installed :
		Input.set_custom_mouse_cursor(point,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.


func _on_install_mouse_exited() -> void:
	if not is_installed :
		Input.set_custom_mouse_cursor(default,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.


func _on_uninstall_mouse_entered() -> void:
	if is_installed:
		Input.set_custom_mouse_cursor(point,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.


func _on_uninstall_mouse_exited() -> void:
	if is_installed:
		Input.set_custom_mouse_cursor(default,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.

func _ready() -> void:
	$install.disabled = false
	$uninstall.disabled = true


func _process(_delta: float) -> void:
	if is_installed:
		$install.disabled = true
		$uninstall.disabled = false
	else :
		$install.disabled = false
		$uninstall.disabled = true


func _on_install_pressed() -> void:
	install_plugin()
	is_installed = true
	pass # Replace with function body.


func _on_uninstall_pressed() -> void:
	uninstall_plugin()
	is_installed = false
	pass # Replace with function body.


func _on_texture_rect_pressed() -> void:
	Global.current_selection_name = data["this_name"]
	Global.current_selection_path = path
	get_tree().change_scene_to_file("res://scenes/description.tscn")
	pass # Replace with function body.
