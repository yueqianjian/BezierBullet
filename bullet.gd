extends Node2D

var speed = 500.0
var direction = Vector2.ZERO

var start_point = Vector2.ZERO
var target_point = Vector2.ZERO
var start_control_point = Vector2.ZERO
var target_control_point = Vector2.ZERO
var t = 0.0

func _ready():
	look_at(get_global_mouse_position())
	direction = (get_global_mouse_position() - global_position).normalized()
	
	var enemy = get_tree().get_first_node_in_group("enemy") as Node2D
	if !enemy:
		return

	start_point = global_position
	target_point = enemy.global_position
	start_control_point = direction * (start_point.distance_to(target_point) / 0.3)
	target_control_point = target_point


func _physics_process(delta):
	t = min((speed * delta / 500) + t, 1) 
	var new_point = start_point.bezier_interpolate(start_control_point, target_control_point, target_point, t)
	global_position = global_position.move_toward(new_point, speed * delta)


func _on_timer_timeout():
	queue_free()
