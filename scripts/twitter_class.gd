class_name twitter_class
signal twitter_signal(dir)

var user_dir = DirAccess.open("user://")

func get_img(url,name,id):
	var output = []
	OS.execute(OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.bin",[
		"--cookies-from-browser",
		"firefox",
		url,
		"-d",
		OS.get_user_data_dir()+"/"+"bin",
		"-c",
		OS.get_user_data_dir()+"/"+"bin/"+"config.json"
	],output,true,true)
	print("output of gallery-dl DEBUG: "+str(output))
	
	if DirAccess.dir_exists_absolute("user://tributes/twitter/"+name+"_"+id) != true:
		print("DEBUG: making "+"user://tributes/twitter/"+name+"_"+id)
		DirAccess.make_dir_absolute("user://tributes/twitter/"+name+"_"+id)
		
	if DirAccess.dir_exists_absolute("user://tributes/twitter/"+name+"_"+id+"/"+"edited") != true:
		print("DEBUG: making "+"user://tributes/twitter/"+name+"_"+id+"/"+"edited")
		DirAccess.make_dir_absolute("user://tributes/twitter/"+name+"_"+id+"/"+"edited")
	
	if DirAccess.dir_exists_absolute("user://tributes/twitter/"+name+"_"+id+"/"+"record") != true:
		print("DEBUG: making "+"user://tributes/twitter/"+name+"_"+id+"/"+"record")
		DirAccess.make_dir_absolute("user://tributes/twitter/"+name+"_"+id+"/"+"record")
	
	if DirAccess.dir_exists_absolute("user://tributes/twitter/"+name+"_"+id+"/"+"src") != true:
		print("DEBUG: making "+"user://tributes/twitter/"+name+"_"+id+"/"+"src")
		DirAccess.make_dir_absolute("user://tributes/twitter/"+name+"_"+id+"/"+"src")
		
	if FileAccess.file_exists("user://tributes/twitter/"+name+"_"+id+"/"+"src/source.txt") != true:
		print("DEBUG: making source.txt for "+"user://tributes/twitter/"+name+"_"+id)
		FileAccess.open(
			"user://tributes/twitter/"+name+"_"+id+"/"+"src/source.txt",
			FileAccess.WRITE
		).store_string(
			"\n"+"#二次絵ぶっかけ #cumtributeِs #sop\n\n"+"image used in the tribute"+"\n"+url
		)
	
	if FileAccess.file_exists("user://tributes/twitter/"+name+"_"+id+"/edit.sh") != true:
		print("DEBUG: copying edit.sh to "+"user://tributes/twitter/"+name+"_"+id+"/edit.sh")
		user_dir.copy(
			"res://bin/edit.sh",
			"user://tributes/twitter/"+name+"_"+id+"/edit.sh"
		)
	
	for i in DirAccess.get_files_at("user://bin/twitter/"+name+"/Images/"):
		DirAccess.rename_absolute(
		"user://bin/twitter/"+name+"/Images/"+i,
		"user://tributes/twitter/"+name+"_"+id+"/src/"+i
	)
		twitter_signal.emit("user://tributes/twitter/"+name+"_"+id+"/src/"+i)
