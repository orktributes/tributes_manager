class_name options_class
extends Node

var config_file = "user://config.cfg"
var config
var pixiv_id = ""
var browser = ""

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

func _process(delta):
	config.set_value("config", "browser",$browser.get_item_text($browser.selected))
	config.set_value("config", "pixiv_id",$pixiv_id.text)

func _on_button_pressed() -> void:
	config.save(config_file)
