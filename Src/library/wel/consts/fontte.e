indexing
	description: "Font type constants for WEL_FONT_FAMILY_ENUMERATOR class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FONT_TYPE_ENUM_CONSTANTS

feature -- Access

	Device_fonttype: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DEVICE_FONTTYPE"
		end

	Raster_fonttype: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"RASTER_FONTTYPE"
		end

	Truetype_fonttype: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TRUETYPE_FONTTYPE"
		end

feature -- Status report

	valid_font_type_enum_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid font type enum constant?
		do
			Result := c = Device_fonttype or else
				c = Raster_fonttype or else
				c = Truetype_fonttype
		end

end -- class WEL_FONT_TYPE_ENUM_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All righttype reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
