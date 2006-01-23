indexing
	description: "Font type constants for WEL_FONT_FAMILY_ENUMERATOR class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FONT_TYPE_ENUM_CONSTANTS

feature -- Access

	Raster_fonttype: INTEGER is 1

	Device_fonttype: INTEGER is 2

	Truetype_fonttype: INTEGER is 4

feature -- Status report

	valid_font_type_enum_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid font type enum constant?
		do
			Result := c = Device_fonttype or else
				c = Raster_fonttype or else
				c = Truetype_fonttype
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




end -- class WEL_FONT_TYPE_ENUM_CONSTANTS

