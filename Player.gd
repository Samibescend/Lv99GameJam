extends CharacterBody2D

@export var speed = 400
@export var focus = 0

func _ready():
	set_process_input(true) 


func _input(event):
	if event.is_action("charge_focus"):
		charge_focus()


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed


func _physics_process(delta):
	get_input()
	move_and_slide()


func charge_focus():
	$ChargeTimer.start()



func _on_charge_timer_timeout():
	focus += 1
	print(focus)

