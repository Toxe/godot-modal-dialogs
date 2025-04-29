class_name Enemy extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
    animation_player.play("idle")
