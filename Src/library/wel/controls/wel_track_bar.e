indexing
	description: "Control that displays a slider and optional tick marks."
	note: "The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to %
		%be loaded to use this control."
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

creation
	make_vertical,
	make_horizontal,
	make_by_id

feature {NONE} -- Initialization

	make_vertical (a_parent: WEL_WINDOW; a_x, a_y, a_width,
			a_height, an_id: INTEGER) is
			-- Make a vertical track bar.
		require
			a_parent_not_void: a_parent /= Void
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
			a_height, an_id: INTEGER) is
			-- Make a horizontal track bar.
		require
			a_parent_not_void: a_parent /= Void
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

	line: INTEGER is
			-- Number of scroll units per line
			-- Used when the user use the arrow keys.
		do
			Result := cwin_send_message_result (item,
					Tbm_getlinesize, 0, 0)
		end

	page: INTEGER is
			-- Number of scroll units per page
			-- Used when the user use the page-up,
			-- page down key or click on the range.
		do
			Result := cwin_send_message_result (item,
					Tbm_getpagesize, 0, 0)
		end

	position: INTEGER is
			-- Current position
		do
			Result := cwin_send_message_result (item, Tbm_getpos,
				0, 0)
		end

	minimum: INTEGER is
			-- Minimum position
		do
			Result := cwin_send_message_result (item,
				Tbm_getrangemin, 0, 0)
		end

	maximum: INTEGER is
			-- Maximum position
		do
			Result := cwin_send_message_result (item,
				Tbm_getrangemax, 0, 0)
		end

	tick_mark_position (index: INTEGER): INTEGER is
			-- Tick mark position at the zero-based `index'
		require
			exists: exists
			valid_index: valid_index (index)
		do
			Result := cwin_send_message_result (item, Tbm_gettic,
				index, 0)
		ensure
			positive_result: Result >= 0
		end

feature -- Status report

	valid_index (index: INTEGER): BOOLEAN is
			-- Is `index' valid?
		require
			exists: exists
		do
			Result := index >= 0 and then
				cwin_send_message_result (item, Tbm_gettic,
				index, 0) /= -1
		end

feature -- Element change

	set_line (line_magnitude: INTEGER) is
			-- Set `line' with `line_magnitude'.
		do
			cwin_send_message (item, Tbm_setlinesize,
				0, line_magnitude)
		end

	set_page (page_magnitude: INTEGER) is
			-- Set `page' with `page_magnitude'.
		do
			cwin_send_message (item, Tbm_setpagesize,
				0, page_magnitude)
		end

	set_position (new_position: INTEGER) is
			-- Set `position' with `new_position'
		do
			cwin_send_message (item, Tbm_setpos, 1, new_position)
		end

	set_range (a_minimum, a_maximum: INTEGER) is
			-- Set `minimum' and `maximum' with
			-- `a_minimum' and `a_maximum'
		do
			cwin_send_message (item, Tbm_setrange, 1,
				cwin_make_long (a_minimum, a_maximum))
		end

	set_tick_mark (pos: INTEGER) is
			-- Set a tick mark at `pos'.
		require
			exists: exists
			pos_large_enough: pos > minimum
			pos_small_enough: pos < maximum
		do
			cwin_send_message (item, Tbm_settic, 0, pos)
		end

	clear_tick_marks is
			-- Clear the current tick marks from the track bar.
		require
			exists: exists
		do
			cwin_send_message (item, Tbm_cleartics, 1, 0)
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			create Result.make (0)
			Result.from_c (cwin_trackbar_class)
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group + Ws_tabstop
		end

feature {NONE} -- Externals

	cwin_trackbar_class: POINTER is
		external
			"C [macro <cctrl.h>] : EIF_POINTER"
		alias
			"TRACKBAR_CLASS"
		end

end -- class WEL_TRACK_BAR


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

