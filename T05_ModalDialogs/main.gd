extends Node2D

const notification_scene = preload("res://notification.tscn")

@onready var main_action_menu := $HSplitContainer/MainActionMenu as Menu

var characters: Array[String] = ["Fighter", "Mage", "Cleric"]


func _ready() -> void:
    main_action_menu.add_menu("Attack", build_attack_menu)
    main_action_menu.add_menu("Magic", build_magic_menu)
    main_action_menu.add_menu("Item", build_item_menu)
    main_action_menu.add_action("Guard", func() -> void: show_notification("Defending!"))
    main_action_menu.add_action("Flee", flee)
    main_action_menu.set_focus_to_first_button()


func build_attack_menu(menu: Menu) -> void:
    for i in 3:
        var enemy_name := "Enemy " + char(65 + i)
        menu.add_action(enemy_name, func() -> void: show_notification("%s is hit for %d damage!" % [enemy_name, randi_range(10, 20)]))


func build_magic_menu(menu: Menu) -> void:
    menu.add_menu("Fire", build_magic_fire_menu)
    menu.add_menu("Cure", build_magic_cure_menu)


func build_magic_fire_menu(menu: Menu) -> void:
    for i in 3:
        var enemy_name := "Enemy " + char(65 + i)
        menu.add_action(enemy_name, func() -> void: show_notification("%s is hit for %d fire damage!" % [enemy_name, randi_range(20, 30)]))


func build_magic_cure_menu(menu: Menu) -> void:
    menu.add_action("All", func() -> void: show_notification("The party is healed for %d points." % randi_range(200, 300)))
    menu.add_menu("Pick Character", build_magic_cure_pick_character_menu)


func build_magic_cure_pick_character_menu(menu: Menu) -> void:
    for character_name in characters:
        menu.add_action(character_name, func() -> void: show_notification("%s is healed for %d points." % [character_name, randi_range(200, 300)]))


func build_item_menu(menu: Menu) -> void:
    menu.add_action("Potion", func() -> void: show_notification("Using Potion."))
    menu.add_action("Ether", func() -> void: show_notification("Using Ether."))
    menu.add_menu("Phoenix Down", build_item_phoenix_down_menu)


func build_item_phoenix_down_menu(menu: Menu) -> void:
    for character_name in characters:
        menu.add_action(character_name, func() -> void: show_notification("Using Phoenix Down on %s." % character_name))


func show_notification(text: String) -> void:
    var popup := notification_scene.instantiate()
    popup.set_text(text)
    add_child(popup)


func flee() -> void:
    show_notification("Your party escapes!")
    await get_tree().create_timer(1.5).timeout
    get_tree().quit()
