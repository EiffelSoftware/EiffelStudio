indexing
	description:
		""
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RAW_IMAGE_DATA

inherit
	ARRAY [CHARACTER]
		rename
			make as array_make,
			item as array_item,
			put as array_put,
			force as array_force,
			resize as array_resize,
			wipe_out as array_wipe_out
		export
			{NONE}
				array_make, array_item, array_force,
				array_resize, array_wipe_out;
			{EV_RAW_IMAGE_DATA}
				array_put;
			{ANY}
				copy, is_equal, area, to_c
		end

create
	make, make_with_alpha_zero

feature {NONE} -- Initialization

	make (a_width, a_height: INTEGER) is
			-- Create an array which has `a_width'
			-- * `a_height' * 4 items.
		require
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0;
		do
			height := a_height;
			width := a_width;
			array_make (1, height * width * 4)
			initialize_alpha
		ensure
			new_count: count = height * width * 4
		end

	make_with_alpha_zero (a_width, a_height: INTEGER) is
			-- Create an array which has `a_width'
			-- * `a_height' * 4 items.
		require
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0;
		do
			height := a_height;
			width := a_width;
			array_make (1, height * width * 4)
		ensure
			new_count: count = height * width * 4
		end

	initialize_alpha is
			-- Make each alpha entry have value `255'.
		local
			i, j: INTEGER
			c: CHARACTER
		do
			from
				i := 4
				j := 255
				c := j.ascii_char
			until
				i > count
			loop
				array_put (c, i)
				i := i + 4
			end
		end

feature -- Measurement

	height: INTEGER
			-- Number of rows.

	width: INTEGER
			-- Number of columns.

feature -- Access

	originating_pixmap: EV_PIXMAP
		-- Pixmap `Current' was based on, if any.

	rgb_hex_representation: STRING is
		-- Returns a string of hex codes representing the RGB values
		-- of all the pixels in pixmap.
		local
			i: INTEGER
		do
			from
				Result := ""
				Result.append_character (hex_code (array_item (1).code.bit_shift_right (4)))
				Result.append_character (hex_code ((array_item (1).code) \\ 16))
				i := 2
			until
				i = count + 1
			loop
				if i \\ 4 /= 0 then
					Result.append_character (hex_code (array_item (i).code.bit_shift_right (4)))
					Result.append_character (hex_code ((array_item (i).code) \\ 16))
				end
				i := i + 1
			end
		end

	pixel (a_x, a_y: INTEGER): EV_COLOR is
		require
			valid_coordinates: valid_coordinates (a_x, a_y)
		local
			a_red, a_green, a_blue: INTEGER
		do
			a_red := pixel_red_component (a_x, a_y).code
			a_green := pixel_green_component (a_x, a_y).code
			a_blue := pixel_blue_component (a_x, a_y).code
			create Result.make_with_8_bit_rgb (a_red, a_green, a_blue)
		end

	pixel_red_component (a_x, a_y: INTEGER): CHARACTER is
		require
			valid_coordinates: valid_coordinates (a_x, a_y)
		do
			Result := get_character_from_position (a_x, a_y, 1)
		end

	pixel_green_component (a_x, a_y: INTEGER): CHARACTER is
		require
			valid_coordinates: valid_coordinates (a_x, a_y)
		do
			Result := get_character_from_position (a_x, a_y, 2)
		end

	pixel_blue_component (a_x, a_y: INTEGER): CHARACTER is
		require
			valid_coordinates: valid_coordinates (a_x, a_y)
		do
			Result := get_character_from_position (a_x, a_y, 3)
		end

	pixel_alpha_component (a_x, a_y: INTEGER): CHARACTER is
		require
			valid_coordinates: valid_coordinates (a_x, a_y)
		do
			Result := get_character_from_position (a_x, a_y, 4)
		end
	
feature -- Element Change

	set_pixel (a_x, a_y: INTEGER; a_color: EV_COLOR) is
		require
			valid_coordinates: valid_coordinates (a_x, a_y)
			a_color_not_void: a_color /= Void
		do
			set_character_from_integer (a_x, a_y, 1,
				a_color.red_8_bit.ascii_char)
			set_character_from_integer (a_x, a_y, 2,
				a_color.green_8_bit.ascii_char)
			set_character_from_integer (a_x, a_y, 3,
				a_color.blue_8_bit.ascii_char)
			--set_character_from_integer (a_x, a_y, 4,
			--	a_color.alpha_8_bit.ascii_char)
		end

	set_pixel_red_component (a_x, a_y: INTEGER; a_intensity: CHARACTER) is
		require
			valid_coordinates: valid_coordinates (a_x, a_y)
		do
			set_character_from_integer (a_x, a_y, 1, a_intensity)
		end

	set_pixel_green_component (a_x, a_y: INTEGER; a_intensity: CHARACTER) is
		require
			valid_coordinates: valid_coordinates (a_x, a_y)
		do
			set_character_from_integer (a_x, a_y, 2, a_intensity)
		end

	set_pixel_blue_component (a_x, a_y: INTEGER; a_intensity: CHARACTER) is
		require
			valid_coordinates: valid_coordinates (a_x, a_y)
		do
			set_character_from_integer (a_x, a_y, 3, a_intensity)
		end

	set_pixel_alpha_component (a_x, a_y: INTEGER; a_intensity: CHARACTER) is
		require
			valid_coordinates: valid_coordinates (a_x, a_y)
		do
			set_character_from_integer (a_x, a_y, 4, a_intensity)
		end

feature -- Contract support

	valid_coordinates (a_x, a_y: INTEGER): BOOLEAN is
		do
			Result := (a_x >= 1 and then a_x <= width and then 
				a_y >= 1 and then a_y <= height)
		end

feature {EV_PIXMAP_ACTION_SEQUENCES_IMP} -- Implementation

	Set_originating_pixmap (a_pixmap: EV_PIXMAP) is
			-- Sets `originating_pixmap' to `a_pixmap'.
		once
			originating_pixmap := a_pixmap
		end

feature {NONE} -- Implementation

	set_character_from_integer (a_x, a_y, a_pos: INTEGER; a_value: CHARACTER) is
		require
			a_x_positive: a_x > 0;
			a_y_positive: a_y > 0;
			a_pos_in_range: a_pos >= 1 and a_pos <= 4;
		local
			array_pos: INTEGER
		do
			array_pos := ((a_y - 1) * 4 * width) + ((a_x - 1) * 4) + a_pos
			array_put (a_value, array_pos)
		end

	get_character_from_position (a_x, a_y, a_pos: INTEGER): CHARACTER is
		require
			
		local
			array_pos: INTEGER
		do
			array_pos := ((a_y - 1) * 4 * width) + ((a_x - 1) * 4) + a_pos
			Result := array_item (array_pos)
		end

	hex_code (a_code: INTEGER): CHARACTER is
		require
			valid_code: a_code >= 0 and a_code <= 15
		do
			if a_code < 10 then
				Result := (a_code + 48).ascii_char
			else
				Result := (a_code + 55).ascii_char
			end
		end

invariant
	items_number: count = width * height * 4

end -- class EV_RAW_IMAGE_DATA

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

