extends Node

var score: int = 0
var level: int = 1

@onready var scoreText: Label = $CanvasLayer/VBoxContainer/SCORE
@onready var levelText: Label = $CanvasLayer/VBoxContainer/LEVEL
var bgMusic: Array[AudioStream] = [preload("res://assets/audio/music/03 Study First Then Videogames.mp3"), preload("res://assets/audio/music/05 The 45 Second War.mp3"), preload("res://assets/audio/music/06 Little Green Men.mp3"), preload("res://assets/audio/music/07 Dumpster Diving!.mp3")]

func _ready() -> void:
	GlobalMusicPlayer._play_music(bgMusic[randi_range(0, bgMusic.size() - 1)], 1.0)
	
	GlobalMusicPlayer.finished.connect(GlobalMusicPlayer._play_music.bind(bgMusic[randi_range(0, bgMusic.size() - 1)], 1.0))

func _add_points(pts):
	score += pts

func _process(delta: float) -> void:
	scoreText.text = "SCORE: " + str(score);
	levelText.text = "LEVEL: " + str(level)
