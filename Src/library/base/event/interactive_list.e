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
			merge_right,
			wipe_out,
			put_front,
			put_left,
			put_right,
			remove_right,
			replace,
			remove,
			extend
		end

feature {NONE} -- Initialization

	default_create is
			-- Initialize linked list.
		do
			make
		end

feature -- Miscellaneous

	on_item_added (an_item: G) is
			-- `an_item' has just been added.
		require
			an_item_not_void: an_item /= Void
		do
		end

	on_item_removed (an_item: G) is
			-- `an_item' has been removed.
		require
			an_item_not_void: an_item /= Void
		do
		end

feature -- Element Change

	put_front (v: like item) is
			-- Add `v' to beginning.
			-- Do not move cursor.
		do
			in_operation := True
			{LINKED_LIST} Precursor (v)
			in_operation := False

			added_item (v)
		end

	extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		do
			in_operation := True
			{LINKED_LIST} Precursor (v)
			in_operation := False

			added_item (v)
		end

	put_left (v: like item) is
			-- Add `v' to the left of cursor position.
			-- Do not move cursor.
		do
			in_operation := True
			{LINKED_LIST} Precursor (v)
			in_operation := False

			added_item (v)
		end

	put_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		do
			in_operation := True
			{LINKED_LIST} Precursor (v)
			in_operation := False

			added_item (v)
		end

	replace (v: like item) is
			-- Replace current item by `v'.
		local
			active_item: like item
		do
			active_item := active.item

			in_operation := True
			Precursor (v)
			in_operation := False

			removed_item (active_item)
			added_item (v)
		end

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor).
		local
			active_item: like item
		do
			active_item := active.item

			in_operation := True
			Precursor
			in_operation := False

			removed_item (active_item)
		end

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		local
			item_removed: like item
		do
			if before then
				item_removed := first_element.item
			else
				item_removed := active.right.item
			end

			in_operation := True
			Precursor
			in_operation := False

			removed_item (item_removed)
		end

	merge_left (other: like Current) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'
		do
			in_operation := True
			Precursor (other)
			in_operation := False

			add_all (other)
		end

	merge_right (other: like Current) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'
		do
			in_operation := True
			Precursor (other)
			in_operation := False

			add_all (other)
		end

feature -- Removal

	wipe_out is
			-- Remove all items.
		local
			l: like Current
		do
			l := clone (Current)

			Precursor

			from
				l.start
			until
				l.after
			loop
				consistency_count := consistency_count - 1
				on_item_removed (l.item)
				l.forth
			end
		end

feature  {LINKED_LIST} -- Implementation

	new_cell (v: like item): like first_element is
			-- Create new cell with `v'.
		do
			consistency_count := consistency_count + 1
			create Result
			Result.put (v)
		end

	cleanup_after_remove (v: like first_element) is
			-- Clean-up a just removed cell.
		do
			consistency_count := consistency_count - 1
		end

feature {NONE} -- Implementation

	add_all (other: like Current) is
			-- Call `on_item_added' for all elements in `other'.
		local
			cur: CURSOR
		do
			cur := other.cursor
			from
				other.start
			until
				other.after
			loop
				consistency_count := consistency_count + 1
				added_item (other.item)
				other.forth
			end
			other.go_to (cur)
		end

	remove_all (other: like Current) is
			-- Call `on_item_removed' for all elements in `other'.
		do
			from
				other.start
			until
				other.after
			loop
				consistency_count := consistency_count - 1
				removed_item (other.item)
				other.forth
			end
		end

feature {NONE} -- Implementation

	added_item (an_item: G) is
			-- `an_item' is has been added.
		do
			if not in_operation then
				on_item_added (an_item)
			end
		end

	removed_item (an_item: G) is
			-- `an_item' has been removed.
		do
			if not in_operation then
				on_item_removed (an_item)
			end
		end

	in_operation: BOOLEAN
			-- Are we executing an operation from LINKED_LIST?

feature {NONE} -- Contract support

	consistency_count: INTEGER
			-- Number of items in the list.

invariant
	consistency_count_equal_to_count: consistency_count = count

end -- class ACTIVE_LIST

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
