extends Area2D


func _on_area_entered(area):
	area.owner.queue_free()
