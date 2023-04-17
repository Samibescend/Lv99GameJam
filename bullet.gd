extends Area2D

@export var velocity = Vector2(1,0)
var speed = 400
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += velocity * delta * speed

