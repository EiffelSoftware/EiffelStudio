note
	description: "[
		Control that displays a slider and optional tick marks.

		Note: The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to
			be loaded to use this control.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TRACK_BAR

inherit
	WEL_BAR

	WEL_TBM_CONSTANTS
		export
			{NONE} all
		end

	WEL_TBS_CONSTANTS
		export
			{NONE} all
		end

create
	make_vertical,
	make_horizontal,
	make_by_id

feature {NONE} -- Initialization

	make_vertical (a_parent: WEL_WINDOW; a_x, a_y, a_width,
			a_height, an_id: INTEGER)
			-- Make a vertical track bar.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			internal_window_make (a_parent, Void,
				default_style + Tbs_vert,
				a_x, a_y, a_width, a_height, an_id,
				default_pointer)
			id := an_id
		ensure
			exists: exists
			parent_set: parent = a_parent
			id_set: id = an_id
			position_equal_zero: position = 0
		end

	make_horizontal (a_parent: WEL_WINDOW; a_x, a_y, a_width,
			a_height, an_id: INTEGER)
			-- Make a horizontal track bar.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			internal_window_make (a_parent, Void,
				default_style + Tbs_horz,
				a_x, a_y, a_width, a_height, an_id,
				default_pointer)
			id := an_id
		ensure
			parent_set: parent = a_parent
			exists: exists
			id_set: id = an_id
			position_equal_zero: position = 0
		end

feature -- Access

	line: INTEGER
			-- Number of scroll units per line
			-- Used when the user use the arrow keys.
		do
			Result := {WEL_API}.send_message_result_integer (item, Tbm_getlinesize, to_wparam (0), to_lparam (0))
		end

	page: INTEGER
			-- Number of scroll units per page
			-- Used when the user use the page-up,
			-- page down key or click on the range.
		do
			Result := {WEL_API}.send_message_result_integer (item, Tbm_getpagesize, to_wparam (0), to_lparam (0))
		end

	position: INTEGER
			-- Current position
		do
			Result := {WEL_API}.send_message_result_integer (item, Tbm_getpos, to_wparam (0), to_lparam (0))
		end

	minimum: INTEGER
			-- Minimum position
		do
			Result := {WEL_API}.send_message_result_integer (item, Tbm_getrangemin, to_wparam (0), to_lparam (0))
		end

	maximum: INTEGER
			-- Maximum position
		do
			Result := {WEL_API}.send_message_result_integer (item, Tbm_getrangemax, to_wparam (0), to_lparam (0))
		end

	tick_mark_position (index: INTEGER): INTEGER
			-- Tick mark position at the zero-based `index'
		require
			exists: exists
			valid_index: valid_index (index)
		do
			Result := {WEL_API}.send_message_result_integer (item, Tbm_gettic, to_wparam (index), to_lparam (0))
		ensure
			positive_result: Result >= 0
		end

feature -- Status report

	valid_index (index: INTEGER): BOOLEAN
			-- Is `index' valid?
		require
			exists: exists
		do
			Result := index >= 0 and then
				{WEL_API}.send_message_result_integer (item, Tbm_gettic,
				to_wparam (index), to_lparam (0)) /= -1
		end

feature -- Element change

	set_line (line_magnitude: INTEGER)
			-- Set `line' with `line_magnitude'.
		do
			{WEL_API}.send_message (item, Tbm_setlinesize, to_wparam (0), to_lparam (line_magnitude))
		end

	set_page (page_magnitude: INTEGER)
			-- Set `page' with `page_magnitude'.
		do
			{WEL_API}.send_message (item, Tbm_setpagesize, to_wparam (0), to_lparam (page_magnitude))
		end

	set_position (new_position: INTEGER)
			-- Set `position' with `new_position'
		do
			{WEL_API}.send_message (item, Tbm_setpos, to_wparam (1), to_lparam (new_position))
		end

	set_range (a_minimum, a_maximum: INTEGER)
			-- Set `minimum' and `maximum' with
			-- `a_minimum' and `a_maximum'
		do
				-- We do not use `Tbm_setrange' message as this limits
				-- our values to 2^16, instead of the full 32 bit INTEGER.
			{WEL_API}.send_message (item, Tbm_setrangemin, to_wparam (1), to_lparam (a_minimum))
			{WEL_API}.send_message (item, Tbm_setrangemax, to_wparam (1), to_lparam (a_maximum))
		end

	set_tick_mark (pos: INTEGER)
			-- Set a tick mark at `pos'.
		require
			exists: exists
			pos_large_enough: pos > minimum
			pos_small_enough: pos < maximum
		do
			{WEL_API}.send_message (item, Tbm_settic, to_wparam (0), to_lparam (pos))
		end

	clear_tick_marks
			-- Clear the current tick marks from the track bar.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Tbm_cleartics, to_wparam (1), to_lparam (0))
		end

feature {NONE} -- Implementation

	class_name: STRING_32
			-- Window class name to create
		once
			Result := (create {WEL_STRING}.share_from_pointer (cwin_trackbar_class)).string
		end

	default_style: INTEGER
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group + Ws_tabstop
		end

feature {NONE} -- Externals

	cwin_trackbar_class: POINTER
		external
			"C [macro <cctrl.h>] : EIF_POINTER"
		alias
			"TRACKBAR_CLASS"
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




end -- class WEL_TRACK_BAR

