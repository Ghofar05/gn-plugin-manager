extends HBoxContainer

var default = preload("res://assets/pointer_b.png")
var point = preload("res://assets/hand_small_point.png")
var desc = "res://scenes/description.tscn"


var path = Global.source

var targetPathXMLJS = Global.target_source_xmljs
var targetPathSWF = Global.target_source_swf
var is_update_available = false

var data:Dictionary = {
	"this_name":"",
	"installed_files":[],
	"installed_jsfl":[],
	"installed_xml":[],
	"installed_swf":[],
	"is_installed":false,
	"last_version":1
	
	
	
}
var installed_list_file = []

var is_this_installed:bool = false

func change_label(nama) -> void:
	name = nama
	data["this_name"] = nama
	$TextureRect/Label.text = nama
	update_file_icon()

func load_save_data(nama) -> void:
	
	
	
	if FileAccess.file_exists("user://"+str(nama)+".json"):
		var file = FileAccess.open("user://"+str(nama)+".json",FileAccess.READ)
		var json = file.get_as_text()
		data = JSON.parse_string(json)
		file.close()
	else:
		print("no "+ str(nama)+".json exists")
		
	installed_list_file = data["installed_files"]
	
	if data["is_installed"]:
		is_this_installed = true
		
		
		var newPath = path+"/"+name
		if FileAccess.file_exists(newPath+"/"+name+".json"):
			var file = FileAccess.open(newPath+"/"+name+".json",FileAccess.READ)
			var json = file.get_as_text()
			var info = JSON.parse_string(json)
			print(info)
			is_update_available = int(info["versi"]) > int(data["last_version"])
			file.close()
		else:
			OS.alert("no "+ str(name)+".json in server")
		
		
	else :
		is_this_installed = false
	


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
		if ".jsfl" in i :
			if not i in list_name_updatejsxml:
				list_name_updatejsxml.append(str(name)+".jsfl")
				data["installed_jsfl"].append(str(name)+".jsfl")
			
		elif ".xml" in i:
			if not i in list_name_updatejsxml:
				list_name_updatejsxml.append(str(name)+".xml")
				data["installed_xml"].append(str(name)+".xml")
		elif ".swf" in i:
			if not i in list_name_swf:
				list_name_swf.append(str(name)+".swf")
				data["installed_swf"].append(str(name)+".swf")
			
	
	installed_list_file.append_array(list_name_updatejsxml)
	installed_list_file.append_array(list_name_swf)
	data["installed_files"] = installed_list_file
	data["is_installed"] = true
	var file = FileAccess.open("user://"+str(name)+".json",FileAccess.WRITE)
	var json = JSON.stringify(data)
	file.store_string(json)
	file.close()
	print(data)
	
	file = FileAccess.open(newPath+"/"+name+".json",FileAccess.READ)
	json = file.get_as_text()
	var info = JSON.parse_string(json)
	is_update_available = int(info["versi"]) > int(data["last_version"])
	data["last_version"] = info["versi"]
	print(data)
		
	file = FileAccess.open("user://"+str(name)+".json",FileAccess.WRITE)
	json = JSON.stringify(data)
	file.store_string(json)
	file.close()
	print(data)
	
	file = FileAccess.open(newPath+"/"+name+".json",FileAccess.READ)
	json = file.get_as_text()
	info = JSON.parse_string(json)
	is_update_available = int(info["versi"]) > int(data["last_version"])
	
	
	#memulai copy
	for i in list_name_updatejsxml:
		print(i)
		copyfile(i,dir,newPath,targetPathXMLJS)
		
	for i in list_name_swf:
		print(i)
		copyfile(i,dir,newPath,targetPathSWF)
	
	

	
	#print(data)
	#print("ini dari data: " + str(data["installed_jsfl"]))
	#print("ini installed list file nya : "+str(installed_list_file))


func uninstall_plugin() -> void:
	var dir
	if is_this_installed:
		for i in installed_list_file:
			print(i)
			if ".swf" in i:
				dir = DirAccess.open(targetPathSWF)
				delfile(i,dir,targetPathSWF)
				data["installed_swf"].erase(i)
				
			elif ".jsfl" in i:
				dir = DirAccess.open(targetPathXMLJS)
				delfile(i,dir,targetPathXMLJS)
				data["installed_swf"].erase(i)
				
			elif ".xml" in i:
				dir = DirAccess.open(targetPathXMLJS)
				delfile(i,dir,targetPathXMLJS)
				data["installed_swf"].erase(i)
	else :
		OS.alert("this plugin not installed")
			
	data["installed_files"] = []
	data["is_installed"] = false
	var file = FileAccess.open("user://"+str(name)+".json",FileAccess.WRITE)
	var json = JSON.stringify(data)
	file.store_string(json)
	file.close()
	print(data)
	
	pass



# untuk mencopy file
func copyfile(filename:String,dir:DirAccess,from:String,to:String):
	if dir.file_exists(from+"/"+filename):
		dir.copy(from+"/"+filename,to+"/"+filename)
	else:
		OS.alert("file yang mau copy tidak ada")

func delfile(filename:String,dir:DirAccess,to:String):
	if dir.file_exists(to+"/"+filename):
		dir.remove(to+"/"+filename)
	else :
		print(to+"/"+filename)


func _on_install_mouse_entered() -> void:
	if not is_this_installed or is_update_available:
		Input.set_custom_mouse_cursor(point,Input.CURSOR_ARROW,Vector2(12,12))



func _on_install_mouse_exited() -> void:
	if not is_this_installed or is_update_available:
		Input.set_custom_mouse_cursor(default,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.


func _on_uninstall_mouse_entered() -> void:
	if is_this_installed:
		Input.set_custom_mouse_cursor(point,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.


func _on_uninstall_mouse_exited() -> void:
	if is_this_installed:
		Input.set_custom_mouse_cursor(default,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.

func _ready() -> void:
	pass

	



func _process(_delta: float) -> void:
	if is_this_installed:
		if is_update_available:
			$install.texture_normal = load("res://assets/update_active.svg")
			$install.texture_pressed = load("res://assets/update passive.svg")
			$install.texture_disabled = load("res://assets/update passive.svg")
			$install.disabled = false
			$uninstall.disabled = false
		else :
			$install.texture_normal = load("res://assets/install on.svg")
			$install.texture_pressed = load("res://assets/install off.svg")
			$install.texture_disabled = load("res://assets/install off.svg")
			$install.disabled = true
			$uninstall.disabled = false
			
		
	else :
		$install.texture_normal = load("res://assets/install on.svg")
		$install.texture_pressed = load("res://assets/install off.svg")
		$install.texture_disabled = load("res://assets/install off.svg")
		$install.disabled = false
		$uninstall.disabled = true


func _on_install_pressed() -> void:
	install_plugin()
	is_this_installed = true
	pass # Replace with function body.


func _on_uninstall_pressed() -> void:
	uninstall_plugin()
	is_this_installed = false
	pass # Replace with function body.


func _on_texture_rect_pressed() -> void:
	Global.current_selection_name = data["this_name"]
	Global.current_selection_path = path
	get_tree().change_scene_to_file("res://scenes/description.tscn")
	pass # Replace with function body.
