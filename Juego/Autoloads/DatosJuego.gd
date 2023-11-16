
extends Node

## Atributos
var player_actual:Jugador = null setget set_player_actual, get_player_actual

## Setters y Getters
func set_player_actual(player: Jugador) -> void:
	player_actual = player

func get_player_actual() -> Jugador:
	return player_actual
