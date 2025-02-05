class_name twitter_class
var user_dir = DirAccess.open("user://")

var site_name = "twitter"

func linux_gallerydl(url):
	var output = []
	print_rich("[color=Blue]BEBUG:[/color] linux_gallerydl runing linux gallery-dl")
	OS.execute(OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.bin",[
		url,
		"-d",
		OS.get_user_data_dir()+"/"+"bin",
		"-c",
		OS.get_user_data_dir()+"/"+"bin/"+"config.json",
		"--cookies-from-browser",
		"firefox::twitter",
		"--user-agent",
		"firefox",
		"--no-check-certificate"
	],output,true,true)
	print_rich("[color=Blue]BEBUG:[/color] output of linux gallery-dl "+str(output))

func Windows_gallerydl(url):
	print_rich("[color=Blue]BEBUG:[/color] Windows_gallerydl runing Windows gallery-dl")
	var output = []
	OS.execute(OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.exe",[
		url,
		"-d",
		OS.get_user_data_dir()+"/"+"bin",
		"-c",
		OS.get_user_data_dir()+"/"+"bin/"+"config.json",
		"--cookies-from-browser",
		"firefox::twitter",
		"--user-agent",
		"firefox"
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
	
	var multiple = null
	var regex = RegEx.new()
	regex.compile(r"(multiple)_([2-9])_(.*)_(.*)")
	for i in DirAccess.get_directories_at("user://bin/"+site_name+"/"):
		print_rich("[color=Blue]BEBUG:[/color] finding all images in bin/"+site_name+" and moveing to tributes/"+site_name)
		multiple = regex.search(i)
		if multiple:
			for multiple_num in multiple.get_string(2):
				print(multiple_num)
				if DirAccess.dir_exists_absolute("user://bin/"+site_name+"/"+multiple.get_string(0)+"/Images"):
					for multiple_imgs in DirAccess.get_files_at("user://bin/"+site_name+"/"+multiple.get_string(0)+"/Images"):
						if DirAccess.dir_exists_absolute("user://bin/"+site_name+"/"+multiple.get_string(0)+"/Images/"+multiple_imgs) != true:
							print(multiple_imgs)
							DirAccess.make_dir_absolute("user://tributes/"+site_name+"/"+multiple_imgs.split(".")[0])
							DirAccess.rename_absolute(
								"user://bin/"+site_name+"/"+multiple.get_string(0)+"/Images/"+multiple_imgs,
								"user://tributes/"+site_name+"/"+multiple_imgs.split(".")[0]+"/"+multiple_imgs
							)
					for multiple_imgs_site in DirAccess.get_directories_at("user://tributes/"+site_name):
						print(multiple_imgs_site)
						if DirAccess.dir_exists_absolute("user://tributes/"+site_name+"/"+multiple_imgs_site+"/"+"edited") != true:
							print_rich("[color=Blue]BEBUG[/color] making: "+"user://tributes/"+site_name+"/"+multiple_imgs_site+"/"+"edited")
							DirAccess.make_dir_absolute("user://tributes/"+site_name+"/"+multiple_imgs_site+"/"+"edited")
	
						if DirAccess.dir_exists_absolute("user://tributes/"+site_name+"/"+multiple_imgs_site+"/"+"record") != true:
							print_rich("[color=Blue]BEBUG[/color] making: "+"user://tributes/"+site_name+"/"+multiple_imgs_site+"/"+"record")
							DirAccess.make_dir_absolute("user://tributes/"+site_name+"/"+multiple_imgs_site+"/"+"record")
	
						if DirAccess.dir_exists_absolute("user://tributes/"+site_name+"/"+multiple_imgs_site+"/"+"src") != true:
							print_rich("[color=Blue]BEBUG[/color] renameing Images to src: "+"user://tributes/"+site_name+"/"+multiple_imgs_site+"/"+"src")
							DirAccess.make_dir_absolute("user://tributes/"+site_name+"/"+multiple_imgs_site+"/"+"src")
							for multiple_imgs_site_files in DirAccess.get_files_at("user://tributes/"+site_name+"/"+multiple_imgs_site):
								DirAccess.rename_absolute(
									"user://tributes/"+site_name+"/"+multiple_imgs_site+"/"+multiple_imgs_site_files,
									"user://tributes/"+site_name+"/"+multiple_imgs_site+"/src/"+multiple_imgs_site_files
								)
						if FileAccess.file_exists("user://tributes/"+site_name+"/"+multiple_imgs_site+"/edit.sh") != true:
							print_rich("[color=Blue]BEBUG:[/color] copying edit.sh to "+"user://tributes/"+site_name+"/"+i+"/edit.sh")
							user_dir.copy(
								"res://bin/edit.sh",
								"user://tributes/"+site_name+"/"+multiple_imgs_site+"/edit.sh"
							)
							if FileAccess.file_exists("user://tributes/"+site_name+"/"+multiple_imgs_site+"/"+"src/source.txt") != true:
								print_rich("[color=Blue]BEBUG:[/color] making source.txt for "+"user://tributes/"+site_name+"/"+multiple_imgs_site)
								FileAccess.open(
									"user://tributes/"+site_name+"/"+multiple_imgs_site+"/"+"src/source.txt",
									FileAccess.WRITE
								).store_string("\n"+"#二次絵ぶっかけ #cumtributeِs #sop\n\n"+"image used in the tribute"+"\n"+url)
						#pass
		else:
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
					"\n"+"#二次絵ぶっかけ #cumtributeِs #sop\n\n"+"image used in the tribute"+"\n"+url
				)
		#for ii in DirAccess.get_files_at("user://tributes/"+site_name+"/"+i+"/src/"):
			#print_rich("[color=Blue]BEBUG:[/color] sending the downloaded image to the download tab")
			#if ii == "source.txt":
				#pass
			#else:
				#twitter_signal.emit("user://tributes/"+site_name+"/"+i+"/src/"+ii)
