class_name SubMenuButton extends Button

const menu_dialog_scene = preload("res://menu_dialog/menu_dialog.tscn")


func setup(menu: Menu, build_sub_menu: Callable) -> void:
    pressed.connect(func() -> void: _on_pressed(menu, build_sub_menu))


func _on_pressed(menu: Menu, build_sub_menu: Callable) -> void:
    # create sub-menu dialog
    var menu_dialog := menu_dialog_scene.instantiate() as MenuDialog
    menu_dialog.global_position = global_position + Vector2(size.x + 20, -30)
    build_sub_menu.call(menu_dialog.get_menu())

    get_viewport().add_child(menu_dialog)

    # move dialog up if it clips out of the viewport
    var viewport_height: float = ProjectSettings.get("display/window/size/viewport_height")
    var dialog_y_pos := (menu_dialog.global_position + menu_dialog.size).y

    if dialog_y_pos > viewport_height:
        menu_dialog.global_position.y -= dialog_y_pos - viewport_height

    theme_type_variation = "SelectedMenuButton"
    menu.disable_mouse_input()

    menu_dialog.menu_dialog_closed.connect(func(_close_all_dialogs: bool) -> void:
        theme_type_variation = ""
        menu.enable_mouse_input()
        grab_focus())

    menu.sub_menu_dialog_opened.emit(menu_dialog)
