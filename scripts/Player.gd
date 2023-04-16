extends CharacterBody2D

@export var speed = 400
@export var dash_speed = 1000
@export var focus_increment_by_second = 10
@export var dash_cost = 20

var old_speed
var focus = 0
var focus_time_in_seconds = 0


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if (Input.is_action_just_pressed("dash") and $DashTimer.is_stopped() and focus >= dash_cost):
		focus -= dash_cost
		get_parent().update_focus(focus)
		old_speed = speed
		speed += dash_speed
		$DashTimer.start()
		
	if (Input.is_action_pressed("charge_focus")):
		velocity = Vector2.ZERO


func _process(delta):
	if (Input.is_action_pressed("charge_focus")):
		focus_time_in_seconds += delta
		if (floor(focus_time_in_seconds * focus_increment_by_second) > 1):
			focus = clamp(focus + floor(focus_time_in_seconds * focus_increment_by_second), 0, 100)
			focus_time_in_seconds = 0
			(get_parent().update_focus(focus))


func _physics_process(delta):
	get_input()
	move_and_slide()


func _on_dash_timer_timeout():
	speed = old_speed

