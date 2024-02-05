extends Area2D

@export var speed: float
@export var size: float
@export var weight: float
var objects = []
const objectRelativeMinSpeed = 1.25
@export var level: Node2D
@onready var currentZoom: float = $Camera2D.zoom.x
@onready var defaultZoom: float = $Camera2D.zoom.x
@onready var targetZoom: float = $Camera2D.zoom.x
@export var zoomSpeed: float = 10.0

func _ready():
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
			scale += Vector2(1,1)
			targetZoom = (defaultZoom / scale.x)
			objects = objects.filter(func(e): return e != object)
	if abs(currentZoom - targetZoom) > 0.01:
		camera_zoom(delta)
		
func _on_body_entered(body):
	objects.push_back(body)
	
func camera_zoom(delta):
	currentZoom = lerp(currentZoom, targetZoom, zoomSpeed * delta)
	$Camera2D.zoom = Vector2(currentZoom, currentZoom)


