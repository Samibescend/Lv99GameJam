extends CharacterBody2D

@export var speed = 400
@export var dash_speed = 1000
@export var focus_increment_by_second = 10
@export var dash_cost = 20

var focus = 100
var focus_time_in_seconds = 0
var has_collided
var can_focus = true
var dash_target

func get_input():
	if (Input.is_action_just_pressed("dash") and $DashTimer.is_stopped() and focus >= dash_cost):
		focus -= dash_cost
		dash_target = get_global_mouse_position()
		$DashTimer.start()
		
	var input_direction = Input.get_vector("left", "right", "up", "down")
	look_at(get_global_mouse_position())
	
	if ($DashTimer.is_stopped()):
		velocity = input_direction * speed
	else:
		velocity = position.direction_to(dash_target) * dash_speed
		print_debug("Dashed in direction ", velocity, " at speed ", speed, " with direction ", position.direction_to(dash_target))
		
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
