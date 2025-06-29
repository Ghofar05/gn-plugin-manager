extends Control

var default = preload("res://assets/pointer_b.png")
var point = preload("res://assets/hand_small_point.png")
var main = "res://scenes/main.tscn"

@onready var video_stream_player: VideoStreamPlayer = $AspectRatioContainer/VideoStreamPlayer
@onready var thumb_1: TextureButton = $HBoxContainer/thumb1
@onready var thumb_2: TextureButton = $HBoxContainer/thumb2
@onready var thumb_3: TextureButton = $HBoxContainer/thumb3
@onready var paused_label: Label = $AspectRatioContainer/VideoStreamPlayer/paused_label
@onready var imageview: TextureRect = $imageview


var is_video_pause:bool = true
var data:Dictionary = {
	"thumb_2_img":"",
	"thumb_3_img":"",
	"current_selected":[0,0,0]
}


var path = Global.current_selection_path
var this_name = Global.current_selection_name






func _ready() -> void:
	var dir = DirAccess.open(path)
	var list_dir = dir.get_directories()
	var list_file
	var update_png_file = []
	var update_ogv_file
	var vid_thumbnail:Image
	var img_thumbnail1:Image
	var img_thumbnail2:Image
	
	for i in list_dir:
		print(i)
	
	var newPath = str(path+"/"+this_name)
	
	dir = DirAccess.open(newPath)
	list_file = dir.get_files()
	print("ini list file mentahan = "+str(list_file))
	
	for i in list_file:
		if ".png" in i:
			update_png_file.append(i)
			pass
		elif ".ogv" in i:
			update_ogv_file = i
			
	print("ini list file png dari mentahan = "+str(update_png_file))
	print (update_ogv_file)
	
	
	var video_file = VideoStreamTheora.new()
	video_file.file = newPath+"/"+update_ogv_file
	video_stream_player.stream = video_file
	video_stream_player.loop = true
	video_stream_player.play()
	video_stream_player.paused = true
	paused_label.show()
	
	
	vid_thumbnail = video_stream_player.get_video_texture().get_image()
	thumb_1.texture_normal = ImageTexture.create_from_image(vid_thumbnail)
	
	img_thumbnail1 = Image.load_from_file(newPath+"/"+update_png_file[0])
	img_thumbnail2 = Image.load_from_file(newPath+"/"+update_png_file[1])
	
	thumb_2.texture_normal = ImageTexture.create_from_image(img_thumbnail1)
	data.set("thumb_2_img",thumb_2.texture_normal)
	thumb_3.texture_normal = ImageTexture.create_from_image(img_thumbnail2)
	data.set("thumb_3_img",thumb_3.texture_normal)
	
	print(video_stream_player.is_playing())
	print(video_stream_player.scale)
	
	print(data)
	



func _on_video_stream_player_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(default,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.


func _on_video_stream_player_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.


func _on_video_stream_player_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB"):
		if not is_video_pause:
			is_video_pause = true
			video_stream_player.paused = true
			paused_label.show()
		else:
			is_video_pause = false
			video_stream_player.paused = false
			paused_label.hide()
	pass # Replace with function body.


func _on_thumb_1_pressed() -> void:
	video_stream_player.show()
	imageview.hide()
	pass # Replace with function body.


func _on_thumb_2_pressed() -> void:
	imageview.show()
	paused_label.show()
	video_stream_player.paused = true
	video_stream_player.hide()
	imageview.texture = data["thumb_2_img"]
	
	
	pass # Replace with function body.


func _on_thumb_3_pressed() -> void:
	imageview.show()
	paused_label.show()
	video_stream_player.paused = true
	video_stream_player.hide()
	imageview.texture = data["thumb_3_img"]
	pass # Replace with function body.


func _on_thumb_1_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.


func _on_thumb_1_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(default,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.


func _on_thumb_2_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.


func _on_thumb_2_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(default,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.


func _on_thumb_3_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.


func _on_thumb_3_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(default,Input.CURSOR_ARROW,Vector2(12,12))
	pass # Replace with function body.


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file(main)
	pass # Replace with function body.
