indexing
	description: "Contains a slider which indicates a position."
	note: "The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to %
		% be loaded to use this control."
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
	make_horizontal

feature {NONE} -- Initialization

	make_vertical (a_parent: WEL_COMPOSITE_WINDOW; a_x, a_y, a_width,
			a_height, an_id: INTEGER) is
			-- Make a vertical track bar.
		require
			a_parent_not_void: a_parent /= Void
			a_width_small_enough: a_width <= maximal_width
			a_width_large_enough: a_width >= minimal_width
			a_height_small_enough: a_height <= maximal_height
			a_height_large_enough: a_height >= minimal_height
		do
			internal_window_make (a_parent, Void,
				default_style + Tbs_vert,
				a_x, a_y, a_width, a_height, an_id,
				default_pointer)
			id := an_id
		ensure
			parent_set: parent = a_parent
			exists: exists
			id_set: id = an_id
			position_equal_zero: position = 0
			minimum_equal_zero: minimum = 0
			maximum_equal_zero: maximum = 0
		end

	make_horizontal (a_parent: WEL_COMPOSITE_WINDOW; a_x, a_y, a_width,
			a_height, an_id: INTEGER) is
			-- Make a horizontal track bar.
		require
			a_parent_not_void: a_parent /= Void
			width_large_enough: a_width >= minimal_width
			height_large_enough: a_height >= minimal_height
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
			minimum_equal_zero: minimum = 0
			maximum_equal_zero: maximum = 0
		end

feature -- Access

	position: INTEGER is
			-- Current position
		do
			Result := cwin_send_message_result (item, Tbm_getpos,
				0, 0)
		end

	minimum: INTEGER is
			-- Maximum position
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

feature -- Element change

	set_position (new_position: INTEGER) is
			-- Set `position' with `new_position'
		do
			cwin_send_message (item,  Tbm_setpos, 1,
				new_position)
		end

	set_range (a_minimum, a_maximum: INTEGER) is
			-- Set `minimum' and `maximum' with
			-- `a_minimum' and `a_maximum'
		do
			cwin_send_message (item, Tbm_setrange, 1,
				cwin_make_long (a_minimum, a_maximum))
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			!! Result.make (0)
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
			"C [macro <cctrl.h>]"
		alias
			"TRACKBAR_CLASS"
		end

end -- class WEL_TRACK_BAR

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
