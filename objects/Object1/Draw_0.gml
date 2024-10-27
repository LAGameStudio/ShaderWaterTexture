
if ( !surface_exists(surf_world) ) {
surf_world = surface_create(room_width,room_height);
}


if ( !surface_exists(surf_water_mask) ) {
surf_water_mask = surface_create(room_width,room_height);
}

if ( !surface_exists(surf_with_water) ) {
surf_with_water = surface_create(room_width,room_height);
}

 // pass 1: draw your world (in this example its just two sprite blits)
surface_set_target(surf_world);
draw_rectangle_color(0,0,room_width,room_height,c_orange,c_orange,c_blue,c_blue,false); // clear your world (world background color)
draw_sprite_ext(sprite_index, image_index, x, y, 4, 4, 0, c_white, 1);
draw_sprite_ext(sprite_index, image_index, x+room_width/2, y, 4, 4, 0, c_white, 1);
surface_reset_target();

// pass 2: add your water by drawing white in regions over black indicating where the effect should take place
surface_set_target(surf_water_mask)
draw_rectangle_color(0,0,room_width,room_height,c_black,c_black,c_black,c_black,false); // black = no water
// left half only, but this would really be the rectangle of the tiles that are water, just for demo
draw_rectangle_color(0,0,room_width/2,room_height,c_white,c_white,c_white,c_white,false); // white = distort me
surface_reset_target();

// pass 3: add your water by using surf_water_mask to guide the distortion shader over source surf_world
surface_set_target(surf_with_water);
shader_set(shd_water);
shader_set_uniform_f(time_uniform, current_time / 1000);
texture_set_stage(mask_uniform, surface_get_texture(surf_water_mask));
draw_surface_ext(surf_world,0,0,1,1, 0, c_white, 1);
shader_reset();
surface_reset_target();

// pass 4: draw the result to the application surface
draw_surface_ext(surf_with_water,0,0,1,1,0,c_white,1);