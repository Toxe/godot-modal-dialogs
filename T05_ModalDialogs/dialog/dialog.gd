class_name Dialog extends PanelContainer


func add_content(control: Control) -> void:
    $MarginContainer.add_child(control)


func close() -> void:
    queue_free()
