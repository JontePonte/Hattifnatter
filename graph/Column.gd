extends Control

# Hattifnatt information
var n = GlobalVars.hatt_total
var s = GlobalVars.hatt_sus
var i = GlobalVars.hatt_inf
var r = GlobalVars.hatt_rem

# Variables for diagram size and pos
var column_width = GlobalVars.graph_column_width
var graph_height = GlobalVars.graph_height
var soc_dist_height = graph_height * 0.05

# Column colors
var color_S = GlobalVars.color_graph_sus
var color_I = GlobalVars.color_graph_inf
var color_R = GlobalVars.color_graph_rem
var color_SD = GlobalVars.color_graph_sd

# The number of seconds the column has been visable
var visable_counter = 0

# x1,y1 are position and x2,y2 are size
# This creates a triple diagram with the boxes on top of each other 
var rS_x1 = 0
var rS_y1 = graph_height - (float(s)/n + float(i)/n) * graph_height
var rS_x2 = column_width
var rS_y2 = float(s)/n*graph_height

var rI_x1 = 0
var rI_y1 = graph_height - float(i)/n * graph_height
var rI_x2 = column_width
var rI_y2 = float(i)/n*graph_height

var rR_x1 = 0
var rR_y1 = graph_height - (float(s)/n + float(i)/n + float(r)/n) * graph_height
var rR_x2 = column_width
var rR_y2 = float(r)/n*graph_height

var rSD_x1 = rI_x1
var rSD_y1 = rI_y1+i
var rSD_x2 = rI_x2
var rSD_y2 = soc_dist_height

# Create rectangels for the column
var rect_S = Rect2(Vector2(rS_x1, rS_y1), Vector2(rS_x2, rS_y2))
var rect_I = Rect2(Vector2(rI_x1, rI_y1), Vector2(rI_x2, rI_y2))
var rect_R = Rect2(Vector2(rR_x1, rR_y1), Vector2(rR_x2, rR_y2))
var rect_SD = Rect2(Vector2(rSD_x1, rSD_y1), Vector2(rSD_x2, rSD_y2))


func _ready():
	var GlobalVars = get_node("/root/GlobalVars")

func _draw(): 
	draw_rect(rect_S, color_S)
	draw_rect(rect_I, color_I)
	draw_rect(rect_R, color_R)
	if GlobalVars.is_social_distance:
		draw_rect(rect_SD, color_SD)
#func _process(delta):
#	pass
