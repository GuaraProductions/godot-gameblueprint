@tool
extends TabContainer

## Todas as abas que tera no menu de opcoes e seus respectivos nomes
@export var tabs : Array[String] = [] : set = _set_tabs
@export_category("Tab Margin")
## Margem esquerda das abas (Atencao, ao atualizar as margens, os nodes irao sumir da arvore, tenha certeza de alterar esse valor somente na configuracao inicial)
@export var margin_left : int = 0 : set = _set_margin_left
## Margem direita das abas (Atencao, ao atualizar as margens, os nodes irao sumir da arvore, tenha certeza de alterar esse valor somente na configuracao inicial)
@export var margin_right: int = 0 : set = _set_margin_right
## Margem do topo das abas (Atencao, ao atualizar as margens, os nodes irao sumir da arvore, tenha certeza de alterar esse valor somente na configuracao inicial)
@export var margin_top : int = 0 : set = _set_margin_top
## Margem inferior das abas (Atencao, ao atualizar as margens, os nodes irao sumir da arvore, tenha certeza de alterar esse valor somente na configuracao inicial)
@export var margin_bottom : int = 0 : set = _set_margin_bottom

func _set_margin_left(new_margin: int) -> void:
	margin_left = new_margin
	_update_tabs()

func _set_margin_right(new_margin: int) -> void:
	margin_right = new_margin
	_update_tabs()

func _set_margin_top(new_margin: int) -> void:
	margin_top = new_margin
	_update_tabs()

func _set_margin_bottom(new_margin: int) -> void:
	margin_bottom = new_margin
	_update_tabs()

func _set_tabs(new_tabs: Array[String]) -> void:
	tabs = new_tabs
	_update_tabs()

func _update_tabs() -> void:
	if not is_inside_tree():
		return

	var current_size = get_children().size()
	
	if current_size > tabs.size():
		_remove_tabs_no_longer_present()
	else:
		_add_new_tabs()

func _remove_tabs_no_longer_present() -> void:
	var current_children = get_children()
	for child in current_children:
		if child.name not in tabs:
			remove_child(child)
			child.queue_free()

func _add_new_tabs() -> void:
	var current_children = get_children()
	var current_size = current_children.size()

	var current_tab_names = current_children.map(func(c): return c.name)
	for idx in range(tabs.size()):
		var tab_name = tabs[idx]
		if tab_name.is_empty():
			tab_name = "Nova Aba %d" % [idx]
			tabs[idx] = tab_name
				
		if idx >= current_size:
			# Create a new tab if it doesn't exist
			var margin_container : MarginContainer = MarginContainer.new()
			margin_container.name = tab_name
			add_child(margin_container)
			margin_container.owner = get_tree().edited_scene_root
			current_tab_names.append(tab_name)  # Update the current tab list

		# Update margins
		var margin_container = get_child(idx)
		margin_container.name = tab_name
		if margin_container:
			margin_container.add_theme_constant_override("margin_top", margin_top)
			margin_container.add_theme_constant_override("margin_bottom", margin_bottom)
			margin_container.add_theme_constant_override("margin_left", margin_left)
			margin_container.add_theme_constant_override("margin_right", margin_right)
