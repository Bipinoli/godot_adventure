extends Node


var theme = "green"
var detail_selected_country = "null"
var selected_continent_filter = "Asia"
var detail_screen_routed_from_casual_game = false
var lastest_ad_shown_time = 0 # in seconds since the app started

const MIN_TIME_BETWEEN_ADS = 10 # seconds

const SCREEN_HEIGHT = 731
const SCREEN_WIDTH = 411

const MAIN_MENU_SEL_WIDTH = 381
const MAIN_MENU_SEL_HEIGHT = 86

const THEME_SEL_WIDTH = 226
const THEME_SEL_HEIGHT = 74

const COLOR_RED = "#F0134D"
const COLOR_BLUE = "#3A7CA5"
const COLOR_BLACK = "#292F36"
const COLOR_YELLOW = "#FFD166"
const COLOR_PURPLE = "#B388EB"
const COLOR_GREEN = "#17B890"
const COLOR_WHITE = "#FFFFFF"

const THEME_SEL_1 = "res://assets/sprites/theme_sel1.png"
const THEME_SEL_2 = "res://assets/sprites/theme_sel2.png"

const RECT_RED = "res://assets/sprites/rect_red.png"
const RECT_BLUE = "res://assets/sprites/rect_blue.png"
const RECT_BLACK = "res://assets/sprites/rect_black.png"
const RECT_YELLOW = "res://assets/sprites/rect_yellow.png"
const RECT_PURPLE = "res://assets/sprites/rect_purple.png"
const RECT_GREEN = "res://assets/sprites/rect_green.png"

const THEME_RED = "res://assets/themes/theme_red.tres"
const THEME_BLUE = "res://assets/themes/theme_blue.tres"
const THEME_BLACK = "res://assets/themes/theme_black.tres"
const THEME_YELLOW = "res://assets/themes/theme_yellow.tres"
const THEME_PURPLE = "res://assets/themes/theme_purple.tres"
const THEME_GREEN = "res://assets/themes/theme_green.tres"

const TITLE_RED = "res://assets/sprites/title_red.png"
const TITLE_BLUE = "res://assets/sprites/title_blue.png"
const TITLE_BLACK = "res://assets/sprites/title_black.png"
const TITLE_YELLOW = "res://assets/sprites/title_yellow.png"
const TITLE_PURPLE = "res://assets/sprites/title_purple.png"
const TITLE_GREEN = "res://assets/sprites/title_green.png"

const LEARN_TITLE_RED = "res://assets/sprites/learn_title_red.png"
const LEARN_TITLE_BLUE = "res://assets/sprites/learn_title_blue.png"
const LEARN_TITLE_BLACK = "res://assets/sprites/learn_title_black.png"
const LEARN_TITLE_YELLOW = "res://assets/sprites/learn_title_yellow.png"
const LEARN_TITLE_PURPLE = "res://assets/sprites/learn_title_purple.png"
const LEARN_TITLE_GREEN = "res://assets/sprites/learn_title_green.png"
