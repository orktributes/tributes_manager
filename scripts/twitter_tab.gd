extends Control

var textrect_pre = preload("res://scenes/img_container.tscn")

func _on_button_pressed():
	var get_twitter_dir = DirAccess.get_directories_at("user://tributes/twitter/")
	# look like it is not working
	get_twitter_dir.sort()
	for n in $ScrollContainer/GridContainer.get_children():
		$ScrollContainer/GridContainer.remove_child(n)
	for i in get_twitter_dir:
		
		for ii in DirAccess.get_files_at("user://tributes/twitter/"+i+"/src"):
			if ii == "source.txt":
				pass
			else:
				var textrect = textrect_pre.instantiate()
				textrect.dir_name = i
				textrect.sites = "twitter"
				var image = Image.load_from_file("user://tributes/twitter/"+i+"/src/"+ii)
				image.resize(128,128)
				var texture = ImageTexture.create_from_image(image)
				textrect.texture = texture
				$ScrollContainer/GridContainer.add_child(textrect)
				print("path of the twitter data DEBUG: "+"user://tributes/twitter/"+i+"/src/"+ii)
