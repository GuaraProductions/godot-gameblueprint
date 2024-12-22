extends AbstractConfig
class_name VSyncConfig

func is_valid(value: Variant) -> bool:
	return value is int and value >= DisplayServer.VSYNC_DISABLED and value <= DisplayServer.VSYNC_DISABLED
	
func _default_value() -> Variant:
	return ProjectSettings.get_setting("display/window/vsync/vsync_mode", DisplayServer.VSYNC_ENABLED)
	
func apply() -> bool:
	DisplayServer.window_set_vsync_mode(value)
	
	return DisplayServer.window_get_vsync_mode() == value
