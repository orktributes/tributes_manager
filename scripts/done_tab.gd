extends Control

# load the img_container scene
var textrect_pre = preload("res://scenes/img_container.tscn")


func _on_button_pressed():
	print("DEBUG: removeing children of done GridContainer")
	for n in $ScrollContainer/GridContainer.get_children():
		$ScrollContainer/GridContainer.remove_child(n)
		
	for i in DirAccess.get_directories_at("user://tributes/done/"):
		print("DEBUG: finding all folder in done "+i)
		for ii in DirAccess.get_files_at("user://tributes/done/"+i+"/src"):
			print("DEBUG: finding all images in done "+ii)
			if ii == "source.txt":
				pass
			else:
				print("DEBUG: path of the done image "+"user://tributes/done/"+i+"/src/"+ii)
				# instantiate the img_container scene
				var textrect = textrect_pre.instantiate()
				textrect.dir_name = i
				textrect.sites = "done"
				# load the image and set the size of it
				var image = Image.load_from_file("user://tributes/done/"+i+"/src/"+ii)
				image.resize(128,128)
				# create a texture from the image and set it
				var texture = ImageTexture.create_from_image(image)
				textrect.texture = texture
				# add it to the GridContainer
				$ScrollContainer/GridContainer.add_child(textrect)
