extends TextEdit

@export var sceneGenNode : Node2D
@export var collisionMgrNode : Node2D
@export var scoreCount : int
@export var scoreConsumedArr : Array[bool] = []

@export var consumptionArrSet : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scoreCount = 0
	consumptionArrSet = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if consumptionArrSet == false:
		_consumption_array_setter()
		consumptionArrSet = true
		return

	if scoreCount != 0 && scoreCount == sceneGenNode.brickCount:
		collisionMgrNode._reset_all()
		return

	if scoreConsumedArr.size() == sceneGenNode.brickCount:
		_score_counter()

	text = str(scoreCount)

func _consumption_array_setter() -> void:
	for k in sceneGenNode.brickCount:
		scoreConsumedArr.append(false)

func _score_counter() -> void:
	var brickNode : Node2D
	var brickSprite : Sprite2D

	for k in sceneGenNode.brickCount:
		brickNode = sceneGenNode.brickArr[k]
		brickSprite = brickNode.get_child(0) as Sprite2D
		if brickSprite.frame >= ((brickSprite.hframes * brickSprite.vframes) - 1):
			scoreConsumedArr[k] = true

	scoreCount = 0
	for scoreConsump in scoreConsumedArr:
		if scoreConsump == true:
			scoreCount += 1

func _score_reset() -> void:
	scoreCount = 0
	consumptionArrSet = false
	scoreConsumedArr.clear()
