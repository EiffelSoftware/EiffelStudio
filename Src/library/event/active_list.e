indexing
	description:
		"Sequential, one-way linked lists that call an action %N%
		%sequence when an item is removed or added."
	status: "See notice at end of class"
	keywords: "event, action"
	date: "$Date$"
	revision: "$Revision$"

class
	ACTIVE_LIST [G]

inherit
	LINKED_LIST [G]
		redefine
			default_create,
			new_cell,
			cleanup_after_remove,
			merge_left,
			merge_right
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize
		do
			make
			create add_actions.make ("add", <<"item">>)
			create remove_actions.make ("remove", <<"item">>)
		end

feature -- Access

	add_actions: ACTION_SEQUENCE [TUPLE [G]]
			-- Actions performed when an item is added.

	remove_actions: ACTION_SEQUENCE [TUPLE [G]]
			-- Actions performed when an item is removed.

feature  -- Element Change

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
			add_actions.call ([v])
			create Result
			Result.put (v)
		end

	cleanup_after_remove (v: like first_element) is
			-- Clean-up a just removed cell.
		do
			consistency_count := consistency_count - 1
			remove_actions.call ([v.item])
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
				add_actions.call ([other.item])
				other.forth
			end
		end

	consistency_count: INTEGER
			-- Number of items in the list.

invariant
	add_actions_not_void: add_actions /= Void
	remove_actions_not_void: remove_actions /= Void
	consistency_count_equal_to_count: consistency_count = count

end -- class ACTIVE_LIST

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
--| Revision 1.2  2000/01/25 16:55:08  brendel
--| Minor bug fixes.
--|
--| Revision 1.1  2000/01/25 16:27:40  brendel
--| Initial.
--|
--| 
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
