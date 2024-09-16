class_name linux_files

var user_dir = DirAccess.open("user://")

func make_files():
	var output = []
	if DirAccess.dir_exists_absolute("user://bin/") != true:
		print_rich("[color=Blue]BEBUG:[/color] making user://bin/")
		DirAccess.make_dir_absolute("user://bin/")
	else :
		print_rich("[color=Blue]BEBUG:[/color] user://bin/ exists")
		
	if DirAccess.dir_exists_absolute("user://tributes") != true:
		print_rich("[color=Blue]BEBUG:[/color] making user://tributes")
		DirAccess.make_dir_absolute("user://tributes")
	else :
		print_rich("[color=Blue]BEBUG:[/color] user://tributes exists")
	
	if DirAccess.dir_exists_absolute("user://tributes/done") != true:
		print_rich("[color=Blue]BEBUG:[/color] making user://tributes/done")
		DirAccess.make_dir_absolute("user://tributes/done")
	else :
		print_rich("[color=Blue]BEBUG:[/color] user://tributes/done exists")
		
	if DirAccess.dir_exists_absolute("user://tributes/twitter") != true:
		print_rich("[color=Blue]BEBUG:[/color] making user://tributes/twitter")
		DirAccess.make_dir_absolute("user://tributes/twitter")
	else :
		print_rich("[color=Blue]BEBUG:[/color] user://tributes/twitter exists")
		
	if DirAccess.dir_exists_absolute("user://tributes/rule34") != true:
		print_rich("[color=Blue]BEBUG:[/color] making user://tributes/rule34")
		DirAccess.make_dir_absolute("user://tributes/rule34")
	else :
		print_rich("[color=Blue]BEBUG:[/color] user://tributes/rule34 exists")
		
	if DirAccess.dir_exists_absolute("user://tributes/pixiv") != true:
		print_rich("[color=Blue]BEBUG:[/color] making user://tributes/pixiv")
		DirAccess.make_dir_absolute("user://tributes/pixiv")
	else :
		print_rich("[color=Blue]BEBUG:[/color] user://tributes/pixiv exists")
		
	if FileAccess.file_exists("user://bin/gallery-dl.bin") != true:
		print_rich("[color=Blue]BEBUG:[/color] copying gallery-dl.bin to user://bin/ and making it executable")
		user_dir.copy(
			"res://bin/gallery-dl.bin",
			"user://bin/gallery-dl.bin"
		)
		OS.execute("chmod",["+x",OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.bin"],output,true,true)
		print_rich("[color=Blue]BEBUG:[/color] output of chmod "+str(output))
	else :
		print_rich("[color=Blue]BEBUG:[/color] gallery-dl.bin exists in user://bin/")
		
	if FileAccess.file_exists("user://bin/config.json") != true:
		print_rich("[color=Blue]BEBUG:[/color] copying config.json to user://bin/")
		user_dir.copy(
			"res://bin/config.json",
			"user://bin/config.json"
		)
	else :
		print_rich("[color=Blue]BEBUG:[/color] config.json exists in user://bin/")
