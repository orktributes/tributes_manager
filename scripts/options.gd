class_name options_class
extends Node

var config_file = "user://config.cfg"
var config
var pixiv_id = ""
var browser = ""
var video_type = ""

func _ready():
	config = ConfigFile.new()
	# Load data from a file.
	var err = config.load(config_file)
	if err != OK:
		print_rich("[color=Red]BEBUG[/color] load config file err: "+err)
	
	browser = config.get_value("config","browser")
	print_rich("[color=Blue]BEBUG[/color] config get browser key value: "+browser)
	pixiv_id = config.get_value("config","pixiv_id")
	print_rich("[color=Blue]BEBUG[/color] config get pixiv_id key value: "+pixiv_id)
	video_type = config.get_value("config","video_type")
	print_rich("[color=Blue]BEBUG[/color] config get video_type key value: "+video_type)

func _process(delta):
	config.set_value("config", "browser",$browser.get_item_text($browser.selected))
	config.set_value("config", "pixiv_id",$pixiv_id.text)
	config.set_value("config", "video_type",$video_type.text)

func _on_button_pressed() -> void:
	config.save(config_file)
