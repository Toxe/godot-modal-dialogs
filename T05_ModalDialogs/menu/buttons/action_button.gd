class_name ActionButton extends Button


func setup(menu: Menu, action: Callable) -> void:
    pressed.connect(func() -> void: _on_pressed(menu, action))


func _on_pressed(menu: Menu, action: Callable) -> void:
    action.call()
    menu.action_performed.emit()
