indexing
	description: "Fonts supported."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GIF_FONTS

inherit

	GIF_FONT_CONSTANTS

feature {GIF_IMAGE} -- Access

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

end -- class GIF_FONTS
