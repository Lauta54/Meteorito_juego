class_name Meteorito

extends RigidBody2D


## Atributos export
export var vel_lineal_base:Vector2 = Vector2(300.0, 300.0)
export var vel_ang_base:float = 3.0
export var hitpoints_base:float = 10.0

##Atributos
var hitpoints:float

##Atributos onready
#onready var impacto_sfx:AudioStreamPlayer = $impactoSFX
onready var impacto_meteorito = $AnimationPlayer


## Metodos
func _ready() -> void:
	angular_velocity = vel_ang_base

#Metodos Custom
func recibir_danio(danio: float) -> void:
	hitpoints -= danio
	if hitpoints <= 0.0:
		destruir()
	impacto_meteorito.play("impacto")
	#impacto_sfx.play()



func destruir() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	Eventos.emit_signal("meteorito_destruido", global_position)
	queue_free()

func aleatorizar_velocidad() -> float:
	randomize()
	return rand_range(1.1, 1.4)

## Constructor
func crear(pos: Vector2, dir: Vector2, tamanio: float) -> void:
	position = pos
	linear_velocity = vel_lineal_base * dir
	mass *= tamanio
	$Sprite.scale = Vector2.ONE * tamanio
	var radio:int =int($Sprite.texture.get_size().x / 2.3 * tamanio)
	var forma_colision:CircleShape2D = CircleShape2D.new()
	forma_colision.radius = radio
	$CollisionShape2D.shape = forma_colision
	#Calcular velocidades
	linear_velocity = (vel_lineal_base * dir / tamanio) * aleatorizar_velocidad()
	angular_velocity = (vel_ang_base / tamanio) * aleatorizar_velocidad()
	#Calcular hitpoints
	hitpoints = hitpoints_base * tamanio
	#Solo debug
	print("hitpoints: ", hitpoints)



