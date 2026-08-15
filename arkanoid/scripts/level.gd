extends Node2D

@onready var brickObj = preload("res://scenes/bricks.tscn")
@onready var floor: Area2D = $floor

@onready var ball: CharacterBody2D = $ball
@onready var ballRespawnTimer: Timer = $ballRespawnTimer

var columns: int = 32; #how many columns of bricks there will be;
var rows: int = 7 #how many rows of bricks there will be
var margin: int = 50 #so the bricks aren't in the edge of the screen

func _ready() -> void:
	_setup_level()

func _setup_level():
	for r in rows:
		for c in columns:
			var newBrick = brickObj.instantiate()
			add_child(newBrick)
			newBrick.position = Vector2(margin + (34 * c), margin + (34 * r))

func _on_floor_area_entered(_area: Area2D) -> void:
	if ballRespawnTimer.is_stopped():
		_change_ball_y_pos()
		ballRespawnTimer.start()
	
	await ballRespawnTimer.timeout
	_change_ball_y_pos()

func _change_ball_y_pos():
	if ball.global_position.y >= floor.position.x:
		print("fag")
		ball.position = ball.spawnPoint
