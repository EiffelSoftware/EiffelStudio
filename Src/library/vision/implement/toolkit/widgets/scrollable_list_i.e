indexing
	description: "Scrollable lists toolkit"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class

	SCROLLABLE_LIST_I 

inherit

	FONTABLE_I
		undefine
			copy, is_equal
		end

	PRIMITIVE_I
		rename
			cursor as screen_cursor
		undefine
			copy, is_equal
		end

	ARRAYED_LIST [SCROLLABLE_LIST_ELEMENT]
		rename
			make as ll_make,
			append as ll_append,
			extend as ll_extend,
			fill as ll_fill,
			force as ll_force,
			merge_left as ll_merge_left,
			merge_right as ll_merge_right,
			put as ll_put,
			put_front as ll_put_front,
			put_i_th as ll_put_i_th,
			put_left as ll_put_left,
			put_right as ll_put_right,
			replace as ll_replace,
			prune as ll_prune,
			prune_all as ll_prune_all,
			remove as ll_remove,
			remove_left as ll_remove_left,
			remove_right as ll_remove_right,
			wipe_out as ll_wipe_out,
			lower as ll_lower
		undefine
			is_equal
		end

feature  -- Element change

	append (s: SEQUENCE [SCROLLABLE_LIST_ELEMENT]) is
			-- Append a copy of s.
		require
			argument_not_void: s /= void
		deferred
		ensure
			new_count: count >= old count
		end;

	extend (v: SCROLLABLE_LIST_ELEMENT) is
			-- Add a new occurrence of v.
		require 
			extendible: extendible
		deferred
		ensure 
			one_more_occurrence: occurrences (v) = old (occurrences (v)) + 1
			item_inserted: has (v)
		end;

	fill (other: CONTAINER [SCROLLABLE_LIST_ELEMENT]) is
			-- Fill with as many items of other as possible.
			-- The representations of other and current structure
			-- need not be the same.
		require
			other_not_void: other /= void;
			extendible
		deferred
		end;

	force (v: like item) is
			-- Add v to end.
		require
			extendible: extendible
		deferred
		ensure 
			new_count: count = old count + 1;
			item_inserted: has (v)
		end;

	merge_left (other: LIST [SCROLLABLE_LIST_ELEMENT]) is
			-- Merge other into current structure before cursor
			-- position. Do not move cursor. Empty other.
		require 
			extendible: extendible;
			not_off: not before;
			other_exists: other /= void
		deferred
		ensure 
			new_count: count = old count + old other.count;
			new_index: index = old index + old other.count;
			other_is_empty: other.is_empty
		end;

	merge_right (other: LIST [SCROLLABLE_LIST_ELEMENT]) is
			-- Merge other into current structure after cursor
			-- position. Do not move cursor. Empty other.
		require 
			extendible: extendible;
			not_off: not after;
			other_exists: other /= void
		deferred
		ensure
			new_count: count = old count + old other.count;
			same_index: index = old index;
			other_is_empty: other.is_empty
		end;

	put (v: like item) is
			-- Replace current item by v.
			-- (Synonym for replace)
		require
			extendible: extendible
		do
			replace (v)
		ensure
			same_count: count = old count
			item_inserted: has (v)
		end;

	put_front (v: like item) is
			-- Add v at beginning.
			-- Do not move cursor.
		deferred
		ensure 
			new_count: count = old count + 1;
			item_inserted: first = v
		end;

	put_i_th (v: like item; i: INTEGER) is
			-- Put v at i-th position.
		require 
			valid_key: valid_index (i)
		deferred
		ensure 
			insertion_done: i_th (i) = v
		end;

	put_left (v: like item) is
			-- Add v to the left of cursor position.
			-- Do not move cursor.
		require 
			extendible: extendible;
			not_before: not before
		deferred
		ensure 
			new_count: count = old count + 1;
			new_index: index = old index + 1
		end;

	put_right (v: like item) is
			-- Add v to the right of cursor position.
			-- Do not move cursor.
		require 
			extendible: extendible;
			not_after: not after
		deferred
		ensure 
			new_count: count = old count + 1;
			same_index: index = old index
		end;

	replace (v: SCROLLABLE_LIST_ELEMENT) is
			-- Replace current item by v.
		require 
			writable: writable
		deferred
		ensure
			item_replaced: item = v
		end;

