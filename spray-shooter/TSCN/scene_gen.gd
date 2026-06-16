extends Node2D

const BRICK_SCENE = preload("res://TSCN/brick.tscn")
const LIQUID_SCENE = preload("res://TSCN/liquid.tscn")
const PLAYER_SCENE = preload("res://TSCN/player.tscn")
const WALL_SCENE = preload("res://TSCN/wall.tscn")

@export var brickArr : Array[Node2D] = []
@export var brickXArr : Array[float] = []
@export var brickYArr : Array[float] = []

@export var brickCount : int = 0
@export var brickMaxNum : int = 0

@export var brickInitialPosX : float = 80.0
@export var brickInitialPosY : float = 80.0
@export var brickOffset : float = 40.0

@export var liquidNode : Node2D
@export var liquidPosX : float = 575.0
@export var liquidPosY : float = 575.0

@export var playerNode : Node2D
@export var playerPosX : float = 575.0
@export var playerPosY : float = 325.0

@export var wallNode : Node2D
@export var wallPosX : float = 575.0
@export var wallPosY : float = 325.0

@export var spawnedEverything : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	liquidPosX = 575.0
	liquidPosY = 325.0

	playerPosX = 575.0
	playerPosY = 325.0

	wallPosX = 575.0
	wallPosY = 325.0

	brickCount = 0
	brickMaxNum = 11

	brickOffset = 100.0

	spawnedEverything = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if spawnedEverything == false:
		_spawn_liquid()
		_spawn_player()
		_spawn_wall()
		_spawn_bricks()
	spawnedEverything = true

func _spawn_liquid() -> void:
	var liquid_instance = LIQUID_SCENE.instantiate()
	liquid_instance.global_position.x = liquidPosX
	liquid_instance.global_position.y = liquidPosY
	add_child(liquid_instance)
	liquidNode = liquid_instance

func _spawn_player() -> void:
	var player_instance = PLAYER_SCENE.instantiate()
	player_instance.global_position.x = playerPosX
	player_instance.global_position.y = playerPosY
	add_child(player_instance)
	playerNode = player_instance

func _spawn_wall() -> void:
	var wall_instance = WALL_SCENE.instantiate()
	wall_instance.global_position.x = wallPosX
	wall_instance.global_position.y = wallPosY
	add_child(wall_instance)
	wallNode = wall_instance

func _spawn_bricks() -> void:
	var brick_instance
	var _xBegin : int = 0
	var _yBegin : int = 0

	for k in brickMaxNum:
		var makeBrickRand : float = randf_range(0.0, 100.0)

		if makeBrickRand <= 30.0:
			_xBegin += 1
			continue

		brick_instance = BRICK_SCENE.instantiate()
		brick_instance.global_position.x = brickInitialPosX + brickOffset * _xBegin
		brick_instance.global_position.y = brickInitialPosY + brickOffset * _yBegin
		add_child(brick_instance)
		brickArr.append(brick_instance)
		brickCount += 1

		_xBegin += 1

func _reset_spawns() -> void:

	remove_child(liquidNode)
	remove_child(playerNode)
	remove_child(wallNode)

	for k in get_children():
		remove_child(k)

	brickArr.clear()
	brickXArr.clear()
	brickYArr.clear()

	liquidPosX = 575.0
	liquidPosY = 325.0

	playerPosX = 575.0
	playerPosY = 325.0

	wallPosX = 575.0
	wallPosY = 325.0

	brickCount = 0
	brickMaxNum = 11

	brickOffset = 100.0

	spawnedEverything = false
