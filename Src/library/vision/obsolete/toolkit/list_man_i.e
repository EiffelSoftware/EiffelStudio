
-- General list implementation.

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class LIST_MAN_I 

feature 

	add_browse_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with browse selection mode in current scroll list.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_browse_action

	add_click_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with click selection mode in current scroll list.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_click_action

	add_extended_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with extended selection mode in current scroll list.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_extended_action

	add_left (an_item: STRING) is
			-- Put `an_item' to the left of cursor position.
			-- Do not move cursor.
		require
			not_before_unless_empty: before implies empty
		deferred
		ensure
--			count = old count+1;
--			(not (position = 2)) implies (position = old position+1)
		end; -- add_left

	add_multiple_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with multiple selection mode in current scroll list.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_multiple_action

	add_right (an_item: STRING) is
			-- Put item `v' to the right of cursor position.
			-- Do not move cursor.
		require
			not_after_unless_empty: after implies empty
		deferred
		ensure
--			count = old count+1;
--			index = old index
		end; -- add_right

	add_single_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with single selection mode in current scroll list.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_single_action

	back is
			-- Move cursor backward one index.
		require
			not_before: index > 0
		deferred
		ensure
--			index = old index - 1
		end; -- back

	count: INTEGER is
			-- Number of items in the chain
		deferred
		end;  -- count

	deselect_all is
			-- Deselect all selected items.
		deferred
		ensure
			selected_list_is_empty: selected_count = 0
		end; -- deselect_all

	duplicate (n: INTEGER): LINKED_LIST [STRING] is
			-- Copy of the sub-list beginning at cursor index
			-- and comprising min (`n', count-index+1) items
		require
			not_off: not off;
			valid_sublist: n >= 0
		deferred
		end; -- duplicate

	empty: BOOLEAN is
			-- Is the chain empty?
		deferred
		end; -- empty

	finish is
			-- Move cursor to last index
			-- (no effect if chain is empty).
		deferred
		ensure
			empty or islast
		end; -- finish

	first: STRING is
			-- Item at first index
		require
			not_empty: not empty
		deferred
		end; -- first

	first_visible_item_position: INTEGER is
			-- Position of the first visible item in the list
		deferred
		ensure
			Result <= count;
			empty = (Result = 0)
		end; -- first_visible_item_position

	forth is
			-- Move cursor forward one position.
		require
			not empty and then index <= count
		deferred
		ensure
			index >= 1 and index <= count + 1
		end; -- forth

	go_i_th (i: INTEGER) is
			-- Move cursor to index `i'.
		require
			index_large_enough: i >= 0;
			index_small_enough: i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		deferred
		ensure
			index = i
		end; -- go

	has (v: STRING): BOOLEAN is
			-- Does `v' appear in the chain ?
		deferred
		end; -- has

	i_th (i: INTEGER): STRING is
			-- Item at `i'_th index
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count;
		deferred
		end; -- i_th

	index_of (v: STRING; i: INTEGER): INTEGER is
			-- Index of `i'-th item `v'; 0 if none
		require
			positive_occurrence: i > 0
		deferred
		ensure
			Result >= 0
		end; -- index_of

	isfirst: BOOLEAN is
			-- Is cursor at first index in the chain?
		deferred
		ensure
			Result implies (not empty)
		end; -- isfirst

	islast: BOOLEAN is
			-- Is cursor at last index in the chain?
		deferred
		ensure
			Result implies (not empty)
		end; -- islast

	item: STRING is
			-- Item at cursor index
		require
			not_off: not off
		deferred
		end; -- item

	last: STRING is
			-- Item at last index
		require
			not_empty: not empty
		deferred
		end; -- last

	merge_left (other: LIST [STRING]) is
			-- Merge `other' into the current list before
			-- cursor position.
			-- Do not move cursor.
			-- Empty other.
		require
			empty_or_not_before: empty or not before;
			other_exists: not (other = Void)
		deferred
		ensure
--			count = old count + old other.count;
			other.empty
		end; -- merge_left

	merge_right (other: LIST [STRING]) is
			-- Merge `other' into the current list after
			-- cursor position.
			-- Do not move cursor.
			-- Empties other.
		require
			not_after_unless_empty: empty or not after;
			other_exists: not (other = Void)
		deferred
		ensure
--			count = old count+old other.count;
			other.empty
		end; -- merge_right

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		require
			stay_right: index + i >= 0;
			stay_left: index + i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		deferred
		ensure
--			index = old index + i
		end; -- move

	off: BOOLEAN is
			-- Is cursor off?
		deferred
		end; -- off

	before: BOOLEAN is
			-- Is cursor off left edge?
		deferred
		end; -- before

	after: BOOLEAN is
			-- Is cursor off right edge?
		deferred
		end; -- after

	index: INTEGER is
			-- Current cursor index, 0 if empty
		deferred
		end; -- index

	put (an_item: STRING) is
			-- Put `an_item' at cursor position.
		require
			not_off: not off;
		deferred
		end; -- put

	put_i_th (an_item: STRING; i: INTEGER) is
			-- Put `an_item' at `i'-th position.
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		deferred
		ensure
			not empty
		end; -- put_i_th

	remove is
			-- Remove item at cursor position
			-- and move cursor to its right neighbor
			-- (or after if no right neighbor).
		require
		deferred
		ensure
--			count = old count-1;
			not empty implies index = old index
		end; -- remove

	remove_all_occurrences (an_item: STRING) is
			-- Remove all items `an_item' from list.
			-- Put cursor after.
		deferred
		ensure
			after
		end; -- remove_all_occurrences

	remove_browse_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with browse selection mode in current scroll list.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_browse_action

	remove_click_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with click selection mode in current scroll list.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_click_action

	remove_extended_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with extended selection mode in current scroll list.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_extended_action

	remove_left (n: INTEGER) is
			-- Remove min (`n', index - 1) items
			-- to the left of cursor position.
			-- Do not move cursor
			-- (but its position will be decreased by up to n).
		require
			not_before: not before;
			non_negative_argument: n >= 0
		deferred
		end; 

	remove_multiple_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with multiple selection mode in current scroll list.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_multiple_action

	remove_right (n: INTEGER) is
			-- Remove min (`n', count - position) items
			-- to the right of cursor position.
			-- Do not move cursor.
		require
			not_after: not after;
			non_negative_argument: n >= 0
		deferred
		ensure
--			index = old index
		end; -- remove_right

	remove_single_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with single selection mode in current scroll list.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_single_action

	scroll_to_current is
			-- Make `item' the first visible item in the list if
			-- `index' < `first_visible_item_index'.
			-- Make `item' the last visible item in the list if
			-- `index' >= `first_visible_item_position'+`visible_item_count'.
			-- Do nothing if `item' is visible.
		require
			not_off: not off
		deferred
		end; -- scroll_to_current

	search_equal (v: STRING) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where item is equal to `v' (shallow equality);
			-- go off right if none.
		require
			search_element_exists: not (v = Void)
		deferred
		ensure
			(not off) implies (v.is_equal (item))
		end; -- search_equal

	select_item is
			-- Select item at current position.
		require
			not_off: not off
		deferred
		end; -- select

	select_i_th (i: INTEGER) is
			-- Select item at `i'-th position.
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		deferred
		end; -- select_i_th

	selected_count: INTEGER is
			-- Number of selected items in current list
		deferred
		end; -- selected_count

	selected_item: STRING is
			-- Selected item if single or browse selection mode is selected
			-- Void if nothing is selected
		deferred
		end; -- selected_item

	selected_items: LINKED_LIST [STRING] is
			-- Selected items
		deferred
		end; -- current_select

	selected_position: INTEGER is
			-- Position of selected item if single or browse selection mode is
			-- selected
			-- Null if nothing is selected
		deferred
		end; -- selected_position

	selected_positions: LINKED_LIST [INTEGER] is
			-- Positions of the selected items
		deferred
		end; -- selected_positions

	set_browse_selection is
			-- Set selection mode of current list to
			-- browse. At most only one item can be selected
			-- at a time but dragging select button moves
			-- the selection along with the cursor.
		deferred
		end; -- set_browse_selection

	set_extended_selection is
			-- Set selection mode of current list to
			-- extended. Any number of items can be selected
			-- at any time using dragging mode, otherwise
			-- pressing an item selects it but deselect any
			-- other selected items.
		deferred
		end; -- set_extended_selection

	set_multiple_selection is
			-- Set selection mode of current list to
			-- multiple. Any item can be selected at any
			-- time in this mode.
		deferred
		end; -- set_multiple_selection

	set_single_selection is
			-- Set selection mode of current list to
			-- single. At most only one item can be selected
			-- at a time.
		deferred
		end; -- set_single_selection

	set_visible_item_count (a_count: INTEGER) is
			-- Set the number of visible items to `a_count'.
		require
			a_count_large_enough: a_count >0
		deferred
		end; -- set_visible_item_count

	show_current is
			-- Make item at current position visible.
		require
			not_off: not off
		deferred
		end; -- show_current

	show_first is
			-- Make first item visible.
		deferred
		end; -- show_first

	show_i_th (i: INTEGER) is
			-- Make item at `i'-th position visible.
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		deferred
		end; -- show_i_th

	show_last is
			-- Make last item visible.
		deferred
		end; -- show_last

	start is
			-- Move cursor to first position.
		deferred
		ensure
			empty or isfirst
		end; -- start

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
		require
			cursor_not_off: not off;
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		deferred
		end; -- swap

	visible_item_count: INTEGER is
			-- Number of visible item of list
		deferred
		ensure
			count_large_enough: Result >0
		end; -- visible_item_count

	wipe_out is
			-- Make list empty
		deferred
		end -- wipe_out

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
