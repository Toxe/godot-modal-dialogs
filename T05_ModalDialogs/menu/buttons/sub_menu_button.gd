class_name SubMenuButton extends Button

const dialog_scene = preload("res://dialog/dialog.tscn")
const menu_scene = preload("res://menu/menu.tscn")

var build_menu: Callable


func setup(build_menu_command: Callable) -> void:
    pressed.connect(_on_pressed)
    build_menu = build_menu_command


func close_dialog(dialog: Dialog) -> void:
    dialog.close()

    var parent_menu := get_menu()
    if parent_menu:
        parent_menu.enable_mouse_input()
        parent_menu.close.emit()


func get_menu() -> Menu:
    return get_parent().get_parent().get_parent().get_parent() as Menu


func _on_pressed() -> void:
    # create menu
    var menu := menu_scene.instantiate() as Menu
    build_menu.call(menu)

    # create dialog
    var pos := global_position + Vector2(size.x + 20, -30)
    var dialog := dialog_scene.instantiate() as Dialog
    dialog.global_position = pos

    dialog.add_content(menu)
    get_viewport().add_child(dialog)

    # move dialog up if it clips out of the viewport
    var viewport_height: float = ProjectSettings.get("display/window/size/viewport_height")
    var dialog_y_pos := (dialog.global_position + dialog.size).y

    if dialog_y_pos > viewport_height:
        dialog.global_position.y -= dialog_y_pos - viewport_height

    get_menu().disable_mouse_input()
    menu.close.connect(func() -> void: close_dialog(dialog))
