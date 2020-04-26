extends Spatial

var clock_set = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Load the Global Variables
	var GlobalVars = get_node("/root/GlobalVars")
	
	# Create instances for the hattifnatts
	for i in range(GlobalVars.hatt_total):
		var scene = load("res://Hattifnatt.tscn")
		var scene_instance = scene.instance()
		scene_instance.set_name(str(i))
		var hatt_pos_x = (0.5-randf()) * GlobalVars.floor_size_x * 0.9
		var hatt_pos_z = (0.5-randf()) * GlobalVars.floor_size_z * 0.9
		scene_instance.translate(Vector3(hatt_pos_x, 0, hatt_pos_z))
		add_child(scene_instance)
		if i < GlobalVars.hatt_inf_start:
			scene_instance.become_infected()


func _process(delta):
	# Reset world by pressing ENTER
	if Input.is_action_just_pressed("ui_reset"):
		get_tree().reload_current_scene()	# Reset all scenes
		GlobalVars.reset_all()				# Reset global variables
	
	# Toggle Social Distance policy with SPACE
	if Input.is_action_just_pressed("ui_select"):
		if GlobalVars.is_social_distance:
			GlobalVars.is_social_distance = false
		else:
			GlobalVars.is_social_distance = true 


func _physics_process(delta):
	# Klick up the clock. It is set to onec every second
	clock_set += delta
	if clock_set >= 1:
		GlobalVars.time += 1
		clock_set = 0
		# Update graph if not all infected hattifnatts have been removed
		if not ($Graph.column_counter >= $Graph.column_counter_max and GlobalVars.hatt_inf == 0):
			$Graph.graph_update()
		
		# Update the percentent of hattifnatts susceptible and infected
		GlobalVars.sus_percent = stepify(100 * (float(GlobalVars.hatt_sus) / GlobalVars.hatt_total), 0.1)
		GlobalVars.inf_percent = stepify(100 * (float(GlobalVars.hatt_inf) / GlobalVars.hatt_total), 0.1)
		GlobalVars.rem_percent = stepify(100 * (float(GlobalVars.hatt_rem) / GlobalVars.hatt_total), 0.1)
		# Update max infected percent if infected percent is higher
		if GlobalVars.inf_percent >= GlobalVars.inf_percent_max:
			GlobalVars.inf_percent_max = GlobalVars.inf_percent
