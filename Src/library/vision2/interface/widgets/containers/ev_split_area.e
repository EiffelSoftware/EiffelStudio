indexing
	description:
		"Eiffel Vision split area. Contains two items either side of a%N%
		%separator. The user can adjust separator by dragging it."
	status: "See notice at end of class"
	keywords: "container, split, devide"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SPLIT_AREA

inherit
	EV_CONTAINER
		export
			{NONE} fill
		undefine
			extend,
			put
		redefine
			implementation
		end

feature -- Access

	first: EV_WIDGET is
			-- First item.
		do
			Result := implementation.first_item
		ensure
			bridge_ok: Result = implementation.first_item
		end

	second: EV_WIDGET is
			-- Second item.
		do
			Result := implementation.second_item
		ensure
			bridge_ok: Result = implementation.second_item
		end

	go_to_first is
			-- Make `first' current `item'.
		do
			implementation.go_to_first
		ensure
			item_is_first: item = first
		end

	go_to_second is
			-- Make `first' current `item'.
		do
			implementation.go_to_second
		ensure
			item_is_second: item = second
		end

	has (v: like item): BOOLEAN is
			-- Does structure include `v'?
		do
			Result := implementation.has (v)
		end

feature -- Status report

	empty: BOOLEAN is
			-- Is there no element?
		do
			Result := first = Void and second = Void
		end

	extendible: BOOLEAN is
			-- Items may be added.
		do
			Result := first = Void or second = Void
		end

	full: BOOLEAN is
			-- Is structure filled to capacity?
		do
			Result := first /= Void and second /= Void
		end

	prunable: BOOLEAN is True
			-- Items may be removed.

	writable: BOOLEAN is True
			-- Is there a current item that may be modified?

	split_position: INTEGER is
			-- Current position of the splitter.
			--| FIXME position relative to...?
		do
			Result := implementation.split_position
		ensure
			result_large_enough: Result >= minimum_split_position
			result_small_enough: Result <= maximum_split_position
		end

	minimum_split_position: INTEGER is
			-- Minimum position the splitter can have.
		do
			Result := implementation.minimum_split_position
		ensure
			positive_value: Result >= 0
			coherent_position: Result <= maximum_split_position
		end

	maximum_split_position: INTEGER is
			-- Maximum position the splitter can have.
		do
			Result := implementation.maximum_split_position
		ensure
			positive_value: Result >= 0
			coherent_position: Result >= minimum_split_position
		end

feature -- Element change

	put, extend (an_item: like item) is
			-- Assign `an_item' to `first_item' if not already assigned or to
			-- `second_item' otherwise.
		do
			implementation.extend (an_item)
		ensure then
			first_used_first:
				old first = Void implies first = an_item
			second_used_second:
				old first /= Void implies second = an_item
		end

	set_first (an_item: like item) is
			-- Assign `an_item' to `first'.
		require
			an_item_not_void: an_item /= Void
			not_has_an_item: not has (an_item)
		do
			implementation.set_first_item (an_item)
		ensure
			an_item_assigned: first = an_item
		end
		
	set_second (an_item: like item) is
			-- Assign `an_item' to `second'.
		require
			an_item_not_void: an_item /= Void
			not_has_an_item: not has (an_item)
		do
			implementation.set_second_item (an_item)
		ensure
			an_item_assigned: second = an_item
		end	

feature -- Status setting

	set_split_position (a_split_position: INTEGER) is
			-- Make `a_split_position' the new position of the splitter in pixels.
		require
			position_in_valid_range:
				(a_split_position >= minimum_split_position and a_split_position <= maximum_split_position)
		do
			implementation.set_split_position (a_split_position)
		ensure
			--split_position = a_split_position
			--| FIXME IEK This doesn't always hold true as GTK may not resize the
			--| split area immediately, this is true when shrinking min size of first cell.
		end

	set_proportion (a_proportion: REAL) is
			-- Move the separator position to be relative to the size of the split area.
			-- 0.5 = middle of split area, providing the user can do this manually anyway.
			-- A value of 1 will move the separator to its upmost position, zero its smallest.
		require
			proportion_in_valid_range:
				(a_proportion >= 0 and a_proportion <= 1)
		do
			implementation.set_proportion (a_proportion)
		end

feature -- Removal

	prune (v: like item) is
			-- Remove one occurrence of `v' if any.
		do
			implementation.prune (v)
		end

	wipe_out is
			-- Remove all items.
		do
			implementation.wipe_out
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

	implementation: EV_SPLIT_AREA_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

end -- class EV_SPLIT_AREA

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
--| changed first_item to first and second_item to second in line with CHAIN.first -- Item at first position
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
--| Added assertions to set_position, removed positioning postcondition as it doesn't hold in gtk when the minimum size is shrunk
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
