extends RigidBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var collisionShape: CollisionShape2D = $CollisionShape2D


func hit():
	#sets the block to invisible and uncollidable, without deleting it entirely.
	sprite.visible = false;
	collisionShape.disabled = true;
	
	# we wait one second, before we nuke the block out of existence entirely.
	await get_tree().create_timer(1.0).timeout
	queue_free()
