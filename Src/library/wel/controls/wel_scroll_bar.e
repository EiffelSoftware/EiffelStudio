indexing
	description: "A bar with a scroll box which indicates a position."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SCROLL_BAR

inherit
	WEL_BAR
		redefine
			on_size
		end

	WEL_SCROLL_BAR_CONSTANTS
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
			create scroll_info_struct.make
			set_line (Default_line_value)
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
			create scroll_info_struct.make
			is_horizontal := True
			set_line (Default_line_value)
		ensure
			parent_set: parent = a_parent
			exists: exists
			id_set: id = an_id
			position_equal_zero: position = 0
			minimum_equal_zero: minimum = 0
			maximum_equal_zero: maximum = 0
		end

feature -- Access

	is_horizontal: BOOLEAN
			-- Is current scrollbar an horizontal one?

	line: INTEGER
			-- Number of scroll units per line

	page: INTEGER is
			-- Number of scroll units per page
		do
			scroll_info_struct.set_mask (Sif_page)
			cwin_get_scroll_info (item, Sb_ctl, scroll_info_struct.item)
			Result := scroll_info_struct.page
		end

	position: INTEGER is
			-- Current position of the scroll box
		do
			scroll_info_struct.set_mask (Sif_pos)
			cwin_get_scroll_info (item, Sb_ctl, scroll_info_struct.item)
			Result := scroll_info_struct.position
		end

	minimum: INTEGER is
			-- Minimum position
		do
			scroll_info_struct.set_mask (Sif_range)
			cwin_get_scroll_info (item, Sb_ctl, scroll_info_struct.item)
			Result := scroll_info_struct.minimum
		end

	maximum: INTEGER is
			-- Maximum position
		do
			scroll_info_struct.set_mask (Sif_range)
			cwin_get_scroll_info (item, Sb_ctl, scroll_info_struct.item)
			Result := scroll_info_struct.maximum
		end

	background_color: WEL_COLOR_REF is
			-- Background color used for the background of the
			-- control
			-- Can be redefined by the user
		do
			create Result.make_system (color_scrollbar)
		end

feature -- Element change

	set_position (new_position: INTEGER) is
			-- Set `position' with `new_position'
		do
			scroll_info_struct.set_mask (Sif_pos)
			scroll_info_struct.set_position (new_position)
			cwin_set_scroll_info (item, Sb_ctl, scroll_info_struct.item, True)
		end

	set_range (a_minimum, a_maximum: INTEGER) is
			-- Set `minimum' and `maximum' with
			-- `a_minimum' and `a_maximum'
		do
			scroll_info_struct.set_mask (Sif_range)
			scroll_info_struct.set_minimum (a_minimum)
			scroll_info_struct.set_maximum (a_maximum)
			cwin_set_scroll_info (item, Sb_ctl, scroll_info_struct.item, True)
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
			positive_page: page_magnitude >= 0
		do
			scroll_info_struct.set_mask (Sif_page)
			scroll_info_struct.set_page (page_magnitude)
			cwin_set_scroll_info (item, Sb_ctl, scroll_info_struct.item, True)
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
			old_pos, new_pos: INTEGER
			min, max, p: INTEGER
		do
			if scroll_code /= Sb_endscroll then
				old_pos := position
				p := page
				min := minimum
				max := maximum
				if scroll_code = Sb_pagedown then
					new_pos := old_pos + p
				elseif scroll_code = Sb_pageup then
					new_pos := old_pos - p
				elseif scroll_code = Sb_linedown then
					new_pos := old_pos + line
				elseif scroll_code = Sb_lineup then
					new_pos := old_pos - line
				elseif scroll_code = Sb_thumbposition then
					new_pos := pos
				elseif scroll_code = Sb_thumbtrack then
					new_pos := pos
				elseif scroll_code = Sb_top then
					new_pos := min
				elseif scroll_code = Sb_bottom then
					new_pos := max - p + 1
				end
				if new_pos > max - p + 1 then
					new_pos := max - p + 1
				elseif new_pos < min then
					new_pos := min
				end

				set_position (new_pos)
			end
		end

	on_size (size_type, a_width, a_height: INTEGER) is
		do
			scroll_info_struct.set_mask (Sif_range + Sif_page)
			cwin_set_scroll_info (item, Sb_Ctl, scroll_info_struct.item, True)
		end

feature {NONE} -- Inapplicable

	foreground_color: WEL_COLOR_REF is
			-- Foreground color has no effect with SCROLL_BAR.
			-- Cannot be Void.
		do
			create Result.make_system (Color_windowtext)
		end

feature {NONE} -- Implementation

	Default_line_value: INTEGER is 1
			-- Default scroll units per line

	class_name: STRING is
			-- Window class name to create
		once
			Result := "SCROLLBAR"
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group
		end

	scroll_info_struct: WEL_SCROLL_BAR_INFO
		-- Associated SCROLLINFO struct to current toolbar.

feature {NONE} -- Externals

	cwin_set_scroll_info (hwnd: POINTER; direction: INTEGER; info: POINTER; redraw: BOOLEAN) is
		external
			"C [macro <windows.h>] (HWND, int, LPSCROLLINFO, BOOL)"
		alias
			"SetScrollInfo"
		end

	cwin_get_scroll_info (hwnd: POINTER; direction: INTEGER; info: POINTER) is
		external
			"C [macro <windows.h>] (HWND, int, LPSCROLLINFO)"
		alias
			"GetScrollInfo"
		end

invariant
	positive_line: line >= 0
	positive_page: page >= 0

end -- class WEL_SCROLL_BAR


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

