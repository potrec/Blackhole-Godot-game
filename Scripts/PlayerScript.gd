extends Node2D

const speed: int = 100

# Called when the node enters the scene tree for the first time
func _ready():
	#$Sprite2D.rotation_degrees = 90
	#position = Vector2(300,200)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_vector("Right","Left","Down","Up")
	print(direction)
	position -= speed*delta*direction
	#print(position)
