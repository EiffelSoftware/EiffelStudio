class EB_TOP_SHELL

inherit
	
	TOP_SHELL;
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

end
