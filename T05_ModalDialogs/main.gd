extends Node2D

const notification_scene = preload("res://notification.tscn")

@onready var main_action_menu := $HSplitContainer/MainActionMenu as Menu


func _ready() -> void:
    main_action_menu.add_menu("Attack", build_attack_menu)
    main_action_menu.add_menu("Magic", build_magic_menu)
    main_action_menu.add_menu("Item", build_item_menu)
    main_action_menu.add_action("Guard", func() -> void: show_notification("guard"))
    main_action_menu.add_action("Flee", func() -> void: show_notification("flee"))
    main_action_menu.set_focus_to_first_button()


func build_attack_menu(menu: Menu) -> void:
    menu.add_action("Enemy A", func() -> void: show_notification("attack enemy 1"))
    menu.add_action("Enemy B", func() -> void: show_notification("attack enemy 2"))
    menu.add_action("Enemy C", func() -> void: show_notification("attack enemy 3"))


func build_magic_menu(menu: Menu) -> void:
    menu.add_menu("Fire", build_magic_fire_menu)
    menu.add_menu("Cure", build_magic_cure_menu)


func build_magic_fire_menu(menu: Menu) -> void:
    menu.add_action("Enemy A", func() -> void: show_notification("fire enemy 1"))
    menu.add_action("Enemy B", func() -> void: show_notification("fire enemy 2"))
    menu.add_action("Enemy C", func() -> void: show_notification("fire enemy 3"))


func build_magic_cure_menu(menu: Menu) -> void:
    menu.add_action("All", func() -> void: show_notification("cure all"))
    menu.add_menu("Pick Character", build_magic_cure_pick_character_menu)


func build_magic_cure_pick_character_menu(menu: Menu) -> void:
    menu.add_action("Friend 1", func() -> void: show_notification("cure friend 1"))
    menu.add_action("Friend 2", func() -> void: show_notification("cure friend 2"))
    menu.add_action("Friend 3", func() -> void: show_notification("cure friend 3"))
    menu.add_action("Friend 4", func() -> void: show_notification("cure friend 4"))


func build_item_menu(menu: Menu) -> void:
    menu.add_action("Potion", func() -> void: show_notification("use potion"))
    menu.add_action("Ether", func() -> void: show_notification("use ether"))
    menu.add_menu("Phoenix Down", build_item_phoenix_down_menu)


func build_item_phoenix_down_menu(menu: Menu) -> void:
    menu.add_action("Friend 1", func() -> void: show_notification("phoenix down friend 1"))
    menu.add_action("Friend 2", func() -> void: show_notification("phoenix down friend 2"))
    menu.add_action("Friend 3", func() -> void: show_notification("phoenix down friend 3"))
    menu.add_action("Friend 4", func() -> void: show_notification("phoenix down friend 4"))


func show_notification(text: String) -> void:
    var popup := notification_scene.instantiate()
    popup.set_text(text)
    add_child(popup)
