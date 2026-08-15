extends RigidBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var collisionShape: CollisionShape2D = $CollisionShape2D
@onready var effect: CPUParticles2D = $effect

var soundFX: Array[AudioStream] = [preload("res://assets/audio/bricksBreaking/Block Break 1.wav")]

func hit():
	#plays sound effect
	GlobalMusicPlayer._play_FX(soundFX[randi_range(0, soundFX.size() - 1)])
	
	#adds points
	GameManager._add_points(1)
	
	#sets the block to invisible and uncollidable, without deleting it entirely.
	effect.emitting = true
	sprite.visible = false;
	collisionShape.disabled = true;
	
	var bricksLeft = get_tree().get_nodes_in_group("bricks")
	if bricksLeft.size() == 1:
		get_parent().get_node("ball").isActive = false;
		await get_tree().create_timer(1.0).timeout
		GameManager.level += 1;
		get_tree().reload_current_scene()
	else:
		# we wait one second, before we nuke the block out of existence entirely.
		await get_tree().create_timer(1.0).timeout
		queue_free()
