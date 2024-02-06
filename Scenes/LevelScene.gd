extends Node2D
@export var maxItemCount: int
@export var food: PackedScene
@export var objectList: Array[StaticBody2D]
@onready var player = $Player
@export var spawningRange: float
@export var foodResources: Array[FoodResource]

func _ready():
	for i in range(maxItemCount):
		create_food()
	pass # Replace with function body.

func remove_food(object):
	object.queue_free()
	create_food()

func create_food():
	var newObject = food.instantiate()
	newObject.foodResource = foodResources.pick_random()
	var spawnRange = spawningRange*player.get_node("CollisionShape2D").shape.radius*player.scale.x
	newObject.position = player.position + Vector2.from_angle(randf_range(0,deg_to_rad(360)))*spawnRange*randf_range(1,2)
	add_child(newObject)
	objectList.append(newObject)
