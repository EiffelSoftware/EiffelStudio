indexing
	description: "Fonts supported."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GD_FONTS

inherit

	GD_FONT_CONSTANTS

feature {NONE} -- Access

	large_font_pointer: POINTER is
		once
			Result := c_large_font
		end

	tiny_font_pointer: POINTER is
		once
			Result := c_tiny_font
		end

	small_font_pointer: POINTER is
		once
			Result := c_small_font
		end

	medium_bold_font_pointer: POINTER is
		once
			Result := c_medium_bold_font
		end

	giant_font_pointer: POINTER is
		once
			Result := c_giant_font
		end
	
feature -- Access

	font(i: INTEGER):POINTER is
		-- Select a font thanks to its associated value.
		-- Please refer to GIF_FONT_CONSTANTS for possible values.
		require
			indice_possible: font_possible(i)
		do
			inspect i
				when large_font then Result := large_font_pointer
				when tiny_font then Result := tiny_font_pointer
				when small_font then Result := small_font_pointer
				when medium_bold_font then Result := medium_bold_font_pointer
				when giant_font then Result := giant_font_pointer
			end
		ensure
			result_exists: Result /= DEFAULT_POINTER
		end

feature -- Externals

	c_tiny_font:POINTER is
		external
			"C"
		alias
			"c_tiny_font"
		end

	c_small_font:POINTER is
		external
			"C"
		alias
			"c_small_font"
		end

	c_medium_bold_font:POINTER is
		external
			"C"
		alias
			"c_medium_bold_font"
		end

	c_giant_font:POINTER is
		external
			"C"
		alias
			"c_giant_font"
		end

	c_large_font:POINTER  is
		external
			"C"
		alias
			"c_large_font"
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






end -- class GIF_FONTS
