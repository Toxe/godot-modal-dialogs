class_name Dialog extends MarginContainer


func add_content(control: Control) -> void:
    add_child(control)


func close() -> void:
    queue_free()
