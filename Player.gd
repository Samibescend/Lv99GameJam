extends CharacterBody2D

@export var speed = 400
@export var dash_speed = 1000

var old_speed

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if (Input.is_action_just_pressed("dash") and $DashTimer.is_stopped()):
		old_speed = speed
		speed += dash_speed
		$DashTimer.start()
	
	
func _physics_process(delta):
	get_input()
	move_and_slide()


func _on_dash_timer_timeout():
	speed = old_speed
