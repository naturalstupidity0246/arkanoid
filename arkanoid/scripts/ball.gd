extends CharacterBody2D

var speed: int = 420;
var dirY: Vector2 = Vector2.DOWN;
var isActive: bool = false;
var spawnPoint: Vector2 = Vector2(576.0, 420.0)

@onready var respawnTimer: Timer = $respawnTimer

func _ready() -> void:
	speed = (speed + ( 20 * GameManager.level))
	_spawn(); #the ball spawns falling left down.

func _spawn() -> void:
	isActive = false;
	global_position = spawnPoint;
	
	respawnTimer.start()
	await respawnTimer.timeout
	_drop_the_ball()

func _drop_the_ball() -> void:
	#makes it move
	isActive = true
	
	var dirX: int = 0
	velocity = Vector2(speed * dirX, speed)

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
			velocity.y = changeDir
		
		if velocity.x == ZERO:
			velocity.x = changeDir

#checks if we hit a brick, then activates the hit() method if we did.
func didWeHitabrick(collision: Variant):
	if collision.get_collider().has_method("hit"):
		collision.get_collider().hit()
