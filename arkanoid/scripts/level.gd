extends Node2D

@onready var brickObj = preload("res://scenes/bricks.tscn")
@onready var floor: Area2D = $floor

@onready var ball: CharacterBody2D = $ball

var columns: int = 32; #how many columns of bricks there will be;
var rows: int = 7 #how many rows of bricks there will be
var margin: int = 50 #so the bricks aren't in the edge of the screen
var maxRows: int = 9

func _ready() -> void:
	_setup_level()

func _setup_level():
	
	rows = 2 + GameManager.level
	
	if rows > maxRows:
		rows = maxRows
	
	var colors = _get_colors()
	colors.shuffle()
	
	for r in rows:
		for c in columns:
			var randNum: int = randi_range(0,2) #procedural generation but with numbers
			if randNum > 0:
				var newBrick = brickObj.instantiate()
				add_child(newBrick)
				newBrick.position = Vector2(margin + (34 * c), margin + (34 * r))
				
				var sprite = newBrick.get_node("Sprite2D")
				
				#changes the brick's colors based on what row they're in
				if r <= 9:
					sprite.modulate = colors[0]
				if r < 6:
					sprite.modulate = colors[1]
				if r < 3:
					sprite.modulate = colors[2]

func _get_colors():
	var colors: Array = [
		Color.from_rgba8(226, 59,  140),
		Color.from_rgba8(125, 221, 6),
		Color.from_rgba8(209,203, 33),
		Color.from_rgba8(38, 239, 149),
		Color.from_rgba8(237, 114, 14),
		Color.from_rgba8(37, 234, 119),
		Color.from_rgba8(21, 214, 194),
		Color.from_rgba8(229, 193, 64),
		Color.from_rgba8(52, 38, 255),
		Color.from_rgba8(243, 32, 247),
	]
	return colors

func _on_floor_area_entered(_area: Area2D) -> void:
	get_tree().reload_current_scene()
	GameManager.level = 1;
	GameManager.score = 0;
