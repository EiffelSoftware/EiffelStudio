indexing
	description: "Font type constants for WEL_FONT_FAMILY_ENUMERATOR class."
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

end -- class WEL_FONT_TYPE_ENUM_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

