indexing
	description: "This class processes the scroll messages associated to %
		%a window."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SCROLLER

inherit
	WEL_SB_CONSTANTS
		export
			{NONE} all
		end

	WEL_SCROLL_BAR_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_with_options

feature -- Initialization

	make (a_window: WEL_COMPOSITE_WINDOW; horizontal_size,
			vertical_size, line, page: INTEGER) is
			-- Make a scroller associated to `a_window' using
			-- `horizontal_size' and `vertical_size' as the
			-- size of the scrollable area. `line' and `page'
			-- specify the scroll incrementation for a line and
			-- a page.
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
			positive_horizontal_size: horizontal_size > 0
			positive_vertical_size: vertical_size > 0
			positive_line: line >= 0
			valid_line: line < horizontal_size and then line < vertical_size
			positive_page: page >= 0
			valid_page: page < horizontal_size and then page < vertical_size
		do
			window := a_window
			window_item := a_window.item
			create scroll_info_struct.make
			set_horizontal_range (0, horizontal_size)
			set_vertical_range (0, vertical_size)
			set_horizontal_line (line)
			set_horizontal_page (page)
			set_vertical_line (line)
			set_vertical_page (page)
		ensure
			window_set: window = a_window
		end

	make_with_options (a_window: WEL_COMPOSITE_WINDOW;
			a_minimal_horizontal_position, a_maximal_horizontal_position,
			a_minimal_vertical_position, a_maximal_vertical_position,
			a_horizontal_line, a_horizontal_page, a_vertical_line,
			a_vertical_page: INTEGER) is
			-- Make a scroller associated to `a_window'.
			-- `a_minimal_horizontal_position' and
			-- `a_maximal_horizontal_position' specify the
			-- horizontal scroll range.
			-- `a_minimal_vertical_position' and
			-- `a_maximal_vertical_position' specify the
			-- vertical scroll range.
			-- `a_horizontal_line' and `a_horizontal_page' specify
			-- the scroll incrementation for a horizontal line and
			-- page.
			-- `a_vertical_line' and `a_vertical_page' specify
			-- the scroll incrementation for a vertical line and
			-- page.
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
			consistent_horizontal_range:
				a_minimal_horizontal_position < a_maximal_horizontal_position
			consistent_vertical_range:
				a_minimal_vertical_position < a_maximal_vertical_position
			positive_horizontal_line: a_horizontal_line >= 0
			positive_vertical_line: a_vertical_line >= 0
			positive_horizontal_page: a_horizontal_page >= 0
			positive_vertical_page: a_vertical_page >= 0
		do
			window := a_window
			window_item := a_window.item
			create scroll_info_struct.make
			set_horizontal_range (a_minimal_horizontal_position,
				a_maximal_horizontal_position)
			set_vertical_range (a_minimal_vertical_position,
				a_maximal_vertical_position)
			set_horizontal_line (a_horizontal_line)
			set_horizontal_page (a_horizontal_page)
			set_vertical_line (a_vertical_line)
			set_vertical_page (a_vertical_page)
		ensure
			window_set: window = a_window
			minimal_horizontal_position_set:
				minimal_horizontal_position = a_minimal_horizontal_position
			maximal_horizontal_position_set:
				maximal_horizontal_position = a_maximal_horizontal_position
			minimal_vertical_position_set:
				minimal_vertical_position = a_minimal_vertical_position
			maximal_vertical_position_set:
				maximal_vertical_position = a_maximal_vertical_position
		end

feature -- Access

	window: WEL_COMPOSITE_WINDOW
			-- Window which has the scroller

	horizontal_line: INTEGER
			-- Number of horizontal scroll units per line

	vertical_line: INTEGER
			-- Number of vertical scroll units per line

	horizontal_position: INTEGER is
			-- Current position of the horizontal scroll box
		require
			window_exists: window.exists
		do
			scroll_info_struct.set_mask (Sif_pos)
			cwin_get_scroll_info (window_item, Sb_horz, scroll_info_struct.item)
			Result := scroll_info_struct.position
		end

	vertical_position: INTEGER is
			-- Current position of the vertical scroll box
		require
			window_exists: window.exists
		do
			scroll_info_struct.set_mask (Sif_pos)
			cwin_get_scroll_info (window_item, Sb_vert, scroll_info_struct.item)
			Result := scroll_info_struct.position
		end

	horizontal_page: INTEGER is
			-- Number of scroll units per page
		require
			window_exists: window.exists
		do
			scroll_info_struct.set_mask (Sif_page)
			cwin_get_scroll_info (window_item, Sb_horz, scroll_info_struct.item)
			Result := scroll_info_struct.page
		end

	vertical_page: INTEGER is
			-- Number of scroll units per page
		require
			window_exists: window.exists
		do
			scroll_info_struct.set_mask (Sif_page)
			cwin_get_scroll_info (window_item, Sb_vert, scroll_info_struct.item)
			Result := scroll_info_struct.page
		end

	minimal_horizontal_position: INTEGER is
			-- Minimum position of the horizontal scroll box
		require
			window_exists: window.exists
		do
			scroll_info_struct.set_mask (Sif_range)
			cwin_get_scroll_info (window_item, Sb_horz, scroll_info_struct.item)
			Result := scroll_info_struct.minimum
		end

	minimal_vertical_position: INTEGER is
			-- Minimum position of the vertical scroll box
		require
			window_exists: window.exists
		do
			scroll_info_struct.set_mask (Sif_range)
			cwin_get_scroll_info (window_item, Sb_vert, scroll_info_struct.item)
			Result := scroll_info_struct.minimum
		end

	maximal_horizontal_position: INTEGER is
			-- Maxium position of the horizontal scroll box
		require
			window_exists: window.exists
		do
			scroll_info_struct.set_mask (Sif_range)
			cwin_get_scroll_info (window_item, Sb_horz, scroll_info_struct.item)
			Result := scroll_info_struct.maximum
		end

	maximal_vertical_position: INTEGER is
			-- Maxium position of the vertical scroll box
		require
			window_exists: window.exists
		do
			scroll_info_struct.set_mask (Sif_range)
			cwin_get_scroll_info (window_item, Sb_vert, scroll_info_struct.item)
			Result := scroll_info_struct.maximum
		end

