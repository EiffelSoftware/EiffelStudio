indexing
	description: "A bar with a scroll box which indicates a position."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SCROLL_BAR

inherit
	WEL_BAR

	WEL_SB_CONSTANTS
		export
			{NONE} all
		end

	WEL_SBS_CONSTANTS
		export
			{NONE} all
		end

creation
	make_vertical,
	make_horizontal

feature {NONE} -- Initialization

	make_vertical (a_parent: WEL_COMPOSITE_WINDOW;
			a_x, a_y, a_width, a_height, an_id: INTEGER) is
			-- Make a vertical scroll bar.
		require
			a_parent_not_void: a_parent /= Void
			a_width_small_enough: a_width <= maximal_width
			a_width_large_enough: a_width >= minimal_width
			a_height_small_enough: a_height <= maximal_height
			a_height_large_enough: a_height >= minimal_height
		do
			internal_window_make (a_parent, Void,
				default_style + Sbs_vert,
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

	make_horizontal (a_parent: WEL_COMPOSITE_WINDOW;
			a_x, a_y, a_width, a_height, an_id: INTEGER) is
			-- Make a horizontal scroll bar.
		require
			a_parent_not_void: a_parent /= Void
			width_large_enough: a_width >= minimal_width
			height_large_enough: a_height >= minimal_height
		do
			internal_window_make (a_parent, Void,
				default_style + Sbs_horz,
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
			-- Current position of the scroll box
		do
			Result := cwin_get_scroll_pos (item, Sb_ctl)
		end

	minimum: INTEGER is
			-- Maximum position
		local
			min, max: INTEGER
		do
			cwin_get_scroll_range (item, Sb_ctl, $min, $max)
			Result := min
		end

	maximum: INTEGER is
			-- Maximum position
		local
			min, max: INTEGER
		do
			cwin_get_scroll_range (item, Sb_ctl, $min, $max)
			Result := max
		end

feature -- Element change

	set_position (new_position: INTEGER) is
			-- Set `position' with `new_position'
		do
			cwin_set_scroll_pos (item, Sb_ctl, new_position, True)
		end

	set_range (a_minimum, a_maximum: INTEGER) is
			-- Set `minimum' and `maximum' with
			-- `a_minimum' and `a_maximum'
		do
			cwin_set_scroll_range (item, Sb_ctl,
				a_minimum, a_maximum, True)
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			Result := "SCROLLBAR"
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group + Ws_tabstop
		end

feature {NONE} -- Externals

	cwin_set_scroll_pos (hwnd: POINTER; flag, a_position: INTEGER;
			redraw: BOOLEAN) is
			-- SDK SetScrollPos
		external
			"C [macro <wel.h>] (HWND, int, int, BOOL)"
		alias
			"SetScrollPos"
		end

	cwin_set_scroll_range (hwnd: POINTER; flag, min, max: INTEGER;
			redraw: BOOLEAN) is
			-- SDK SetScrollRange
		external
			"C [macro <wel.h>] (HWND, int, int, int, BOOL)"
		alias
			"SetScrollRange"
		end

	cwin_get_scroll_pos (hwnd: POINTER; flag: INTEGER): INTEGER is
			-- SDK GetScrollPos
		external
			"C [macro <wel.h>] (HWND, int): EIF_INTEGER"
		alias
			"GetScrollPos"
		end

	cwin_get_scroll_range (hwnd: POINTER; flag: INTEGER;
			min, max: POINTER) is
			-- SDK GetScrollRange
		external
			"C [macro <wel.h>] (HWND, int, LPINT, LPINT)"
		alias
			"GetScrollRange"
		end

end -- class WEL_SCROLL_BAR

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
