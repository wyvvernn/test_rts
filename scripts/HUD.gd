extends Node2D

var rect: Rect2
# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func drawbox(startvec,endvec):
    var upperleft = Vector2(min(startvec.x, endvec.x), min(startvec.y, endvec.y))
    var size = Vector2(abs(startvec.x-endvec.x), abs(startvec.y-endvec.y))
    rect = Rect2(upperleft,size)
    queue_redraw()

func _draw():
    draw_rect(self.rect, Color(1,0,0), false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

    pass
