indexing
	description: "This class represents a MS_WINDOWS list manager";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	LIST_MAN_WINDOWS

inherit
	LIST_MAN_I

feature -- Access

	index: INTEGER
		-- Current cursor index, 0 if empty

	multiple_selection: BOOLEAN
			-- May this list have more than one item selected?

feature -- Status report

	count: INTEGER is
			-- Number of items in current list
		do
			Result := private_list.count
		end

	empty: BOOLEAN is
			-- Is the chain empty?
		do
			Result := count = 0
		end

	first: STRING is
			-- Item at first position
		do
			Result := private_list.first
		end

	first_visible_item_position: INTEGER is
			-- Position of the first visible item in the list
		do
			if not empty then
				if Result = 0 then
					Result := count
				end
			end
		end

	has (an_item: STRING): BOOLEAN is
			-- Does `an_item' exist in current scroll list?
		require else
			not_an_item_void: an_item /= Void
		do
			Result := private_list.has (an_item)
		end

	i_th (i: INTEGER): STRING is
			-- Item at `i'-th position
		do
			Result := private_list.i_th (i)
		end

	index_of (an_item: STRING; i: INTEGER): INTEGER is
			-- Index of `i'-th `an_item'; 0 if none
		do
			Result := private_list.index_of (an_item, i)
		end

	isfirst: BOOLEAN is
			-- Is cursor at first position in the chain?
		do
			Result := index = 1
		end

	islast: BOOLEAN is
			-- Is cursor at last position in the chain?
		do
			Result := (index = count) and not empty
		end

	item: STRING is
			-- Item at cursor position
		do
			Result := private_list.i_th (index)
		end

	last: STRING is
			-- Item at last position
		do
			Result := private_list.i_th (count)
		end

	off: BOOLEAN is
			-- Is cursor off?
		do
			Result := (index = 0) or (index = count + 1)
		end

	before: BOOLEAN is
			-- Is cursor off left edge?
		do
			Result := (index = 0)
		end

	after: BOOLEAN is
			-- Is cursor off right edge?
		do
			Result := (count = 0) or (index = count + 1)
		end

feature -- Status setting

	set_browse_selection is
			-- Set selection mode of current list to
			-- browse. At most only one item can be selected
			-- at a time but dragging select button moves
			-- the selection along with the cursor.
		do
			multiple_selection := False
		end

	set_extended_selection is
			-- Set selection mode of current list to
			-- extended. Any number of items can be selected
			-- at any time using dragging mode, otherwise
			-- pressing an item selects it but deselect any
			-- other selected items.
		do
			multiple_selection := True
		end

	set_multiple_selection is
			-- Set selection mode of current list to
			-- multiple. Any item can be selected at any
			-- time in this mode.
		do
			multiple_selection := True
		end

	set_single_selection is
			-- Set selection mode of current list to
			-- single. At most only one item can be selected
			-- at a time.
		do
			multiple_selection := False
		end

	set_visible_item_count (a_count : INTEGER) is
		deferred
		end

feature -- Cursor movement

	back is
			-- Move cursor backward one position.
		do
			index := index - 1
		ensure then
			index = old index - 1
		end

	finish is
			-- Move cursor to last position
			-- (no effect if chain is empty).
		do
			index := count
		end

	forth is
			-- Move cursor forward one position.
		do
			index := index + 1
		end

	go_i_th (i: INTEGER) is
			-- Move cursor to position `i'.
		do
			index := i
		end

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		do
			index := index + i
		ensure then
			index = old index + i
		end

	search_equal (an_item: STRING) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where item is equal to `an_item' (shallow equality)
			-- go off right if none.
		do
			private_list.start
			private_list.compare_objects
			private_list.search (an_item)
			index := private_list.index
			private_list.compare_references
		end

	start is
			-- Move cursor to first position.
		do
			if not empty then
				index := 1
			end
		end

