indexing
	description: "Contains information for tracking mouse events."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TRACK_MOUSE_EVENT

inherit
	WEL_STRUCTURE
		rename
			make as structure_make,
			make_by_pointer as structure_make_by_pointer
		end

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make is
			-- Create TRACKMOUSEEVENT struct.
		do
			structure_make
			cwel_trackmouseevent_set_cbsize (item, structure_size)
		end

	make_by_pointer (a_pointer: POINTER) is
			-- Create TRACKMOUSEEVENT from `a_pointer'.
		do
			structure_make_by_pointer (a_pointer)
			cwel_trackmouseevent_set_cbsize (item, structure_size)
		end

feature -- Access

	dwflags: INTEGER is
				-- Requested tracking service.
		do
			Result := cwel_trackmouseevent_get_dwflags (item)
		ensure
			Result_not_void: Result /= Void
		end

	hwndtrack: POINTER is
			-- Window to track.
		do
			Result := cwel_trackmouseevent_get_hwndtrack (item)
		ensure
			Result_not_void: Result /= Void
		end

	dwhovertime: INTEGER is
			-- Hover time-out.
		do
			Result := cwel_trackmouseevent_get_dwhovertime (item)
		ensure
			Result_not_void: Result /= Void
		end

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_trackmouseevent
		end

feature -- Status setting

	set_dwflags (flags: INTEGER) is
			-- Assign `flags' to `dwflags'.
		do
			cwel_trackmouseevent_set_dwflags (item, flags)
		ensure
			dwflags_set: dwflags = flags
		end

	set_hwndtrack (window: POINTER) is
			-- Assign `window' to `hwndtrack'.
		do
			cwel_trackmouseevent_set_hwndtrack (item, window)
		ensure
			hwndtrack_set: hwndtrack = window
		end

	set_dwhovertime (time: INTEGER) is
			-- Assign `time' to `dwhovertime'.
		do
			cwel_trackmouseevent_set_dwhovertime (item, time)
		ensure
			dwhovertime_set: dwhovertime = time 
		end

feature {NONE} -- Externals

	c_size_of_trackmouseevent: INTEGER is
		external
			"C [macro <trackmouseevent.h>]"
		alias
			"sizeof (TRACKMOUSEEVENT)"
		end

	cwel_trackmouseevent_get_cbsize (ptr: POINTER): INTEGER is
		external
			"C [macro <trackmouseevent.h>] (TRACKMOUSEEVENT*): EIF_INTEGER"
		end

	cwel_trackmouseevent_get_hwndtrack (ptr: POINTER): POINTER is
		external
			"C [macro <trackmouseevent.h>] (TRACKMOUSEEVENT*): EIF_POINTER"
		end

	cwel_trackmouseevent_get_dwflags (ptr: POINTER): INTEGER is
		external
			"C [macro <trackmouseevent.h>] (TRACKMOUSEEVENT*): EIF_INTEGER"
		end

	cwel_trackmouseevent_get_dwhovertime (ptr: POINTER): INTEGER is
		external
			"C [macro <trackmouseevent.h>] (TRACKMOUSEEVENT*): EIF_INTEGER"
		end

	cwel_trackmouseevent_set_cbsize (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <trackmouseevent.h>] (TRACKMOUSEEVENT*, int)"
		end

	cwel_trackmouseevent_set_hwndtrack (ptr, window: POINTER) is
		external
			"C [macro <trackmouseevent.h>] (TRACKMOUSEEVENT*, EIF_POINTER)"
		end

	cwel_trackmouseevent_set_dwflags (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <trackmouseevent.h>] (TRACKMOUSEEVENT*, int)" 
		end

	cwel_trackmouseevent_set_dwhovertime (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <trackmouseevent.h>] (TRACKMOUSEEVENT*, int)" 
		end

end -- class WEL_TRACK_MOUSE_EVENT

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

