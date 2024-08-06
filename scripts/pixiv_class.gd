class_name pixiv_class

var user_dir = DirAccess.open("user://")

func get_img(url,id):
	var output = []
	OS.execute(OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.bin",[
		url,
		"-d",
		OS.get_user_data_dir()+"/"+"bin",
		"-c",
		OS.get_user_data_dir()+"/"+"bin/"+"config.json",
	],output,true,true)
	print("DEBUG: output of gallery-dl "+str(output))
	
	if DirAccess.dir_exists_absolute("user://tributes/pixiv/"+id) != true:
		print("DEBUG: making "+"user://tributes/pixiv/"+id)
		DirAccess.make_dir_absolute("user://tributes/pixiv/"+id)
		
	if DirAccess.dir_exists_absolute("user://tributes/pixiv/"+id+"/"+"edited") != true:
		print("DEBUG: making "+"user://tributes/pixiv/"+id+"/"+"edited")
		DirAccess.make_dir_absolute("user://tributes/pixiv/"+id+"/"+"edited")
	
	if DirAccess.dir_exists_absolute("user://tributes/pixiv/"+id+"/"+"record") != true:
		print("DEBUG: making "+"user://tributes/pixiv/"+id+"/"+"record")
		DirAccess.make_dir_absolute("user://tributes/pixiv/"+id+"/"+"record")
	
	if DirAccess.dir_exists_absolute("user://tributes/pixiv/"+id+"/"+"src") != true:
		print("DEBUG: making "+"user://tributes/pixiv/"+id+"/"+"src")
		DirAccess.make_dir_absolute("user://tributes/pixiv/"+id+"/"+"src")
		
	if FileAccess.file_exists("user://tributes/pixiv/"+id+"/"+"src/source.txt") != true:
		print("DEBUG: making source.txt for "+"user://tributes/pixiv/"+id)
		FileAccess.open(
			"user://tributes/pixiv/"+id+"/"+"src/source.txt",
			FileAccess.WRITE
		).store_string(
			"\n"+"#二次絵ぶっかけ #cumtributeِs #sop\n\n"+"image used in the tribute"+"\n"+url
		)
	
	if FileAccess.file_exists("user://tributes/pixiv/"+id+"/edit.sh") != true:
		print("DEBUG: copying edit.sh to "+"user://tributes/pixiv/"+id)
		user_dir.copy(
			"res://bin/edit.sh",
			"user://tributes/pixiv/"+id+"/edit.sh"
		)
	
	for i in DirAccess.get_files_at("user://bin/"+id+"/Images/"):
		print("DEBUG: copying "+i+" user://tributes/pixiv/"+id+"/src/")
		DirAccess.copy_absolute(
		"user://bin/"+id+"/Images/"+i,
		"user://tributes/pixiv/"+id+"/src/"+i
	)
