@tool
extends TabContainer

## Todas as abas que tera no menu de opcoes e seus respectivos nomes
@export var tabs : Array[String] : set = _set_tabs
@export_category("Tab Margin")
## Margem esquerda das abas (Atencao, ao atualizar as margens, os nodes irao sumir da arvore, tenha certeza de alterar esse valor somente na configuracao inicial)
@export var margin_left : int : set = _set_margin_left
## Margem direita das abas (Atencao, ao atualizar as margens, os nodes irao sumir da arvore, tenha certeza de alterar esse valor somente na configuracao inicial)
@export var margin_right: int : set = _set_margin_right
## Margem do topo das abas (Atencao, ao atualizar as margens, os nodes irao sumir da arvore, tenha certeza de alterar esse valor somente na configuracao inicial)
@export var margin_top : int : set = _set_margin_top
## Margem inferior das abas (Atencao, ao atualizar as margens, os nodes irao sumir da arvore, tenha certeza de alterar esse valor somente na configuracao inicial)
@export var margin_bottom : int : set = _set_margin_bottom

func _ready() -> void:
	if tabs.is_empty():
		_remove_children()

func _set_margin_left(new_margin: int) -> void:
	margin_left = new_margin
	_set_tabs(tabs)
	
func _set_margin_right(new_margin: int) -> void:
	margin_right = new_margin
	_set_tabs(tabs)

func _set_margin_top(new_margin: int) -> void:
	margin_top = new_margin
	_set_tabs(tabs)

func _set_margin_bottom(new_margin: int) -> void:
	margin_bottom = new_margin
	_set_tabs(tabs)


func _set_tabs(new_tabs: Array[String]) -> void:
	
	if not get_tree():
		return
	
	_remove_children() 
	
	tabs = new_tabs
	
	var idx : int = 0
	for tab in tabs:
		var margin_container : MarginContainer = MarginContainer.new()
		if tab.is_empty():
			tab = "Nova Aba %d" % [idx]
			tabs[idx] = tab
			
		idx += 1 

		margin_container.name = tab
		
		add_child(margin_container)
		
		margin_container.add_theme_constant_override("margin_top", margin_top)
		margin_container.add_theme_constant_override("margin_bottom", margin_bottom)
		margin_container.add_theme_constant_override("margin_left", margin_left)
		margin_container.add_theme_constant_override("margin_right", margin_right)
		
		margin_container.owner = get_tree().edited_scene_root

func _remove_children() -> void:
	
	for child in get_children():
		remove_child(child)
		child.queue_free()
