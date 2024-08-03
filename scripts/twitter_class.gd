class_name twitter_class

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
	#print("BEBUG: "+str(output))
	DirAccess.make_dir_absolute("user://tributes/twitter/"+name+"_"+id)
	DirAccess.make_dir_absolute("user://tributes/twitter/"+name+"_"+id+"/"+"edited")
	DirAccess.make_dir_absolute("user://tributes/twitter/"+name+"_"+id+"/"+"record")
	DirAccess.make_dir_absolute("user://tributes/twitter/"+name+"_"+id+"/"+"src")
		
	FileAccess.open(
		"user://tributes/twitter/"+name+"_"+id+"/"+"src/source.txt",
		FileAccess.WRITE
	).store_string(
		"\n"+"#二次絵ぶっかけ #cumtributeِs #sop "+"#"+name+"\n\n"+"image used in the tribute"+"\n"+url
	)
	
	DirAccess.copy_absolute(
		"res://bin/edit.sh",
		"user://tributes/twitter/"+name+"_"+id+"/edit.sh"
	)
	
	for i in DirAccess.get_files_at("user://bin/twitter/"+name+"/Images/"):
		DirAccess.copy_absolute(
		"user://bin/twitter/"+name+"/Images/"+i,
		"user://tributes/twitter/"+name+"_"+id+"/src/"+i
	)