feature -- Element change

	put_left (an_item: STRING) is
			-- Put `an_item' to the left of cursor position.
			-- Do not move cursor.
		do
			private_list.go_i_th (index + 1)
			private_list.put_left (an_item)
			if exists then
				insert_item (an_item, index)
			end
			index := index + 1
		ensure then
			count_changed: count = old count + 1
		end

	put_right (an_item: STRING) is
			-- Put `an_item' to the right of cursor position.
			-- Do not move cursor.
		do
			if private_list.empty then
				private_list.put_front (an_item)
			else
				private_list.go_i_th (index)
				private_list.put_right (an_item)
			end
			if after then
				private_list.start
			end
			if exists then
				insert_item (an_item, private_list.index + 1)
			end
		ensure then
			count_changed: count = old count + 1
			index_not_changed: index = old index
		end

	merge_left (other: LIST [STRING]) is
		local
			item_index: INTEGER
		do
			private_list.go_i_th (index)
			item_index := private_list.index
			from
				other.start
			variant
				other.count + 1 - other.index
			until
				other.after
			loop
				if exists then
					insert_item (other.item, item_index)
				end
				private_list.put_left (other.item)
				item_index := item_index + 1
				other.forth
			end
			other.wipe_out
		end

	merge_right (other: LIST[STRING]) is
		local
			item_index: INTEGER
		do
			private_list.go_i_th (index)
			item_index := private_list.index + 1
			from
				other.start
			variant
				other.count + 1 - other.index
			until
				other.after
			loop
				if exists then
					insert_item (other.item, item_index)
				end
				private_list.put_right (other.item)
				private_list.forth
				item_index := item_index + 1
				other.forth
			end
			other.wipe_out
		end

	put (an_item: STRING) is
			-- Put `an_item' at cursor position.
		do
			private_list.put_i_th (an_item, index)
			if exists then
				insert_item (an_item, index)
			end
		ensure then
			not empty
			has (an_item)
		end

	put_i_th (an_item: STRING; i: INTEGER) is
			-- Put `an_item' at `i'-th position.
		do
			private_list.put_i_th (an_item, i)
			if exists then
				insert_item (an_item, i)
			end
		ensure then
			has (an_item)
			not empty
		end

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
		local
			ext_name: STRING
			ext_name_i: STRING
			cursor_index: INTEGER
		do
			cursor_index := index
			ext_name := private_list.item
			private_list.go_i_th (i)
			ext_name_i := private_list.item
			private_list.swap (index)
			if exists then
				delete_item (i)
				insert_item (ext_name, i)
				delete_item (cursor_index)
				insert_item (ext_name_i, cursor_index)
			end
		end

feature -- Duplication

	duplicate (n: INTEGER): LINKED_LIST [STRING] is
			-- Copy of the sub-list beginning at cursor position
			-- and comprising min (`n', count-position+1) items
			-- Cannot duplicate a widget !!!
		do
		end

feature -- Output

	deselect_all is
			-- Deselect all selected items.
		deferred
		end

	scroll_to_current is
			-- Make `item' the visible in the list
			-- Do nothing if `item' is visible.
			-- Not under Windows
		do
		end

	select_item is
			-- Select item at current position.
		do
			if exists then
				select_i_th (index)
			end
		end

	show_current is
			-- Make item at current position the first visible item.
		do
		end

	show_first is
			-- Make first item the first visible item.
		do
		end

	show_i_th (i: INTEGER) is
			-- Make item at `i'-th position the first visible item.
		do
		end

	show_last is
			-- Make last item the last visible item.
		do
		end

feature {NONE} -- Implementation

	private_list: ARRAYED_LIST [STRING]

	private_visible_item_count: INTEGER

	private_selected_count: INTEGER

	private_selected_item: STRING

	private_selected_items: LINKED_LIST[STRING]

	private_selected_position: INTEGER

	private_selected_positions: LINKED_LIST[INTEGER]

	insert_item (s: STRING; iti: INTEGER) is
		-- Add an item checking for size as we go
		deferred
		end

	delete_item (i: INTEGER) is
		deferred
		end

	exists: BOOLEAN is
		deferred
		end

	selection_change_actions: ACTIONS_MANAGER is
			-- Event handler for list events
		deferred
		end

end -- class LIST_MAN_WINDOWS


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

