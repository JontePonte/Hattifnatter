extends Node

# Total number of hattifnatts and how many of the start as infected
var hatt_total_base = 100
var hatt_inf_start_base = 1

var hatt_total = hatt_total_base
var hatt_inf_start = hatt_inf_start_base

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

var color_graph_sus = Color(0.1,  0.1,  0.1)
var color_graph_inf = Color(0.8,  0.3,  0.3)
var color_graph_rem = Color(0.3,  0.3,  0.8)

# Variables for the different hattifnatt states
var hatt_sus = hatt_total
var hatt_inf = 0
var hatt_rem = 0

# Clock variable (count up ~ every second)
var time = 0

# Need this to reset all variables. Probalbly a cleaner solution out there
func reset_all():
	# Initial values for simulation
	hatt_total = hatt_total_base
	hatt_inf_start = hatt_inf_start_base
	
	# Variables for the different hattifnatt states
	hatt_sus = hatt_total
	hatt_inf = 0
	hatt_rem = 0
	
	# Clock variable (count up ~ every second)
	time = 0
	print("reset")
