indexing
	description: "Contains information about a window's maximized size and %
		%position and its minimum and maximum tracking size."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MIN_MAX_INFO

inherit
	WEL_STRUCTURE

creation
	make,
	make_by_pointer

feature -- Access

	max_size: WEL_POINT is
			-- Maximized width and height of the window
		do
			create Result.make_by_pointer (cwel_minmaxinfo_get_maxsize (item))
		ensure
			result_not_void: Result /= Void
		end

	max_position: WEL_POINT is
			-- Position of the left side of the maximized window
			-- and the position of the top of the maximized window
		do
			create Result.make_by_pointer (cwel_minmaxinfo_get_maxposition (item))
		ensure
			result_not_void: Result /= Void
		end

	min_track_size: WEL_POINT is
			-- Minimum tracking width and the minimum tracking
			-- height of the window
		do
			create Result.make_by_pointer (cwel_minmaxinfo_get_mintracksize (item))
		ensure
			result_not_void: Result /= Void
		end

	max_track_size: WEL_POINT is
			-- Maximum tracking width and the minimum tracking
			-- height of the window
		do
			create Result.make_by_pointer (cwel_minmaxinfo_get_maxtracksize (item))
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_max_size (point: WEL_POINT) is
			-- Set `max_size' with `point'.
		require
			point_not_void: point /= Void
		do
			cwel_minmaxinfo_set_maxsize (item, point.item)
		ensure
			point_set: max_size.is_equal (point)
		end

	set_max_position (point: WEL_POINT) is
			-- Set `max_position' with `point'.
		require
			point_not_void: point /= Void
		do
			cwel_minmaxinfo_set_maxposition (item, point.item)
		ensure
			point_set: max_position.is_equal (point)
		end

	set_min_track_size (point: WEL_POINT) is
			-- Set `min_track_size' with `point'.
		require
			point_not_void: point /= Void
		do
			cwel_minmaxinfo_set_mintracksize (item, point.item)
		ensure
			point_set: min_track_size.is_equal (point)
		end

	set_max_track_size (point: WEL_POINT) is
			-- Set `max_track_size' with `point'.
		require
			point_not_void: point /= Void
		do
			cwel_minmaxinfo_set_maxtracksize (item, point.item)
		ensure
			point_set: max_track_size.is_equal (point)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_minmaxinfo
		end

feature {NONE} -- Externals

	c_size_of_minmaxinfo: INTEGER is
		external
			"C [macro <minmaxi.h>]"
		alias
			"sizeof (MINMAXINFO)"
		end

	cwel_minmaxinfo_set_maxsize (ptr: POINTER; value: POINTER) is
		external
			"C [macro <minmaxi.h>]"
		end

	cwel_minmaxinfo_set_maxposition (ptr: POINTER; value: POINTER) is
		external
			"C [macro <minmaxi.h>]"
		end

	cwel_minmaxinfo_set_mintracksize (ptr: POINTER; value: POINTER) is
		external
			"C [macro <minmaxi.h>]"
		end

	cwel_minmaxinfo_set_maxtracksize (ptr: POINTER; value: POINTER) is
		external
			"C [macro <minmaxi.h>]"
		end

	cwel_minmaxinfo_get_maxsize (ptr: POINTER): POINTER is
		external
			"C [macro <minmaxi.h>] (LPMINMAXINFO): EIF_POINTER"
		end

	cwel_minmaxinfo_get_maxposition (ptr: POINTER): POINTER is
		external
			"C [macro <minmaxi.h>] (LPMINMAXINFO): EIF_POINTER"
		end

	cwel_minmaxinfo_get_mintracksize (ptr: POINTER): POINTER is
		external
			"C [macro <minmaxi.h>] (LPMINMAXINFO): EIF_POINTER"
		end

	cwel_minmaxinfo_get_maxtracksize (ptr: POINTER): POINTER is
		external
			"C [macro <minmaxi.h>] (LPMINMAXINFO): EIF_POINTER"
		end

end -- class WEL_MIN_MAX_INFO


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

