extends PanelContainer

@onready var animated_sprite_2d: AnimatedSprite2D = $Emote/AnimatedSprite2D
@onready var emote_idle_timer: Timer = $EmoteIdleTimer

var idle_emotes: Array = ["emote_01_idle", "emote_02_smile", "emote_03_ear_flap", "emote_04_blink"]

func _ready() -> void:
	animated_sprite_2d.play("emote_01_idle")

func play_emote(animation:String) -> void:
	animated_sprite_2d.play(animation)


func _on_emote_idle_timer_timeout() -> void:
	play_emote(idle_emotes[randi_range(0, 3)])
