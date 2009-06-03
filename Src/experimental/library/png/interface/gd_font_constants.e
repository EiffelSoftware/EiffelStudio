note
	description: "Constants used to select a font"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GD_FONT_CONSTANTS

feature -- Implementation

	large_font: INTEGER = 1

	tiny_font: INTEGER = 2

	small_font: INTEGER = 3

	medium_bold_font: INTEGER = 4

	giant_font: INTEGER = 5

feature -- Access

	font_possible(i: INTEGER): BOOLEAN
		-- Select a font thanks to its associated value.
		-- Please refer to GD_FONT_CONSTANTS for possible values.
		do
			inspect i
				when large_font then Result := TRUE
				when tiny_font then Result := TRUE
				when small_font then Result := TRUE
				when medium_bold_font then Result := TRUE
				when giant_font then Result := TRUE
			end
		end


note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end -- class GD_FONT_CONSTANTS
