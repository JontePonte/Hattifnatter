extends RichTextLabel

var text_color = Color( 0, 0, 0, 1 )

# All the displayed text
var timer = "Time: "
var sus = "Susceptible: "
var inf = "Infected:       "
var rem = "Removed:      "
var inf_max = "Max infected: "
var inf_total = "Total infected: "

func _ready():
	# Load global variables
	var GlobalVars = get_node("/root/GlobalVars")
	set_position(Vector2(GlobalVars.graph_marg_x*2 + GlobalVars.graph_width, GlobalVars.graph_marg_y))

func _process(delta):
	# Attach the numbers to each string
	timer = "Time: " + str(GlobalVars.time)
	sus = "Susceptible: " + str(GlobalVars.hatt_sus)
	inf = "Infected:       " + str(GlobalVars.hatt_inf)
	rem = "Removed:      " + str(GlobalVars.hatt_rem)
	inf_max = "Max infected: " + str(GlobalVars.inf_percent_max) + "%"
	inf_total = "Total infected: " + str(GlobalVars.inf_percent + GlobalVars.rem_percent) + "%"
	
	# Clear the window and print the test
	clear()
	push_color(text_color)
	add_text(timer)
	newline()
	add_text(sus)
	newline()
	add_text(inf)
	newline()
	add_text(rem)
	newline()
	add_text(inf_max)
	newline()
	add_text(inf_total)
