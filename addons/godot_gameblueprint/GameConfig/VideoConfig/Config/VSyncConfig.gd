extends AbstractConfig
class_name VSyncConfig

func is_valid(new_value: Variant) -> bool:
	return new_value is int and new_value >= DisplayServer.VSYNC_DISABLED and new_value <= DisplayServer.VSYNC_MAILBOX
	
func _default_value() -> Variant:
	return ProjectSettings.get_setting("display/window/vsync/vsync_mode", DisplayServer.VSYNC_ENABLED)
	
func apply() -> bool:
	DisplayServer.window_set_vsync_mode(value)
	
	return DisplayServer.window_get_vsync_mode() == value
