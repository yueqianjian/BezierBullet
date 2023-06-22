extends Node2D


func _on_hurt_box_area_entered(area):
	area.owner.queue_free()
