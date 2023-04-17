extends CharacterBody2D
var player_seen = false
var speed = 400
signal shoot(bullet, direction, location)

var Bullet = preload("res://Bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_seen:
		look_at(get_parent().get_node("./Player").position)
	if player_seen and $Timer.is_stopped():
		$Timer.start()
		shoot.emit(Bullet, self.rotation, self.position)


func _on_vision_cone_area_body_entered(body):
	#print("player repéré")
	player_seen = true
	pass






func _on_vision_cone_area_body_exited(body):
	player_seen = false
