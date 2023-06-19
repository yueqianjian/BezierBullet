extends Node2D

var bullet_scene = preload("res://bullet.tscn")


func _unhandled_input(event):
	if event.is_action_pressed("left_click"):
		attack()
	
	get_tree().root.set_input_as_handled()


func attack():
	var enemy = get_tree().get_first_node_in_group("enemy")
	if !enemy:
		return
	
	var pool = get_tree().get_first_node_in_group("pool")
	if !pool:
		return
	var bullet = bullet_scene.instantiate() as Node2D
	bullet.global_position = global_position	
	pool.add_child(bullet)
