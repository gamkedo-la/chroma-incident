class_name TrackingHandler
extends Node2D

func track_mouse(character_body: CharacterBody2D) -> void:
	character_body.look_at(get_global_mouse_position())