feature  -- Removal

	prune (v: like item) is
			-- Remove first occurrence of v, if any,
			-- after cursor position.
			-- If found, move cursor to right neighbor;
			-- if not, make structure exhausted.
		require 
			prunable: prunable
		deferred
		end;

	prune_all (v: like item) is
			-- Remove all occurrences of v.
			-- (Reference or object equality,
			-- based on object_comparison.)
			-- Leave structure exhausted.
		require 
			prunable
		deferred
		ensure 
			is_exhausted: exhausted
			no_more_occurrences: not has (v)
		end;

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or after if no right neighbor).
		require 
			prunable: prunable;
			writable: writable
		deferred
		ensure
			after_when_empty: is_empty implies after
		end;

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		require
			not_before: not before
			left_exists: index > 1
		deferred
		ensure
			new_count: count = old count - 1;
			new_index: index = old index - 1
		end;

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		require
			right_exists: index < count
		deferred
		ensure 
			new_count: count = old count - 1;
			same_index: index = old index
		end;

	wipe_out is
			-- Remove all items.
		require 
			prunable: prunable
		deferred
		ensure
			is_before: before
			wiped_out: is_empty
		end;

feature  -- Status report

	selected_count: INTEGER is
			-- Number of selected items in current list
		deferred
		end;

	selected_item: SCROLLABLE_LIST_ELEMENT is
			-- Selected item if single or browse selection mode is selected
			-- Void if nothing is selected
		deferred
		end;

	selected_items: LINKED_LIST [SCROLLABLE_LIST_ELEMENT] is
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

	visible_item_count: INTEGER is
			-- Number of visible item of list
		deferred
		end;

feature  -- Default action callbacks

	add_default_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to
			-- execute when items are selected with double
			-- click or by pressing `RETURN' in current
			-- scroll list.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_default_action is
			-- Remove all actions executed when items are
			-- selected with double click or by pressing
			-- `RETURN' in current scroll list.
		deferred
		end;

feature  -- Status setting

	add_click_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when items are
			-- selected with click selection mode in current scroll list.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	deselect_all is
			-- Deselect all selected items.
		deferred
		ensure
			selected_list_is_empty: selected_count = 0
		end;

	remove_click_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with click selection mode in current scroll list.
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

	select_item is
			-- Select item at current position.
		require
			not_off: not off
		deferred
		end;

	deselect_item is
			-- Deselect item at current position.
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

	deselect_i_th (i: INTEGER) is
			-- Deselect item at `i'-th position.
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		deferred
		end;

	set_multiple_selection is
			-- Set the selection to multiple items
		require
			not_realized: not realized
		deferred
		end

	set_single_selection is
			-- Set the selection to single items
		require
			not_realized: not realized
		deferred
		end

	set_visible_item_count (a_count: INTEGER) is
			-- Set the number of visible items to `a_count'.
		require
			a_count_large_enough: a_count > 0
		deferred
		end

feature -- Update

	update is
			-- Update the content of the scrollable list from
			-- `list'.
		deferred
		end;

invariant
	before_definition: before = (index = 0);
	after_definition: after = (index = count + 1);
	non_negative_index: index >= 0;
	index_small_enough: index <= count + 1;
	off_definition: off = ((index = 0) or (index = count + 1));
	isfirst_definition: isfirst = ((not is_empty) and (index = 1));
	islast_definition: islast = ((not is_empty) and (index = count));
	item_corresponds_to_index: (not off) implies (item = i_th (index));
	writable_constraint: writable implies readable;
	empty_constraint: is_empty implies (not readable) and (not writable);
	not_both: not (after and before);
	empty_property: is_empty implies (after or before);
	before_constraint: before implies off;
	after_constraint: after implies off;
	empty_constraint: is_empty implies off;
	empty_definition: is_empty = (count = 0);
	non_negative_count: count >= 0;
	extendible: extendible;

end -- class SCROLLABLE_LIST_I


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

