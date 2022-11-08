extends Node2D

func _on_Player_dead():
	queue_free()
