class_name Menu extends VBoxContainer

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
    add_child(button)
    return button


func get_controls() -> Array[Control]:
    var controls: Array[Control] = []
    for child in get_children():
        var ctrl := child as Control
        if ctrl:
            controls.append(ctrl)
    return controls


func disable_mouse_input() -> void:
    for control in get_controls():
        control.mouse_filter = Control.MOUSE_FILTER_IGNORE


func enable_mouse_input() -> void:
    for control in get_controls():
        control.mouse_filter = Control.MOUSE_FILTER_STOP
