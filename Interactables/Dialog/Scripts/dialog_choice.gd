@tool
@icon("res://GUI/DialogSystem/Icons/question_bubble.svg")
extends DialogItem
class_name DialogChoice

@export var choices: Array[String] = ["Yes", "No"]
