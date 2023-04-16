extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_end_level_1_body_entered(body):
	print("END OF THE FIRST LEVEL") # Replace with function body.

func update_focus(value):
	$HUD.update_focus(value)


