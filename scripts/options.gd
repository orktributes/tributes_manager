class_name options_class
extends Node

var config_file = "user://config.cfg"
var config
var browser = ""

func _ready():
	config = ConfigFile.new()
	# Load data from a file.
	var err = config.load(config_file)
	if err != OK:
		print_rich("[color=Red]BEBUG:[/color] "+err)
	
	browser = config.get_value("config","browser")
	print_rich("[color=Blue]BEBUG[/color] config browser: "+browser)

func _process(delta):
	config.set_value("config", "browser",$browser.get_item_text($browser.selected))

func _on_button_pressed() -> void:
	config.save(config_file)
