extends Area2D

export (int) var speed = 100
var bulletScene = preload("res://Bullet.tscn")

signal shoot(bullet, direction, location)
signal hit

var health = 3
var screen_size # size of the game window 


func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false
	
# Called when the node enters the scene tree for the first time.
func _ready():
	#hide()
	print('ready')
	screen_size = get_viewport_rect().size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
	var velocity = Vector2() # The player's movement vector. 
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
		
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x , 0 , screen_size.x)
	position.y = clamp(position.y , 0, screen_size.y)

func _input(event):
	if event is InputEventMouseButton: 
		if event.button_index == BUTTON_LEFT and event.pressed: 
#			print("Left Moust button Clicked")
#			add_child(bullet_instance)
#			bullet_instance.position = get_global_mouse_position()
			emit_signal("shoot", bulletScene, rotation,position)


func _on_Player_area_entered(area):
	if check_enemy_hit(area.get_name()):
		hide()
		emit_signal("hit")
		$CollisionShape2D.call_deferred("set_disabled", true)
		print("got hit")

func check_enemy_hit(name): 
	if name == "Enemy" || name == "Enemy2"|| name == "Enemy3" 	|| name == "Enemy4":
		return true
	return false