extends Control

var textrect_pre = preload("res://scenes/img_container.tscn")
var array_ran_img = []

var img_limit = 20
var img_limit_index = 0

func _on_button_pressed():
	print("DEBUG: removeing children of twitter GridContainer")
	img_limit_index = 0
	for n in $ScrollContainer/GridContainer.get_children():
		$ScrollContainer/GridContainer.remove_child(n)
	
	print("DEBUG: finding and adding images to twitter GridContainer")
	for i in DirAccess.get_directories_at("user://tributes/twitter/"):
		for ii in DirAccess.get_files_at("user://tributes/twitter/"+i+"/src"):
			if ii == "source.txt":
				pass
			else:
				var textrect = textrect_pre.instantiate()
				textrect.dir_name = i
				textrect.sites = "twitter"
				textrect.img_name = ii
				var image = Image.load_from_file("user://tributes/twitter/"+i+"/src/"+ii)
				array_ran_img.append(i+"\\"+ii)
				image.resize(128,128)
				var texture = ImageTexture.create_from_image(image)
				textrect.texture = texture
				$ScrollContainer/GridContainer.add_child(textrect)
				print("path of the twitter data DEBUG: "+"user://tributes/twitter/"+i+"/src/"+ii)
		if img_limit == img_limit_index:
			print("img_limit "+str(img_limit))
			print("img_limit_index "+str(img_limit_index))
			return
		img_limit_index = img_limit_index + 1
		print("img_limit "+str(img_limit))
		print("img_limit_index "+str(img_limit_index))

func _on_button_2_pressed() -> void:
	var file_path = array_ran_img.pick_random()
	print("debug: array_ran_img.pick_random() "+file_path)
	#OS.shell_open(OS.get_user_data_dir()+"/tributes/twitter/"+file_path.get_slice("\\",0)+"/src/"+file_path.get_slice("\\",1))
	DirAccess.copy_absolute(
		"user://tributes/twitter/"+file_path.get_slice("\\",0)+"/src/"+file_path.get_slice("\\",1),
		"user://tributes/cuming/cuming.jpg"
	)
