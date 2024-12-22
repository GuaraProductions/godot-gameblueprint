extends AbstractConfig
class_name WindowModeConfig

func is_valid(value: Variant) -> bool:
	return value is int and value >= DisplayServer.WINDOW_MODE_WINDOWED and value <= DisplayServer.VSYNC_MAILBOX

func _default_value() -> Variant:
	return DisplayServer.WINDOW_MODE_WINDOWED

func apply() -> bool:
	DisplayServer.window_set_mode(value)

	return DisplayServer.window_get_mode() == value
