extends CharacterBody2D

@export var speed = 400
@export var dash_speed = 1000
@export var focus_increment_by_second = 10
@export var dash_cost = 20

var old_speed
var focus = 0
var focus_time_in_seconds = 0
var has_collided
var can_focus = true


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if (Input.is_action_just_pressed("dash") and $DashTimer.is_stopped() and focus >= dash_cost):
		focus -= dash_cost
		old_speed = speed
		speed += dash_speed
		$DashTimer.start()
		
	if (Input.is_action_pressed("charge_focus")):
		velocity = Vector2.ZERO


func _process(delta):
	if (has_collided):
		can_focus = false
		focus_time_in_seconds = 0

	elif (can_focus):
		if (Input.is_action_pressed("charge_focus")):
			focus_time_in_seconds += delta
		if (Input.is_action_just_released("charge_focus")):
			var focus_increase = floor(focus_time_in_seconds * focus_increment_by_second)
			focus = clamp(focus + focus_increase, 0, 100)
			print_debug(focus, "\n", focus_time_in_seconds)
			focus_time_in_seconds = 0
			
	# J'ai perdu la possibilité de focus à la frame précédente et je ne presse plus Espace et je n'ai pas été touché à la frame précédente
	if (not can_focus and not Input.is_action_pressed("charge_focus") and not has_collided):
		can_focus = true
		print_debug("Focus ability restored")


func _physics_process(delta):
	get_input()
	has_collided = move_and_slide()

func _on_dash_timer_timeout():
	speed = old_speed
