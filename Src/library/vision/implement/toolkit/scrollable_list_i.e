indexing
	description: "Scrollable lists toolkit"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCROLLABLE_LIST_I

inherit
	PRIMITIVE_I
		rename
			cursor as screen_cursor
		end

feature  -- Access

	cursor: CURSOR is
			-- Current cursor position
		deferred
		end;

	first: like item is
			-- Item at first position
		require
			not_empty: not empty
		deferred
		end;

	has (v: like item): BOOLEAN is
			-- Does chain include v?
			-- (Reference or object equality,
			-- based on object_comparison.)
		deferred
		ensure
			not_found_in_empty: Result implies not empty
		end;

	i_th (i: INTEGER): like item is
			-- Item at i-th position
		require
			valid_key: valid_index (i)
		deferred
		end;

	index: INTEGER is
			-- Current cursor index
		deferred
		end;

	index_of (v: like item; i: INTEGER): INTEGER is
			-- Index of i-th occurrence of item identical to v.
			-- (Reference or object equality,
			-- based on object_comparison.)
			-- 0 if none.
		require 
			positive_occurrences: i > 0
		deferred
		ensure 
			non_negative_result: Result >= 0
		end;

	item: SCROLLABLE_LIST_ELEMENT is
			-- Item at current position
		require 
			not_off: not off
			readable: readable
		deferred
		end;

	last: like item is
			-- Item at last position
		require 
			not_empty: not empty
		deferred
		end;

	occurrences (v: like item): INTEGER is
			-- Number of times v appears.
			-- (Reference or object equality,
			-- based on object_comparison.)
		deferred
		ensure 
			non_negative_occurrences: Result >= 0
		end;

feature  -- Conversion

	linear_representation: LINEAR [SCROLLABLE_LIST_ELEMENT] is
			-- Representation as a linear structure
		deferred
		end;

feature  -- Cursor movement

	back is
			-- Move to previous position.
		require
			not_before: not before
		deferred
		ensure
			moved_back: index = old index - 1
		end;

	finish is
			-- Move cursor to last position.
			-- (No effect if empty)
		deferred
		ensure
			at_last: not empty implies islast
		end;

	forth is
			-- Move to next position; if no next position,
			-- ensure that exhausted will be true.
		require 
			not_after: not after
		deferred
		ensure
			moved_forth: index = old index + 1
		end;

	go_i_th (i: INTEGER) is
			-- Move cursor to i-th position.
		require 
			valid_cursor_index: valid_cursor_index (i)
		deferred
		ensure
			position_expected: index = i
		end;

	go_to (p: CURSOR) is
			-- Move cursor to position p.
		require
			cursor_position_valid: valid_cursor (p)
		deferred
		end;

	move (i: INTEGER) is
			-- Move cursor i positions. The cursor
			-- may end up off if the absolute value of i
			-- is too big.
		deferred
		ensure
			too_far_right: (old index + i > count) implies exhausted;
			too_far_left: (old index + i < 1) implies exhausted;
			expected_index: (not exhausted) implies (index = old index + i)
		end;

	search (v: like item) is
			-- Move to first position (at or after current
			-- position) where item and v are equal.
			-- If structure does not include v ensure that
			-- exhausted will be true.
			-- (Reference or object equality,
			-- based on object_comparison.)
		deferred
		ensure
			object_found: (not exhausted and then object_comparison and then v /= void and then item /= void) implies v.is_equal (item);
			item_found: (not exhausted and not object_comparison) implies v = item
		end;

	start is
			-- Move cursor to first position.
			-- (No effect if empty)
		deferred
		ensure
			at_first: not empty implies isfirst
		end;

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

	merge_left (other: like Current) is
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
			other_is_empty: other.empty
		end;

	merge_right (other: like Current) is
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
			other_is_empty: other.empty
		end;

	put (v: like item) is
			-- Replace current item by v.
			-- (Synonym for replace)
		require
			extendible: extendible
		deferred
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

feature  -- Measurement

	count: INTEGER is
			-- Number of items
		deferred
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
			after_when_empty: empty implies after
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
			wiped_out: empty
		end;

feature  -- Status report

	after: BOOLEAN is
			-- Is there no valid cursor position to the right of cursor?
		deferred
		end;

	before: BOOLEAN is
			-- Is there no valid cursor position to the left of cursor?
		deferred
		end;

	changeable_comparison_criterion: BOOLEAN is
			-- May object_comparison be changed?
			-- (Answer: yes by default.)
		deferred
		end;

	empty: BOOLEAN is
			-- Is structure empty?
		deferred
		end;

	exhausted: BOOLEAN is
			-- Has structure been completely explored?
		deferred
		ensure 
			exhausted_when_off: off implies Result
		end;

	extendible: BOOLEAN is 
			-- May new items be added? (Answer: yes.)
		deferred
		end

	full: BOOLEAN is
			-- Is structure filled to capacity?
		deferred
		end;

	isfirst: BOOLEAN is
			-- Is cursor at first position?
		deferred
		ensure 
			valid_position: Result implies not empty
		end;

	islast: BOOLEAN is
			-- Is cursor at last position?
		deferred
		ensure 
			valid_position: Result implies not empty
		end;

	object_comparison: BOOLEAN is
			-- Must search operations use equal rather than =
			-- for comparing references? (Default: no, use =.)
		deferred
		end

	off: BOOLEAN is
			-- Is there no current item?
		deferred
		end;

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		deferred
		end;

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		deferred
		end;

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

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Can the cursor be moved to position p?
		deferred
		end;

	valid_cursor_index (i: INTEGER): BOOLEAN is
			-- Is i correctly bounded for cursor movement?
		deferred
		ensure 
			valid_cursor_index_definition: Result = ((i >= 0) and (i <= count + 1))
		end;

	valid_index (i: INTEGER): BOOLEAN is
			-- Is i within allowable bounds?
		deferred
		ensure
			valid_index_definition: Result = (i >= 1) and (i <= count)
		end;

	visible_item_count: INTEGER is
			-- Number of visible item of list
		deferred
		end;

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
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

	compare_objects is
			-- Ensure that future search operations will use equal
			-- rather than = for comparing references.
		require
			changeable_comparison_criterion
		deferred
		ensure
			object_comparison: object_comparison
		end;

	compare_references is
			-- Ensure that future search operations will use =
			-- rather than equal for comparing references.
		require 
			changeable_comparison_criterion
		deferred
		ensure 
			reference_comparison: not object_comparison
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
		end; 

feature  -- Transformation

	swap (i: INTEGER) is
			-- Exchange item at i-th position with item
			-- at cursor position.
		require 
			not_off: not off;
			valid_index: valid_index (i)
		deferred
		ensure 
			swapped_to_item: item = old i_th (i);
			swapped_from_item: i_th (i) = old item
		end;

invariant
	before_definition: before = (index = 0);
	after_definition: after = (index = count + 1);
	non_negative_index: index >= 0;
	index_small_enough: index <= count + 1;
	off_definition: off = ((index = 0) or (index = count + 1));
	isfirst_definition: isfirst = ((not empty) and (index = 1));
	islast_definition: islast = ((not empty) and (index = count));
	item_corresponds_to_index: (not off) implies (item = i_th (index));
	writable_constraint: writable implies readable;
	empty_constraint: empty implies (not readable) and (not writable);
	not_both: not (after and before);
	empty_property: empty implies (after or before);
	before_constraint: before implies off;
	after_constraint: after implies off;
	empty_constraint: empty implies off;
	empty_definition: empty = (count = 0);
	non_negative_count: count >= 0;
	extendible: extendible;

end -- class SCROLLABLE_LIST_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

