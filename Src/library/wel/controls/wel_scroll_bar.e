indexing
	description: "A bar with a scroll box which indicates a position."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SCROLL_BAR

inherit
	WEL_BAR

	WEL_SBS_CONSTANTS
		export
			{NONE} all
		end

	WEL_COLOR_CONTROL

creation
	make_vertical,
	make_horizontal,
	make_by_id

feature {NONE} -- Initialization

	make_vertical (a_parent: WEL_WINDOW;
			a_x, a_y, a_width, a_height, an_id: INTEGER) is
			-- Make a vertical scroll bar.
		require
			a_parent_not_void: a_parent /= Void
		do
			internal_window_make (a_parent, Void,
				default_style + Sbs_vert,
				a_x, a_y, a_width, a_height, an_id,
				default_pointer)
			id := an_id
			set_line (Default_line_value)
			set_page (Default_page_value)
		ensure
			parent_set: parent = a_parent
			exists: exists
			id_set: id = an_id
			position_equal_zero: position = 0
			minimum_equal_zero: minimum = 0
			maximum_equal_zero: maximum = 0
		end

	make_horizontal (a_parent: WEL_WINDOW;
			a_x, a_y, a_width, a_height, an_id: INTEGER) is
			-- Make a horizontal scroll bar.
		require
			a_parent_not_void: a_parent /= Void
		do
			internal_window_make (a_parent, Void,
				default_style + Sbs_horz,
				a_x, a_y, a_width, a_height, an_id,
				default_pointer)
			id := an_id
			set_line (Default_line_value)
			set_page (Default_page_value)
		ensure
			parent_set: parent = a_parent
			exists: exists
			id_set: id = an_id
			position_equal_zero: position = 0
			minimum_equal_zero: minimum = 0
			maximum_equal_zero: maximum = 0
		end

feature -- Access

	line: INTEGER
			-- Number of scroll units per line

	page: INTEGER
			-- Number of scroll units per page

	position: INTEGER is
			-- Current position of the scroll box
		do
			Result := cwin_get_scroll_pos (item, Sb_ctl)
		end

	minimum: INTEGER is
			-- Minimum position
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

	background_color: WEL_COLOR_REF is
			-- Background color used for the background of the
			-- control
			-- Can be redefined by the user
		do
			!! Result.make_system (Color_scrollbar)
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

	set_line (line_magnitude: INTEGER) is
			-- Set `line' with `line_magnitude'.
		require
			positive_line: line >= 0
		do
			line := line_magnitude
		ensure
			line_set: line = line_magnitude
		end

	set_page (page_magnitude: INTEGER) is
			-- Set `page' with `page_magnitude'.
		require
			positive_page: page >= 0
		do
			page := page_magnitude
		ensure
			page_set: page = page_magnitude
		end

feature -- Basic operations

	on_scroll (scroll_code, pos: INTEGER) is
			-- Process the scroll messages.
			-- Typically, this routine will be called from
			-- `on_vertical_scroll_control' or
			-- `on_horizontal_scroll_control' of the parent window.
		require
			exists: exists
		local
			new_pos: INTEGER
		do
			new_pos := position
			if scroll_code = Sb_pagedown then
				new_pos := new_pos + page
			elseif scroll_code = Sb_pageup then
				new_pos := new_pos - page
			elseif scroll_code = Sb_linedown then
				new_pos := new_pos + line
			elseif scroll_code = Sb_lineup then
				new_pos := new_pos - line
			elseif scroll_code = Sb_thumbposition then
				new_pos := pos
			elseif scroll_code = Sb_thumbtrack then
				new_pos := pos
			elseif scroll_code = Sb_top then
				new_pos := minimum
			elseif scroll_code = Sb_bottom then
				new_pos := maximum
			end
			if new_pos > maximum then
				new_pos := maximum
			elseif new_pos < minimum then
				new_pos := minimum
			end
			set_position (new_pos)
		end

feature {NONE} -- Inapplicable

	foreground_color: WEL_COLOR_REF is
			-- Foreground color has no effect with SCROLL_BAR.
			-- Cannot be Void.
		do
			!! Result.make_system (Color_windowtext)
		end

feature {NONE} -- Implementation

	Default_line_value: INTEGER is 1
			-- Default scroll units per line

	Default_page_value: INTEGER is 20
			-- Default scroll units per page

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

invariant
	positive_line: line >= 0
	positive_page: page >= 0

end -- class WEL_SCROLL_BAR

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

