indexing
	description:
		"Contains two widgets either side of an adjustable separator."
	status: "See notice at end of class"
	keywords: "container, split, devide"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SPLIT_AREA

inherit
	EV_CONTAINER
		rename
			implementation as ev_container_implementation,
			item as ev_container_item
		export
			{NONE} fill
		undefine
			extend,
			put
		redefine
			replace,
			client_height,
			client_width,
			initialize,
			merge_radio_button_groups
		end

	EV_WIDGET
		redefine
			implementation,
			create_implementation,
			initialize
		select
			implementation
		end

	FIXED [EV_WIDGET]
		undefine
			default_create,
			changeable_comparison_criterion
		end

feature {NONE} -- Initialization

	initialize is
			--|FIXME comment
		do
			check
				split_box_not_void: split_box /= Void
				sep_not_void: sep /= Void
				-- This function should be called after init
				-- of vertical/horizontal split area.
			end
			{EV_WIDGET} Precursor
			create scr
			scr.set_line_width (3)
			scr.set_invert_mode
			sep.set_minimum_height (8)
			sep.set_minimum_width (8)
			create first_cell
			split_box.extend (first_cell)
			split_box.extend (sep)
			split_box.disable_item_expand (sep)
			create second_cell
			split_box.extend (second_cell)
			implementation.box.extend (split_box)
			first_cell.merge_radio_button_groups (second_cell)
			previous_split_position := -1
			sep.pointer_button_press_actions.extend (~on_click)
		end

feature -- Access

	item: EV_WIDGET is
			-- Item at current position.
		require
			readable: readable
		do
			if index = 1 then
				Result := first_cell.item
			elseif index = 2 then
				Result := second_cell.item
			end
		ensure
			not_void: Result /= Void
		end

	first: EV_WIDGET is
			-- First item.
		do
			if first_cell.readable then
				Result := first_cell.item
			end
		end

	second: EV_WIDGET is
			-- Second item.
		do
			if second_cell.readable then
				Result := second_cell.item
			end
		end

	go_to_first is
			-- Make `first' current `item'.
		require
			first_exists: count >= 1
		do
			index := 1
		ensure
			item_is_first: item = first
		end

	go_to_second is
			-- Make `first' current `item'.
		require
			second_exists: count >= 2
		do
			index := 2
		ensure
			item_is_second: item = second
		end

	has (v: like item): BOOLEAN is
			-- Does structure include `v'?
		do
			Result := first_cell.has (v) or second_cell.has (v)
		end

feature -- Status report

	count: INTEGER is
			-- Number of items.
		do
			if first_cell.readable then
				Result := 1
				if second_cell.readable then
					Result := 2
				end
			end
		end

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
			if index = 1 then
				Result := first_cell.readable
			elseif index = 2 then
				Result := second_cell.readable
			end
		end

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		do
			Result := item /= Void
		end

	extendible: BOOLEAN is
			-- Items may be added.
		do
			Result := first = Void or second = Void
		end

	prunable: BOOLEAN is True
			-- Items may be removed.

	split_position: INTEGER is
			-- Offset of the splitter from left or top.
		do
			Result := select_from (first_cell.width, first_cell.height)
		ensure
			result_large_enough: Result >= minimum_split_position
			result_small_enough: Result <= maximum_split_position
		end

	minimum_split_position: INTEGER is
			-- Minimum position the splitter can have.
		do
			if first_cell.readable then
				Result := select_from (first.minimum_width,
					first.minimum_height)
			else
				Result := 1
			end
		ensure
			positive_value: Result >= 0
			coherent_position: Result <= maximum_split_position
		end

	maximum_split_position: INTEGER is
			-- Maximum position the splitter can have.
		local
			sec_item_min_size: INTEGER
		do
			if second_cell.readable /= Void then
				sec_item_min_size := select_from (
					first.minimum_width,
					first.minimum_height)
			else
				sec_item_min_size := 1
			end
			Result := select_from (split_box.width, split_box.height) -
				select_from (sep.width, sep.height) - sec_item_min_size
		ensure
			positive_value: Result >= 0
			coherent_position: Result >= minimum_split_position
		end

feature -- Measurement

	client_width: INTEGER is
			-- Width of the client area of container.
		do
			Result := implementation.box.client_width
		end

	client_height: INTEGER is
			-- Height of the client area of container.
		do
			Result := implementation.box.client_height
		end

	capacity: INTEGER is 2
			-- Number of items that may be stored.

feature -- Element change

	put, extend (an_item: like item) is
			-- Assign `an_item' to `first_item' if not already assigned or to
			-- `second_item' otherwise.
		do
			if an_item.parent /= Void then
				an_item.parent.prune_all (an_item)
			end
			if first_cell.empty then
				first_cell.put (an_item)
			else 
				second_cell.put (an_item)
			end
		ensure then
			first_item_used_first:
				old first  = Void implies first = an_item
			second_item_used_second:
				old first /= Void implies second = an_item
			has_an_item: has (an_item)
		end

	replace (an_item: like item) is
			-- Replace `item' with `v'.
		do
			if item = second then
				second_cell.replace (an_item)
			else
				first_cell.replace (an_item)
			end
		end

	set_first (an_item: like item) is
			-- Assign `an_item' to `first'.
		require
			an_item_not_void: an_item /= Void
			not_has_an_item: not has (an_item)
		do
			first_cell.put (an_item)
		ensure
			an_item_assigned: first = an_item
		end
		
	set_second (an_item: like item) is
			-- Assign `an_item' to `second'.
		require
			an_item_not_void: an_item /= Void
			not_has_an_item: not has (an_item)
		do
			second_cell.put (an_item)
		ensure
			an_item_assigned: second = an_item
		end	

