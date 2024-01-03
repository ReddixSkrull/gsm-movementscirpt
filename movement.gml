// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//velocity_x_axis = 0; // horizontal velocity
//velocity_y_axis = 0; // vertical velocity
//_maximal_velocity = 6; // maximal velocity
//_acceleration = 0.2; // _acceleration
//_normal_deacceleration = 0.2; // normal deacceleration 
//_skid_deacceleration = 0.0; // skid deacceleration -> ist quasi die trägheit des characters

/// @function 
/// @param {real} _velocity_x_axis
/// @param {real} _velocity_y_axis
/// @param {number} _maximal_velocity
/// @param {real} _acceleration
/// @param {real} _normal_deacceleration
/// @param {real} _skid_deacceleration
/// @description Funktion die die horizontale und vertikale bewegung des spielers steuert
function movement(_velocity_x_axis, _velocity_y_axis, _maximal_velocity, _acceleration, _normal_deacceleration, _skid_deacceleration){
	var _horizontal_axis = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	var _vertical_axis = keyboard_check(ord("S")) - keyboard_check(ord("W"));



	var _speed = sqrt(_velocity_x_axis * _velocity_x_axis + _velocity_y_axis * _velocity_y_axis);
	
	
	
	if _horizontal_axis == 0 && _vertical_axis == 0 {
	    // deaccelerate when not moving
	    if _speed <= _normal_deacceleration {
	        _velocity_x_axis = 0;
	        _velocity_y_axis = 0;
	    } else {
	        _velocity_x_axis -= _velocity_x_axis / _speed * _normal_deacceleration;
	        _velocity_y_axis -= _velocity_y_axis / _speed * _normal_deacceleration;
	    }
	} else {
	    if _velocity_x_axis * _horizontal_axis + _velocity_y_axis * _vertical_axis < 0 {
	        // skid
	        if _speed <= _skid_deacceleration {
	            _velocity_x_axis = 0;
	            _velocity_y_axis = 0;
	        } else {
	            _velocity_x_axis -= _velocity_x_axis / _speed * _skid_deacceleration;
	            _velocity_y_axis -= _velocity_y_axis / _speed * _skid_deacceleration;
	        }
	    } else {
	        // accelerate
	        _velocity_x_axis += _horizontal_axis * _acceleration;
	        _velocity_y_axis += _vertical_axis * _acceleration;
	        _speed = sqrt(_velocity_x_axis * _velocity_x_axis + _velocity_y_axis * _velocity_y_axis);
	        if _speed > _maximal_velocity {
	            _velocity_x_axis = _velocity_x_axis / _speed * _maximal_velocity;
	            _velocity_y_axis = _velocity_y_axis / _speed * _maximal_velocity;
	        }
	    }
	}


	// es muss ein obj_root existieren das heir eingetragen werden muss damit die basic collision funktioniert
	if (place_meeting(x + _velocity_x_axis * 20, y + _velocity_y_axis * 20, obj_root_16x16)) {
	    _velocity_x_axis = 0;
	    _velocity_y_axis = 0;
	}

	// Change the below to have some collision in it
	x += _velocity_x_axis * 20;
	y += _velocity_y_axis * 20;


}
