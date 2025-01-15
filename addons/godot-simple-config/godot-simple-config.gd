@tool
extends EditorPlugin

const GAME_CONFIG_SINGLETON_NAME : String = "GameConfig"
const GAME_CONFIG_SCENE_PATH : String = "res://addons/godot-simple-config/GameConfig/GameConfig.tscn"

func _enter_tree() -> void:
	_add_singletons()

func _exit_tree() -> void:
	_remove_singletons()

func _add_singletons() -> void:
	add_autoload_singleton(GAME_CONFIG_SINGLETON_NAME, GAME_CONFIG_SCENE_PATH)
	
func _remove_singletons() -> void:
	remove_autoload_singleton(GAME_CONFIG_SINGLETON_NAME)
