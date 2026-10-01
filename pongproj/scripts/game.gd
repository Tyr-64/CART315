extends Node2D
var game_area_size = Vector2(1280, 720)

@onready var ball = $Ball
@onready var detector_left = $DetectorLeft
@onready var detector_right = $DetectorRight
@onready var start_delay = $StartDelay

var score = Vector2i.ZERO
@export var final_score = 11

@onready var hud = $CanvasLayer/HUD

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _ready():
	detector_left.ball_out.connect(_on_detector_ball_out)
	detector_right.ball_out.connect(_on_detector_ball_out)
	
	randomize()
	reset_game()



func _draw() -> void:
	var line_start = Vector2(game_area_size.x/2.0, 0)
	var line_end = Vector2(game_area_size.x/2.0, game_area_size.y)
	draw_dashed_line(line_start, line_end, Color.WHITE, 8.0, 12.0, false)

func reset_round():
	var reset_pos = game_area_size / 2.0
	ball.reset(reset_pos)
	start_delay.start()
	await start_delay.timeout
	ball.active = true
	

func reset_game():
	score = Vector2i.ZERO
	hud.reset_score()
	reset_round()






func _on_detector_ball_out(is_left):
	if is_left:
		score.y += 1
	else:
		score.x += 1
	
	hud.set_new_score(score)
	
	if score.x >= final_score:
		hud.win(true)
		reset_game()
	elif score.y >= final_score:
		hud.win(false)
		reset_game()
	else:
		reset_round()
	print(score)
	reset_round()
