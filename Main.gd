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
		scene_instance.translate(Vector3((0.5-randf())*GlobalVars.floor_size_x,0,(0.5-randf())*GlobalVars.floor_size_z))
		add_child(scene_instance)
		if i < GlobalVars.hatt_inf_start:
			scene_instance.become_infected()


func _process(delta):
	# Reset world by pressing ENTER
	if Input.is_key_pressed(KEY_ENTER):
		get_tree().reload_current_scene()	# Reset all scenes
		GlobalVars.reset_all()				# Reset global variables


func _physics_process(delta):
	# Klick up the clock. It is set to onec every second
	clock_set += delta
	if clock_set >= 1:
		GlobalVars.time += 1
		clock_set = 0
		# Update graph if not all infected hattifnatts have been removed
		if not ($Graph.column_counter >= $Graph.column_counter_max and GlobalVars.hatt_inf == 0):
			$Graph.graph_update()
