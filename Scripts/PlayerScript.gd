extends Node2D

var speed: float = 0
var size: float = 0
var weight: float = 0

func _ready():
	speed = get_meta("Speed")
	size = get_meta("Size")
	weight = get_meta("Weight")
	scale.x = size
	scale.y = size
	$AnimationPlayer.current_animation = "Test"
func _process(delta):
	var direction = Input.get_vector("Right","Left","Down","Up")
	position -= speed*delta*direction
