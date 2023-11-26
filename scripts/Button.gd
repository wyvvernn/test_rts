extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
    self.pressed.connect(self._button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func _button_pressed():
    print("hi bro")
    if self.name == 'Button2':
        self.owner.select_both()
    else:
        self.owner.swap_unit()
