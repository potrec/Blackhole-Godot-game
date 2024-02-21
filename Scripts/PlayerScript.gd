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
@onready var parallaxBackground: ParallaxBackground
func _ready():
	$AnimationPlayer.current_animation = "Test"

func _process(delta):
	var direction = Input.get_vector("Left","Right","Up","Down")
	var transport = speed*delta*direction*scale.x
	position += transport
	for object in objects:
		if object.foodResource.mass > scale.x:
			continue
		var objectSpeed = (position - object.position).normalized()/position.distance_to(object.position)*delta*speed*$CollisionShape2D.shape.radius*scale.x*scale.x
		if objectSpeed.length() < transport.length()*objectRelativeMinSpeed:
			objectSpeed = objectSpeed.normalized()*transport.length()*objectRelativeMinSpeed
		object.position += objectSpeed
		if position.distance_to(object.position) < scale.x:
			level.remove_food(object)
			scale += Vector2(object.foodResource.mass,object.foodResource.mass)*0.1
			targetZoom = (defaultZoom / scale.x)
			objects = objects.filter(func(e): return e != object)
			
	if currentZoom/targetZoom > 1.01:
		camera_zoom(delta)

func _on_body_entered(body):
	if(body.foodResource.mass <= scale.x):
		objects.push_back(body)

func camera_zoom(delta):
	currentZoom = lerp(currentZoom, targetZoom, zoomSpeed * delta)
	if(currentZoom < targetZoom):
		currentZoom = targetZoom
	$Camera2D.zoom = Vector2(currentZoom, currentZoom)


