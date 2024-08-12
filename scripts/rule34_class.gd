class_name rule34_class
signal rule34_signal(dir)
var user_dir = DirAccess.open("user://")

func get_img(url,id):
	var output = []
	OS.execute(OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.bin",[
		"--cookies-from-browser",
		"firefox",
		url,
		"-d",
		OS.get_user_data_dir()+"/"+"bin",
		"-c",
		OS.get_user_data_dir()+"/"+"bin/"+"config.json",
	],output,true,true)
	print("output of gallery-dl DEBUG: "+str(output))
	
	if DirAccess.dir_exists_absolute("user://tributes/rule34/"+id) != true:
		print("DEBUG: making "+"user://tributes/rule34/"+id)
		DirAccess.make_dir_absolute("user://tributes/rule34/"+id)
		
	if DirAccess.dir_exists_absolute("user://tributes/rule34/"+id+"/"+"edited") != true:
		print("DEBUG: making "+"user://tributes/rule34/"+id+"/"+"edited")
		DirAccess.make_dir_absolute("user://tributes/rule34/"+id+"/"+"edited")
	
	if DirAccess.dir_exists_absolute("user://tributes/rule34/"+id+"/"+"record") != true:
		print("DEBUG: making "+"user://tributes/rule34/"+id+"/"+"record")
		DirAccess.make_dir_absolute("user://tributes/rule34/"+id+"/"+"record")
	
	if DirAccess.dir_exists_absolute("user://tributes/rule34/"+id+"/"+"src") != true:
		print("DEBUG: making "+"user://tributes/rule34/"+id+"/"+"src")
		DirAccess.make_dir_absolute("user://tributes/rule34/"+id+"/"+"src")
		
	if FileAccess.file_exists("user://tributes/rule34/"+id+"/"+"src/source.txt") != true:
		print("DEBUG: making source.txt for "+"user://tributes/rule34/"+id)
		FileAccess.open(
			"user://tributes/rule34/"+id+"/"+"src/source.txt",
			FileAccess.WRITE
		).store_string(
			"\n"+"#二次絵ぶっかけ #cumtributeِs #sop\n\n"+"image used in the tribute"+"\n"+url
		)
	
	if FileAccess.file_exists("user://tributes/rule34/"+id+"/edit.sh") != true:
		print("DEBUG: copying edit.sh to "+"user://tributes/rule34/"+id)
		user_dir.copy(
			"res://bin/edit.sh",
			"user://tributes/rule34/"+id+"/edit.sh"
		)
	
	for i in DirAccess.get_files_at("user://bin/rule34/Images/"):
		print("DEBUG: copying "+i+" user://tributes/rule34/"+id+"/src/")
		DirAccess.copy_absolute(
		"user://bin/rule34/Images/"+i,
		"user://tributes/rule34/"+id+"/src/"+i
	)
		rule34_signal.emit("user://tributes/pixiv/"+id+"/src/"+i)
