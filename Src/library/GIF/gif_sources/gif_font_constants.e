indexing
	description: "Constants used to select a font"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GIF_FONT_CONSTANTS

feature -- Implementation

	large_font: INTEGER is 1

	tiny_font: INTEGER is 2

	small_font: INTEGER is 3

	medium_bold_font: INTEGER is 4

	giant_font: INTEGER is 5

feature -- Access

	font_possible(i: INTEGER): BOOLEAN is
		-- Select a font thanks to its associated value.
		-- Please refer to GIF_FONT_CONSTANTS for possible values.
		do
			inspect i
				when large_font then Result := TRUE
				when tiny_font then Result := TRUE
				when small_font then Result := TRUE
				when medium_bold_font then Result := TRUE
				when giant_font then Result := TRUE
			end
		end


end -- class GIF_FONT_CONSTANTS
