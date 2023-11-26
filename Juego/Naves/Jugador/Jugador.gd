class_name Jugador
extends NaveBase

## Atributos Export
export var potencia_motor:int = 18
export var potencia_rotacion:int = 260
export var estela_maxima:int =  150


## Atributos
var empuje:Vector2 = Vector2.ZERO
var dir_rotacion:int = 0

## Atributos Onready
onready var laser:RayoLaser = $LaserBeam2D setget, get_laser
onready var estela:Estela = $EstelaPuntoInicio/Trail2D
onready var motor_sfx:Motor = $MotorSFX
onready var escudo:Escudo = $Escudo setget, get_escudo

## Setters y Getters
func get_laser() -> RayoLaser:
	return laser

func get_escudo() -> Escudo:
	return escudo


## Metodos 
func _ready() -> void:
	DatosJuego.set_player_actual(self)

func _unhandled_input(event: InputEvent) -> void:
	if not esta_input_activo():
		return
	
	#Disparo Rayo
	if event.is_action_pressed("disparo_secundario"):
		laser.set_is_casting(true)
	
	if event.is_action_released("disparo_secundario"):
		laser.set_is_casting(false)
	
	## Control Escudo
	if event.is_action_pressed("escudo") and not escudo.get_esta_activado():
		escudo.activar()
	
	#Control estela y sonido motor
	if event.is_action_pressed("Mov_Adelante"):
		estela.set_max_points(estela_maxima)
	
	elif event.is_action_pressed("Mov_Atras"):
		estela.set_max_points(0)
		
	
	if (event.is_action_released("Mov_Adelante")
		or event.is_action_released("Mov_Atras")):
			motor_sfx.sonido_off()
	

func _integrate_forces(_state: Physics2DDirectBodyState) -> void:
	apply_central_impulse(empuje.rotated(rotation))
	apply_torque_impulse(dir_rotacion * potencia_rotacion)


func _process(_delta: float) -> void:
	Jugador_input()

## Metodos Custom
func Jugador_input() -> void:
	if not esta_input_activo():
		return
	
	#empuje
	empuje = Vector2.ZERO
	if Input.is_action_pressed("Mov_Adelante"):
		empuje = Vector2(potencia_motor, 0)
		motor_sfx.sonido_on()
	elif Input.is_action_pressed("Mov_Atras"):
		empuje = Vector2(-potencia_motor, 0)
		motor_sfx.sonido_on()
	if not esta_input_activo():
		return
	
	#rotacion
	dir_rotacion = 0
	if Input.is_action_pressed("rotar_antihorario"):
		dir_rotacion -= 1
	elif Input.is_action_pressed("rotar_horario"):
		dir_rotacion += 1
	
	
	#Disparo
	if Input.is_action_pressed("disparo_principal"):
		canion.set_esta_disparando(true)
	
	if Input.is_action_just_released("disparo_principal"):
		canion.set_esta_disparando(false)

func esta_input_activo() -> bool:
	if estado_actual in [ESTADO.MUERTO, ESTADO.SPAWN]:
		return false
	
	return true

func desactivar_controles() -> void:
	controlador_estados(ESTADO.SPAWN)
	empuje = Vector2.ZERO
	motor_sfx.sonido_off()
	laser.set_is_casting(false)
