extends Spatial

# Rotation speed per second
var deg_per_s = 4
var rad_per_s = deg2rad(deg_per_s)


func _ready():
	pass # Replace with function body.

func _process(delta):
	rotate_y(rad_per_s*delta)
