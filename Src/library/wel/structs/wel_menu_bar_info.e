indexing
	description: "Wrapper around MENUBARINFO C structure"
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

	make is
		do
			structure_make
			cwel_menubarinfo_set_cbsize (item, c_size_of_menubarinfo)
		end

feature -- Access

	rc_bar: WEL_RECT is
			--
		do
			create Result.make_by_pointer (cwel_menubarinfo_get_rcbar (item))
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_menubarinfo
		end

feature {NONE} -- External

	c_size_of_menubarinfo: INTEGER is
		external
			"C [macro <windows.h>]"
		alias
			"sizeof (MENUBARINFO)"
		end

	cwel_menubarinfo_set_cbsize (ptr: POINTER; value: INTEGER) is
		external
			"C [struct <rect.h>] (MENUBARINFO, DWORD)"
		alias
			"cbSize"
		end

	cwel_menubarinfo_get_rcbar (ptr: POINTER): POINTER is
		external
			"C inline use <windows.h>"
		alias
			"(& (((MENUBARINFO *)($ptr))->rcBar) )"
		end

end
