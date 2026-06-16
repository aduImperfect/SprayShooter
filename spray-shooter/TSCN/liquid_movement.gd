extends Node2D

@export var sceneGenNode : Node2D

@export var liquidSprite : Sprite2D
@export var assignedSprite : bool = false

@export var animDelay : float = 1.0
@export var delayAccumulation : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	delayAccumulation = 0.0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if assignedSprite == false:
		liquidSprite = sceneGenNode.liquidNode.get_child(0) as Sprite2D
		assignedSprite = true
		return

	delayAccumulation += _delta
	if delayAccumulation >= animDelay:
		_animate_char()
		delayAccumulation = 0.0

func _animate_char() -> void:
	if liquidSprite == null:
		return
	
	if liquidSprite.frame < ((liquidSprite.hframes * liquidSprite.vframes) - 1):
		liquidSprite.frame += 1
	else:
		liquidSprite.frame = 0

func _liquid_reset() -> void:
	delayAccumulation = 0.0
	assignedSprite = false
