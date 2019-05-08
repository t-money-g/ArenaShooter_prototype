extends Area2D

export (int) var speed = 0

const START_SPEED = 100

var target = Vector2()
var velocity = Vector2()
var evolSteps = 0

onready var initial_pos = self.position

func ready():
	resetSpeed()
	
func reset(firstEvolution):
	$EvolTimer.stop()
	position = initial_pos
	show()
	$CollisionShape2D.disabled = false
	if firstEvolution:
		resetSpeed()
	
	
func _process(delta):
	velocity = (target - position).normalized() * speed
	if (target - position).length() > 5:
        position += velocity * delta

func vaporize(): 
	$CollisionShape2D.call_deferred("set_disabled", true)
	hide()
	speed = 0
	$EvolTimer.start()
	
func _on_Enemy_area_entered(area):
	#print(area)
	vaporize() 
	
func resetSpeed():
	speed = START_SPEED
	
func _on_EvolTimer_timeout():
	evolSteps += .5
	speed += START_SPEED * evolSteps 
	reset(false)
