class_name Menu extends PanelContainer

signal action_performed
signal sub_menu_dialog_opened(menu_dialog: MenuDialog)


func _ready() -> void:
    set_focus_to_first_button()


func add_action(text: String, action: Callable) -> void:
    var button := add_button(ActionButton.new(), text) as ActionButton
    button.setup(self, action)


func add_menu(text: String, build_sub_menu: Callable) -> void:
    var button := add_button(SubMenuButton.new(), text) as SubMenuButton
    button.setup(self, build_sub_menu)


func add_button(button: Button, text: String) -> Button:
    button.text = text
    button.alignment = HORIZONTAL_ALIGNMENT_LEFT
    %VBoxContainer.add_child(button)

    var button_count := get_buttons().size()
    if button_count < 10:
        var event := InputEventAction.new()
        event.action = "button%d" % button_count
        button.shortcut = Shortcut.new()
        button.shortcut.events.append(event)
        button.text = "%d: %s" % [button_count, button.text]

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


func set_focus_to_first_button() -> void:
    if not get_buttons().is_empty():
        var button := get_buttons().front() as Button
        if button:
            button.grab_focus()
