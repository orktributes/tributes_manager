extends Node

var no_cum_list = []

var twitter = null
#var rule34 = null
var bsky = null

# load the class
var twitter_class_load = load("res://scripts/twitter_class.gd").new()
var bsky_class_load = load("res://scripts/bsky_class.gd").new()
#var rule34_class_load = load("res://scripts/rule34_class.gd").new()
var linux_files_class_load = load("res://scripts/linux_files.gd").new()
var windows_files_class_load = load("res://scripts/windows_files.gd").new()

func _ready():
	# send a http request to get the no cum list file from github
	$"../../no_cum_lists".request("https://raw.githubusercontent.com/orktributes/no_cum_lists/refs/heads/main/no_cum_lists")
	# get os name and run the func for it 
	print("DEBUG ready func: OS.get_name(): "+OS.get_name())
	match OS.get_name():
		"Windows":
			windows_files_class_load.make_files()
			print("DEBUG ready func: Windows!")
		"Linux","X11","FreeBSD", "NetBSD", "OpenBSD", "BSD":
			linux_files_class_load.make_files()
			print("DEBUG ready func: Linux/BSD!")

# func for identifying and and runing the class func for the url
func _on_download_button_pressed():
	var regex = RegEx.new()
	
	$no_cum_Label.visible = false
	# ---------------------- twitter ----------------------------------------------
	# regex for the the img_url url
	# layout			domain 				username      status       id
	regex.compile(r"(https:\/\/x\.com\/)([a-zA-Z0-9_]+)(\/status\/)([a-zA-Z0-9_]+)")
	# search the regex for the img_url url
	twitter = regex.search($img_url.text)
	# loop through the no_cum_list array and if the the username is in the no cum list exit and tell the uesr
	for username in no_cum_list:
		print("DEBUG download func: no_cum_list and twitter.get_string(1): "+username+" - "+twitter.get_string(2))
		if username == twitter.get_string(2):
			print("DEBUG download func: it is on the no cum list: "+$img_url.text)
			$no_cum_Label.visible = true
			return
	if twitter:
		twitter_class_load.get_img($img_url.text)
		$img_url.text = ""
		print("DEBUG download func: twitter regex: "+twitter.get_string(0)+"\n"+twitter.get_string(1)+"\n"+twitter.get_string(2)+"\n"+twitter.get_string(3)+"\n"+twitter.get_string(4))
		print("DEBUG download func: twitter url: "+$img_url.text)
	# ---------------------- bsky ----------------------------------------------


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print("DEBUG no_cum_list http request func: response_code: "+ str(response_code))
	print("DEBUG no_cum_list http request func: body: "+body.get_string_from_utf8())
	if response_code == 200:
		print("DEBUG no_cum_list http request func: response_code is 200")
		for i in body.get_string_from_utf8().split("\n"):
			no_cum_list.append(i)
			print("DEBUG no_cum_list http request func: append to no_cum_list loop: "+i)
	else:
		print("DEBUG no_cum_list http request func: response_code is "+str(response_code))
