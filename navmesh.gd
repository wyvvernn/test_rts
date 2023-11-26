extends Node3D


const Character = preload("res://character.gd")

@onready var _camera := $CameraBase/Camera3D as Camera3D
@onready var unit1 := $RobotBase as Character
@onready var unit2 := $RobotBase2 as Character
@onready var _selected_units = [unit1] #  : Character = null

var _cam_rotation := 0.0
var _last_pressed_pos 

func swap_unit():
    if _selected_units.has(unit1):
        _selected_units = [unit2]
    else:
        _selected_units = [unit1]
func select_both():
    _selected_units = [unit1, unit2]

func _unhandled_input(event: InputEvent):
    var mouse_cursor_position
    if event is InputEventMouse:
        mouse_cursor_position = event.position
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT :
      if event.is_pressed():
        _last_pressed_pos=event.position
      elif event.is_released() and len(_selected_units):
        #Check if it should draw select units or move them
        var drag_distance = mouse_cursor_position.distance_to(_last_pressed_pos)
        if drag_distance < 10:
            var camera_ray_length := 1000.0
            var camera_ray_start := _camera.project_ray_origin(mouse_cursor_position)
            var camera_ray_end := camera_ray_start + _camera.project_ray_normal(mouse_cursor_position) * camera_ray_length
            # Get closest point on navmesh for the current mouse cursor position.
            var closest_point_on_navmesh := NavigationServer3D.map_get_closest_point_to_segment(
                get_world_3d().navigation_map,
                    camera_ray_start,
            camera_ray_end
            )
            # print(len(_selected_units))
            for unit in _selected_units:
              unit.set_target_position(closest_point_on_navmesh)
        #Clear box
        %HUD.drawbox(_last_pressed_pos,_last_pressed_pos)
      else:
        %HUD.drawbox(_last_pressed_pos,_last_pressed_pos)

    elif event is InputEventMouseMotion:
        #Camera rotation
        if event.button_mask & (MOUSE_BUTTON_MASK_MIDDLE + MOUSE_BUTTON_MASK_RIGHT):
            _cam_rotation += event.relative.x * 0.005
            $CameraBase.set_rotation(Vector3.UP * _cam_rotation)
        #Draw box continously 
        if event.button_mask & MOUSE_BUTTON_LEFT:
            %HUD.drawbox(_last_pressed_pos,mouse_cursor_position)
