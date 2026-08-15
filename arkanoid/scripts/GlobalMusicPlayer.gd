extends AudioStreamPlayer2D

func _play_music(music: AudioStream, volume = 0.0) -> void:
	if stream == music:
		return;
	else:
		stream = music;
		volume_db = volume;
		play()

func _play_FX(FX: AudioStream, volume = 0.0) -> void:
	var fx_player = AudioStreamPlayer.new(); #makes a new audio stream player so the bg music won't suddenly stop
	fx_player.name = "FX_PLAYER"; #the name of the FX player
	
	fx_player.stream = FX; #streams the current FX
	fx_player.volume_db = volume;
	fx_player.pitch_scale = randf_range(0.94, 1.06)
	
	add_child(fx_player) #adds child to the current scene
	fx_player.play() #plays the fx
	await fx_player.finished
	fx_player.queue_free()
