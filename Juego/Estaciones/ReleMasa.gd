class_name ReleDeMasa

extends Node2D


func _ready() -> void: 
	Eventos.emit_signal("minimapa_objeto_creado")


## Metodos Custom
func atraer_jugador(body: Node) -> void:
	$Tween.interpolate_property(
		body,
		"global_position",
		body.global_position,
		global_position,
		1.0,
		Tween.TRANS_CIRC,
		Tween.EASE_IN
	)
	$Tween.start()

## Señales Internas

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Spawn":
		$AnimationPlayer.play("activado")


func _on_DetectorJugador_body_entered(body: Node) -> void:
	$DetectorJugador/CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("super_activado ")
	body.desactivar_controles()
	atraer_jugador(body)



func _on_Tween_tween_all_completed() -> void:
	Eventos.emit_signal("nivel_completado")
