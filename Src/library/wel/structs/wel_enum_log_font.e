indexing
	description: "Defines the attributes, the complete name, the style of a %
		%font. This structure is used by WEL_FONT_FAMILY_ENUMERATOR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ENUM_LOG_FONT

inherit
	WEL_STRUCTURE

create
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

	full_name: STRING_32 is
			-- Specifies a unique name for the font
		local
			l_str: WEL_STRING
		do
			create l_str.share_from_pointer (cwel_enumlogfont_get_elffullname (item))
			Result := l_str.string
		ensure
			result_not_void: Result /= Void
		end

	style: STRING_32 is
			-- Specifies the style of the font
		local
			l_str: WEL_STRING
		do
			create l_str.share_from_pointer (cwel_enumlogfont_get_elfstyle (item))
			Result := l_str.string
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




end -- class WEL_ENUM_LOG_FONT

