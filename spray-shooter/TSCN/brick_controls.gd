extends Node2D

@export var sceneGenNode : Node2D

@export var xMinPos : float = 90.0
@export var yMinPos : float = 90.0
@export var xMaxPos : float = 1050.0
@export var yMaxPos : float = 400.0

@export var moveSpeed : float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if sceneGenNode.brickCount == 0:
		return

	_bricks_movement(_delta)

func _bricks_movement(_delta : float) -> void:
	for k in sceneGenNode.brickCount:
		if (sceneGenNode.brickArr[k].position.x <= xMaxPos) && (sceneGenNode.brickArr[k].position.y <= yMinPos):
			sceneGenNode.brickArr[k].position.x += moveSpeed * _delta

		elif (sceneGenNode.brickArr[k].position.x > xMaxPos) && (sceneGenNode.brickArr[k].position.y < yMaxPos):
			sceneGenNode.brickArr[k].position.y += moveSpeed * _delta

		elif (sceneGenNode.brickArr[k].position.x > xMinPos) && (sceneGenNode.brickArr[k].position.y > yMaxPos):
			sceneGenNode.brickArr[k].position.x -= moveSpeed * _delta

		elif (sceneGenNode.brickArr[k].position.x <= xMinPos) && (sceneGenNode.brickArr[k].position.y > yMinPos):
			sceneGenNode.brickArr[k].position.y -= moveSpeed * _delta
