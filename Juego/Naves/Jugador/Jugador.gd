class_name Jugador
extends RigidBody2D

export var potencia_motor:int = 20 
export var potencia_rotacion:int = 280

var empuje:Vector2 = Vector2.ZERO
var dir_rotacion:int = 0


#Metodos
func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	apply_central_impulse(empuje.rotated(rotation))
	apply_torque_impulse(dir_rotacion * potencia_rotacion)


func _process(delta: float) -> void:
	Jugador_input()


#Metodos Custom
func Jugador_input() -> void:
	pass
	#empuje
	empuje = Vector2.ZERO
	if Input.is_action_pressed("Mov_Adelante"):
		empuje = Vector2(potencia_motor, 0)
	elif Input.is_action_pressed("Mov_Atras"):
		empuje = Vector2(-potencia_motor, 0)
	
	#rotacion
	
	dir_rotacion = 0
	if Input.is_action_pressed("rotar_antihorario"):
		dir_rotacion -= 1
	elif Input.is_action_pressed("rotar_horario"):
		dir_rotacion += 1
	









#func _ready():
	#pass # Replace with function body.



