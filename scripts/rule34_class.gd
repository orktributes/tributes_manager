class_name rule34_class

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
	DirAccess.make_dir_absolute("user://tributes/rule34/"+id)
	DirAccess.make_dir_absolute("user://tributes/rule34/"+id+"/"+"edited")
	DirAccess.make_dir_absolute("user://tributes/rule34/"+id+"/"+"record")
	DirAccess.make_dir_absolute("user://tributes/rule34/"+id+"/"+"src")
		
	FileAccess.open(
		"user://tributes/rule34/"+id+"/"+"src/source.txt",
		FileAccess.WRITE
	).store_string(
		"\n"+"#二次絵ぶっかけ #cumtributeِs #sop\n\n"+"image used in the tribute"+"\n"+url
	)
	
	DirAccess.copy_absolute(
		"res://bin/edit.sh",
		"user://tributes/rule34/"+id+"/edit.sh"
	)
	
	for i in DirAccess.get_files_at("user://bin/rule34/Images/"):
		DirAccess.copy_absolute(
		"user://bin/rule34/Images/"+i,
		"user://tributes/rule34/"+id+"/src/"+i
	)
