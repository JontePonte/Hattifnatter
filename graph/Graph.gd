extends Control

# Declare member variables here. Examples:
var pos = Vector2()

var column_width = GlobalVars.graph_column_width
var graph_width = GlobalVars.graph_width

var column_counter_max = graph_width / column_width
var column_counter = 0

# Back panel
var back_x1 = GlobalVars.graph_marg_x
var back_y1 = GlobalVars.graph_marg_y
var back_x2 = GlobalVars.graph_width
var back_y2 = GlobalVars.graph_height
var back_panel = Rect2(Vector2(back_x1, back_y1), Vector2(back_x2, back_y2))

# Called when the node enters the scene tree for the first time.
func _ready():
	var GlobalVars = get_node("/root/GlobalVars")


func graph_update():
	var scene = load("res://graph/Column.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_position(Vector2(GlobalVars.graph_marg_x+GlobalVars.graph_width,GlobalVars.graph_marg_y))
	add_child(scene_instance)
	
	for column in get_children():
		if not column.get_name() == "BackPanel":
			pos = column.get_position()
			column.set_position(Vector2(pos.x-column_width, pos.y))
			if column.visable_counter > column_counter_max:
				column.queue_free()
			column.visable_counter += 1
		
	# Count the number of times the graph has been updated
	column_counter += 1

func _draw():
	draw_rect(back_panel, GlobalVars.color_graph_sus)
	