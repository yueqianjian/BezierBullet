extends Node2D

var speed = 700.0
var direction = Vector2.ZERO
var next_point = Vector2.ZERO
var current_time = 0.0

func _ready():
	look_at(get_global_mouse_position())
	direction = (get_global_mouse_position() - global_position).normalized()
	next_point = global_position


func set_next_point(delta):
	var enemy = get_tree().get_first_node_in_group("enemy") as Node2D
	if !enemy:
		return
	
	current_time += delta	
	var distance = global_position.distance_to(enemy.global_position)
	var all_time = distance / speed
	var t = min(current_time / all_time, 1)
	var start_control_point = direction * speed * 1.7
	next_point = global_position.bezier_interpolate(start_control_point, enemy.global_position, enemy.global_position, t)


func _physics_process(delta):
	var enemy = get_tree().get_first_node_in_group("enemy") as Node2D
	if !enemy:
		global_position += direction * delta * speed
		return
	
	set_next_point(delta)
	global_position = global_position.move_toward(next_point, speed * delta)


func _on_timer_timeout():
	queue_free()