feature -- Element change

	set_horizontal_position (position: INTEGER) is
			-- Set `horizontal_position' with `position'.
		require
			window_exists: window.exists
			position_small_enough:
				position <= maximal_horizontal_position
			position_large_enough:
				position >= minimal_horizontal_position
		do
			scroll_info_struct.set_mask (Sif_pos)
			scroll_info_struct.set_position (position)
			cwin_set_scroll_info (window_item, Sb_horz, scroll_info_struct.item, True)
		ensure
			horizontal_position_set: horizontal_position = position
		end

	set_vertical_position (position: INTEGER) is
			-- Set `vertical_position' with `position'.
		require
			window_exists: window.exists
			position_small_enough:
				position <= maximal_vertical_position
			position_large_enough:
				position >= minimal_vertical_position
		do
			scroll_info_struct.set_mask (Sif_pos)
			scroll_info_struct.set_position (position)
			cwin_set_scroll_info (window_item, Sb_vert, scroll_info_struct.item, True)
		ensure
			vertical_position_set: vertical_position = position
		end

	set_horizontal_range (minimum, maximum: INTEGER) is
			-- Set `horizontal_minimum_range' and
			-- `horizontal_maximal_range' with `minimum' and
			-- `maximum'.
		require
			window_exists: window.exists
			consistent_range: minimum <= maximum
		do
			scroll_info_struct.set_mask (Sif_range)
			scroll_info_struct.set_minimum (minimum)
			scroll_info_struct.set_maximum (maximum)
			cwin_set_scroll_info (window_item, Sb_horz, scroll_info_struct.item, True)
		ensure
			horizontal_minimum_range_set:
				minimal_horizontal_position = minimum
			horizontal_maximal_range_set:
				maximal_horizontal_position = maximum
		end

	set_vertical_range (minimum, maximum: INTEGER) is
			-- Set `minimal_vertical_position' and
			-- `maximal_vertical_position' with `minimum' and
			-- `maximum'.
		require
			window_exists: window.exists
			consistent_range: minimum <= maximum
		do
			scroll_info_struct.set_mask (Sif_range)
			scroll_info_struct.set_minimum (minimum)
			scroll_info_struct.set_maximum (maximum)
			cwin_set_scroll_info (window_item, Sb_vert, scroll_info_struct.item, True)
		ensure
			minimal_vertical_position_set:
				minimal_vertical_position = minimum
			maximal_vertical_position_set:
				maximal_vertical_position = maximum
		end

	set_horizontal_line (unit: INTEGER) is
			-- Set `horizontal_line' with `unit'.
		require
			positive_unit: unit >= 0
		do
			horizontal_line := unit
		ensure
			horizontal_line_set: horizontal_line = unit
		end

	set_vertical_line (unit: INTEGER) is
			-- Set `vertical_line' with `unit'.
		require
			positive_unit: unit >= 0
		do
			vertical_line := unit
		ensure
			vertical_line_set: vertical_line = unit
		end

	set_horizontal_page (page_magnitude: INTEGER) is
			-- Set `horizontal_page' with `unit'.
		require
			window_exists: window.exists
			positive_unit: page_magnitude >= 0
		do
			scroll_info_struct.set_mask (Sif_page)
			scroll_info_struct.set_page (page_magnitude)
			cwin_set_scroll_info (window_item, Sb_horz, scroll_info_struct.item, True)
		ensure
			horizontal_page_set: horizontal_page = page_magnitude
		end

	set_vertical_page (page_magnitude: INTEGER) is
			-- Set `vertical_page' with `unit'.
		require
			window_exists: window.exists
			positive_unit: page_magnitude >= 0
		do
			scroll_info_struct.set_mask (Sif_page)
			scroll_info_struct.set_page (page_magnitude)
			cwin_set_scroll_info (window_item, Sb_vert, scroll_info_struct.item, True)
		ensure
			vertical_page_set: vertical_page = page_magnitude
		end

