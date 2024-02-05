extends Node2D
@export var maxItemCount: int
@export var itemList: Array[PackedScene]
@export var objectList: Array[StaticBody2D]
@onready var player = $Player
@export var spawningRange: float
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(maxItemCount):
		create_food()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	pass

func remove_food(object):
	object.queue_free()
	create_food()

func create_food():
	var newObject = itemList.pick_random().instantiate()
	var spawnRange = spawningRange*player.get_node("CollisionShape2D").shape.radius*player.scale.x
	newObject.position = player.position + Vector2.from_angle(randf_range(0,deg_to_rad(360)))*spawnRange*randf_range(1,2)
	add_child(newObject)
	objectList.append(newObject)
