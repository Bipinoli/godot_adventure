extends Node


onready var global_configs = get_node("/root/GlobalConfigurations")
onready var facebook_ad = get_node("GodotFacebookAd")


func _shouldAdBeShown():
	var timePassed = int(OS.get_ticks_msec()/1000)
	var sinceAdShown = timePassed - global_configs.lastest_ad_shown_time
	print("since ad: ", sinceAdShown)
	print("current time: ", timePassed)
	return sinceAdShown > global_configs.MIN_TIME_BETWEEN_ADS


func _showAd():
	print(" ad showing time ----")
	facebook_ad.show_interstitial()


func _on_GodotFacebookAd_interstitial_dismissed():
	global_configs.lastest_ad_shown_time = int(OS.get_ticks_msec()/1000)
	print(" ad closed at: ", global_configs.lastest_ad_shown_time)
