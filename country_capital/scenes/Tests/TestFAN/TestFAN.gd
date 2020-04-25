extends Control




onready var fb_ad = get_node("FacebookAd")



func _ready()-> void:
	pass


func _on_Button_button_down():
	print(" button down ")
	fb_ad.show_interstitial()




func _on_FacebookAd_interstitial_displayed():
	print(" interstitial displayed ")
	
	
	

func _on_FacebookAd_interstitial_dismissed():
	print(" interstitial dismissed ")



func _on_FacebookAd_interstitial_error(adError):
	print(" interstitial error: ", adError)


func _on_FacebookAd_interstitial_impression_logged():
	print(" interstitial impressed logged")



func _on_FacebookAd_interstitial_loaded():
	print(" interstital loaded")


func _on_FacebookAd_interstitial_clicked():
	print("interstitial clicked")