feature -- Status setting

	merge_radio_button_groups (other: EV_CONTAINER) is
			-- Merge `Current' radio button group with that of `other'.
		do
			first_cell.merge_radio_button_groups (other)
		end

	set_split_position (a_split_position: INTEGER) is
			-- Make `a_split_position' the position of the splitter in pixels.
		require
			position_in_valid_range:
				(a_split_position >= minimum_split_position
				and a_split_position <= maximum_split_position)
		local
			fcd, scd: INTEGER
		do
			fcd := a_split_position
			scd := select_from (split_box.width, split_box.height) -
				select_from (sep.width, sep.height) - a_split_position
			if a_split_position < first_cell.height then
				set_first_cell_dimension (fcd)
				set_second_cell_dimension (scd)
			elseif a_split_position > first_cell.height then
				set_second_cell_dimension (scd)
				set_first_cell_dimension (fcd)
			end
		ensure
			--split_position = a_split_position
--| FIXME IEK This doesn't always hold true as GTK may not resize the
--| split area immediately, this is true when shrinking min size of first cell.
		end

	set_proportion (a_proportion: REAL) is
			--|FIXME reword this! 
			-- Move the separator position to be relative to the size of the
			-- split area 0.5 = middle of split area, providing the user can do
			-- this manually anyway. A value of 1 will move the separator to
			-- its upmost position, zero its smallest.
		require
			proportion_in_valid_range:
				(a_proportion >= 0 and a_proportion <= 1)
		local
			current_proportion: INTEGER	
		do
			current_proportion := (a_proportion *
				select_from (split_box.width, split_box.height)).rounded
			if current_proportion < minimum_split_position then
				set_split_position (minimum_split_position)
			elseif current_proportion > maximum_split_position then
				set_split_position (maximum_split_position)
			else
				set_split_position (current_proportion)
			end	
		end

feature -- Removal

	prune (v: like item) is
			-- Remove one occurrence of `v' if any.
		do
			first_cell.prune (v)
			second_cell.prune (v)
		end

	wipe_out is
			-- Remove all items.
		do
			first_cell.wipe_out
			second_cell.wipe_out
		end

feature -- Conversion

	linear_representation: LINEAR [like item] is
			-- Representation as a linear structure
		local
			l: LINKED_LIST [like item]
		do
			create l.make
			l.extend (first)
			l.extend (second)
			Result := l
		end

