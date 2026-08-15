extends CharacterBody2D

var speed: int = 420;
var dir: Vector2 = Vector2.DOWN;
var isActive: bool = true;
var left: int = -1
var spawnPoint: Vector2 = Vector2(576.0, 420.0)

func _ready() -> void:
	velocity = Vector2(speed * left, speed); #the ball spawns falling left down.

func _physics_process(delta: float) -> void:
	if isActive:
		
		var collision = move_and_collide(velocity * delta)
		
		if collision:
			velocity = velocity.bounce(collision.get_normal())
			
			didWeHitabrick(collision)
		
		var ZERO: int = 0
		var tooLow: int = 100
		var changeDir: int = -200
		
		if ((velocity.y > ZERO) and (velocity.y < tooLow)):
			print(velocity.y)
			velocity.y = changeDir
		
		if velocity.x == ZERO:
			velocity.x = changeDir

#checks if we hit a brick, then activates the hit() method if we did.
func didWeHitabrick(collision: Variant):
	if collision.get_collider().has_method("hit"):
		collision.get_collider().hit()
