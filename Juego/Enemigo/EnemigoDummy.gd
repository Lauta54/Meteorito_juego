class_name EnemgioDummy

extends Node2D


func _on_Area2D_body_entered(body: Node) -> void:
	if body is Jugador:
		body.destruir()
