extends Control

var textrect_pre = preload("res://scenes/img_container.tscn")

func _on_button_pressed():
	print("DEBUG: removeing children of pixiv GridContainer")
	for n in $ScrollContainer/GridContainer.get_children():
		$ScrollContainer/GridContainer.remove_child(n)
		
	print("DEBUG: finding and adding images to pixiv GridContainer")
	for i in DirAccess.get_directories_at("user://tributes/pixiv/"):
		for ii in DirAccess.get_files_at("user://tributes/pixiv/"+i+"/src"):
			if ii == "source.txt":
				pass
			else:
				var textrect = textrect_pre.instantiate()
				textrect.dir_name = i
				textrect.sites = "pixiv"
				var image = Image.load_from_file("user://tributes/pixiv/"+i+"/src/"+ii)
				image.resize(128,128)
				var texture = ImageTexture.create_from_image(image)
				textrect.texture = texture
				$ScrollContainer/GridContainer.add_child(textrect)
				print("path of the pixiv data DEBUG: "+"user://tributes/pixiv/"+i+"/src/"+ii)
