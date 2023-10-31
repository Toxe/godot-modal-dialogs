class_name ActionButton extends Button


func setup(action: Callable) -> void:
    pressed.connect(action)
