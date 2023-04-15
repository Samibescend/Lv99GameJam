extends CharacterBody2D

@export var speed = 400
@export var dash_speed = 1000
@export var focus_increment_by_second = 10

var old_speed
var focus = 0
var focus_time_in_seconds = 0

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if (Input.is_action_just_pressed("dash") and $DashTimer.is_stopped()):
		old_speed = speed
		speed += dash_speed
		$DashTimer.start()


func _process(delta):
	if (Input.is_action_pressed("charge_focus")):
		focus_time_in_seconds += delta
	if (Input.is_action_just_released("charge_focus")):
		var focus_increase = floor(focus_time_in_seconds * focus_increment_by_second)
		focus = clamp(focus + focus_increase, 0, 100)
		print_debug(focus, "\n", focus_time_in_seconds)
		focus_time_in_seconds = 0
	if (Input.is_key_pressed(KEY_R)) :
		focus = 0


func _physics_process(delta):
	get_input()
	move_and_slide()


func _on_dash_timer_timeout():
	speed = old_speed
