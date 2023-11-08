class_name MenuDialog extends MarginContainer

signal menu_dialog_closed(close_all_dialogs: bool)


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        get_viewport().set_input_as_handled()
        close_dialog(false)  # pressed escape --> only close the top menu dialog


func get_menu() -> Menu:
    return $Menu


func close_dialog(close_all_dialogs: bool) -> void:
    queue_free()
    menu_dialog_closed.emit(close_all_dialogs)


func _on_menu_action_performed() -> void:
    close_dialog(true)  # clicked on menu action button --> close all menu dialogs


func _on_menu_sub_menu_dialog_opened(menu_dialog: MenuDialog) -> void:
    menu_dialog.menu_dialog_closed.connect(_on_menu_dialog_closed)


func _on_menu_dialog_closed(close_all_dialogs: bool) -> void:
    if close_all_dialogs:
        close_dialog(true)
