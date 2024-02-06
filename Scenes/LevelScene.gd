extends Node2D
@export var maxItemCount: int
@export var food: PackedScene
@export var aliveFoodList: Array[StaticBody2D]
@onready var player = $Player
@export var spawningRange: float
@export var foodResources: Array[FoodResource]
@export var minDistanceBetweenFood: float
@onready var playerArrowParent = player.get_node("ArrowParent")
var arrowTarget
var arrowTargetDistance = 0
var lastPickedFood

func _ready():
	for i in range(maxItemCount):
		create_food()
	pass # Replace with function body.

func _process(delta):
	target_closest_food()

func target_closest_food():
	for food in aliveFoodList:
		if (arrowTargetDistance > player.position.distance_to(food.position) || arrowTarget == food || arrowTargetDistance == 0):
			arrowTarget = food
			arrowTargetDistance = player.position.distance_to(arrowTarget.position)
			var angleToTarget = player.position.angle_to_point(arrowTarget.position)+PI/2.0
			playerArrowParent.rotation = angleToTarget
			
func rotate_arrow_to_closest_food():
	
	pass

func remove_food(object):
	object.queue_free()
	aliveFoodList = aliveFoodList.filter(func(e): return e != object)
	arrowTargetDistance = 0
	create_food()
	target_closest_food()

func create_food():
	var newObject = food.instantiate()
	newObject.foodResource = get_valid_food_resource()
	set_valid_position(newObject)
	add_child(newObject)
	aliveFoodList.append(newObject)

func set_valid_position(object):
	var spawnRange = spawningRange*player.get_node("CollisionShape2D").shape.radius*player.scale.x
	while true:
		object.position = player.position + Vector2.from_angle(randf_range(0,deg_to_rad(360)))*spawnRange*randf_range(1,2)
		var canSpawn = true
		for food in aliveFoodList:
			if object.position.distance_to(food.position) < minDistanceBetweenFood*(object.scale.x+food.scale.x):
				canSpawn = false
		if canSpawn:
			return

func get_valid_food_resource():
	var foodResource
	var i = 0
	while true:
		foodResource = foodResources.pick_random()
		print("food mass: ", foodResource.mass, " player scale: ", player.scale.x)
		if foodResource.mass <= player.scale.x && foodResource.mass*2 >= player.scale.x:
			lastPickedFood = foodResource
			return foodResource
		elif i > 100:
			print("print last food")
			return lastPickedFood
		i+=1
