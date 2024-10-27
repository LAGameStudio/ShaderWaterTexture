time_uniform = shader_get_uniform(shd_water, "time");
mask_uniform = shader_get_sampler_index(shd_water, "mask");

application_surface_draw_enable(true);

surf_world = surface_create(room_width,room_height);
surf_water_mask = surface_create(room_width,room_height);
surf_with_water = surface_create(room_width,room_height);
