extends StaticBody2D

@export var sprite: Sprite2D
@export var foodResource: FoodResource

func _ready():
	sprite.texture = foodResource.texture
	$CollisionShape2D.shape.radius = 2.5
	match (foodResource.foodTextureType):
		foodResource.State.WIDE:
			$CollisionShape2D.shape.height = 10
		foodResource.State.SQUARE:
			$CollisionShape2D.shape.height = 5
	scale *= foodResource.mass
