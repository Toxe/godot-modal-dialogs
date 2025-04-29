class_name Notification extends CanvasLayer


func _ready() -> void:
    await get_tree().create_timer(1.5).timeout

    var tween := create_tween()
    tween.tween_property($PanelContainer, "modulate", Color.TRANSPARENT, 0.5)
    tween.tween_callback(queue_free)


func set_text(text: String) -> void:
    (%Label as Label).text = text
