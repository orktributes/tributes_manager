extends TextureRect

var dir_name = ""
var sites = ""
var is_config_load = false
var config_file = "user://config.cfg"
var config
var video_type
var fd

func load_config():
	config = ConfigFile.new()
	
	var err = config.load(config_file)
	if err != OK:
		print_rich("[color=Red]BEBUG[/color] load config file err: "+err)
		
	video_type = config.get_value("config","video_type")
	print_rich("[color=Blue]BEBUG[/color] config get video_type key value: "+video_type)
	is_config_load = true

func _ready():
	if is_config_load == false:
		load_config()
	var is_done = $CheckButton
	is_done.toggled.connect(_on_check_button_toggled)
	var open_dir = $open_dir
	open_dir.pressed.connect(_on_open_dir_pressed)
	var pick_video = $pick_video
	pick_video.pressed.connect(_on_pick_video_pressed)
	fd = $fd
	fd.set_filters(PackedStringArray([video_type]))
	fd.file_selected.connect(_on_file_dialog_file_selected)

func _on_open_dir_pressed():
	print("DEBUG: dir_name var in pressed "+dir_name)
	print("DEBUG: sites var in pressed "+sites)
	OS.shell_open(OS.get_user_data_dir()+"/tributes/"+sites+"/"+dir_name)

func _on_check_button_toggled(toggled_on):
	print("DEBUG: toggled_on arg "+ str(toggled_on))
	print("DEBUG: dir_name var in toggled "+dir_name)
	print("DEBUG: sites var in toggled "+sites)
	if toggled_on == true:
		print("DEBUG: moveing "+"user://tributes/"+sites+"/"+dir_name+" to "+"user://tributes/done/"+dir_name)
		DirAccess.rename_absolute(
			"user://tributes/"+sites+"/"+dir_name,
			"user://tributes/done/"+dir_name
		)

func _on_pick_video_pressed():
	fd.show()

func _on_file_dialog_file_selected(path):
	print("DEBUG: video path "+path)
	DirAccess.copy_absolute(
		path,
		"user://tributes/"+sites+"/"+dir_name+"/record/cum.mkv"
	)


#func _on_gui_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.button_index == 1:
		#print(event.get_button_index())
		#print("lll")
		##do_thing()
