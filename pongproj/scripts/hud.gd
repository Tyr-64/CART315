extends Control

@onready var left_score = $LeftScore
@onready var right_score = $RightScore
@onready var winScreen = $WinScreen


func set_new_score(score):
	left_score.text = str(score.x)
	right_score.text = str(score.y)

func reset_score():
	left_score.text = "0"
	right_score.text = "0"

func win(leftWin):
	if leftWin:
		winScreen.global_position.y = 120
		winScreen.global_position.x = 200
		await get_tree().create_timer(1).timeout
		winScreen.global_position.y = -120
		winScreen.global_position.x = -250
	elif leftWin == false:
		winScreen.global_position.y = 120
		winScreen.global_position.x = 900
		await get_tree().create_timer(1).timeout
		winScreen.global_position.y = -120
		winScreen.global_position.x = -250
