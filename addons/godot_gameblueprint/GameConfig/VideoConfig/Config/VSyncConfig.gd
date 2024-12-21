extends AbstractVideoConfig
class_name VSyncConfig

func is_valid(value: Variant) -> bool:
	return value is bool
	
func _default_value() -> Variant:
	return ProjectSettings.get_setting("display/window/vsync/vsync_mode", DisplayServer.VSYNC_ENABLED) == DisplayServer.VSYNC_ENABLED
	
func apply() -> bool:
	var vsync_value : int = DisplayServer.VSYNC_ENABLED if value else DisplayServer.VSYNC_DISABLED
	DisplayServer.window_set_vsync_mode(vsync_value)
	
	return DisplayServer.window_get_vsync_mode() == vsync_value
