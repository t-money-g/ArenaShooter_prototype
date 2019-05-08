extends Node2D

var playerHit = false

var firstEvolution = true

func _ready():
	pass

func new_game():
	playerHit = false
	$StartTimer.stop()
	$Player.start($SpawnPoint.position)
	$Enemy.reset(firstEvolution)
	$Enemy2.reset(firstEvolution)
	$Enemy3.reset(firstEvolution)
	$Enemy4.reset(firstEvolution)
	
	
	
func game_over():
	playerHit = true
	firstEvolution = true
	$StartTimer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !playerHit:
		var player_position = $Player.position
		$Enemy.target = player_position 
		$Enemy2.target = player_position
		$Enemy3.target = player_position
		$Enemy4.target = player_position

func _on_Player_shoot(bullet, direction, location):
	if !playerHit:
		var b = bullet.instance()
		add_child(b)
		b.rotation = direction
		b.position = location
		b.velocity = b.velocity.rotated(direction)

func _on_StartTimer_timeout():
	new_game()
