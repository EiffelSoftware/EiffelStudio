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
			positive_page: page >= 0
		do
			window := a_window
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
			consistent_horizontal_range: a_minimal_horizontal_position < a_maximal_horizontal_position
			consistent_vertical_range: a_minimal_vertical_position < a_maximal_vertical_position
			positive_horizontal_line: a_horizontal_line >= 0
			positive_vertical_line: a_vertical_line >= 0
			positive_horizontal_page: a_horizontal_page >= 0
			positive_vertical_page: a_vertical_page >= 0
		do
			window := a_window
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
			minimal_horizontal_position_set: minimal_horizontal_position = a_minimal_horizontal_position
			maximal_horizontal_position_set: maximal_horizontal_position = a_maximal_horizontal_position
			minimal_vertical_position_set: minimal_vertical_position = a_minimal_vertical_position
			maximal_vertical_position_set: maximal_vertical_position = a_maximal_vertical_position
		end

feature -- Access

	window: WEL_COMPOSITE_WINDOW
			-- Window which has the scroller

	horizontal_line: INTEGER
			-- Number of horizontal scroll units per line

	horizontal_page: INTEGER
			-- Number of horizontal scroll units per page

	vertical_line: INTEGER
			-- Number of vertical scroll units per line

	vertical_page: INTEGER
			-- Number of vertical scroll units per page

	horizontal_position: INTEGER is
			-- Current position of the horizontal scroll box
		require
			window_exists: window.exists
		do
			Result := window.horizontal_position
		end

	vertical_position: INTEGER is
			-- Current position of the vertical scroll box
		require
			window_exists: window.exists
		do
			Result := window.vertical_position
		end

	minimal_horizontal_position: INTEGER is
			-- Minimum position of the horizontal scroll box
		require
			window_exists: window.exists
		do
			Result := window.minimal_horizontal_position
		end

	minimal_vertical_position: INTEGER is
			-- Minimum position of the vertical scroll box
		require
			window_exists: window.exists
		do
			Result := window.minimal_vertical_position
		end

	maximal_horizontal_position: INTEGER is
			-- Maxium position of the horizontal scroll box
		require
			window_exists: window.exists
		do
			Result := window.maximal_horizontal_position
		end

	maximal_vertical_position: INTEGER is
			-- Maxium position of the vertical scroll box
		require
			window_exists: window.exists
		do
			Result := window.maximal_vertical_position
		end

feature -- Element change

	set_horizontal_position (position: INTEGER) is
			-- Set `horizontal_position' with `position'.
		require
			window_exists: window.exists
			position_small_enough: position <= maximal_horizontal_position
			position_large_enough: position >= minimal_horizontal_position
		do
			window.set_horizontal_position (position)
		ensure
			horizontal_position_set: horizontal_position = position
		end

	set_vertical_position (position: INTEGER) is
			-- Set `vertical_position' with `position'.
		require
			window_exists: window.exists
			position_small_enough: position <= maximal_vertical_position
			position_large_enough: position >= minimal_vertical_position
		do
			window.set_vertical_position (position)
		ensure
			vertical_position_set: vertical_position = position
		end

	set_horizontal_range (minimum, maximum: INTEGER) is
			-- Set `horizontal_minimum_range' and
			-- `horizontal_maximal_range' with `minimum' and
			-- `maximum'.
		require
			window_exists: window.exists
			consistent_range: minimum < maximum
		do
			window.set_horizontal_range (minimum, maximum)
		ensure
			horizontal_minimum_range_set: minimal_horizontal_position = minimum
			horizontal_maximal_range_set: maximal_horizontal_position = maximum
		end

	set_vertical_range (minimum, maximum: INTEGER) is
			-- Set `minimal_vertical_position' and
			-- `maximal_vertical_position' with `minimum' and
			-- `maximum'.
		require
			window_exists: window.exists
			consistent_range: minimum < maximum
		do
			window.set_vertical_range (minimum, maximum)
		ensure
			minimal_vertical_position_set: minimal_vertical_position = minimum
			maximal_vertical_position_set: maximal_vertical_position = maximum
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

	set_horizontal_page (unit: INTEGER) is
			-- Set `horizontal_page' with `unit'.
		require
			positive_unit: unit >= 0
		do
			horizontal_page := unit
		ensure
			horizontal_page_set: horizontal_page = unit
		end

	set_vertical_page (unit: INTEGER) is
			-- Set `vertical_page' with `unit'.
		require
			positive_unit: unit >= 0
		do
			vertical_page := unit
		ensure
			vertical_page_set: vertical_page = unit
		end

