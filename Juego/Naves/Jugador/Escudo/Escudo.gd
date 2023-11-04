class_name Escudo
extends Area2D

## Variables
var esta_activado:bool = false setget ,get_esta_activado

## Variables Export
export var energia:float = 8.0
export var radio_desgate:float = -1.6


func _process(delta: float) -> void:
	energia += radio_desgate * delta
	
	if energia <= 0.0:
		desactivar()
	

## Setters y Getters
func get_esta_activado() -> bool:
	return esta_activado



##Metodos
func _ready() -> void:
	set_process(false)
	controlar_colisionador(true)

##Metodos Custom
func controlar_colisionador(esta_desactivado: bool) -> void:
	$CollisionShape2D.set_deferred("disabled", esta_desactivado)

func activar() -> void:
	if energia <= 0.0:
		return

	esta_activado = true
	controlar_colisionador(false)
	$AnimationPlayer.play("activando")

func desactivar() -> void:
	set_process(false)
	esta_activado = false
	controlar_colisionador(true)
	$AnimationPlayer.play_backwards("activando")


##Señales internas
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "activando" and esta_activado:
		$AnimationPlayer.play("activado")
		set_process(true)



func _on_body_entered(body: Node) -> void:
	body.queue_free()