extends CharacterBody2D

class_name Ball

const START_SPEED = 3000
var speed = START_SPEED
var move_dir = Vector2(-1, 0)
var active = false

func _physics_process(delta: float) -> void:
	if !active: return
	velocity = move_dir * speed
	var collided = move_and_slide()
	
	if collided:
		move_dir = move_dir.bounce(get_last_slide_collision().get_normal())


func bounce_from_paddle(paddle_y_pos, paddle_height):
	var new_move_dir_y = (global_position.y - paddle_y_pos) / (paddle_height/2.0)
	move_dir.y = new_move_dir_y
	move_dir.x *= -1

func reset(reset_pos):
	global_position = reset_pos
	speed = START_SPEED
	move_dir.x = 1
	#move_dir.x = [-1, 1].pick_random()
	move_dir.y = randf() * [-1, 1].pick_random()
	
	active = false
	