feature {NONE} -- Implementation

	select_from (a_hor, a_vert: INTEGER): INTEGER is
			-- Return either `a_hor' or `a_vert'.
			--| EV_HORIZONTAL_SPLIT_AREA returns `a_hor'.
			--| EV_VERTICAL_SPLIT_AREA returns `a_vert'.
		deferred
		end

	set_first_cell_dimension (a_size: INTEGER) is
			-- Set either width or height of first_cell.
		deferred
		end

	set_second_cell_dimension (a_size: INTEGER) is
			-- Set either width or height of second_cell.
		deferred
		end
	
feature {NONE} -- Implementation

	splitter_position_from_screen_x_or_y (a_x, a_y: INTEGER): INTEGER is
			-- Return splitter position given screen `a_y'.
		do
			Result := select_from (a_x, a_y) - offset -
				select_from (x_origin, y_origin)
			if Result < minimum_split_position then
				Result := minimum_split_position
			elseif Result > maximum_split_position then
				Result := maximum_split_position
			end
		end

	offset: INTEGER
			-- Horizontal or vertical offset where the user
			-- clicked on the separator.

	x_origin: INTEGER
			-- Horizontal screen offset of `Current'.

	y_origin: INTEGER
			-- Vertical screen offset of `Current'.

	half_sep_dimension: INTEGER
			-- Width or height of separator divided by 2.

	on_click (a_x, a_y, e: INTEGER; f, g, h: DOUBLE; scr_x, scr_y: INTEGER) is
			-- Start of the drag.
		local
			origin: TUPLE [INTEGER, INTEGER]
		do
			half_sep_dimension := select_from (sep.width, sep.height) // 2
			offset := select_from (a_x, a_y)
			x_origin := select_from (
				scr_x - a_x - first_cell.width,
				scr_x - a_x)
			y_origin := select_from (
				scr_y - a_y,
				scr_y - a_y - first_cell.height)
			sep.enable_capture
			sep.pointer_motion_actions.extend (~on_motion)
			sep.pointer_button_release_actions.extend (~on_release)
			draw_line (splitter_position_from_screen_x_or_y (scr_x, scr_y))
		end

	on_motion (a_x, a_y: INTEGER; f, g, h: DOUBLE; scr_x, scr_y: INTEGER) is
			-- Draw separator line.
		local
			new_pos: INTEGER
		do
			new_pos := splitter_position_from_screen_x_or_y (scr_x, scr_y)
			if new_pos /= previous_split_position then
				remove_line
				draw_line (new_pos)
			end
		end

	on_release (a_x, a_y, e: INTEGER; f, g, h: DOUBLE; scr_x, scr_y: INTEGER) is
			-- End of the drag.
		do
			remove_line
			set_split_position (
				splitter_position_from_screen_x_or_y (scr_x, scr_y)
			)
			sep.disable_capture
			sep.pointer_motion_actions.wipe_out
			sep.pointer_button_release_actions.wipe_out
		end

feature {NONE} -- Implementation

	remove_line is
			-- Remove previously drawn line by redrawing it over the old one.
		do
			if previous_split_position >= 0 then
				draw_line (previous_split_position)
				previous_split_position := -1
			end
		end

	draw_line (a_position: INTEGER) is
			-- Draw line on `a_position'.
		do
			scr.draw_segment (
				select_from (
					a_position + x_origin + half_sep_dimension,
					x_origin
				),
				select_from (
					y_origin,
					a_position + y_origin + half_sep_dimension
				),
				select_from (
					a_position + x_origin + half_sep_dimension,
					x_origin + sep.width
				),
				select_from (
					y_origin + sep.height,
					a_position + y_origin + half_sep_dimension
				)
			)
			previous_split_position := a_position
		end

feature {NONE} -- Implementation

	index: INTEGER
			-- Current cursor position.

	previous_split_position: INTEGER
		-- Previous split_position.

	first_cell, second_cell: EV_CELL
		-- Two client areas.

	split_box: EV_BOX
		-- Contains `first_cell', a seperator and `second_cell'.

	sep: EV_SEPARATOR
		-- Separator used to split between the two items.

	scr: EV_SCREEN
		-- Used for drawing guideline on screen.

	implementation: EV_AGGREGATE_WIDGET_I
			-- Responsible for interaction with the native graphics toolkit.

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_AGGREGATE_WIDGET_IMP} implementation.make (Current)
		end

