indexing

	description: 
		"Representation of an X Pixel.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PIXEL

inherit

	MEL_RESOURCE
		rename
			handle as identifier,
			make_from_existing as old_make_from_existing
		export
			{NONE} old_make_from_existing
		redefine
			is_valid
		end

creation
	make_by_name, 
	make_by_rgb_value, 
	make_from_existing

feature {NONE} -- Initilization

	make_by_name (a_display: MEL_DISPLAY; a_colormap: MEL_COLORMAP;
			a_color_name: STRING) is
			-- Make a pixel from the name of a color.
		require
			valid_display: a_display /= Void and then a_display.is_valid
			valid_colormap: a_colormap /= Void and then a_colormap.is_valid
			color_name_not_void: a_color_name /= Void;
		local
			temp: ANY
		do
			temp := a_color_name.to_c;
			display_handle := a_display.handle;
			colormap_identifier := a_colormap.identifier;
			identifier := get_color_by_name ($temp, 
				display_handle, colormap_identifier);
			status := last_color_alloc_status;
			is_shared := True
		ensure
			has_valid_display: has_valid_display;
			has_valid_colormap: has_valid_colormap;
			is_shared: is_shared
		end;

	make_by_rgb_value (a_display: MEL_DISPLAY; a_colormap: MEL_COLORMAP;
				red_value, green_value, blue_value: INTEGER) is
			-- Make a pixel from a rgb value.
			-- Caution, red, green and blue are 16 bits int values.
		require
			valid_display: a_display /= Void and then a_display.is_valid;
			valid_colormap: a_colormap /= Void and then a_colormap.is_valid
			red_value_large_enough: red_value >= 0;
			red_value_small_enough: red_value <= 65535;
			green_value_large_enough: green_value >= 0;
			green_value_small_enough: green_value <= 65535;
			blue_value_large_enough: blue_value >= 0;
			blue_value_small_enough: blue_value <= 65535;
		do
			colormap_identifier := a_colormap.identifier;
			display_handle := a_display.handle;
			identifier := get_color_by_rgb_value 
				(red_value, green_value, blue_value, 
					display_handle, colormap_identifier);
			status := last_color_alloc_status;
			is_shared := True
		ensure
			has_valid_display: has_valid_display;
			has_valid_colormap: has_valid_colormap;
			is_shared: is_shared
		end;

	make_from_existing (a_display: MEL_DISPLAY; an_id: like identifier) is
			-- Make a pixel from an already existing value.
		require
			valid_display: a_display /= Void and then a_display.is_valid
		do
			identifier := an_id;
			display_handle := a_display.handle;
			status := 0;
			is_shared := True
		ensure then
			is_valid: is_valid;
			is_shared: is_shared
		end;

feature -- Access

	colormap_identifier: POINTER;
			-- Associated color map identifier used to
			-- allocate the colors

	colormap: MEL_COLORMAP is
			-- Associated color map
		do
			if colormap_identifier /= default_pointer then	
				!! Result.make_from_existing (colormap_identifier)
			end
		end;

	is_bad_color_name: BOOLEAN is
			-- Did the last attempt of allocating a color
			-- could not be done successfully because the color
			-- name did not exist?
		do
			Result := status = BAD_COLOR_NAME
		end;

	is_no_free_cell_available: BOOLEAN is
			-- Did the last attempt of allocating a color
			-- could not be done successfully because there were
			-- no free cell available?
		do
			Result := status = NO_FREE_CELL_AVAILABLE
		end;

	has_valid_colormap: BOOLEAN is
			-- Has the `colormap_identifier' been set?
		do
			Result := colormap_identifier /= default_pointer
		ensure
			valid_result: Result implies colormap_identifier /= default_pointer
		end;

feature -- Status report

	is_valid: BOOLEAN is
			-- Is Current pixel valid?
		do
			Result := status = 0
		end;

	red: INTEGER is
			-- Red component value of this color
		require
			pixel_is_valid: is_valid;
			has_valid_colormap: has_valid_colormap
		do
			Result := red_component (identifier, display_handle, colormap_identifier)
		ensure
			red_value_large_enough: Result >= 0;
			red_value_small_enough: Result <= 65535
		end;

	green: INTEGER is
			-- Green component value of this color
		require
			pixel_is_valid: is_valid;
			has_valid_colormap: has_valid_colormap
		do
			Result := green_component (identifier, 
				display_handle, colormap_identifier)
		ensure
			green_value_large_enough: Result >= 0;
			green_value_small_enough: Result <= 65535
		end;

	blue: INTEGER is
			-- Blue component value of this color
		require
			pixel_is_valid: is_valid;
			has_valid_colormap: has_valid_colormap
		do
			Result := blue_component (identifier, 
				display_handle, colormap_identifier)
		ensure
			blue_value_large_enough: Result >= 0;
			blue_value_small_enough: Result <= 65535
		end;

feature -- Status setting

    set_colormap (a_colormap: MEL_COLORMAP) is
            -- Set `colormap' to `a_colormap'.
        require
			colormap_not_set: not has_valid_colormap;
            valid_colormap: a_colormap /= Void and then a_colormap.is_valid
        do
            colormap_identifier := a_colormap.identifier
        ensure
			set: equal (colormap, a_colormap);
            valid_colormap: has_valid_colormap
        end;

feature -- Removal

	destroy is
			-- Free the cell from `colormap'.
		do
			check
				has_valid_display: display_handle /= default_pointer;
				has_valid_colormap: has_valid_colormap
			end;
			x_free_color (display_handle, 
					colormap_identifier,
					identifier);
			identifier := default_pointer;
			status := ALREADY_FREED
		end;

feature {NONE} -- Implementation

	status: INTEGER;
			-- Possible values for error:
			-- O: no error
			-- -1: bad screen pointer given to the get_color function is black and white
			-- -2: bad color name
			-- -3: couldn't allocate the color (no more cells in the colormap)
			-- -99: Alread freed

	ALREADY_FREED: INTEGER is -99;	

feature {NONE} -- Implementation

	get_color_by_name (a_string: POINTER; a_display, cmap: POINTER): POINTER is
		external
			"C"
		end;

	get_color_by_rgb_value (red_value, green_value, 
			blue_value: INTEGER; a_display, cmap: POINTER): POINTER is
		external
			"C"
		end;

	red_component (pixel: POINTER; a_display, a_colormap: POINTER): INTEGER is
		external
			"C"
		end;

	green_component (pixel: POINTER; a_display, a_colormap: POINTER): INTEGER is
		external
			"C"
		end;

	blue_component (pixel: POINTER; a_display, a_colormap: POINTER): INTEGER is
		external
			"C"
		end;

	last_color_alloc_status: INTEGER is
		external
			"C [macro %"pixel.h%"]: EIF_INTEGER"
		alias
			"last_color_alloc_status"
		end;

	x_free_color (a_display, a_colormap, an_id: POINTER) is
		external
			"C"
		end;

	BAD_COLOR_NAME: INTEGER is
		external
			"C [macro %"pixel.h%"]: EIF_INTEGER"
		alias
			"BAD_COLOR_NAME"
		end;

	NO_FREE_CELL_AVAILABLE: INTEGER is
		external
			"C [macro %"pixel.h%"]: EIF_INTEGER"
		alias
			"NO_FREE_CELL_AVAILABLE"
		end;

invariant

	valid_display: has_valid_display

end -- class MEL_PIXEL


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

