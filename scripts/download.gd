extends Node

var twitter = null
var rule34 = null
var pixiv = null
var twitter_class = load("res://scripts/twitter_class.gd").new()
var pixiv_class = load("res://scripts/pixiv_class.gd").new()
var rule34_class = load("res://scripts/rule34_class.gd").new()

var user_dir = DirAccess.open("user://")

@onready var textrect = $TextureRect

func _ready():
	twitter_class.twitter_signal.connect(twitter_done)
	pixiv_class.pixiv_signal.connect(pixiv_done)
	rule34_class.rule34_signal.connect(rule34_done)
	
	
	
	var output = []
	if DirAccess.dir_exists_absolute("user://bin/") != true:
		print("DEBUG: making user://bin/")
		DirAccess.make_dir_absolute("user://bin/")
	else :
		print("DEBUG: user://bin/ exists")
		
	if DirAccess.dir_exists_absolute("user://tributes") != true:
		print("DEBUG: making user://tributes")
		DirAccess.make_dir_absolute("user://tributes")
	else :
		print("DEBUG: user://tributes exists")
	
	if DirAccess.dir_exists_absolute("user://tributes/done") != true:
		print("DEBUG: making user://tributes/done")
		DirAccess.make_dir_absolute("user://tributes/done")
	else :
		print("DEBUG: user://tributes/done exists")
		
	if DirAccess.dir_exists_absolute("user://tributes/twitter") != true:
		print("DEBUG: making user://tributes/twitter")
		DirAccess.make_dir_absolute("user://tributes/twitter")
	else :
		print("DEBUG: user://tributes/twitter exists")
		
	if DirAccess.dir_exists_absolute("user://tributes/rule34") != true:
		print("DEBUG: making user://tributes/rule34")
		DirAccess.make_dir_absolute("user://tributes/rule34")
	else :
		print("DEBUG: user://tributes/rule34 exists")
		
	if DirAccess.dir_exists_absolute("user://tributes/pixiv") != true:
		print("DEBUG: making user://tributes/pixiv")
		DirAccess.make_dir_absolute("user://tributes/pixiv")
	else :
		print("DEBUG: user://tributes/pixiv exists")
		
	if FileAccess.file_exists("user://bin/gallery-dl.bin") != true:
		print("DEBUG: copying gallery-dl.bin to user://bin/ and making it executable")
		user_dir.copy(
			"res://bin/gallery-dl.bin",
			"user://bin/gallery-dl.bin"
		)
		OS.execute("chmod",["+x",OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.bin"],output,true,true)
		print("BEBUG: output of chmod "+str(output))
	else :
		print("DEBUG: gallery-dl.bin exists in user://bin/")
		
	if FileAccess.file_exists("user://bin/config.json") != true:
		print("DEBUG: copying config.json to user://bin/")
		user_dir.copy(
			"res://bin/config.json",
			"user://bin/config.json"
		)
	else :
		print("DEBUG: config.json exists in user://bin/")

func _on_download_button_pressed():
	var regex = RegEx.new()
	# ---------------------- twitter ----------------------------------------------
	regex.compile(r"(https:\/\/x\.com\/)([a-zA-Z0-9_]+)(\/status\/)([a-zA-Z0-9_]+)")
	twitter = regex.search($img_url.text)
	if twitter:
		twitter_class.get_img($img_url.text,twitter.get_string(2),twitter.get_string(4))
		$img_url.text = ""
		print("twitter regex BEBUG: "+twitter.get_string(0)+"\n"+twitter.get_string(1)+"\n"+twitter.get_string(2)+"\n"+twitter.get_string(3)+"\n"+twitter.get_string(4))
		print("twitter url BEBUG: "+$img_url.text)
	# ---------------------- pixiv ----------------------------------------------
	regex.compile(r"(https:\/\/www\.pixiv\.net\/en\/)(artworks\/)([a-zA-Z0-9_]+)")
	pixiv = regex.search($img_url.text)
	if pixiv:
		pixiv_class.get_img($img_url.text,pixiv.get_string(3))
		$img_url.text = ""
		print("pixiv regex BEBUG: "+pixiv.get_string(0)+"\n"+pixiv.get_string(1)+"\n"+pixiv.get_string(2)+"\n"+pixiv.get_string(3)+"\n"+pixiv.get_string(4))
		print("pixiv url BEBUG: "+$img_url.text)
	# ---------------------- rule34 ---------------------------------------------
	regex.compile(r"(https:\/\/rule34\.xxx\/)(index\.php\?page=post&s=view&id=)([a-zA-Z0-9_]+)")
	rule34 = regex.search($img_url.text)
	if rule34:
		rule34_class.get_img($img_url.text,rule34.get_string(3))
		$img_url.text = ""
		print("rule34 regex BEBUG: "+rule34.get_string(0)+"\n"+rule34.get_string(1)+"\n"+rule34.get_string(2)+"\n"+rule34.get_string(3)+"\n"+rule34.get_string(4))
		print("rule34 url BEBUG: "+$img_url.text)

func twitter_done(dir):
	var image = Image.load_from_file(dir)
	image.resize(1192,818)
	var texture = ImageTexture.create_from_image(image)
	$TextureRect.texture = texture
	print(dir)

func pixiv_done(dir):
	var image = Image.load_from_file(dir)
	image.resize(1192,818)
	var texture = ImageTexture.create_from_image(image)
	$TextureRect.texture = texture
	print(dir)
	
func rule34_done(dir):
	var image = Image.load_from_file(dir)
	image.resize(1192,818)
	var texture = ImageTexture.create_from_image(image)
	$TextureRect.texture = texture
	print(dir)



