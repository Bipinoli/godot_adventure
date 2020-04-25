extends Control


onready var admob = get_node("Admob")


func _ready():
	admob.load_interstitial()



func _on_Button_button_down():
	print(" button down ---")
	admob.show_interstitial()

func _on_Admob_interstitial_closed():
	print(" --- ad closed")
	pass # Replace with function body.
