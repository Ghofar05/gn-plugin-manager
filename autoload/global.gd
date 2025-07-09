extends Node


# the main source path, you can change it as needed
var source = "//ARTBID-SERVER/Animation Assets/Adobe Animate/Plugin"

#this only for test
#var source = "C:/Users/Rova/Documents/test plugin manager/copy file"

# the target path for xml and jsfl according the default path, you can change it as needed
var target_source_xmljs = "C:/Users/User/AppData/Local/Adobe/Animate 2024/en_US/Configuration/Commands"

#this only for test
#var target_source_xmljs = "C:/Users/Rova/AppData/Local/Adobe/Animate 2024/en_US/Configuration/Commands"

# the target path for swf according the default path, you can change it as needed
var target_source_swf = "C:/Users/User/AppData/Local/Adobe/Animate 2024/en_US/Configuration/WindowSWF"

#this only for test
#var target_source_swf = "C:/Users/Rova/AppData/Local/Adobe/Animate 2024/en_US/Configuration/WindowSWF"


# if you need to difference of client ID, this from OS.get_unique_id()
var Device_id = ""

# for debug
var current_selection_path = ""
var current_selection_name = ""
