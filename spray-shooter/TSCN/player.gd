extends Node2D

@export var sceneGenNode : Node2D
@export var liquidMovementNode : Node2D
@export var collisionMgr : Node2D

@export var playerSprite : Sprite2D
@export var assignedSprite : bool = false

#@export var animDelay : int = 50
#@export var delayAccumulation : int = 0

@export var startPosX : float = 575.0
@export var startPosY : float = 325.0

@export var dropSpeed : float = 200.0
@export var pushUpSpeed : float = 350.0
@export var strafeSpeed : float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assignedSprite = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if assignedSprite == false:
		playerSprite = sceneGenNode.playerNode.get_child(0) as Sprite2D
		assignedSprite = true
		return

	_drop_char(_delta)
	_input_char(_delta)

func _drop_char(_delta : float) -> void:
	sceneGenNode.playerNode.position.y += dropSpeed * _delta

func _input_char(_delta : float) -> void:
	if Input.is_action_just_pressed("ui_space"):
		_animate_char() 

	if Input.is_action_pressed("ui_up"):
		sceneGenNode.playerNode.position.y -= pushUpSpeed * _delta

	if Input.is_action_pressed("ui_left"):
		sceneGenNode.playerNode.position.x -= strafeSpeed * _delta

	if Input.is_action_pressed("ui_right"):
		sceneGenNode.playerNode.position.x += strafeSpeed * _delta

func _animate_char() -> void:
	if playerSprite == null:
		return

	if playerSprite.frame < ((playerSprite.hframes * playerSprite.vframes) - 2):
		playerSprite.frame += 1
	else:
		collisionMgr._reset_all()

func _player_refill() -> void:
	playerSprite.frame = 0

func _player_reset() -> void:
	assignedSprite = false
	playerSprite.frame = 0
	sceneGenNode.playerNode.position.x = startPosX
	sceneGenNode.playerNode.position.y = startPosY