invariant
	split_box_not_void: is_useable implies split_box /= Void
	separator_not_void: is_useable implies sep /= Void
	first_cell_not_void: is_useable implies first_cell /= Void
	second_cell_not_void: is_useable implies second_cell /= Void
	split_box_has_three_items: is_useable implies split_box.count = 3
	split_box_first_is_first_cell:
		is_useable implies split_box.first = first_cell
	split_box_last_is_second_cell:
		is_useable implies split_box.last = second_cell

end -- class EV_SPLIT_AREA

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.26  2000/03/18 00:52:23  oconnor
--| formatting, layout and comment tweaks
--|
--| Revision 1.25  2000/03/09 16:12:24  brendel
--| Replaced obsolete call width disable_item_expand.
--|
--| Revision 1.24  2000/03/06 20:39:10  brendel
--| Modified implementation of set_split_position to calculate the new sizes
--| before setting any of them.
--|
--| Revision 1.23  2000/03/06 20:22:12  brendel
--| Moved location of 1/2 sep. width calculation.
--|
--| Revision 1.22  2000/03/06 19:50:12  brendel
--| Moved a lot of implementation from descendants into this class to reduce
--| duplication of code in horizontal and vertical split area.
--| Added feature `select_from' to reduce the greater part.
--| Added features set_first_cell_dimension and set_second_cell_dimension.
--|
--| Revision 1.21  2000/03/03 23:00:28  brendel
--| Moved all initialization to `initialize'.
--|
--| Revision 1.20  2000/03/03 20:27:41  brendel
--| Cosmetics.
--|
--| Revision 1.19  2000/03/03 16:50:23  brendel
--| Added feature initialize. Now only to find out why it is not called.
--| Fixed bug in readable.
--|
--| Revision 1.18  2000/03/03 02:52:39  brendel
--| Since `item' is no longer inherited, pre- and postconditions are added.
--|
--| Revision 1.16  2000/03/03 00:33:16  oconnor
--| fixed first and second
--|
--| Revision 1.15  2000/03/01 19:59:07  rogers
--| Fixed writeable and added readable.
--|
--| Revision 1.14  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.13  2000/02/22 01:18:00  rogers
--| Changed the export status of box to NONE.
--|
--| Revision 1.11  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.15  2000/02/08 09:29:35  oconnor
--| added writeable is True
--|
--| Revision 1.10.6.14  2000/02/08 05:18:20  oconnor
--| added perconditions to check for duplicate insertion.
--|
--| Revision 1.10.6.13  2000/02/08 05:12:48  oconnor
--| fixed full to work instead of being completly wrong
--|
--| Revision 1.10.6.12  2000/01/28 20:00:14  oconnor
--| released
--|
--| Revision 1.10.6.11  2000/01/28 16:46:38  oconnor
--| changed first_item to first and second_item to second in line with
--| CHAIN.first -- Item at first position
--|
--| Revision 1.10.6.10  2000/01/27 19:30:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.9  2000/01/26 02:50:32  king
--| Added set_proportion routine
--|
--| Revision 1.10.6.8  2000/01/25 19:08:01  king
--| Changed position features to split_position
--|
--| Revision 1.10.6.7  2000/01/25 17:19:26  king
--| Added assertions to set_position, removed positioning postcondition as it
--| doesn't hold in gtk when the minimum size is shrunk
--|
--| Revision 1.10.6.6  2000/01/21 23:10:59  oconnor
--| fixed postcond on extend
--|
--| Revision 1.10.6.5  2000/01/20 18:41:32  oconnor
--| reimplemented as decendant of EV_CONTAINER
--|
--| Revision 1.10.6.4  2000/01/19 22:16:12  king
--| First foundation of platform independent split area
--|
--| Revision 1.10.6.3  2000/01/15 02:38:47  oconnor
--| formatting
--|
--| Revision 1.10.6.2  1999/11/24 22:40:59  oconnor
--| added review notes
--|
--| Revision 1.10.6.1  1999/11/24 17:30:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.4  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.10.2.3  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
