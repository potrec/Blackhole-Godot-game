extends Node2D
@export var maxItemCount: int
@export var food: PackedScene
@export var aliveFoodList: Array[StaticBody2D]
@onready var player = $Player
@export var spawningRange: float
@export var foodResources: Array[FoodResource]
@export var minDistanceBetweenFood: float
func _ready():
	for i in range(maxItemCount):
		create_food()
	pass # Replace with function body.

func remove_food(object):
	object.queue_free()
	aliveFoodList = aliveFoodList.filter(func(e): return e != object)
	create_food()

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
	while true:
		foodResource = foodResources.pick_random()
		if foodResource.mass < player.scale.x * 5  && foodResource.mass * 5 > player.scale.x:
			return foodResource
