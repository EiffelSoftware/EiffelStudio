indexing
	description: "[
		Sequential, one-way linked lists that call add/remove features
		when an item is removed or added.
		]"
	status: "See notice at end of class"
	keywords: "event, linked, list"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INTERACTIVE_LIST [G]

inherit
	ARRAYED_LIST [G]
		redefine
			default_create,
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
			make (4)
		end

feature -- Miscellaneous

	on_item_added (an_item: G) is
			-- `an_item' has just been added.
		obsolete
			"Use `on_item_added_at' instead."
		require
			an_item_not_void: an_item /= Void
		do
		end

	on_item_removed (an_item: G) is
			-- `an_item' has been removed.
		obsolete
			"Use `on_item_remove_at' instead'."
		require
			an_item_not_void: an_item /= Void
		do
		end
		
	on_item_added_at (an_item: G; item_index: INTEGER) is
			-- `an_item' has just been added at index `item_index'.
		require
			an_item_not_void: an_item /= Void
			item_index_valid: (1 <= item_index) and (item_index <= count)
		do
			on_item_added (an_item)
		end
		
	on_item_removed_at (an_item: G; item_index: INTEGER) is
			-- `an_item' has just been removed from index `item_index'.
		require
			an_item_not_void: an_item /= Void
			item_index_valid: (1 <= item_index) and (item_index <= count + 1)
		do
			on_item_removed (an_item)
		end

feature -- Element Change

	put_front (v: like item) is
			-- Add `v' to beginning.
			-- Do not move cursor.
		do
			in_operation := True
			Precursor {ARRAYED_LIST} (v)
			in_operation := False

			added_item (v, 1)
		end

	extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		do
			in_operation := True
			Precursor {ARRAYED_LIST} (v)
			in_operation := False
			added_item (v, count)
		end

	put_left (v: like item) is
			-- Add `v' to the left of cursor position.
			-- Do not move cursor.
		do
			in_operation := True
			Precursor {ARRAYED_LIST} (v)
			in_operation := False

			added_item (v, index - 1)
		end

	put_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		do
			in_operation := True
			Precursor {ARRAYED_LIST} (v)
			in_operation := False

			added_item (v, index + 1)
		end

	replace (v: like item) is
			-- Replace current item by `v'.
		local
			original_index: INTEGER
			original_item: G
		do
			original_index := index
			original_item := item
			in_operation := True
			Precursor {ARRAYED_LIST} (v)
			in_operation := False

			removed_item (original_item, original_index)
			added_item (v, original_index)
		end

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor).
		local
			original_index: INTEGER
			original_item: G
		do
			original_index := index
			original_item := item

			in_operation := True
			Precursor {ARRAYED_LIST}
			in_operation := False

			removed_item (original_item, original_index)
		end

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		local
			item_removed: like item
		do
			item_removed := i_th (index + 1)
			in_operation := True
			Precursor {ARRAYED_LIST}
			in_operation := False

			removed_item (item_removed, index + 1)
		end

	merge_left (other: like Current) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'
		local
			original_index: INTEGER
			original_other_count: INTEGER
		do
			original_index := index
			original_other_count := other.count
			index := index - 1
			merge_right (other)
			index := original_index + original_other_count
		end

	merge_right (other: like Current) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'
		local
			original_index: INTEGER
			new_item_count: INTEGER
		do
			original_index := index
			new_item_count := other.count
			in_operation := True
			Precursor {ARRAYED_LIST} (other)
			in_operation := False
			
			update_for_added (original_index + 1)
			go_i_th (original_index)
		end
		
	update_for_added (start_index: INTEGER) is
			-- Call `added_item' for all items from index `start_index' to `count'
		local
			a_cursor: CURSOR
		do
			a_cursor := cursor
			from
				go_i_th (start_index)
			until
				index > count
			loop
				added_item (item, index)
				forth
			end
			go_to (cursor)
		end

feature -- Removal

	wipe_out is
			-- Remove all items.
		local
			l: like Current
		do
			l := standard_clone (Current)
			Precursor {ARRAYED_LIST}
			from
				l.start
			until
				l.after
			loop
				on_item_removed_at (l.item, l.index)
				l.forth
			end
		end

feature {NONE} -- Implementation

	add_all (other: like Current; start_index: INTEGER) is
			-- Call `on_item_added' for all elements in `other'.
		local
			cur: CURSOR
			current_index: INTEGER
		do
			current_index := start_index
			cur := other.cursor
			from
				other.start
			until
				other.after
			loop
				added_item (other.item, current_index)
				other.forth
				current_index := current_index + 1
			end
			other.go_to (cur)
		end

feature {NONE} -- Implementation

	in_operation: BOOLEAN
			-- Are we executing an operation from ARRAYED_LIST?

	added_item (an_item: G; item_index: INTEGER) is
			-- `an_item' is has been added.
		do
			if not in_operation then
				on_item_added_at (an_item, item_index)
			end
		end

	removed_item (an_item: G; item_index: INTEGER) is
			-- `an_item' has been removed.
		do
			if not in_operation then
				on_item_removed_at (an_item, item_index)
			end
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class ACTIVE_LIST

