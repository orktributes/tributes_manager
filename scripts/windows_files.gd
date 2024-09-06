class_name windows_files

var user_dir = DirAccess.open("user://")

func make_files():
	var output = []
	if DirAccess.dir_exists_absolute("user://bin/") != true:
		print("DEBUG: making user://bin/")
		DirAccess.make_dir_absolute("user://bin/")
	else :
		print("DEBUG: user://bin/ exists")
		
	if DirAccess.dir_exists_absolute("user://tributes") != true:
		print("DEBUG: making user://tributes")
		DirAccess.make_dir_absolute("user://tributes")
	else :
		print("DEBUG: user://tributes exists")
	
	if DirAccess.dir_exists_absolute("user://tributes/done") != true:
		print("DEBUG: making user://tributes/done")
		DirAccess.make_dir_absolute("user://tributes/done")
	else :
		print("DEBUG: user://tributes/done exists")
		
	if DirAccess.dir_exists_absolute("user://tributes/twitter") != true:
		print("DEBUG: making user://tributes/twitter")
		DirAccess.make_dir_absolute("user://tributes/twitter")
	else :
		print("DEBUG: user://tributes/twitter exists")
		
	if DirAccess.dir_exists_absolute("user://tributes/rule34") != true:
		print("DEBUG: making user://tributes/rule34")
		DirAccess.make_dir_absolute("user://tributes/rule34")
	else :
		print("DEBUG: user://tributes/rule34 exists")
		
	if DirAccess.dir_exists_absolute("user://tributes/pixiv") != true:
		print("DEBUG: making user://tributes/pixiv")
		DirAccess.make_dir_absolute("user://tributes/pixiv")
	else :
		print("DEBUG: user://tributes/pixiv exists")
		
	if FileAccess.file_exists("user://bin/gallery-dl.exe") != true:
		print("DEBUG: copying gallery-dl.exe to user://bin/ and making it executable")
		user_dir.copy(
			"res://bin/gallery-dl.exe",
			"user://bin/gallery-dl.exe"
		)
		#OS.execute("chmod",["+x",OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.bin"],output,true,true)
		#print("BEBUG: output of chmod "+str(output))
	else :
		print("DEBUG: gallery-dl.exe exists in user://bin/")
		
	if FileAccess.file_exists("user://bin/config.json") != true:
		print("DEBUG: copying config.json to user://bin/")
		user_dir.copy(
			"res://bin/config.json",
			"user://bin/config.json"
		)
	else :
		print("DEBUG: config.json exists in user://bin/")
