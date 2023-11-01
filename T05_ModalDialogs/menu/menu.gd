class_name Menu extends PanelContainer

signal close


func add_action(text: String, action: Callable) -> void:
    var button := add_button(ActionButton.new(), text) as ActionButton
    button.setup(action)
    button.pressed.connect(func() -> void: close.emit())


func add_menu(text: String, build_sub_menu: Callable) -> void:
    var button := add_button(SubMenuButton.new(), text) as SubMenuButton
    button.setup(build_sub_menu)


func add_button(button: Button, text: String) -> Button:
    button.text = text
    button.alignment = HORIZONTAL_ALIGNMENT_LEFT
    %VBoxContainer.add_child(button)
    return button


func get_buttons() -> Array[Button]:
    var buttons: Array[Button] = []
    for child in %VBoxContainer.get_children():
        var button := child as Button
        if button:
            buttons.append(button)
    return buttons


func disable_mouse_input() -> void:
    for button in get_buttons():
        button.mouse_filter = Control.MOUSE_FILTER_IGNORE


func enable_mouse_input() -> void:
    for button in get_buttons():
        button.mouse_filter = Control.MOUSE_FILTER_STOP
