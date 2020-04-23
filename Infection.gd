extends Area

# Timer variables
var timer = 0
var timer_stop = GlobalVars.inf_spread_size
var timer_hold = timer_stop * 0.75

# Scaling
var scale_factor = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var GlobalVars = get_node("/root/GlobalVars")
	
	var material_I = SpatialMaterial.new()
	material_I.albedo_color = GlobalVars.color_infection
	$MeshInstance.set_surface_material(0, material_I)

func _process(delta):
	
	# Grow the infection until timer_stop
	if timer <= timer_stop:
		scale_object_local(Vector3(1+scale_factor, 1+scale_factor, 1+scale_factor))
	
	# Start retracting after timer_hold
	if timer >= timer_stop + timer_hold:
		scale_object_local(Vector3(1-scale_factor, 1-scale_factor, 1-scale_factor))
	
	# Remove the object when it is small again
	if timer >= timer_stop * 2 +timer_hold:
		queue_free() 
	
	timer += 1


func _on_Infection_body_entered(body):
	if body.has_method("become_infected"):
		body.become_infected()
