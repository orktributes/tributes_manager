extends TextureRect

var dir_name = ""
var img_name = ""
var sites = ""
var fd

func _ready():
	# set up the buttons and signals
	var is_done = $CheckButton
	is_done.toggled.connect(_on_check_button_toggled)
	var open_dir = $open_dir
	open_dir.pressed.connect(_on_open_dir_pressed)
	var pick_video = $pick_video
	pick_video.pressed.connect(_on_pick_video_pressed)
	fd = $fd
	fd.file_selected.connect(_on_file_dialog_file_selected)
	var copy_to_viewer = $copy_to_viewer
	copy_to_viewer.pressed.connect(_on_copy_to_viewer_pressed)

func _on_open_dir_pressed():
	# open the folder of the image in the default file browser
	print("DEBUG open_dir func: dir_name var in pressed "+dir_name)
	print("DEBUG open_dir func: sites var in pressed "+sites)
	OS.shell_open(OS.get_user_data_dir()+"/tributes/"+sites+"/"+dir_name)

func _on_check_button_toggled(toggled_on):
	# move the image to the done folder
	print("DEBUG is_done func: toggled_on arg "+ str(toggled_on))
	print("DEBUG is_done func: dir_name var in toggled "+dir_name)
	print("DEBUG is_done func: sites var in toggled "+sites)
	if toggled_on == true:
		print("DEBUG is_done func: moveing "+"user://tributes/"+sites+"/"+dir_name+" to "+"user://tributes/done/"+dir_name)
		DirAccess.rename_absolute(
			"user://tributes/"+sites+"/"+dir_name,
			"user://tributes/done/"+dir_name
		)

func _on_pick_video_pressed():
	# show a file browser for you to pick a video file and copy it to the record folder of the image
	print("DEBUG pick_video func:")
	fd.show()

func _on_file_dialog_file_selected(path):
	print("DEBUG pick_video func: video file path: "+path)
	DirAccess.copy_absolute(
		path,
		"user://tributes/"+sites+"/"+dir_name+"/record/cum.mkv"
	)
	
func _on_copy_to_viewer_pressed():
	print("DEBUG copy_to_viewer func: image to be copy to cuming: "+"user://tributes/"+sites+"/"+dir_name+"/src/"+img_name)
	DirAccess.copy_absolute(
		"user://tributes/"+sites+"/"+dir_name+"/src/"+img_name,
		"user://tributes/cuming/cuming"
	)
