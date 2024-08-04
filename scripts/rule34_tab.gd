extends Control


var textrect_pre = preload("res://scenes/img_container.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_button_pressed():	
	for n in $ScrollContainer/GridContainer.get_children():
		$ScrollContainer/GridContainer.remove_child(n)
	for i in DirAccess.get_directories_at("user://tributes/rule34/"):
		for ii in DirAccess.get_files_at("user://tributes/rule34/"+i+"/src"):
			if ii == "source.txt":
				pass
			else:
				var textrect = textrect_pre.instantiate()
				textrect.dir_name = i
				textrect.sites = "rule34"
				var image = Image.load_from_file("user://tributes/rule34/"+i+"/src/"+ii)
				image.resize(128,128)
				var texture = ImageTexture.create_from_image(image)
				textrect.texture = texture
				$ScrollContainer/GridContainer.add_child(textrect)
				print("path of the rule34 data DEBUG: "+"user://tributes/rule34/"+i+"/src/"+ii)
