indexing
	description: "[
		Constants for use with and by EV_CHARACTER_FORMAT and
		EV_CHARACTER_RANGE_INFORMATION
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHARACTER_FORMAT_CONSTANTS

feature -- Access

	Font_family: INTEGER is 1
		-- Font family applicable.
		
	Font_weight: INTEGER is 2
		-- Font weight applicable.
		
	Font_shape: INTEGER is 4
		-- Font shape applicable.
		
	Font_height: INTEGER is 8
		-- Font height applicable.
		
	Color: INTEGER is 16
		-- Color applicable.
		
	Background_color: INTEGER is 32
		-- Background color applicable.
		
	Effects_striked_out: INTEGER is 64
		-- Effects striked out valid.
		
	Effects_underlined: INTEGER is 128
		-- Effects underlined valid.
		
	Effects_vertical_offset: INTEGER is 256
		-- Effects vertical offset valid.

feature -- Contract support

	valid_character_format_flag (a_flag: INTEGER): BOOLEAN is
			-- Is `a_flag' a valid character format flag?
			-- Used by EV_CHARACTER_FORMAT_RANGE_INFORMATION
			-- May be any combination of the attribute flags above, except that
			-- `Effects_underlined' and `Effects_double_underlined are mutually exclusive
		do
			Result := a_flag <= font_family  + font_weight + font_shape + font_height + color + background_color +
				effects_striked_out + effects_underlined  + effects_vertical_offset
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_CHARACTER_FORMAT_CONSTANTS

