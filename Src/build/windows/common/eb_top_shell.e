class EB_TOP_SHELL

inherit
	
	TOP_SHELL
		rename
			set_x_y as old_set_x_y,
			init_toolkit as top_shell_toolkit,
            make as top_shell_make,
			realize as tp_realize
	
		end
	TOP_SHELL
		rename
			init_toolkit as top_shell_toolkit						
		redefine
			set_x_y,
			realize,
			make
		select
			set_x_y,
			realize,
			make
		end;
	CONSTANTS
	TOOLTIP_INITIALIZER

	UNDO_REDO_ACCELERATOR

creation

	make

feature -- Initialization
	make (a_name: STRING; a_screen: SCREEN) is
			-- Create a eb_top_shell with `a_name' as identifier,
            -- only if `a_name' not void otherwise identifier
            -- will be defined as application name and call
            -- `set_default'. 
			-- Calls top_shell_make and tooltip_initialize 
		do
			top_shell_make ("2", a_screen)
			tooltip_initialize (Current)
			set_default_color
			add_undo_redo_accelerator (Current)
		end

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
--			set_colors: SET_WINDOW_ATTRIBUTES_COM
		do
--			!! set_colors;
--			set_colors.execute (Current)
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

feature -- Display

	realize is
		do
			if not realized then
				tp_realize
				tooltip_realize
			end
		end

end
