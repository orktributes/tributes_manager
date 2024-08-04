extends TextureRect

var dir_name = ""
var sites = ""
func _ready():
	var is_done = get_node("CheckButton")
	is_done.toggled.connect(_on_check_button_toggled)
	var open_dir = get_node("open_dir")
	open_dir.pressed.connect(_on_open_dir_pressed)

func _on_open_dir_pressed():
	print("dir_name var in pressed DEBUG: "+dir_name)
	print("sites var in pressed DEBUG: "+sites)
	OS.shell_open(OS.get_user_data_dir()+"/tributes/"+sites+"/"+dir_name)

func _on_check_button_toggled(toggled_on):
	print("toggled_on arg DEBUG: "+toggled_on)
	print("dir_name var in toggled DEBUG: "+dir_name)
	print("sites var in toggled DEBUG: "+sites)
	if toggled_on == true:
		DirAccess.rename_absolute(
			"user://tributes/"+sites+"/"+dir_name,
			"user://tributes/done/"+dir_name
		)
