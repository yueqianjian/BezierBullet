extends Node2D

@onready var marker_2d = $Marker2D
@onready var timer = $Timer

var arrow_scene = preload("res://arrow.tscn")
var type = 1
var bullet_types = 5


func _process(delta):
	look_at(get_global_mouse_position())


func _physics_process(delta):
	if Input.is_action_pressed("left_click"):
		attack()


func _unhandled_input(event):
	if event.is_action_pressed("right_click"):
		type = wrapi(type + 1, 1 , bullet_types + 1)
		print(type)
		
	get_tree().root.set_input_as_handled()


func attack():
	if !timer.is_stopped():
		return
	
	timer.start()
	var arrow = arrow_scene.instantiate() as Node2D
	arrow.type = type
	arrow.global_position = marker_2d.global_position
	get_parent().add_child(arrow)
