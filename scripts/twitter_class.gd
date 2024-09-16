class_name twitter_class
signal twitter_signal(dir)
var user_dir = DirAccess.open("user://")

var site_name = "twitter"

var is_config_load = false
var config_file = "user://config.cfg"
var config
var browser = ""

func load_config():
	config = ConfigFile.new()
	
	var err = config.load(config_file)
	if err != OK:
		print_rich("[color=Red]BEBUG[/color] "+site_name+" load config file err: "+err)
		
	browser = config.get_value("config","browser")
	print_rich("[color=Blue]BEBUG[/color] "+site_name+" config get browser key value: "+browser)
	is_config_load == true

func linux_gallerydl(url):
	if is_config_load == false:
		load_config()
	
	print_rich("[color=Blue]BEBUG:[/color] linux_gallerydl browser "+browser)
	print_rich("[color=Blue]BEBUG:[/color] linux_gallerydl runing linux gallery-dl")
	var output = []
	OS.execute(OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.bin",[
		url,
		"-d",
		OS.get_user_data_dir()+"/"+"bin",
		"-c",
		OS.get_user_data_dir()+"/"+"bin/"+"config.json",
		"--cookies-from-browser",
		browser
	],output,true,true)
	print_rich("[color=Blue]BEBUG:[/color] output of linux gallery-dl "+str(output))

func Windows_gallerydl(url):
	if is_config_load == false:
		load_config()
		
	print_rich("[color=Blue]BEBUG:[/color] Windows_gallerydl browser "+browser)
	print_rich("[color=Blue]BEBUG:[/color] Windows_gallerydl runing Windows gallery-dl")
	var output = []
	OS.execute(OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.exe",[
		url,
		"-d",
		OS.get_user_data_dir()+"/"+"bin",
		"-c",
		OS.get_user_data_dir()+"/"+"bin/"+"config.json",
		"--cookies-from-browser",
		browser
	],output,true,true)
	print_rich("[color=Blue]BEBUG:[/color] output of Windows gallery-dl "+str(output))

func get_img(url):
	match OS.get_name():
		"Windows":
			print_rich("[color=Blue]BEBUG:[/color] running Windows_gallerydl func")
			Windows_gallerydl(url)
		"Linux","X11","FreeBSD", "NetBSD", "OpenBSD", "BSD":
			print_rich("[color=Blue]BEBUG:[/color] running linux_gallerydl func")
			linux_gallerydl(url)
		"Android":
			print_rich("[color=Blue]BEBUG:[/color] Welcome to Android!")
			
	for i in DirAccess.get_directories_at("user://bin/"+site_name+"/"):
		print_rich("[color=Blue]BEBUG:[/color] finding all images in bin/"+site_name+" and moveing to tributes/"+site_name)
		DirAccess.rename_absolute(
			"user://bin/"+site_name+"/"+i,
			"user://tributes/"+site_name+"/"+i
		)
		if DirAccess.dir_exists_absolute("user://tributes/"+site_name+"/"+i+"/"+"edited") != true:
			print_rich("[color=Blue]BEBUG[/color] making: "+"user://tributes/"+site_name+"/"+i+"/"+"edited")
			DirAccess.make_dir_absolute("user://tributes/"+site_name+"/"+i+"/"+"edited")
	
		if DirAccess.dir_exists_absolute("user://tributes/"+site_name+"/"+i+"/"+"record") != true:
			print_rich("[color=Blue]BEBUG[/color] making: "+"user://tributes/"+site_name+"/"+i+"/"+"record")
			DirAccess.make_dir_absolute("user://tributes/"+site_name+"/"+i+"/"+"record")
	
		if DirAccess.dir_exists_absolute("user://tributes/"+site_name+"/"+i+"/"+"src") != true:
			print_rich("[color=Blue]BEBUG[/color] renameing Images to src: "+"user://tributes/"+site_name+"/"+i+"/"+"src")
			DirAccess.rename_absolute(
				"user://tributes/"+site_name+"/"+i+"/Images",
				"user://tributes/"+site_name+"/"+i+"/src"
			)
			
		if FileAccess.file_exists("user://tributes/"+site_name+"/"+i+"/edit.sh") != true:
			print_rich("[color=Blue]BEBUG:[/color] copying edit.sh to "+"user://tributes/"+site_name+"/"+i+"/edit.sh")
			user_dir.copy(
				"res://bin/edit.sh",
				"user://tributes/"+site_name+"/"+i+"/edit.sh"
			)

		if FileAccess.file_exists("user://tributes/"+site_name+"/"+i+"/"+"src/source.txt") != true:
			print_rich("[color=Blue]BEBUG:[/color] making source.txt for "+"user://tributes/"+site_name+"/"+i)
			FileAccess.open(
				"user://tributes/"+site_name+"/"+i+"/"+"src/source.txt",
				FileAccess.WRITE
			).store_string(
				"\n"+"#二次絵ぶっかけ #cumtributeِs #sop\n\n"+"image used in the tribute"+"\n"+"https://x.com/cum/status/"+i.get_slice("_",1)+"\nps twitter will automatically convert the url"
			)
		for ii in DirAccess.get_files_at("user://tributes/"+site_name+"/"+i+"/src/"):
			print_rich("[color=Blue]BEBUG:[/color] sending the downloaded image to the download tab")
			if ii == "source.txt":
				pass
			else:
				twitter_signal.emit("user://tributes/"+site_name+"/"+i+"/src/"+ii)
