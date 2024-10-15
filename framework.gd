tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("AudioManager", "res://addons/framework/AudioManager.tscn")
	add_autoload_singleton("ParticleManager", "res://addons/framework/ParticleManager.tscn")
	add_autoload_singleton("SceneManager", "res://addons/framework/SceneManager.tscn")
	add_autoload_singleton("Global", "res://addons/framework/Globals.tscn")
	
func _exit_tree():
	remove_autoload_singleton("AudioManager")
	remove_autoload_singleton("ParticleManager")
	remove_autoload_singleton("SceneManager")
	remove_autoload_singleton("Global")
