indexing

	description: "General list implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class LIST_MAN_I 

feature 

	add_browse_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with browse selection mode in current scroll list.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_click_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with click selection mode in current scroll list.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_extended_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with extended selection mode in current scroll list.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	put_left (an_item: STRING) is
			-- Add `an_item' to the left of cursor position.
			-- Do not move cursor.
		require
			not_before_unless_empty: before implies empty
		deferred
		end;

	add_multiple_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with multiple selection mode in current scroll list.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	put_right (an_item: STRING) is
			-- Add `an_item' to the right of cursor position.
			-- Do not move cursor.
		require
			not_after_unless_empty: after implies empty
		deferred
		ensure
			new_count: count = old count+1;
			same_index: index = old index
		end;

	add_single_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with single selection mode in current scroll list.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	back is
			-- Move cursor backward one index.
		require
			not_before: not before
		deferred
		ensure
			moved_back: index = old index - 1
		end;

	count: INTEGER is
			-- Number of items in the chain
		deferred
		ensure
		end;

	deselect_all is
			-- Deselect all selected items.
		deferred
		ensure
			selected_list_is_empty: selected_count = 0
		end;

	duplicate (n: INTEGER): LINKED_LIST [STRING] is
			-- Copy of the sub-list beginning at cursor index
			-- and comprising min (`n', count-index+1) items
		require
			not_off: off implies after
			valid_sublist: n >= 0
		deferred
		end;

	empty: BOOLEAN is
			-- Is the chain empty?
		deferred
		end;

	finish is
			-- Move cursor to last index
			-- (no effect if chain is empty).
		deferred
		ensure
			at_last: not empty implies islast
		end;

	first: STRING is
			-- Item at first index
		require
			not_empty: not empty
		deferred
		end;

	first_visible_item_position: INTEGER is
			-- Position of the first visible item in the list
		deferred
		ensure
			non_negative: Result >= 0
			in_list: Result <= count;
			empty_convention: empty implies (Result = 0)
		end;

	forth is
			-- Move cursor forward one position.
		require
			not_after: not after
		deferred
		ensure
			moved_forth: index = old index + 1
		end;

	go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th position.
		require
			index_large_enough: i >= 0;
			index_small_enough: i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		deferred
		ensure
			position_expected: index = i
		end;

	has (v: STRING): BOOLEAN is
			-- Does `v' appear in the chain ?
		deferred
		ensure
			not_found_in_empty: Result implies not empty
		end;

	i_th (i: INTEGER): STRING is
			-- Item at `i'_th position
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count;
		deferred
		end;

	index_of (v: STRING; i: INTEGER): INTEGER is
			-- Index of `i'-th occurrence of item identical to `v'
			-- 0 if none
		require
			positive_occurrence: i > 0
		deferred
		ensure
			non_negative_result: Result >= 0
		end;

	isfirst: BOOLEAN is
			-- Is cursor at first index in the chain?
		deferred
		ensure
			valid_position: Result implies (not empty)
		end;

	islast: BOOLEAN is
			-- Is cursor at last index in the chain?
		deferred
		ensure
			valid_position: Result implies (not empty)
		end;

	item: STRING is
			-- Item at cursor index
		require
			not_off: not off
		deferred
		end;

	last: STRING is
			-- Item at last index
		require
			not_empty: not empty
		deferred
		end;

	merge_left (other: LIST [STRING]) is
			-- Merge `other' into the current list before
			-- cursor position.
			-- Do not move cursor.
			-- Empty other.
		require
			empty_or_not_before: empty or not before;
			other_exists: other /= Void
		deferred
		ensure
			count = old count + old other.count;
			other.empty
		end;

	merge_right (other: LIST [STRING]) is
			-- Merge `other' into the current list after
			-- cursor position.
			-- Do not move cursor.
			-- Empties other.
		require
			not_after_unless_empty: empty or not after;
			other_exists: other /= Void
		deferred
		ensure
			count = old count+old other.count;
			other.empty
		end;

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		require
			stay_right: index + i >= 0;
			stay_left: index + i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		deferred
		ensure
			expected_index: index = old index + i
		end;

	off: BOOLEAN is
			-- Is cursor off?
		deferred
		end;

	before: BOOLEAN is
			-- Is cursor off left edge?
		deferred
		end;

	after: BOOLEAN is
			-- Is cursor off right edge?
		deferred
		end;

	index: INTEGER is
			-- Current cursor index, 0 if empty
		deferred
		end;

	put (an_item: STRING) is
			-- Put `an_item' at cursor position.
		require
			not_off: not off;
		deferred
		ensure
			same_count: count = old count
		end;

	put_i_th (an_item: STRING; i: INTEGER) is
			-- Put `an_item' at `i'-th position.
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		deferred
		ensure
			insertion_done: i_th (i) = an_item
		end;

	remove is
			-- Remove item at cursor position
			-- and move cursor to its right neighbor
			-- (or `after' if no right neighbor).
		require
			not_empty: not empty
		deferred
		ensure
			count_changed: count = old count-1;
			after_when_empty: empty implies after
		end;

	prune_all (an_item: STRING) is
			-- Remove all items `an_item'.
			-- Put cursor after.
		deferred
		ensure
			no_more_occurrences: not has (an_item)
			is_after: after
		end;

	remove_browse_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with browse selection mode in current scroll list.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_click_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with click selection mode in current scroll list.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_extended_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with extended selection mode in current scroll list.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

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
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_right (n: INTEGER) is
			-- Remove min (`n', count - position) items
			-- to the right of cursor position.
			-- Do not move cursor.
		require
			not_after: not after;
			non_negative_argument: n >= 0
		deferred
		ensure
			unmoved: index = old index
		end;

	remove_single_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with single selection mode in current scroll list.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	scroll_to_current is
			-- Make `item' the first visible item in the list if
			-- `index' < `first_visible_item_index'.
			-- Make `item' the last visible item in the list if
			-- `index' >= `first_visible_item_position'+`visible_item_count'.
			-- Do nothing if `item' is visible.
		require
			not_off: not off
		deferred
		end;

	search_equal (v: STRING) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where item is equal to `v' (shallow equality);
			-- go off right if none.
		require
			search_element_exists: v /= Void
		deferred
		ensure
			(not off) implies (v.is_equal (item))
		end;

	select_item is
			-- Select item at current position.
		require
			not_off: not off
		deferred
		end;

	select_i_th (i: INTEGER) is
			-- Select item at `i'-th position.
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		deferred
		end;

	selected_count: INTEGER is
			-- Number of selected items in current list
		deferred
		end;

	selected_item: STRING is
			-- Selected item if single or browse selection mode is selected
			-- Void if nothing is selected
		deferred
		end;

	selected_items: LINKED_LIST [STRING] is
			-- Selected items
		deferred
		end;

	selected_position: INTEGER is
			-- Position of selected item if single or browse selection mode is
			-- selected
			-- Null if nothing is selected
		deferred
		end;

	selected_positions: LINKED_LIST [INTEGER] is
			-- Positions of the selected items
		deferred
		end;

	set_browse_selection is
			-- Set selection mode of current list to
			-- browse. At most only one item can be selected
			-- at a time but dragging select button moves
			-- the selection along with the cursor.
		deferred
		end;

	set_extended_selection is
			-- Set selection mode of current list to
			-- extended. Any number of items can be selected
			-- at any time using dragging mode, otherwise
			-- pressing an item selects it but deselect any
			-- other selected items.
		deferred
		end;

	set_multiple_selection is
			-- Set selection mode of current list to
			-- multiple. Any item can be selected at any
			-- time in this mode.
		deferred
		end;

	set_single_selection is
			-- Set selection mode of current list to
			-- single. At most only one item can be selected
			-- at a time.
		deferred
		end;

	set_visible_item_count (a_count: INTEGER) is
			-- Set the number of visible items to `a_count'.
		require
			a_count_large_enough: a_count > 0
		deferred
		end; 

	show_current is
			-- Make item at current position visible.
		require
			not_off: not off
		deferred
		end;

	show_first is
			-- Make first item visible.
		deferred
		end;

	show_i_th (i: INTEGER) is
			-- Make item at `i'-th position visible.
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		deferred
		end;

	show_last is
			-- Make last item visible.
		deferred
		end;

	start is
			-- Move cursor to first position.
		deferred
		ensure
			empty or isfirst
		end;

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
		require
			cursor_not_off: not off;
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		deferred
		end;

	visible_item_count: INTEGER is
			-- Number of visible item of list
		deferred
		ensure
		end;

	wipe_out is
			-- Make list empty
		deferred
		end 
	
	is_destroyed: BOOLEAN is
			-- Is Current is_destroyed?
		deferred
		end

	
invariant

	non_negative_selected_item_count: not is_destroyed implies selected_count >= 0	
	positive_visible_item_count:  not is_destroyed implies visible_item_count > 0
	non_negative_index: index >= 0	
	index_small_enough:  not is_destroyed implies index <= count + 1
	non_negative_count:  not is_destroyed implies count >= 0	
	empty_definition:  not is_destroyed implies empty = (count = 0)
end



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

