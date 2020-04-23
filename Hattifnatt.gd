extends KinematicBody

# Variables for movement
var speed = GlobalVars.hatt_speed
var movement = Vector3()
var velocity = Vector3(0, 0, 0)
var acceleration = Vector3(0, 0, 0)

var forward_pos = Vector3()

# Probalilities: Chans in percent per second
var prob_acc_change_percent = GlobalVars.hatt_prob_acc_change_percent
var prob_acc_change = prob_acc_change_percent*0.01*0.01667

var prob_spread_inf_percent = GlobalVars.inf_prob_spread
var prob_spread_inf = prob_spread_inf_percent*0.01*0.01667

var prob_removed_percent = GlobalVars.inf_prob_removed
var prob_removed = prob_removed_percent*0.01*0.01667


# State of the hattifnatt	"S", "I" or "R"
var hatt_state = "S"

func _ready():
	
	var GlobalVars = get_node("/root/GlobalVars")
	
	if hatt_state == "S":
		become_susceptible()
	acceleration.x = (0.5 - randf())
	acceleration.z = (0.5 - randf())

# Main loop
func _physics_process(delta):
		
	# Change acc direction
	if randf() <= prob_acc_change:
		acceleration.x = (0.5 - randf())
		acceleration.z = (0.5 - randf())
	
	
	if is_on_wall():
		if test_move(transform, Vector3(delta,0,0)):
			velocity.x *= 0.8
			acceleration.x = -1
		elif test_move(transform, Vector3(-delta,0,0)):
			acceleration.x = 1
			velocity.x *= 0.8
		elif test_move(transform, Vector3(0,0,delta)):
			acceleration.z = -1
			velocity.z *= 0.8
		elif test_move(transform, Vector3(0,0,-delta)):
			acceleration.z = 1
			velocity.z *= 0.8
	
	# Calculate new velocity for the hattifnatt
	velocity.x += acceleration.x * speed * delta
	velocity.z += acceleration.z * speed * delta
	
	# Move command for the hattifnatt
	movement = move_and_slide(velocity, Vector3(0, 1, 0))
	
	# forward_pos is a point in front of the hattifnatt
	forward_pos = translation + velocity*2
	look_at(forward_pos, Vector3(0, 1, 0))
	
	# Spread infection if infected and infection probalility kicks in
	if hatt_state == "I" and randf() <= prob_spread_inf:
		spread_infection()
	
	# Get removed if infected and removed probalility kicks in
	if hatt_state == "I" and randf() <= prob_removed:
		become_removed()



func spread_infection():
		var scene = load("res://Infection.tscn")
		var scene_instance = scene.instance()
		scene_instance.set_name("infection")
		add_child(scene_instance)

func become_infected():
	if hatt_state == "S":
		hatt_state = "I"
		
		var material_I = SpatialMaterial.new()
		material_I.albedo_color = GlobalVars.color_hatt_inf
		$BodyLow.set_surface_material(0, material_I)
		$BodyHigh.set_surface_material(0, material_I)
		
		GlobalVars.hatt_inf += 1
		GlobalVars.hatt_sus -= 1

func become_susceptible():
	hatt_state = "S"
	
	var material_S = SpatialMaterial.new()
	material_S.albedo_color = GlobalVars.color_hatt_sus
	$BodyLow.set_surface_material(0, material_S)
	$BodyHigh.set_surface_material(0, material_S)


func become_removed():
	if hatt_state == "I":
		hatt_state = "R"
		
		var material_R = SpatialMaterial.new()
		material_R.albedo_color = GlobalVars.color_hatt_rem
		$BodyLow.set_surface_material(0, material_R)
		$BodyHigh.set_surface_material(0, material_R)
		
		GlobalVars.hatt_rem += 1
		GlobalVars.hatt_inf -= 1
