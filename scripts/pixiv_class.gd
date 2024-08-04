class_name pixiv_class

func get_img(url,id):
	var output = []
	OS.execute(OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.bin",[
		url,
		"-d",
		OS.get_user_data_dir()+"/"+"bin",
		"-c",
		OS.get_user_data_dir()+"/"+"bin/"+"config.json",
	],output,true,true)
	print("output of gallery-dl DEBUG: "+str(output))
	DirAccess.make_dir_absolute("user://tributes/pixiv/"+id)
	DirAccess.make_dir_absolute("user://tributes/pixiv/"+id+"/"+"edited")
	DirAccess.make_dir_absolute("user://tributes/pixiv/"+id+"/"+"record")
	DirAccess.make_dir_absolute("user://tributes/pixiv/"+id+"/"+"src")
		
	FileAccess.open(
		"user://tributes/pixiv/"+id+"/"+"src/source.txt",
		FileAccess.WRITE
	).store_string(
		"\n"+"#二次絵ぶっかけ #cumtributeِs #sop\n\n"+"image used in the tribute"+"\n"+url
	)
	
	DirAccess.copy_absolute(
		"res://bin/edit.sh",
		"user://tributes/pixiv/"+id+"/edit.sh"
	)
	
	for i in DirAccess.get_files_at("user://bin/"+id+"/Images/"):
		DirAccess.copy_absolute(
		"user://bin/"+id+"/Images/"+i,
		"user://tributes/pixiv/"+id+"/src/"+i
	)
