extends Area2D

@export var speed: float = 0
@export var size: float = 0
@export var weight: float = 0
var objects = []
@onready var defaultCameraZoom = $Camera2D.zoom
const objectRelativeMinSpeed = 1.25
@export var level: Node2D

func _ready():
	scale = Vector2(size, size)
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
			level.remove_food(object)
			scale += Vector2(0.3,0.3)
			$Camera2D.zoom = defaultCameraZoom / scale 
			objects = objects.filter(func(e): return e != object)

func _on_body_entered(body):
	objects.push_back(body)
