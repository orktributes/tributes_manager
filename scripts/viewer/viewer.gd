extends Node2D
var degrees = 90.0
var move_speed = 0.99
var scale_value = 1.0

var x_scale = 0.99
var y_scale = 0.99
var x_pos = DisplayServer.screen_get_size().x/2
var y_pos = DisplayServer.screen_get_size().y/2
var rotation_value = 90.0

var current_md5 = ""

func _ready() -> void:
	print("viewer: _ready")
	$controller_win.always_on_top = true
	for screens in globals.num_of_screens:
		print("viewer: num_of_screens "+str(screens))
		$controller_win/ItemList.add_item("screen: "+ str(screens))

	for file_name in DirAccess.get_files_at("user://tributes/cuming"):
		print("viewer: file_name "+str(file_name))
		current_md5 = FileAccess.get_md5("user://tributes/cuming/cuming.jpg")
		print("viewer: current_md5 "+str(current_md5))
		var image = Image.load_from_file("user://tributes/cuming/"+file_name)
		var texture = ImageTexture.create_from_image(image)
		$viewer_win/img.texture = texture

func _process(delta: float) -> void:
	if current_md5 != FileAccess.get_md5("user://tributes/cuming/cuming.jpg"):
		x_pos = DisplayServer.screen_get_size().x/2
		y_pos = DisplayServer.screen_get_size().y/2
		rotation_value = 90.0
		print("viewer: current_md5 "+str(current_md5))
		current_md5 = FileAccess.get_md5("user://tributes/cuming/cuming.jpg")
		var image = Image.load_from_file("user://tributes/cuming/cuming.jpg")
		var texture = ImageTexture.create_from_image(image)
		$viewer_win/img.texture = texture
	else:
		pass

	$viewer_win/img.scale = Vector2(x_scale,y_scale)
	$viewer_win/img.position = Vector2(x_pos,y_pos)
	$viewer_win/img.rotation_degrees = rotation_value
	$viewer_win/img.centered = true
	
	if Input.is_action_pressed("scale_up"):
		print("img scale_up")
		x_scale += scale_value *delta
		y_scale += scale_value *delta
	if Input.is_action_pressed("scale_down"):
		print("img scale_down")
		x_scale -= scale_value *delta
		y_scale -= scale_value *delta
	if Input.is_action_pressed("move_up"):
		print("img move_up")
		y_pos -= move_speed
	if Input.is_action_pressed("move_down"):
		print("img move_down")
		y_pos += move_speed
	if Input.is_action_pressed("move_left"):
		print("img move_left")
		x_pos -= move_speed
	if Input.is_action_pressed("move_right"):
		print("img move_right")
		x_pos += move_speed
	if Input.is_action_pressed("rotation_right"):
		print("img rotation_right")
		rotation_value += degrees *delta
	if Input.is_action_pressed("rotation_left"):
		print("img rotation_left")
		rotation_value -= degrees *delta

func _on_item_list_item_activated(index: int) -> void:
	print("_on_item_list_item: "+str(index))
	#$viewer_win.current_screen = index
	DisplayServer.window_set_current_screen(index,2)

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		$viewer_win.mode = DisplayServer.WINDOW_MODE_FULLSCREEN
	elif toggled_on == false:
		$viewer_win.mode = DisplayServer.WINDOW_MODE_WINDOWED
