indexing

	description: 
		"Representation of an X Pixel.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PIXEL

inherit

	ANY
		redefine
			is_equal
		end

creation
	make_by_name, 
	make_by_rgb_value, 
	make_from_existing

feature {NONE} -- Initilization

	make_by_name (a_color_name: STRING; a_screen: MEL_SCREEN) is
			-- Make a pixel from the name of a color.
		require
			a_color_name_not_void: a_color_name /= Void;
			a_screen_not_void: a_screen /= Void
		local
			temp: ANY
		do
			temp := a_color_name.to_c;
			screen := a_screen;
			id := get_color_by_name ($temp, a_screen.handle, $error);
		end;

	make_by_rgb_value (red_value, green_value, blue_value: INTEGER;  
				a_screen: MEL_SCREEN) is
			-- Make a pixel from a rgb value.
			-- Caution, red, green and blue are 16 bits int values.
		require
			red_value_large_enough: red_value >= 0;
			red_value_small_enough: red_value <= 65535;
			green_value_large_enough: green_value >= 0;
			green_value_small_enough: green_value <= 65535;
			blue_value_large_enough: blue_value >= 0;
			blue_value_small_enough: blue_value <= 65535;
			a_screen_not_void: a_screen /= Void
		do
			screen := a_screen;
			id := get_color_by_rgb_value (red_value, green_value, blue_value, a_screen.handle, $error)
		end;

	make_from_existing (an_id: INTEGER; a_screen: MEL_SCREEN) is
			-- Make a pixel from an already existing value.
		require
			an_id_large_enough: an_id >= 0;
			 a_screen_not_void: a_screen /= Void
		do
			screen := a_screen;
			id := an_id;
			error := 0;
		ensure
			id_set: id = an_id;
			pixel_is_valid: is_valid
		end;

feature -- Access

	id: INTEGER;

	screen: MEL_SCREEN

feature -- Comparison

	is_equal (other:like Current): BOOLEAN is
			-- Is Current color equal to `other' id value?
		do
			Result := id = other.id
		end;

feature -- Status report

	is_valid: BOOLEAN is
			-- Has this pixel been allocated ?
		do
			Result := error = 0
		end;

	red: INTEGER is
			-- Return the red component of this color.
		require
			pixel_is_valid: is_valid
		do
			Result := red_component (id, screen.handle)
		ensure
			red_value_large_enough: Result >= 0;
			red_value_small_enough: Result <= 65535
		end;

	green: INTEGER is
			-- Return the green component of this color.
		require
			pixel_is_valid: is_valid
		do
			Result := green_component (id, screen.handle)
		ensure
			green_value_large_enough: Result >= 0;
			green_value_small_enough: Result <= 65535
		end;

	blue: INTEGER is
			-- Return the blue component of this color.
		require
			pixel_is_valid: is_valid
		do
			Result := blue_component (id, screen.handle)
		ensure
			blue_value_large_enough: Result >= 0;
			blue_value_small_enough: Result <= 65535
		end;

feature -- Removal

	destroy is
			-- Free the cell.
		do
			-- Call
			    --XFreeColors (temp, DefaultColormap (temp, DefaultScreen (temp)),
                 --       (unsigned long *) &num, 1, 0);
		
		end;

feature {NONE} -- Access implementation

	error: INTEGER;
			-- Possible values for error:
			-- O: no error
			-- 1: bad screen pointer given to the get_color function is black and white
			-- 2: bad color name
			-- 3: couldn't allocate the color (no more cells in the colormap)

feature {NONE} -- Implementation

	get_color_by_name (a_string: POINTER; screen_ptr: POINTER; error_ptr: POINTER): INTEGER is
		external
			"C"
		end;

	get_color_by_rgb_value (red_value, green_value, blue_value: INTEGER; screen_ptr: POINTER; error_ptr: POINTER): INTEGER is
		external
			"C"
		end;

	red_component (pixel: INTEGER; screen_ptr: POINTER): INTEGER is
		external
			"C"
		end;

	green_component (pixel: INTEGER; screen_ptr: POINTER): INTEGER is
		external
			"C"
		end;

	blue_component (pixel: INTEGER; screen_ptr: POINTER): INTEGER is
		external
			"C"
		end;

end -- class MEL_PIXEL

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
