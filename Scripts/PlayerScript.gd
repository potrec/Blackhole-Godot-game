extends Area2D

var speed: float = 0
var size: float = 0
var weight: float = 0
var objects = []
const objectRelativeMinSpeed = 1.25
func _ready():
	speed = get_meta("Speed")
	size = get_meta("Size")
	weight = get_meta("Weight")
	scale.x = size
	scale.y = size
	$AnimationPlayer.current_animation = "Test"
func _process(delta):
	var direction = Input.get_vector("Left","Right","Up","Down")
	var transport = speed*delta*direction
	position += transport
	for object in objects:
		var objectSpeed = (position - object.position).normalized()/position.distance_to(object.position)*delta*speed*$CollisionShape2D.shape.radius*scale.x
		if objectSpeed.length() < transport.length()*objectRelativeMinSpeed:
			objectSpeed = objectSpeed.normalized()*transport.length()*objectRelativeMinSpeed
		object.position += objectSpeed
		if position.distance_to(object.position) < 1:
			object.queue_free()
			objects = objects.filter(func(e): return e != object)

func _on_body_entered(body):
	objects.push_back(body)
