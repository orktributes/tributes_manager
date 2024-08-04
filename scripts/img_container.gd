extends TextureRect

var dir_name = ""
var sites = ""
func _ready():
	var is_done = get_node("CheckButton")
	is_done.toggled.connect(_on_check_button_toggled)
	var open_dir = get_node("open_dir")
	open_dir.pressed.connect(_on_open_dir_pressed)

func _on_open_dir_pressed():
	print("DEBUG: dir_name var in pressed "+dir_name)
	print("DEBUG: sites var in pressed "+sites)
	OS.shell_open(OS.get_user_data_dir()+"/tributes/"+sites+"/"+dir_name)

func _on_check_button_toggled(toggled_on):
	print("DEBUG: toggled_on arg "+toggled_on)
	print("DEBUG: dir_name var in toggled "+dir_name)
	print("DEBUG: sites var in toggled "+sites)
	if toggled_on == true:
		print("DEBUG: moveing "+"user://tributes/"+sites+"/"+dir_name+" to "+"user://tributes/done/"+dir_name)
		DirAccess.rename_absolute(
			"user://tributes/"+sites+"/"+dir_name,
			"user://tributes/done/"+dir_name
		)
