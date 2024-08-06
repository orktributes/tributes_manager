extends Node

var twitter = null
var rule34 = null
var pixiv = null
var twitter_class = load("res://scripts/twitter_class.gd").new()
var pixiv_class = load("res://scripts/pixiv_class.gd").new()
var rule34_class = load("res://scripts/rule34_class.gd").new()

var user_dir = DirAccess.open("user://")


func _ready():
	var output = []
	if DirAccess.dir_exists_absolute("user://bin/") != true:
		print("DEBUG: making user://bin/")
		DirAccess.make_dir_absolute("user://bin/")
		
	if DirAccess.dir_exists_absolute("user://tributes") != true:
		print("DEBUG: making user://tributes")
		DirAccess.make_dir_absolute("user://tributes")
		
	if DirAccess.dir_exists_absolute("user://tributes/done") != true:
		print("DEBUG: making user://tributes/done")
		DirAccess.make_dir_absolute("user://tributes/done")
		
	if DirAccess.dir_exists_absolute("user://tributes/twitter") != true:
		print("DEBUG: making user://tributes/twitter")
		DirAccess.make_dir_absolute("user://tributes/twitter")
		
	if DirAccess.dir_exists_absolute("user://tributes/rule34") != true:
		print("DEBUG: making user://tributes/rule34")
		DirAccess.make_dir_absolute("user://tributes/rule34")
	
	if DirAccess.dir_exists_absolute("user://tributes/pixiv") != true:
		print("DEBUG: making user://tributes/pixiv")
		DirAccess.make_dir_absolute("user://tributes/pixiv")
	
	if FileAccess.file_exists("user://bin/gallery-dl.bin") != true:
		print("DEBUG: copying gallery-dl.bin to user://bin/ and making it executable")
		user_dir.copy(
			"res://bin/gallery-dl.bin",
			"user://bin/gallery-dl.bin"
		)
		OS.execute("chmod",["+x",OS.get_user_data_dir()+"/"+"bin"+"/"+"gallery-dl.bin"],output,true,true)
		print("BEBUG: output of chmod "+str(output))
		
	if FileAccess.file_exists("user://bin/config.json") != true:
		print("DEBUG: copying config.json to user://bin/")
		user_dir.copy(
			"res://bin/config.json",
			"user://bin/config.json"
		)

func _on_download_button_pressed():
	var regex = RegEx.new()
	# ---------------------- twitter ----------------------------------------------
	regex.compile(r"(https:\/\/x\.com\/)([a-zA-Z0-9_]+)(\/status\/)([a-zA-Z0-9_]+)")
	twitter = regex.search($img_url.text)
	if twitter:
		twitter_class.get_img($img_url.text,twitter.get_string(2),twitter.get_string(4))
		print("twitter regex BEBUG: "+twitter.get_string(0)+"\n"+twitter.get_string(1)+"\n"+twitter.get_string(2)+"\n"+twitter.get_string(3)+"\n"+twitter.get_string(4))
		print("twitter url BEBUG: "+$img_url.text)
	# ---------------------- pixiv ----------------------------------------------
	regex.compile(r"(https:\/\/www\.pixiv\.net\/en\/)(artworks\/)([a-zA-Z0-9_]+)")
	pixiv = regex.search($img_url.text)
	if pixiv:
		pixiv_class.get_img($img_url.text,pixiv.get_string(3))
		print("pixiv regex BEBUG: "+pixiv.get_string(0)+"\n"+pixiv.get_string(1)+"\n"+pixiv.get_string(2)+"\n"+pixiv.get_string(3)+"\n"+pixiv.get_string(4))
		print("pixiv url BEBUG: "+$img_url.text)
	# ---------------------- rule34 ---------------------------------------------
	regex.compile(r"(https:\/\/rule34\.xxx\/)(index\.php\?page=post&s=view&id=)([a-zA-Z0-9_]+)")
	rule34 = regex.search($img_url.text)
	if rule34:
		rule34_class.get_img($img_url.text,rule34.get_string(3))
		print("rule34 regex BEBUG: "+rule34.get_string(0)+"\n"+rule34.get_string(1)+"\n"+rule34.get_string(2)+"\n"+rule34.get_string(3)+"\n"+rule34.get_string(4))
		print("rule34 url BEBUG: "+$img_url.text)
