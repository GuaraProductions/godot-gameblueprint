extends AbstractConfig
class_name WindowModeConfig

func is_valid(new_value: Variant) -> bool:
	return new_value is int and new_value >= DisplayServer.WINDOW_MODE_WINDOWED and value <= DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN

func _default_value() -> Variant:
	return DisplayServer.WINDOW_MODE_WINDOWED

func apply() -> bool:
	DisplayServer.window_set_mode(value)

	return DisplayServer.window_get_mode() == value
