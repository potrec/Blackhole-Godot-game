extends Node

@export var playButton: Button
@export var optionButton: Button
@export var exitButton: Button

func  _ready():
	playButton.connect('pressed',Callable(self, "on_play"))
	
func on_play():
	SceneTransition.change_scene("res://Scenes/LevelScene.tscn")
