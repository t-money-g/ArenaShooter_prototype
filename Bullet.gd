extends Area2D

var speed = 250

var velocity = Vector2()
signal hit_enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#rotation = get_global_mouse_position().angle_to_point(position)
	velocity = Vector2(speed, 0).rotated(rotation)
	position += velocity * delta
	
func _on_Visibility_screen_exited():
	queue_free()

func _on_Bullet_area_entered(area):
	if (check_enemy_hit(area.get_name())):
		print("hit enemy")
		queue_free() # Replace with function body.


func check_enemy_hit(name): 
	if name == "Enemy" || name == "Enemy2"|| name == "Enemy3" 	|| name == "Enemy4":
		return true
	return false