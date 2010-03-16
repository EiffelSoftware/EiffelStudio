note
	description: "Wrapper around MENUBARINFO C structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MENU_BAR_INFO

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make
		do
			structure_make
			cwel_menubarinfo_set_cbsize (item, c_size_of_menubarinfo)
		end

feature -- Access

	rc_bar: WEL_RECT
			--
		do
			create Result.make_by_pointer (cwel_menubarinfo_get_rcbar (item))
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_menubarinfo
		end

feature {NONE} -- External

	c_size_of_menubarinfo: INTEGER
		external
			"C [macro <windows.h>]"
		alias
			"sizeof (MENUBARINFO)"
		end

	cwel_menubarinfo_set_cbsize (ptr: POINTER; value: INTEGER)
		external
			"C [struct <rect.h>] (MENUBARINFO, DWORD)"
		alias
			"cbSize"
		end

	cwel_menubarinfo_get_rcbar (ptr: POINTER): POINTER
		external
			"C inline use <windows.h>"
		alias
			"(& (((MENUBARINFO *)($ptr))->rcBar) )"
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

end
