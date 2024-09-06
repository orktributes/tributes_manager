class_name twitter_class
signal twitter_signal(dir)
var user_dir = DirAccess.open("user://")

func linux_gallerydl(url):
	var output = []
	OS.execute(OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.bin",[
		url,
		"-d",
		OS.get_user_data_dir()+"/"+"bin",
		"-c",
		OS.get_user_data_dir()+"/"+"bin/"+"config.json",
		"--range",
		"1-5",
		"--cookies-from-browser",
		"firefox"
	],output,true,true)
	print("Linux gallery-dl")
	print("DEBUG: output of gallery-dl "+str(output))

func Windows_gallerydl(url):
	var output = []
	OS.execute(OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.exe",[
		url,
		"-d",
		OS.get_user_data_dir()+"/"+"bin",
		"-c",
		OS.get_user_data_dir()+"/"+"bin/"+"config.json",
		"--range",
		"1-5",
		"--cookies-from-browser",
		"firefox"
	],output,true,true)
	print("Windows gallery-dl")
	print("DEBUG: output of gallery-dl "+str(output))

func get_img(url):
	match OS.get_name():
		"Windows":
			Windows_gallerydl(url)
		"Linux","X11","FreeBSD", "NetBSD", "OpenBSD", "BSD":
			linux_gallerydl(url)
		"Android":
			print("Welcome to Android!")
			
	for i in DirAccess.get_directories_at("user://bin/twitter/"):
		DirAccess.rename_absolute(
			"user://bin/twitter/"+i,
			"user://tributes/twitter/"+i
		)
		if DirAccess.dir_exists_absolute("user://tributes/twitter/"+i+"/"+"edited") != true:
			print("DEBUG: making "+"user://tributes/twitter/"+i+"/"+"edited")
			DirAccess.make_dir_absolute("user://tributes/twitter/"+i+"/"+"edited")
	
		if DirAccess.dir_exists_absolute("user://tributes/twitter/"+i+"/"+"record") != true:
			print("DEBUG: making "+"user://tributes/twitter/"+i+"/"+"record")
			DirAccess.make_dir_absolute("user://tributes/twitter/"+i+"/"+"record")
	
		if DirAccess.dir_exists_absolute("user://tributes/twitter/"+i+"/"+"src") != true:
			print("DEBUG: making "+"user://tributes/twitter/"+i+"/"+"src")
			DirAccess.rename_absolute(
				"user://tributes/twitter/"+i+"/Images",
				"user://tributes/twitter/"+i+"/src"
			)
			
		if FileAccess.file_exists("user://tributes/twitter/"+i+"/edit.sh") != true:
			print("DEBUG: copying edit.sh to "+"user://tributes/twitter/"+i+"/edit.sh")
			user_dir.copy(
				"res://bin/edit.sh",
				"user://tributes/twitter/"+i+"/edit.sh"
			)

		if FileAccess.file_exists("user://tributes/twitter/"+i+"/"+"src/source.txt") != true:
			print("DEBUG: making source.txt for "+"user://tributes/twitter/"+i)
			FileAccess.open(
				"user://tributes/twitter/"+i+"/"+"src/source.txt",
				FileAccess.WRITE
			).store_string(
				"\n"+"#二次絵ぶっかけ #cumtributeِs #sop\n\n"+"image used in the tribute"+"\n"+"https://x.com/cum/status/"+i.get_slice("_",1)
			)
	

	#
	#for i in DirAccess.get_files_at("user://bin/twitter/"+name+"/Images/"):
		#DirAccess.rename_absolute(
		#"user://bin/twitter/"+name+"/Images/"+i,
		#"user://tributes/twitter/"+name+"_"+id+"/src/"+i
	#)
		#twitter_signal.emit("user://tributes/twitter/"+name+"_"+id+"/src/"+i)
