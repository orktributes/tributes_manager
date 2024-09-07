extends Node

var twitter = null
var rule34 = null
var pixiv = null
var twitter_class_load = load("res://scripts/twitter_class.gd").new()
var pixiv_class_load = load("res://scripts/pixiv_class.gd").new()
var rule34_class_load = load("res://scripts/rule34_class.gd").new()
var linux_files_class_load = load("res://scripts/linux_files.gd").new()
var windows_files_class_load = load("res://scripts/windows_files.gd").new()

@onready var textrect = $TextureRect

func _ready():
	twitter_class_load.twitter_signal.connect(twitter_done)
	pixiv_class_load.pixiv_signal.connect(pixiv_done)
	rule34_class_load.rule34_signal.connect(rule34_done)
	print_rich("[color=Blue]BEBUG[/color] OS.get_name(): "+OS.get_name())
	match OS.get_name():
		"Windows":
			windows_files_class_load.make_files()
			print_rich("[color=Blue]BEBUG:[/color] Windows!")
		"Linux","X11","FreeBSD", "NetBSD", "OpenBSD", "BSD":
			linux_files_class_load.make_files()
			print_rich("[color=Blue]BEBUG:[/color] Linux/BSD!")
		"Android":
			print_rich("[color=Blue]BEBUG:[/color] Android!")
	

func _on_download_button_pressed():
	var regex = RegEx.new()
	# ---------------------- twitter ----------------------------------------------
	regex.compile(r"(https:\/\/x\.com\/)([a-zA-Z0-9_]+)(\/status\/)([a-zA-Z0-9_]+)")
	twitter = regex.search($img_url.text)
	if twitter:
		twitter_class_load.get_img($img_url.text)
		$img_url.text = ""
		print_rich("[color=Blue]BEBUG[/color] twitter regex: "+twitter.get_string(0)+"\n"+twitter.get_string(1)+"\n"+twitter.get_string(2)+"\n"+twitter.get_string(3)+"\n"+twitter.get_string(4))
		print_rich("[color=Blue]BEBUG[/color] twitter url: "+$img_url.text)
	# ---------------------- pixiv ----------------------------------------------
	regex.compile(r"(https:\/\/www\.pixiv\.net\/en\/)(artworks\/)([a-zA-Z0-9_]+)")
	pixiv = regex.search($img_url.text)
	if pixiv:
		pixiv_class_load.get_img($img_url.text)
		$img_url.text = ""
		print_rich("[color=Blue]BEBUG[/color] pixiv regex: "+pixiv.get_string(0)+"\n"+pixiv.get_string(1)+"\n"+pixiv.get_string(2)+"\n"+pixiv.get_string(3)+"\n"+pixiv.get_string(4))
		print_rich("[color=Blue]BEBUG[/color] pixiv url: "+$img_url.text)
	# ---------------------- rule34 ---------------------------------------------
	regex.compile(r"(https:\/\/rule34\.xxx\/)(index\.php\?page=post&s=view&id=)([a-zA-Z0-9_]+)")
	rule34 = regex.search($img_url.text)
	if rule34:
		rule34_class_load.get_img($img_url.text)
		$img_url.text = ""
		print_rich("[color=Blue]BEBUG[/color] rule34 regex: "+rule34.get_string(0)+"\n"+rule34.get_string(1)+"\n"+rule34.get_string(2)+"\n"+rule34.get_string(3)+"\n"+rule34.get_string(4))
		print_rich("[color=Blue]BEBUG[/color] rule34 url: "+$img_url.text)

func twitter_done(dir):
	var image = Image.load_from_file(dir)
	image.resize(440,464)
	var texture = ImageTexture.create_from_image(image)
	$TextureRect.texture = texture
	print_rich("[color=Blue]BEBUG[/color]twitter_done: "+dir)

func pixiv_done(dir):
	var image = Image.load_from_file(dir)
	image.resize(440,464)
	var texture = ImageTexture.create_from_image(image)
	$TextureRect.texture = texture
	print_rich("[color=Blue]BEBUG[/color]pixiv_done: "+dir)
	
func rule34_done(dir):
	var image = Image.load_from_file(dir)
	image.resize(440,464)
	var texture = ImageTexture.create_from_image(image)
	$TextureRect.texture = texture
	print_rich("[color=Blue]BEBUG[/color]rule34_done: "+dir)


func _on_twitter_bookmarks_pressed() -> void:
	twitter_class_load.get_img("https://x.com/i/bookmarks")


func _on_pixiv_bookmarks_pressed() -> void:
	pass # Replace with function body.
