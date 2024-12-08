class_name rule34_class
signal rule34_signal(dir)
var user_dir = DirAccess.open("user://")

var site_name = "rule34"

func linux_gallerydl(url):
	print_rich("[color=Blue]BEBUG:[/color] runing linux gallery-dl")
	var output = []
	OS.execute(OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.bin",[
		url,
		"-d",
		OS.get_user_data_dir()+"/"+"bin",
		"-c",
		OS.get_user_data_dir()+"/"+"bin/"+"config.json",
		"--cookies-from-browser",
	],output,true,true)
	print_rich("[color=Blue]BEBUG:[/color] output of linux gallery-dl "+str(output))

func Windows_gallerydl(url):
	print_rich("[color=Blue]BEBUG:[/color] runing Windows gallery-dl")
	var output = []
	OS.execute(OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.exe",[
		url,
		"-d",
		OS.get_user_data_dir()+"/"+"bin",
		"-c",
		OS.get_user_data_dir()+"/"+"bin/"+"config.json",
		"--range",
		"1-5",
		"--cookies-from-browser"
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
				"\n"+"#二次絵ぶっかけ #cumtributeِs #sop\n\n"+"image used in the tribute"+"\n"+"https://x.com/cum/status/"+i.get_slice("_",1)+"\nps twitter automatically convert the url"
			)
		for ii in DirAccess.get_files_at("user://tributes/"+site_name+"/"+i+"/src/"):
			print_rich("[color=Blue]BEBUG:[/color] sending the downloaded image to the download tab")
			if ii == "source.txt":
				pass
			else:
				rule34_signal.emit("user://tributes/"+site_name+"/"+i+"/src/"+ii)
