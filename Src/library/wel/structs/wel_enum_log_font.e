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
	make_with_pointer

feature -- Creation

	make_with_pointer (a_pointer: POINTER) is
			-- Copy structure pointed by `a_pointer' into `item'.
			-- Caution: `a_pointer' must be a pointer
			-- coming from Windows.
		do
			make
			memory_copy (a_pointer, structure_size)
		end

feature -- Access

	log_font: WEL_LOG_FONT is
			-- Defines the attribut of a font
		do
			create Result.make_with_pointer (cwel_enumlogfont_get_elflogfont (item))
		ensure
			result_not_void: Result /= Void
		end

	full_name: STRING is
			-- Specifies a unique name for the font
		do
			create Result.make_from_c (cwel_enumlogfont_get_elffullname (item))
		ensure
			result_not_void: Result /= Void
		end

	style: STRING is
			-- Specifies the style of the font
		do
			create Result.make_from_c (cwel_enumlogfont_get_elfstyle (item))
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
			"C [macro <enumlf.h>] (ENUMLOGFONT*): EIF_POINTER"
		end

	cwel_enumlogfont_get_elffullname (ptr: POINTER): POINTER is
		external
			"C [macro <enumlf.h>] (ENUMLOGFONT*): EIF_POINTER"
		end

	cwel_enumlogfont_get_elfstyle (ptr: POINTER): POINTER is
		external
			"C [macro <enumlf.h>] (ENUMLOGFONT*): EIF_POINTER"
		end

end -- class WEL_ENUM_LOG_FONT


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

