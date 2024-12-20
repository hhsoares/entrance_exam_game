extends CharacterBody2D

const GRAVITY : int = 5000
const JUMP_SPEED : int = -1200

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		if not get_parent().game_running:
			$AnimatedSprite2D.play("idle")
		else:
			$RunCol.disabled = false
			if Input.is_action_pressed("ui_accept"):
				velocity.y = JUMP_SPEED
			elif Input.is_action_pressed("ui_down"):
				$AnimatedSprite2D.play("duck")
				$RunCol.disabled = true
			else:
				$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("jump")
		if Input.is_action_pressed("ui_down"):
				$AnimatedSprite2D.play("duck")
				velocity.y = JUMP_SPEED * -1
		
	move_and_slide()
