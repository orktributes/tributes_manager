class_name linux_files

var user_dir = DirAccess.open("user://")

func make_files():
	print("DEBUG linux_files.make_files func:")
	var output = []
	# if user://bin/ exists skip if not make it
	if DirAccess.dir_exists_absolute("user://bin/") != true:
		print("DEBUG linux_files.make_files func: making user://bin/")
		DirAccess.make_dir_absolute("user://bin/")
	else :
		print("DEBUG linux_files.make_files func: user://bin/ exists")
		
	# if user://tributes exists skip if not make it
	if DirAccess.dir_exists_absolute("user://tributes") != true:
		print("DEBUG linux_files.make_files func: making user://tributes")
		DirAccess.make_dir_absolute("user://tributes")
	else :
		print("DEBUG linux_files.make_files func: user://tributes exists")
		
	# if user://tributes/cuming exists skip if not make it
	if DirAccess.dir_exists_absolute("user://tributes/cuming") != true:
		print("DEBUG linux_files.make_files func: making user://tributes/cuming")
		DirAccess.make_dir_absolute("user://tributes/cuming")
	else :
		print("DEBUG linux_files.make_files func: user://tributes/cuming exists")

	# if user://tributes/done exists skip if not make it
	if DirAccess.dir_exists_absolute("user://tributes/done") != true:
		print("DEBUG linux_files.make_files func: making user://tributes/done")
		DirAccess.make_dir_absolute("user://tributes/done")
	else :
		print("DEBUG linux_files.make_files func: user://tributes/done exists")

	# if user://tributes/twitter exists skip if not make it
	if DirAccess.dir_exists_absolute("user://tributes/twitter") != true:
		print("DEBUG linux_files.make_files func: making user://tributes/twitter")
		DirAccess.make_dir_absolute("user://tributes/twitter")
	else :
		print("DEBUG linux_files.make_files func: user://tributes/twitter exists")

	# if user://tributes/bsky exists skip if not make it
	if DirAccess.dir_exists_absolute("user://tributes/bluesky") != true:
		print("DEBUG linux_files.make_files func: making user://tributes/bluesky")
		DirAccess.make_dir_absolute("user://tributes/bluesky")
	else :
		print("DEBUG linux_files.make_files func: user://tributes/bluesky exists")

	# if user://bin/gallery-dl.bin exists skip if not copy it
	if FileAccess.file_exists("user://bin/gallery-dl.bin") != true:
		print("DEBUG linux_files.make_files func: copying gallery-dl.bin to user://bin/ and making it executable")
		user_dir.copy(
			"res://bin/gallery-dl.bin",
			"user://bin/gallery-dl.bin"
		)
		OS.execute("chmod",["+x",OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.bin"],output,true,true)
		print("DEBUG linux_files.make_files func: output of chmod: "+str(output))
	else :
		print("DEBUG linux_files.make_files func: gallery-dl.bin exists in user://bin/")

	# if user://bin/config.json exists skip it not copy it
	if FileAccess.file_exists("user://bin/config.json") != true:
		print("DEBUG linux_files.make_files func: copying config.json to user://bin/")
		user_dir.copy(
			"res://bin/config.json",
			"user://bin/config.json"
		)
	else :
		print("DEBUG linux_files.make_files func: config.json exists in user://bin/")
