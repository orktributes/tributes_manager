class_name twitter_class
signal twitter_signal(dir)
var user_dir = DirAccess.open("user://")

var site_name = "twitter"
var options_class_load = load("res://scripts/options.gd").new()


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
		options_class_load.browser
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
		options_class_load.browser
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
			
	for i in DirAccess.get_directories_at("user://bin/"+site_name+"/"):
		DirAccess.rename_absolute(
			"user://bin/"+site_name+"/"+i,
			"user://tributes/"+site_name+"/"+i
		)
		if DirAccess.dir_exists_absolute("user://tributes/"+site_name+"/"+i+"/"+"edited") != true:
			print("DEBUG: making "+"user://tributes/"+site_name+"/"+i+"/"+"edited")
			DirAccess.make_dir_absolute("user://tributes/"+site_name+"/"+i+"/"+"edited")
	
		if DirAccess.dir_exists_absolute("user://tributes/"+site_name+"/"+i+"/"+"record") != true:
			print("DEBUG: making "+"user://tributes/"+site_name+"/"+i+"/"+"record")
			DirAccess.make_dir_absolute("user://tributes/"+site_name+"/"+i+"/"+"record")
	
		if DirAccess.dir_exists_absolute("user://tributes/"+site_name+"/"+i+"/"+"src") != true:
			print("DEBUG: making "+"user://tributes/"+site_name+"/"+i+"/"+"src")
			DirAccess.rename_absolute(
				"user://tributes/"+site_name+"/"+i+"/Images",
				"user://tributes/"+site_name+"/"+i+"/src"
			)
			
		if FileAccess.file_exists("user://tributes/"+site_name+"/"+i+"/edit.sh") != true:
			print("DEBUG: copying edit.sh to "+"user://tributes/"+site_name+"/"+i+"/edit.sh")
			user_dir.copy(
				"res://bin/edit.sh",
				"user://tributes/"+site_name+"/"+i+"/edit.sh"
			)

		if FileAccess.file_exists("user://tributes/"+site_name+"/"+i+"/"+"src/source.txt") != true:
			print("DEBUG: making source.txt for "+"user://tributes/"+site_name+"/"+i)
			FileAccess.open(
				"user://tributes/"+site_name+"/"+i+"/"+"src/source.txt",
				FileAccess.WRITE
			).store_string(
				"\n"+"#二次絵ぶっかけ #cumtributeِs #sop\n\n"+"image used in the tribute"+"\n"+"https://x.com/cum/status/"+i.get_slice("_",1)
			)
		for ii in DirAccess.get_files_at("user://tributes/"+site_name+"/"+i+"/src/"):
			if ii == "source.txt":
				pass
			else:
				twitter_signal.emit("user://tributes/"+site_name+"/"+i+"/src/"+ii)
