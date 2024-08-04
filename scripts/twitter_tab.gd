extends Control


var textrect_pre = preload("res://scenes/img_container.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_button_pressed():	
	for n in $ScrollContainer/GridContainer.get_children():
		$ScrollContainer/GridContainer.remove_child(n)
	for i in DirAccess.get_directories_at("user://tributes/twitter/"):
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
