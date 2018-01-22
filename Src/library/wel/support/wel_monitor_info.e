note
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MONITOR_INFO

inherit
	WEL_STRUCTURE
		export
			{ANY} is_equal, copy, clone
		redefine
			make
		end

create
	make

feature {NONE} -- Initialize

	make
			-- <Precursor>
		do
			Precursor
				-- Need to set cbSize to sizeof ( MONITORINFO ) for GetMonitorInfo to work.
			cwin_monitorinfo_set_size (item, structure_size)
		end

feature -- Access

	monitor_area: WEL_RECT
			-- Full area of monitor rectangle expressed in virtual coordinates.
		do
			create Result.make_by_pointer (cwin_monitorinfo_get_monitor (item))
		end

	working_area: WEL_RECT
			-- Working area of monitor rectangle expressed in virtual coordinates.
		do
			create Result.make_by_pointer (cwin_monitorinfo_get_work (item))
		end

	is_primary: BOOLEAN
			-- Is the monitor represented by `Current' the primary monitor?
		do
			Result := cwin_monitorinfo_get_flags (item) /= 0
		end

feature -- Measurement

	structure_size: INTEGER
			-- <Precursor>
		do
			Result := c_structure_size
		end

feature {NONE} -- Implementation

	c_structure_size: INTEGER
			-- Implementation of `structure_size`.
		external
			"C [macro <windows.h>]"
		alias
			"sizeof (MONITORINFO)"
		end

	cwin_monitorinfo_set_size (ptr: POINTER; value: INTEGER)
		external
			"C [struct <rect.h>] (MONITORINFO, DWORD)"
		alias
			"cbSize"
		end

	cwin_monitorinfo_get_monitor (ptr: POINTER): POINTER
		external
			"C [struct <windows.h>] (MONITORINFO): EIF_POINTER"
		alias
			"&rcMonitor"
		end

	cwin_monitorinfo_get_work (ptr: POINTER): POINTER
		external
			"C [struct <windows.h>] (MONITORINFO): EIF_POINTER"
		alias
			"&rcWork"
		end

	cwin_monitorinfo_get_flags (ptr: POINTER): INTEGER
		external
			"C [struct <windows.h>] (MONITORINFO): EIF_INTEGER"
		alias
			"dwFlags"
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
