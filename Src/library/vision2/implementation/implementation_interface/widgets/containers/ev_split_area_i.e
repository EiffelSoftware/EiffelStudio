--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision split area, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_SPLIT_AREA_I
	
inherit
	EV_AGGREGATE_WIDGET_IMP
		redefine
			initialize,
			interface
		end

	EV_CONTAINER_I
		redefine
			initialize,
			interface
		end

feature -- Access

	item: EV_WIDGET
			-- Current item.

	first_item: EV_WIDGET is
			-- First item.
		do
			Result := first_cell.item
		end

	second_item: EV_WIDGET is
			-- Second item.
		do
			Result := second_cell.item
		end

	go_to_first is
			-- Make `first' current `item'.
		do
			item := first_item
		ensure
			item_is_first: item = first_item
		end

	go_to_second is
			-- Make `first' current `item'.
		do
			item := second_item
		ensure
			item_is_second: item = second_item
		end

	has (v: like item): BOOLEAN is
			-- Does structure include `v'?
		do
			Result := first_cell.has(v) or second_cell.has (v)
		end

feature -- Initialization

	initialize is
			-- Put `split_box' and two cells in `Current'.
		do
			{EV_AGGREGATE_WIDGET_IMP} Precursor
			is_initialized := False
			create first_cell
			create second_cell
			box.extend (split_box)
			split_box.put_front (first_cell)
			split_box.extend (second_cell)
			split_box.disable_child_expand (first_cell)
			is_initialized := True
		end

feature -- Status report

	split_position: INTEGER is
			-- Current position of the splitter.
		deferred
		ensure
			result_large_enough: Result >= minimum_split_position
			result_small_enough: Result <= maximum_split_position
		end

	minimum_split_position: INTEGER is
			-- Minimum split_position the splitter can have.
		deferred
		ensure
			positive_value: Result >= 0
			coherent_split_position: Result <= maximum_split_position
		end

	maximum_split_position: INTEGER is
			-- Maximum split_position the splitter can have.
		deferred
		ensure
			positive_value: Result >= 0
			coherent_split_position: Result >= minimum_split_position
		end

feature -- Measurement

	client_width: INTEGER is
			-- Width of the client area of container.
		do
			Result := box.client_width
		end

	client_height: INTEGER is
			-- Height of the client area of container.
		do
			Result := box.client_height
		end

feature -- Element change

	extend (an_item: like item) is
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
				old first_item = Void implies first_item = an_item
			second_item_used_second:
				old first_item /= Void implies second_item = an_item
			has_an_item: has (an_item)
		end

	replace (an_item: like item) is
			-- Replace `item' with `v'.
		do
			if item = second_item then
				second_cell.replace (an_item)
			else
				first_cell.replace (an_item)
			end
		end	

	set_first_item (an_item: like item) is
			-- Assign `an_item' to `first_item'.
		require
			an_item_not_void: an_item /= Void
		do
			first_cell.put (an_item)
		ensure
			an_item_assigned: first_item = an_item
		end
		
	set_second_item (an_item: like item) is
			-- Assign `an_item' to `second_item'.
		require
			an_item_not_void: an_item /= Void
		do
			second_cell.put (an_item)
		ensure
			an_item_assigned: second_item = an_item
		end	

feature -- Status setting

	set_split_position (a_split_position: INTEGER) is
			-- Make `value' the new split_position of the splitter.
			-- `value' is given in pixels.
		require
			split_position_in_valid_range: 
				(a_split_position >= minimum_split_position and a_split_position <= maximum_split_position)
		deferred
		ensure
			--split_position = a_split_position
			--| FIXME IEK This doesn't always hold true as GTK may not resize the
			--| split area immediately, this is true when shrinking min size of first item.
		end

	set_proportion (a_proportion: REAL) is
			-- Move the separator position to be relative to the size of the split area.
			-- 0.5 = middle of split area, providing the user can do this manually anyway.
			-- A value of 1 will move the separator to its upmost position, zero its smallest.
		require
			proportion_in_valid_range:
				(a_proportion >= 0 and a_proportion <= 1)
		deferred
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

feature -- Implementation

	split_box: EV_BOX
		-- Contains `first_cell', a seperator and `second_cell'.

	sep: EV_SEPARATOR
		-- Separator used to split between the two items.

	first_cell, second_cell: EV_CELL
		-- Two client areas.

	scr: EV_SCREEN
		-- Used for drawing guideline on screen.

	initialize_split_area is
			-- Initialize the split area and screen.
		do
			create scr
			scr.set_line_width (3)
			scr.set_invert_mode
			sep.set_minimum_height (8)
			sep.set_minimum_width (8)
			split_box.extend (sep)
			split_box.disable_child_expand (sep)
		end

	interface: EV_SPLIT_AREA

invariant
	split_box_not_void: is_useable implies split_box /= Void
	separator_not_void: is_useable implies sep /= Void
	first_cell_not_void: is_useable implies first_cell /= Void
	second_cell_not_void: is_useable implies second_cell /= Void
	split_box_has_three_items: is_useable implies split_box.count = 3
	split_box_first_is_first_cell: is_useable implies split_box.first = first_cell
	split_box_last_is_second_cell: is_useable implies split_box.last = second_cell

end -- class EV_SPLIT_AREA_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--| Revision 1.12  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.11.6.16  2000/02/10 08:46:02  oconnor
--| added Void checks
--|
--| Revision 1.11.6.15  2000/02/08 09:31:33  oconnor
--| added replace
--|
--| Revision 1.11.6.14  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.11.6.13  2000/01/28 17:59:03  oconnor
--| changed put to extend
--|
--| Revision 1.11.6.12  2000/01/28 17:32:09  oconnor
--| revised to inherit EV_AGGREGATE_WIDGET_IMP
--|
--| Revision 1.11.6.11  2000/01/27 19:30:02  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.11.6.10  2000/01/26 02:50:32  king
--| Added set_proportion routine
--|
--| Revision 1.11.6.9  2000/01/26 01:05:00  king
--| Added abstract initialization routine
--|
--| Revision 1.11.6.8  2000/01/25 23:30:45  brendel
--| Changed is_initialized set to true at end of initialize to prevent
--| invariant failing on
--| `put' in box.
--|
--| Revision 1.11.6.7  2000/01/25 19:08:01  king
--| Changed position features to split_position
--|
--| Revision 1.11.6.6  2000/01/25 17:16:20  king
--| Added split_position features, removed redundant features such as
--| set_*_area_shrinkable
--|
--| Revision 1.11.6.5  2000/01/21 23:10:59  oconnor
--| fixed postcond on extend
--|
--| Revision 1.11.6.4  2000/01/21 22:34:26  king
--| Moved sep feature from descendants, added sep invariant
--|
--| Revision 1.11.6.3  2000/01/21 18:55:34  king
--| Made first_cell expandable
--|
--| Revision 1.11.6.2  2000/01/20 18:42:21  oconnor
--| reimplemented platform indeoendantly in line with new interface
--|
--| Revision 1.11.6.1  1999/11/24 17:30:10  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.11.2.3  1999/11/04 23:10:42  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.11.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
