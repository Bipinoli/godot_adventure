extends Node



onready var global_configs = get_node("/root/GlobalConfigurations")
onready var admob = get_node("Admob")

func _ready():
	print("---------- preparing GameAdMob -------------")
	admob.load_interstitial()


func _shouldAdBeShown():
	var timePassed = int(OS.get_ticks_msec()/1000)
	var sinceAdShown = timePassed - global_configs.lastest_ad_shown_time
	print("since ad: ", sinceAdShown)
	print("current time: ", timePassed)
	return sinceAdShown > global_configs.MIN_TIME_BETWEEN_ADS


func _showAd():
	print(" ad showing time ----")
	admob.show_interstitial()


func _on_Admob_interstitial_closed():
	global_configs.lastest_ad_shown_time = int(OS.get_ticks_msec()/1000)
	print(" ad closed at: ", global_configs.lastest_ad_shown_time)
