extends Node

const DINO_START_POS := Vector2i(61, 187)
const CAM_START_POS := Vector2i(160, 120)

var score : int
const SCORE_MODIFIER : int = 10
var speed  : float
const START_SPEED  : float = 1
const MAX_SPEED  : int = 4
const SPEED_MODIFIER : int = 800
var screen_size : Vector2i
var game_running : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	new_game() # Replace with function body.

func new_game():
	score = 0
	show_score()
	game_running = false
	
	$Dino.position = DINO_START_POS
	$Dino.velocity = Vector2i(0, 0)
	$Camera2D.position = CAM_START_POS
	$Ground.position = Vector2i(0, 0)

	$HUD.get_node("StartLabel").show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		speed = START_SPEED + score / SPEED_MODIFIER
		if speed > MAX_SPEED:
			speed = MAX_SPEED
		
		print(speed)
		
		$Dino.position.x += speed
		$Camera2D.position.x += speed
		
		score += speed
		show_score()
		
		if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x
	else:
		if Input.is_action_pressed("ui_accept"):
			game_running = true
			$HUD.get_node("StartLabel").hide()

func show_score():
	$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score / SCORE_MODIFIER)
