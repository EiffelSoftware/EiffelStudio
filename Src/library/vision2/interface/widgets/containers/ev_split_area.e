indexing
	description:
		"Contains two widgets, each on either side of an adjustable separator."
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
		redefine
			implementation,
			put, extend
		end

feature -- Access

	first: EV_WIDGET is
			-- First item.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.first
		end

	second: EV_WIDGET is
			-- Second item.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.second
		end

feature -- Status report

	has (v: like item): BOOLEAN is
			-- Does structure include `v'?
		do
			check
				not_destroyed: not is_destroyed
			end
			Result := implementation.has (v)
		end

	count: INTEGER is
			-- Number of items.
		require
			not_destroyed: not is_destroyed	
		do
			Result := implementation.count
		ensure
			count_not_negative: count >= 0
			count_valid: count <= 2
		end

	is_empty: BOOLEAN is
			-- Is structure empty?
		do
			check
				not_destroyed: not is_destroyed
			end
			Result := first = Void and second = Void
		end

	extendible: BOOLEAN is
			-- Is structure not full yet?
		do
			check
				not_destroyed: not is_destroyed
			end
			Result := first = Void or else second = Void
		end

	full: BOOLEAN is
			-- Is structure filled to capacity?
		do
			check
				not_destroyed: not is_destroyed
			end
			Result := first /= Void and then second /= Void
		end

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
			Result := item /= Void
		end

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		do
			Result := item /= Void
		end

	prunable: BOOLEAN is True
			-- Items may be removed.

	split_position: INTEGER is
			-- Offset of the splitter from left or top.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.split_position
		end

	minimum_split_position: INTEGER is
			-- Minimum position the splitter can have.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.minimum_split_position
		ensure
			non_negative: Result >= 0
		end

	maximum_split_position: INTEGER is
			-- Maximum position the splitter can have.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.maximum_split_position
		ensure
			non_negative: Result >= 0
		end

	is_item_expanded (an_item: EV_WIDGET): BOOLEAN is
			-- Is `an_item' expanded relative to `Current'?
		require
			not_destroyed: not is_destroyed
			an_item_not_void: an_item /= Void
			has_an_item: has (an_item)
		do
			Result := implementation.is_item_expanded (an_item)
		end

feature -- Element change

	put, extend (an_item: like item) is
			-- Assign `an_item' to `first_item' if not already assigned or to
			-- `second_item' otherwise.
		do
			implementation.put (an_item)
		ensure then
			first_item_used_first:
				old first  = Void implies first = an_item
			second_item_used_second:
				old first /= Void implies second = an_item
			has_an_item: has (an_item)
		end

	set_first (an_item: like item) is
			-- Assign `an_item' to `first'.
		require
			not_destroyed: not is_destroyed
			an_item_not_void: an_item /= Void
			an_item_not_in_split_area: not has (an_item)
			an_item_parent_is_void: an_item.parent = Void
			first_is_void: first = Void
		do
			implementation.set_first (an_item)
		ensure
			an_item_assigned: first = an_item
			an_item_not_expanded: not is_item_expanded (an_item)
		end
		
	set_second (an_item: like item) is
			-- Assign `an_item' to `second'.
		require
			not_destroyed: not is_destroyed
			an_item_not_void: an_item /= Void
			an_item_not_in_split_area: not has (an_item)
			an_item_parent_is_void: an_item.parent = Void
			second_is_void: second = Void
		do
			implementation.set_second (an_item)
		ensure
			an_item_assigned: second = an_item
			an_item_expanded: is_item_expanded (an_item)
		end	

feature -- Status setting

	go_to_first is
			-- Make `first' current `item'.
		require
			not_destroyed: not is_destroyed
			first_exists: first /= Void
		do
			implementation.go_to_first
		ensure
			item_is_first: item = first
		end

	go_to_second is
			-- Make `first' current `item'.
		require
			not_destroyed: not is_destroyed
			second_exists: second /= Void
		do
			implementation.go_to_second
		ensure
			item_is_second: item = second
		end

	enable_item_expand (an_item: EV_WIDGET) is
			-- When `Current' is resized, resize `an_item' respectively.
		require
			not_destroyed: not is_destroyed
			an_item_not_void: an_item /= Void
			has_an_item: has (an_item)
		do
			implementation.enable_item_expand (an_item)
		ensure
			an_item_expanded: is_item_expanded (an_item)
		end

	disable_item_expand (an_item: EV_WIDGET) is
			-- When `Current' is resized, do not resize `an_item'.
		require
			not_destroyed: not is_destroyed
			an_item_not_void: an_item /= Void
			has_an_item: has (an_item)
			split_area_full: full
			other_item_is_expandable: (an_item = first and is_item_expanded
				(second)) or (an_item = second and is_item_expanded (first))
		do
			implementation.disable_item_expand (an_item)
		ensure
			not_an_item_expanded: not is_item_expanded (an_item)
		end

	set_split_position (a_split_position: INTEGER) is
			-- Make `a_split_position' position of splitter in pixels.
		require
			not_destroyed: not is_destroyed
			split_area_full: full
			a_split_position_within_bounds:
				is_displayed implies ((a_split_position >= minimum_split_position
				and a_split_position <= maximum_split_position))
		do
			implementation.set_split_position (a_split_position)
		ensure
			split_position_assigned: split_position = a_split_position
		end

	set_proportion (a_proportion: REAL) is
			-- Position `split_position' between minimum and maximum determined
			-- by `a_proportion'.
		require
			not_destroyed: not is_destroyed
			split_area_full: full
			a_proportion_in_valid_range:
				(a_proportion >= 0 and a_proportion <= 1)
		do
			implementation.set_proportion (a_proportion)
		end

feature -- Removal

	prune (v: like item) is
			-- Remove one occurrence of `v' if any.
		do
			check
				not_destroyed: not is_destroyed
			end
			implementation.prune (v)
		ensure then
			count_is_one_implies_child_expandable:
				(count = 1 implies
					(first /= Void and is_item_expanded (first) or
					second /= Void and is_item_expanded (second)))
		end

	wipe_out is
			-- Remove all items.
		do
			check
				not_destroyed: not is_destroyed
			end
			implementation.wipe_out
		end

feature -- Conversion

	linear_representation: LINEAR [like item] is
			-- Representation as a linear structure
		do
			check
				not_destroyed: not is_destroyed
			end
			Result := implementation.linear_representation
		end
	
feature {EV_ANY_I} -- Implementation

	implementation: EV_SPLIT_AREA_I
		-- Responsible for interaction with the native graphics toolkit

invariant

	maximum_greater_or_equal_minimum: 
		is_usable implies minimum_split_position <= maximum_split_position
		
	splitter_in_valid_position__minimum:
		full implies split_position >= minimum_split_position
		
	splitter_in_valid_position__maximum:
		full implies split_position <= maximum_split_position

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
