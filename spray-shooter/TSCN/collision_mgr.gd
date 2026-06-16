extends Node2D

@export var sceneGenNode : Node2D
@export var playerControlsNode : Node2D
@export var liquidMovementNode : Node2D
@export var brickControlsNode : Node2D
@export var scoreCounterTextNode : TextEdit

@export var deltaPlBrX : float = 40.0
@export var deltaPlBrY : float = 40.0

@export var deltaPlayerY : float = 20.0
@export var liquidCollision : float = 500.0

@export var wallCollisionMinX : float = 40.0
@export var wallCollisionMinY : float = 40.0
@export var wallCollisionMaxX : float = 1100.0
@export var wallCollisionMaxY : float = 600.0

@export var collisionOccurred : bool = false

#@export var delayReset : float = 1.0
#@export var delayAccumulation : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deltaPlayerY = 20.0
	deltaPlBrX = 40.0
	deltaPlBrY = 40.0
	liquidCollision = 500.0
	collisionOccurred = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if collisionOccurred == true:
		_reset_all()
		collisionOccurred = false
	_player_spray_brick_collision()
	_player_to_liquid()
	_player_to_bricks()
	_player_to_wall()

func _player_spray_brick_collision() -> void:
	var brickNode : Node2D
	var brickSprite : Sprite2D
	var plNode : Node2D = sceneGenNode.playerNode
	var plSprite : Node2D = plNode.get_child(0) as Sprite2D
	var plX : float = plNode.position.x
	var plY : float = plNode.position.y

	for k in sceneGenNode.brickCount:
		brickNode = sceneGenNode.brickArr[k]
		brickSprite = brickNode.get_child(0) as Sprite2D

		if plSprite.frame < 1 || plSprite.frame > ((plSprite.hframes * plSprite.vframes) - 2):
			continue

		if ((absf(plX - brickNode.position.x) <= deltaPlBrX) && ((plY - brickNode.position.y) > 0.0 && (plY - brickNode.position.y) <= 1.5 * deltaPlBrY)):
			if brickSprite.frame < ((brickSprite.hframes * brickSprite.vframes) - 1):
				print(plSprite.frame)
				brickSprite.frame += 1

func _player_to_wall() -> void:
	if (sceneGenNode.playerNode.position.x < wallCollisionMinX):
		collisionOccurred = true
	if (sceneGenNode.playerNode.position.x >= wallCollisionMaxX):
		collisionOccurred = true
	if (sceneGenNode.playerNode.position.y < wallCollisionMinY):
		collisionOccurred = true
	if (sceneGenNode.playerNode.position.y >= wallCollisionMaxY):
		collisionOccurred = true

func _player_to_liquid() -> void:
	if (sceneGenNode.playerNode.position.y >= liquidCollision):
		playerControlsNode._player_refill()

func _player_to_bricks() -> void:
	var brickNode : Node2D
	var brickSprite : Sprite2D
	var plNode : Node2D = sceneGenNode.playerNode
	var plX : float = plNode.position.x
	var plY : float = plNode.position.y

	for k in sceneGenNode.brickCount:
		brickNode = sceneGenNode.brickArr[k]
		brickSprite = brickNode.get_child(0) as Sprite2D

		if brickSprite.frame >= ((brickSprite.hframes * brickSprite.vframes) - 1):
			continue

		if ((absf(plX - brickNode.position.x) <= deltaPlBrX) && (absf(plY - brickNode.position.y) <= deltaPlBrY)):
			collisionOccurred = true
			break

func _reset_all() -> void:
	sceneGenNode._reset_spawns()
	playerControlsNode._player_reset()
	liquidMovementNode._liquid_reset()
	scoreCounterTextNode._score_reset()
