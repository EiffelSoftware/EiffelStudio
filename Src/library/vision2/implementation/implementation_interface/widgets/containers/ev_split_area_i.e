indexing
	description:
		"Contains two widgets, each on either side of an adjustable separator."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SPLIT_AREA_I

inherit
	
	EV_CONTAINER_I
		redefine
			interface,
			item
		end

feature -- Access

	first: like item
			-- First item of `Current'.

	second: like item
			-- Second item of `Current'.

	item: EV_WIDGET is
			-- Current item.
		do
			if item_refers_to_second then
				Result := second
			else
				Result := first
			end
		end

feature -- Status report
		
	count: INTEGER is
			-- Number of items in `Current'
		do
			if first /= Void then	
				Result := 1
			end
			if second /= Void then
				Result := Result + 1
			end
		end

	has (v: like item): BOOLEAN is
			-- Does structure include `v'?
		do
			Result := v = first or else v = second
		end

	minimum_split_position: INTEGER is
			-- Minimum position the splitter can have.
		deferred
		ensure
			Result_not_negative: Result >= 0
			Result_valid: Result <= maximum_split_position
		end

	maximum_split_position: INTEGER is
			-- Maximum position the splitter can have.
		deferred
		ensure
			Result_not_negative: Result >= 0
			Result_valid: Result >= minimum_split_position
		end

	is_item_expanded (an_item: EV_WIDGET): BOOLEAN is
			-- Is `an_item' expanded relative to `Current'?
		require
			an_item_not_void: an_item /= Void
			has_an_item: has (an_item)
		do
			if an_item = first then
				Result := first_expandable
			elseif an_item = second then
				Result := second_expandable
			end
		end

feature -- Status setting

	set_first (an_item: like item) is
			-- Assign `an_item' to first.
		require
			an_item_not_void: an_item /= Void
			an_item_not_in_split_area: not has (an_item)
			an_item_parent_void: an_item.parent = Void
			first_is_void: first = Void
		deferred
		ensure
			first_set: first = an_item
			an_item_parent_is_current: an_item.parent = interface
			an_item_not_expanded: not is_item_expanded (an_item)
		end

	set_second (an_item: like item) is
			-- Assign `an_item' to second.
		require
			an_item_not_void: an_item /= Void
			an_item_not_in_split_area: not has (an_item)
			an_item_parent_void: an_item.parent = Void
			second_is_void: second = Void
		deferred
		ensure
			second_set: second = an_item
			an_item_parent_is_current: an_item.parent = interface
			an_item_expanded: is_item_expanded (an_item)
		end

	go_to_first is
			-- Make `first' current `item'.
		require
			first_exist: first /= Void
		do
			item_refers_to_second := False
		ensure
			item_is_first: item = first
		end

	go_to_second is
			-- Make `second' current `item'.
		require
			second_exists: second /= Void
		do
			item_refers_to_second := True
		ensure
			item_is_second: item = second
		end

	set_proportion (a_proportion: REAL) is
			-- Position `split_position' between minimum and maximum determined
			-- by `a_proportion'.
		require
			proportion_in_valid_range:
				(a_proportion >= 0 and a_proportion <= 1)
		local
			max_sp, min_sp: INTEGER
		do
			max_sp := maximum_split_position
			min_sp := minimum_split_position
			set_split_position (((max_sp - min_sp) * a_proportion).rounded +
				min_sp)
		end

	enable_item_expand (an_item: EV_WIDGET) is
			-- When `Current' is resized, resize `an_item' respectively.
		deferred
		end

	disable_item_expand (an_item: EV_WIDGET) is
			-- When `Current' is resized, do not resize `an_item'.
		deferred
		end

	set_split_position (a_split_position: INTEGER) is
			-- Make `a_split_position' position of splitter in pixels.
		deferred
		end

	enable_flat_separator is
			-- Set the separator to be "flat"
		deferred
		end

	disable_flat_separator is
			-- Set the separator to be "raised"
		deferred
		end

feature -- Element change

	put (an_item: like item) is
			-- Assign `an_item' to `first_item' if not already assigned or to
			-- `second_item' otherwise.
		do
			if first = Void then
				set_first (an_item)
			else
				set_second (an_item)
			end
		end

	replace (an_item: like item) is
			-- Replace item with `an_item'.
		do
			prune (item)
			if item_refers_to_second then
				set_second (an_item)
			else
				set_first (an_item)
			end
		end

feature -- Removal

	prune (v: like item) is
			-- Remove occurrence of `v' if any.
		deferred
		end

	wipe_out is
			-- Remove all items.
		do
			prune (first)
			prune (second)
			item_refers_to_second := False
		end

feature -- Conversion

	linear_representation: LINEAR [like item] is
			-- Representation as a linear structure.
		local
			l: LINKED_LIST [like item]
		do
			create l.make
			if first /= Void then
				l.extend (first)
			end
			if second /= Void then
				l.extend (second)
			end
			Result := l
		end

feature {EV_SPLIT_AREA} -- Implementation

	item_refers_to_second: BOOLEAN
			-- Is `item' referring to `second'.

	split_position: INTEGER is
			-- Offset of the splitter from the left or top.
		deferred
		end

	flat_separator: BOOLEAN
			-- Does `Current' have a flat separator?

	first_expandable: BOOLEAN
			-- Is `first' expandable?

	second_expandable: BOOLEAN
			-- Is `second' expandable?

	splitter_width: INTEGER is
			-- Width of splitter.
		deferred
		end

feature {EV_SPLIT_AREA_I} -- Status Report

	first_visible: BOOLEAN is
			-- Is `first' not Void and visible?
		do
			Result := first /= Void and first.is_show_requested
		end

	second_visible: BOOLEAN is
			-- Is `second' not Void and visible?
		do
			Result := second /= Void and second.is_show_requested
		end

feature {EV_ANY_I, EV_ANY} -- Implementation

	interface: EV_SPLIT_AREA

end -- class EV_SPLIT_AREA_I

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
--| Revision 1.15  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.11.4.17  2000/08/15 16:22:52  king
--| Implemented platform independant replace
--|
--| Revision 1.11.4.16  2000/08/08 18:17:45  manus
--| Moved `first_visible' and `second_visible' to EV_SPLIT_AREA_I since it is needed for
--| `EV_HORIZONTAL_SPLIT_AREA_I' and `EV_VERTICAL_SPLIT_AREA_I' to compute a correct
--| `minimum_split_position' and `maximum_split_position'. This is only exported to
--| EV_SPLIT_AREA_I and descendants, not to the interface.
--|
--| Revision 1.11.4.15  2000/08/02 18:25:09  rogers
--| Comments, formatting.
--|
--| Revision 1.11.4.14  2000/07/27 22:51:57  rogers
--| Removed show_separator, hide_separator and is_separator_shown.
--|
--| Revision 1.11.4.13  2000/07/27 19:17:59  king
--| Added preconditions
--|
--| Revision 1.11.4.12  2000/07/27 17:34:43  rogers
--| Made splitter_width deferred. Added copyright clause.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
