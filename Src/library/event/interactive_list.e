indexing
	description:
		"Sequential, one-way linked lists that call add/remove features %N%
		%when an item is removed or added."
	status: "See notice at end of class"
	keywords: "event, linked, list"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INTERACTIVE_LIST [G]

inherit
	LINKED_LIST [G]
		redefine
			default_create,
			new_cell,
			cleanup_after_remove,
			merge_left,
			merge_right
		end

feature {NONE} -- Initialization

	default_create is
			-- Initialize linked list.
		do
			make
		end

feature -- Miscellaneous

	on_item_added (an_item: G) is
			-- `an_item' is about to be added.
		require
			an_item_not_void: an_item /= Void
		deferred
		end

	on_item_removed (an_item: G) is
			-- `an_item' is about to be removed.
		require
			an_item_not_void: an_item /= Void
		deferred
		end

feature -- Element Change

	merge_left (other: like Current) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'
		do
			add_all (other)
			Precursor (other)
		end

	merge_right (other: like Current) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'
		do
			add_all (other)
			Precursor (other)
		end

feature  {LINKED_LIST} -- Implementation

	new_cell (v: like item): like first_element is
			-- Create new cell with `v'.
		do
			consistency_count := consistency_count + 1
			on_item_added (v)
			create Result
			Result.put (v)
		end

	cleanup_after_remove (v: like first_element) is
			-- Clean-up a just removed cell.
		do
			consistency_count := consistency_count - 1
			on_item_removed (v.item)
		end

feature {NONE} -- Implementation

	add_all (other: like Current) is
			-- Call add action sequence for all elements in `other'.
		do
			from
				other.start
			until
				other.after
			loop
				consistency_count := consistency_count + 1
				on_item_added (other.item)
				other.forth
			end
		end

feature {NONE} -- Contract support

	consistency_count: INTEGER
			-- Number of items in the list.

invariant
	consistency_count_equal_to_count: consistency_count = count

end -- class ACTIVE_LIST

--!-----------------------------------------------------------------------------
--! EiffelEvent: library of reusable components for ISE Eiffel.
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
--| Revision 1.1  2000/03/23 16:42:25  brendel
--| New list that does is designed to inherit from.
--| One example is now the ACTIVE_LIST.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
