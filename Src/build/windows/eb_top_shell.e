class EB_TOP_SHELL

inherit
	
	TOP_SHELL
		rename
			set_x_y as old_set_x_y
		end
	TOP_SHELL
		redefine
			set_x_y
		select
			set_x_y
		end;
	CONSTANTS

creation

	make

feature

	initialize_window_attributes is
			-- Initialize the geometry
			-- and color of current window.
		do
debug ("RESOURCES")
	io.error.putstring ("Initializing window: ");
	io.error.putstring (identifier);
	io.error.putstring (" ...");
end;
			set_geometry;
			set_default_color;
debug ("RESOURCES")
	io.error.putstring ("finished%N");
end;
		end;

	set_geometry is
		do
		end;

	set_default_color is
		local
			set_colors: SET_WINDOW_ATTRIBUTES_COM
		do
			!! set_colors;
			set_colors.execute (Current)
		end;

	set_x_y (x0, y0: INTEGER) is
			-- Check to see if the x and y position are correct and
			-- set x and y.
		local
			new_x, new_y: INTEGER
		do
			new_x := x0;
			new_y := y0;
			if new_x + width > screen.width then
				new_x := screen.width - width
			elseif new_x < 0 then
				new_x := 0
			end;
			if new_y + height > screen.height then
				new_y := screen.height - height
			elseif new_y < 0 then
				new_y := 0
			end;
			old_set_x_y (new_x, new_y);
		end;

end
