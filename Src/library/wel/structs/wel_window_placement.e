indexing
	description: "Contains information about the placement of a window on %
		%the screen."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WINDOW_PLACEMENT

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make

feature {NONE} -- Initialization

	make (a_window: WEL_WINDOW) is
			-- Make a window placement for `a_window'.
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			structure_make
			cwel_window_placement_set_length (item, structure_size)
			cwin_get_window_placement (a_window.item, item)
		end

feature -- Access

	flags: INTEGER is
			-- Flags that control the position of the
			-- minimized window and the method by which
			-- the window is restored.
			-- See class WEL_WPF_CONSTANTS for possible values.
		do
			Result := cwel_window_placement_get_flags (item)
		end

	show_command: INTEGER is
			-- Show state of the window.
			-- See class WEL_SW_CONSTANTS for possible values
		do
			Result := cwel_window_placement_get_show_command (item)
		end

	minimum_position: WEL_POINT is
			-- Coordinates of the window's upper left
			-- corner when the window is minimized.
		do
			create Result.make_by_pointer
				(cwel_window_placement_get_minimum_position
					(item))
		ensure
			result_not_void: Result /= Void
		end

	maximum_position: WEL_POINT is
			-- Coordinates of the window's upper left
			-- corner when the window is maximized.
		do
			create Result.make_by_pointer
				(cwel_window_placement_get_maximum_position
					(item))
		ensure
			result_not_void: Result /= Void
		end

	normal_position: WEL_RECT is
			-- Window's coordinates when the
			-- windows is in the restored position
		do
			create Result.make_by_pointer
				(cwel_window_placement_get_normal_position
					(item))
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_flags (a_flags: INTEGER) is
			-- Set `flags' with `a_flags'
		do
			cwel_window_placement_set_flags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

	set_show_command (a_show_command: INTEGER) is
			-- Set `show_command' with `a_show_command'
		do
			cwel_window_placement_set_show_command (item,
				a_show_command)
		ensure
			show_command_set: show_command = a_show_command
		end

	set_minimum_position (a_point: WEL_POINT) is
			-- Set `minimum_position' with `a_point'
		require
			a_point_not_void: a_point /= Void
		do
			cwel_window_placement_set_minimum_position (item,
				a_point.item)
		ensure
			-- minimum_position_set: minimum_position = a_point
		end

	set_maximum_position (a_point: WEL_POINT) is
			-- Set `maximum_position' with `a_point'
		require
			a_point_not_void: a_point /= Void
		do
			cwel_window_placement_set_maximum_position (item,
				a_point.item)
		ensure
			-- maximum_position_set: maximum_position = a_point
		end

	set_normal_position (a_rect: WEL_RECT) is
			-- Set `normal_position' with `a_rect'
		require
			a_rect_not_void: a_rect /= Void
		do
			cwel_window_placement_set_normal_position (item,
				a_rect.item)
		ensure
			-- normal_position_set: normal_position = a_rect
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_window_placement
		end

feature {NONE} -- Externals

	c_size_of_window_placement: INTEGER is
		external
			"C [macro <winplace.h>]"
		alias
			"sizeof (WINDOWPLACEMENT)"
		end

	cwel_window_placement_set_length (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_set_flags (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_set_show_command (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_set_minimum_position (ptr: POINTER;
			value: POINTER) is
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_set_maximum_position (ptr: POINTER;
			value: POINTER) is
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_set_normal_position (ptr: POINTER;
			value: POINTER) is
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_get_flags (ptr: POINTER): INTEGER is
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_get_show_command (ptr: POINTER): INTEGER is
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_get_minimum_position (ptr: POINTER): POINTER is
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_get_maximum_position (ptr: POINTER): POINTER is
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_get_normal_position (ptr: POINTER): POINTER is
		external
			"C [macro <winplace.h>]"
		end

	cwin_get_window_placement (hwnd, ptr: POINTER) is
			-- SDK GetWindowPlacement
		external
			"C [macro <winplace.h>] (HWND, WINDOWPLACEMENT *)"
		alias
			"GetWindowPlacement"
		end

end -- class WEL_WINDOW_PLACEMENT

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

