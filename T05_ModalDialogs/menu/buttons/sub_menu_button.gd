class_name SubMenuButton extends Button

const dialog_scene = preload("res://dialog/dialog.tscn")
const menu_scene = preload("res://menu/menu.tscn")

var build_menu: Callable


func setup(build_menu_command: Callable) -> void:
    pressed.connect(_on_pressed)
    build_menu = build_menu_command


func close_dialog(dialog: Dialog) -> void:
    dialog.close()

    var parent_menu := get_parent() as Menu
    if parent_menu:
        parent_menu.enable_mouse_input()
        parent_menu.close.emit()


func _on_pressed() -> void:
    var parent_menu := get_parent() as Menu
    var parent_dialog := parent_menu.get_parent() as Dialog

    var pos := Vector2(30, 0)

    if parent_dialog:
        pos += parent_dialog.global_position + Vector2(parent_dialog.size.x, 0)
    else:
        pos += parent_menu.global_position + Vector2(parent_menu.size.x, 0)

    # create dialog
    var dialog := dialog_scene.instantiate() as Dialog
    dialog.global_position = pos
    get_viewport().add_child(dialog)

    # create menu
    var menu := menu_scene.instantiate() as Menu
    build_menu.call(menu)
    dialog.add_content(menu)

    parent_menu.disable_mouse_input()
    menu.close.connect(func() -> void: close_dialog(dialog))