feature -- Basic operations

	on_horizontal_scroll (scroll_code, pos: INTEGER) is
			-- Scroll the window horizontaly.
		require
			window_exists: window.exists
		local
			old_pos, new_pos: INTEGER
			min, max, p: INTEGER
			inc: INTEGER
		do
			old_pos := horizontal_position
			p := horizontal_page
			min := minimal_horizontal_position
			max := maximal_horizontal_position
			if scroll_code = Sb_pagedown then
				inc := p
				new_pos := old_pos + inc
			elseif scroll_code = Sb_pageup then
				inc := -p
				new_pos := old_pos + inc
			elseif scroll_code = Sb_linedown then
				inc := horizontal_line
				new_pos := old_pos + inc
			elseif scroll_code = Sb_lineup then
				inc := -horizontal_line
				new_pos := old_pos + inc
			elseif scroll_code = Sb_thumbposition then
				inc := pos - old_pos
				new_pos := pos
			elseif scroll_code = Sb_thumbtrack then
				inc := pos - old_pos
				new_pos := pos
			elseif scroll_code = Sb_top then
				new_pos := min
			elseif scroll_code = Sb_bottom then
				new_pos := max - p + 1
			else
				check
					code_is_sb_endscroll: scroll_code = Sb_endscroll
				end
					-- End of scrolling, keep the previous position
				new_pos := old_pos
			end
			if new_pos > max - p + 1 then
				new_pos := max - p + 1
				inc := new_pos - old_pos
			elseif new_pos < min then
				new_pos := min
				inc := new_pos - old_pos
			end

			if old_pos /= new_pos then
				horizontal_update (-inc, new_pos)
			end
		end

	on_vertical_scroll (scroll_code, pos: INTEGER) is
			-- Scroll the window verticaly.
		require
			window_exists: window.exists
		local
			old_pos, new_pos: INTEGER
			min, max, p: INTEGER
			inc: INTEGER
		do
			old_pos := vertical_position
			p := vertical_page
			min := minimal_vertical_position
			max := maximal_vertical_position
			if scroll_code = Sb_pagedown then
				inc := p
				new_pos := old_pos + inc
			elseif scroll_code = Sb_pageup then
				inc := -p
				new_pos := old_pos + inc
			elseif scroll_code = Sb_linedown then
				inc := vertical_line
				new_pos := old_pos + inc
			elseif scroll_code = Sb_lineup then
				inc := -vertical_line
				new_pos := old_pos + inc
			elseif scroll_code = Sb_thumbposition then
				inc := pos - old_pos
				new_pos := pos
			elseif scroll_code = Sb_thumbtrack then
				inc := pos - old_pos
				new_pos := pos
			elseif scroll_code = Sb_top then
				new_pos := min
			elseif scroll_code = Sb_bottom then
				new_pos := max - p + 1
			else
				check
					code_is_sb_endscroll: scroll_code = Sb_endscroll
				end
					-- End of scrolling, keep the previous position
				new_pos := old_pos
			end
			if new_pos > max - p + 1 then
				new_pos := max - p + 1
				inc := new_pos - old_pos
			elseif new_pos < min then
				new_pos := min
				inc := new_pos - old_pos
			end

			if old_pos /= new_pos then
				vertical_update (-inc, new_pos)
			end
		end

	horizontal_update (inc, position: INTEGER) is
			-- Update the window and the horizontal scroll box with
			-- `inc' and `position'.
		require
			window_exists: window.exists
			position_small_enough:
				position <= maximal_horizontal_position
			position_large_enough:
				position >= minimal_horizontal_position
		do
			window.horizontal_update (inc, position)
		ensure
			horizontal_position_set: horizontal_position = position
		end

	vertical_update (inc, position: INTEGER) is
			-- Update the window and the vertical scroll box with
			-- `inc' and `position'.
		require
			window_exists: window.exists
			position_small_enough:
				position <= maximal_vertical_position
			position_large_enough:
				position >= minimal_vertical_position
		do
			window.vertical_update (inc, position)
		ensure
			vertical_position_set: vertical_position = position
		end

feature {NONE} -- Implementation

	window_item: POINTER
			-- Handle of `window' for fast access.

	scroll_info_struct: WEL_SCROLL_BAR_INFO
		-- Associated SCROLLINFO struct to current scrollbars.

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

	window_not_void: window /= Void
	horizontal_position_small_enough:
		window.exists implies
		horizontal_position <= maximal_horizontal_position
	horizontal_position_large_enough:
		window.exists implies
		horizontal_position >= minimal_horizontal_position
	vertical_position_small_enough:
		window.exists implies
		vertical_position <= maximal_vertical_position
	vertical_position_large_enough:
		window.exists implies
		vertical_position >= minimal_vertical_position
	consistent_horizontal_range:
		window.exists implies
		minimal_horizontal_position <= maximal_horizontal_position
	consistent_vertical_range:
		window.exists implies
		minimal_vertical_position <= maximal_vertical_position
	positive_horizontal_line: horizontal_line >= 0
	positive_vertical_line: vertical_line >= 0
	positive_horizontal_page: horizontal_page >= 0
	positive_vertical_page: vertical_page >= 0

end -- class WEL_SCROLLER


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

