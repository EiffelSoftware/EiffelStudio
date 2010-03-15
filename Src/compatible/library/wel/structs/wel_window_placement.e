note
	description: "Contains information about the placement of a window on %
		%the screen."
	legal: "See notice at end of class."
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

create
	make

feature {NONE} -- Initialization

	make (a_window: WEL_WINDOW)
			-- Make a window placement for `a_window'.
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			structure_make
			cwel_window_placement_set_length (item, structure_size)
			cwin_get_window_placement (a_window.item, item)
		ensure
			exists: exists
		end

feature -- Access

	flags: INTEGER
			-- Flags that control the position of the
			-- minimized window and the method by which
			-- the window is restored.
			-- See class WEL_WPF_CONSTANTS for possible values.
		require
			exists: exists
		do
			Result := cwel_window_placement_get_flags (item)
		end

	show_command: INTEGER
			-- Show state of the window.
			-- See class WEL_SW_CONSTANTS for possible values
		require
			exists: exists
		do
			Result := cwel_window_placement_get_show_command (item)
		end

	minimum_position: WEL_POINT
			-- Coordinates of the window's upper left
			-- corner when the window is minimized.
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_window_placement_get_minimum_position (item))
		ensure
			result_not_void: Result /= Void
		end

	maximum_position: WEL_POINT
			-- Coordinates of the window's upper left
			-- corner when the window is maximized.
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_window_placement_get_maximum_position (item))
		ensure
			result_not_void: Result /= Void
		end

	normal_position: WEL_RECT
			-- Window's coordinates when the
			-- windows is in the restored position
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_window_placement_get_normal_position (item))
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_flags (a_flags: INTEGER)
			-- Set `flags' with `a_flags'
		require
			exists: exists
		do
			cwel_window_placement_set_flags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

	set_show_command (a_show_command: INTEGER)
			-- Set `show_command' with `a_show_command'
		require
			exists: exists
		do
			cwel_window_placement_set_show_command (item, a_show_command)
		ensure
			show_command_set: show_command = a_show_command
		end

	set_minimum_position (a_point: WEL_POINT)
			-- Set `minimum_position' with `a_point'
		require
			exists: exists
			a_point_not_void: a_point /= Void
			a_point_exists: a_point.exists
		do
			cwel_window_placement_set_minimum_position (item, a_point.item)
		ensure
			-- minimum_position_set: minimum_position = a_point
		end

	set_maximum_position (a_point: WEL_POINT)
			-- Set `maximum_position' with `a_point'
		require
			exists: exists
			a_point_not_void: a_point /= Void
			a_point_exists: a_point.exists
		do
			cwel_window_placement_set_maximum_position (item, a_point.item)
		ensure
			-- maximum_position_set: maximum_position = a_point
		end

	set_normal_position (a_rect: WEL_RECT)
			-- Set `normal_position' with `a_rect'
		require
			exists: exists
			a_rect_not_void: a_rect /= Void
			a_rect_exists: a_rect.exists
		do
			cwel_window_placement_set_normal_position (item, a_rect.item)
		ensure
			-- normal_position_set: normal_position = a_rect
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_window_placement
		end

feature {NONE} -- Externals

	c_size_of_window_placement: INTEGER
		external
			"C [macro <winplace.h>]"
		alias
			"sizeof (WINDOWPLACEMENT)"
		end

	cwel_window_placement_set_length (ptr: POINTER; value: INTEGER)
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_set_flags (ptr: POINTER; value: INTEGER)
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_set_show_command (ptr: POINTER; value: INTEGER)
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_set_minimum_position (ptr: POINTER;
			value: POINTER)
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_set_maximum_position (ptr: POINTER;
			value: POINTER)
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_set_normal_position (ptr: POINTER;
			value: POINTER)
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_get_flags (ptr: POINTER): INTEGER
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_get_show_command (ptr: POINTER): INTEGER
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_get_minimum_position (ptr: POINTER): POINTER
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_get_maximum_position (ptr: POINTER): POINTER
		external
			"C [macro <winplace.h>]"
		end

	cwel_window_placement_get_normal_position (ptr: POINTER): POINTER
		external
			"C [macro <winplace.h>]"
		end

	cwin_get_window_placement (hwnd, ptr: POINTER)
			-- SDK GetWindowPlacement
		external
			"C [macro <winplace.h>] (HWND, WINDOWPLACEMENT *)"
		alias
			"GetWindowPlacement"
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
