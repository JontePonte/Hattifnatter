extends Node

# Total number of hattifnatts and how many of the start as infected
var hatt_total = 101
var hatt_inf_start = 1

# Variables for hattifnatt movement
var hatt_prob_acc_change_percent = 50
var hatt_speed = 2

# Variabls for infection
var inf_prob_spread = 10
var inf_prob_removed = 2

var inf_spread_size = 15

# World variabels
var floor_size_x = 80
var floor_size_z = 80

# The different hattifnatt colors and infection color
var color_hatt_sus  = Color(1,    1,    1)
var color_hatt_inf  = Color(1,    0.6,  0.6)
var color_hatt_rem  = Color(0.6,  0.6,  1)

var color_infection = Color(1,    0.4,  0.4)

# All variables for graph control
var graph_height = 100
var graph_width = 500
var graph_column_width = 2
var graph_marg_x = 10
var graph_marg_y = 10

var color_graph_sus = Color(0.1,  0.1,  0.1, 0.6)
var color_graph_inf = Color(0.8,  0.3,  0.3, 0.6)
var color_graph_rem = Color(0.3,  0.3,  0.8, 0.6)

# Variables for the different hattifnatt states
var hatt_sus = hatt_total
var hatt_inf = 0
var hatt_rem = 0

# Vars for population information
var inf_percent = 0
var sus_percent = 0
var rem_percent = 0
var inf_percent_max = 0

# Clock variable (count up ~ every second)
var time = 0

# Need this to reset all variables. Probalbly a cleaner solution out there
func reset_all():
	# Initial values for simulation
	hatt_sus = hatt_total
	hatt_inf = 0
	hatt_rem = 0
	
	# Clock variable (count up ~ every second)
	time = 0
	print("reset")