feature -- Basic operations

	on_horizontal_scroll (scroll_code, position: INTEGER) is
			-- Scroll the window horizontaly.
		require
			window_exists: window.exists
		local
			inc: INTEGER
			pos: INTEGER
		do
			pos := horizontal_position
			if scroll_code = Sb_pagedown then
				inc := horizontal_page
				pos := pos + inc
			elseif scroll_code = Sb_pageup then
				inc := -horizontal_page
				pos := pos + inc
			elseif scroll_code = Sb_linedown then
				inc := horizontal_line
				pos := pos + inc
			elseif scroll_code = Sb_lineup then
				inc := -horizontal_line
				pos := pos + inc
			elseif scroll_code = Sb_thumbposition then
				inc := position - pos
				pos := position
			elseif scroll_code = Sb_thumbtrack then
				inc := position - pos
				pos := position
			end
			if pos > maximal_horizontal_position then
				pos := maximal_horizontal_position
			elseif pos < minimal_horizontal_position then
				pos := minimal_horizontal_position
			end
			if pos /= horizontal_position then
				horizontal_update (-inc, pos)
				debug ("scroll_position")
					print (pos)
					print ("=horizontal position%N")
				end
			end
		end

	on_vertical_scroll (scroll_code, position: INTEGER) is
			-- Scroll the window vertically.
		require
			window_exists: window.exists
		local
			inc: INTEGER
			pos: INTEGER
		do
			pos := vertical_position
			if scroll_code = Sb_pagedown then
				inc := vertical_page
				pos := pos + inc
			elseif scroll_code = Sb_pageup then
				inc := -vertical_page
				pos := pos + inc
			elseif scroll_code = Sb_linedown then
				inc := vertical_line
				pos := pos + inc
			elseif scroll_code = Sb_lineup then
				inc := -vertical_line
				pos := pos + inc
			elseif scroll_code = Sb_thumbposition then
				inc := position - pos
				pos := position
			elseif scroll_code = Sb_thumbtrack then
				inc := position - pos
				pos := position
			end
			if pos > maximal_vertical_position then
				pos := maximal_vertical_position
			elseif pos < minimal_vertical_position then
				pos := minimal_vertical_position
			end
			if pos /= vertical_position then
				vertical_update (-inc, pos)
				debug ("scroll_position")
					print (pos)
					print ("=vertical position%N")
				end
			end
		end

	horizontal_update (inc, position: INTEGER) is
			-- Update the window and the horizontal scroll box with
			-- `inc' and `position'.
		require
			window_exists: window.exists
			position_small_enough: position <= maximal_horizontal_position
			position_large_enough: position >= minimal_horizontal_position
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
			position_small_enough: position <= maximal_vertical_position
			position_large_enough: position >= minimal_vertical_position
		do
			window.vertical_update (inc, position)
		ensure
			vertical_position_set: vertical_position = position
		end

invariant

	window_not_void: window /= Void
	horizontal_position_small_enough: window.exists implies horizontal_position <= maximal_horizontal_position
	horizontal_position_large_enough: window.exists implies horizontal_position >= minimal_horizontal_position
	vertical_position_small_enough: window.exists implies vertical_position <= maximal_vertical_position
	vertical_position_large_enough: window.exists implies vertical_position >= minimal_vertical_position
	consistent_horizontal_range: window.exists implies minimal_horizontal_position < maximal_horizontal_position
	consistent_vertical_range: window.exists implies minimal_vertical_position < maximal_vertical_position
	positive_horizontal_line: horizontal_line >= 0
	positive_vertical_line: vertical_line >= 0
	positive_horizontal_page: horizontal_page >= 0
	positive_vertical_page: vertical_page >= 0

end -- class WEL_SCROLLER

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
