indexing
	description: "Defines the attributes, the complete name, the style of a %
		%font. This structure is used by WEL_FONT_FAMILY_ENUMERATOR."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ENUM_LOG_FONT

inherit
	WEL_STRUCTURE

creation
	make_by_pointer

feature -- Access

	log_font: WEL_LOG_FONT is
			-- Defines the attribut of a font
		do
			!! Result.make_by_pointer (cwel_enumlogfont_get_elflogfont (item))
		ensure
			result_not_void: Result /= Void
		end

	full_name: STRING is
			-- Specifies a unique name for the font
		do
			!! Result.make (0)
			Result.from_c (cwel_enumlogfont_get_elffullname (item))
		ensure
			result_not_void: Result /= Void
		end

	style: STRING is
			-- Specifies the style of the font
		do
			!! Result.make (0)
			Result.from_c (cwel_enumlogfont_get_elfstyle (item))
		ensure
			result_not_void: Result /= Void
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_enumlogfont
		end

feature {NONE} -- Externals

	c_size_of_enumlogfont: INTEGER is
		external
			"C [macro <enumlf.h>]"
		alias
			"sizeof (ENUMLOGFONT)"
		end

	cwel_enumlogfont_get_elflogfont (ptr: POINTER): POINTER is
		external
			"C [macro <enumlf.h>]"
		end

	cwel_enumlogfont_get_elffullname (ptr: POINTER): POINTER is
		external
			"C [macro <enumlf.h>]"
		end

	cwel_enumlogfont_get_elfstyle (ptr: POINTER): POINTER is
		external
			"C [macro <enumlf.h>]"
		end

end -- class WEL_ENUM_LOG_FONT

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
