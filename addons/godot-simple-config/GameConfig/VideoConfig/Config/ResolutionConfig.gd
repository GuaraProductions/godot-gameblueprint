extends AbstractConfig
class_name ResolutionConfig

## Se essa opcao for verdadeira, apos fazer o ajuste de resolucao, o jogo ira centralizar a janela, na tela onde a janela esta
@export var centralize_window : bool = true

func _init(p_id: String = "",
		   p_name: String = "", 
		   p_description : String = "",
		   p_centralize_window: bool = true) -> void:
	
	super(p_id, p_name, p_description)
	centralize_window = p_centralize_window

func is_valid(value: Variant) -> bool:
	return value is Vector2i and value.x > 0 and value.y > 0

func _default_value() -> Variant:
	
	var resolution : Vector2i = Vector2i.ZERO
	
	resolution.x = ProjectSettings.get_setting("display/window/size/viewport_width", 1920)
	resolution.y = ProjectSettings.get_setting("display/window/size/viewport_height", 1080)
	
	return resolution

func apply() -> bool:
	if not is_valid(value):
		return false
	
	DisplayServer.window_set_size(value)
	
	var current_size: Vector2i = DisplayServer.window_get_size()
	var resolution_changed: bool = current_size == value
	
	if resolution_changed and centralize_window:
		var screen_size: Vector2i = DisplayServer.screen_get_size()
		var centered: Vector2i = Vector2i(screen_size.x / 2 - current_size.x / 2, screen_size.y / 2 - current_size.y / 2)
		DisplayServer.window_set_position(centered)
	
	return resolution_changed
