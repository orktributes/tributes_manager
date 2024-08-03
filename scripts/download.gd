extends Node

var twitter = null
var rule34 = null
var pixiv = null
var twitter_class = load("res://scripts/twitter_class.gd").new()
var pixiv_class = load("res://scripts/pixiv_class.gd").new()
var rule34_class = load("res://scripts/rule34_class.gd").new()

func _ready():
	var output = []
	DirAccess.make_dir_absolute("user://bin/")
	DirAccess.make_dir_absolute("user://tributes")
	DirAccess.make_dir_absolute("user://tributes/done")
	DirAccess.make_dir_absolute("user://tributes/twitter")
	DirAccess.make_dir_absolute("user://tributes/rule34")
	DirAccess.make_dir_absolute("user://tributes/pixiv")
	
	DirAccess.copy_absolute(
		"res://bin/gallery-dl.bin",
		"user://bin/gallery-dl.bin"
	)
	OS.execute("chmod",["+x",OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.bin"],output)
	DirAccess.copy_absolute(
		"res://bin/config.json",
		"user://bin/config.json"
	)
	#print("BEBUG: "+str(output))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func _on_download_button_pressed():
	var regex = RegEx.new()
	# ---------------------- twitter ----------------------------------------------
	regex.compile(r"(https:\/\/x\.com\/)([a-zA-Z0-9_]+)(\/status\/)([a-zA-Z0-9_]+)")
	twitter = regex.search($img_url.text)
	if twitter:
		twitter_class.get_img($img_url.text,twitter.get_string(2),twitter.get_string(4))
		#print("BEBUG: "+twitter.get_string(0)+"\n"+twitter.get_string(1)+"\n"+twitter.get_string(2)+"\n"+twitter.get_string(3)+"\n"+twitter.get_string(4))
		#print("BEBUG: "+$img_url.text)
	# ---------------------- pixiv ----------------------------------------------
	regex.compile(r"(https:\/\/www\.pixiv\.net\/en\/)(artworks\/)([a-zA-Z0-9_]+)")
	pixiv = regex.search($img_url.text)
	if pixiv:
		pixiv_class.get_img($img_url.text,pixiv.get_string(3))
		print("BEBUG: "+pixiv.get_string(0)+"\n"+pixiv.get_string(1)+"\n"+pixiv.get_string(2)+"\n"+pixiv.get_string(3)+"\n"+pixiv.get_string(4))
		print("BEBUG: "+$img_url.text)
	# ---------------------- rule34 ---------------------------------------------
	regex.compile(r"(https:\/\/rule34\.xxx\/)(index\.php\?page=post&s=view&id=)([a-zA-Z0-9_]+)")
	rule34 = regex.search($img_url.text)
	if rule34:
		rule34_class.get_img($img_url.text,rule34.get_string(3))
		print("BEBUG: "+rule34.get_string(0)+"\n"+rule34.get_string(1)+"\n"+rule34.get_string(2)+"\n"+rule34.get_string(3)+"\n"+rule34.get_string(4))
		print("BEBUG: "+$img_url.text)
