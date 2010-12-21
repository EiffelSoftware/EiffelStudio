note
	description: "Scrollable lists"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class

	SCROLLABLE_LIST

inherit
	FONTABLE
		rename
			implementation as font_implementation
		end;

	PRIMITIVE
		rename
			cursor as screen_cursor
		redefine
			implementation, is_fontable
		end;

create

	make, make_unmanaged, make_fixed_size, make_fixed_size_unmanaged

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE)
			-- Create a scrolled list with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
			-- Scroll list will attempt to resize if entries
			-- are added.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_fixed_size (a_name: STRING; a_parent: COMPOSITE)
			-- Create a scrolled list with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
			-- Scroll list will not resize if entries
			-- are added.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE)
			-- Create an unmanaged scrolled list with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
			-- Scroll list will attempt to resize if entries
			-- are added.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	make_fixed_size_unmanaged (a_name: STRING; a_parent: COMPOSITE)
			-- Create an unmanaged scrolled list with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
			-- Scroll list will not resize if entries
			-- are added.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE;
			man: BOOLEAN; is_fixed: BOOLEAN)
			-- Create a scrolled list with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			if a_name /= Void then
				identifier := a_name.twin
			else
				identifier := Void
			end
			create {SCROLLABLE_LIST_IMP} implementation.make (Current, man, is_fixed, a_parent);
			implementation.set_widget_default;
		end;

feature -- Access

	list: LIST [SCROLLABLE_LIST_ELEMENT]
			-- Duplicate list of all the items
		local
			pos: INTEGER;
			a_list: ARRAYED_LIST [SCROLLABLE_LIST_ELEMENT]
		do
			a_list := implementation;
			pos := a_list.index;
			a_list.start;
			Result := a_list.duplicate (a_list.count);
			a_list.go_i_th (pos)
		end

	cursor: CURSOR
			-- Current cursor position
		do
			Result := implementation.cursor
		end

	first: like item
			-- Item at first position
		require
			not_empty: not is_empty
		do
			Result := implementation.first
		end

	i_th, infix "@" (i: INTEGER): like item
			-- Item at i-th position
		require
			valid_key: valid_index (i)
		do
			Result := implementation.i_th (i)
		end

	index: INTEGER
			-- Current cursor index
		do
			Result := implementation.index
		end

	index_of (v: like item i: INTEGER): INTEGER
			-- Index of i-th occurrence of item identical to v.
			-- (Reference or object equality,
			-- based on object_comparison.)
			-- 0 if none.
		require
			positive_occurrences: i > 0
		do
			Result := implementation.index_of (v, i)
		ensure
			non_negative_result: Result >= 0
		end

	item: SCROLLABLE_LIST_ELEMENT
			-- Item at current position
		require
			not_off: not off
			readable: readable
		do
			Result ?= implementation.item
		end

	last: like item
			-- Item at last position
		require
			not_empty: not is_empty
		do
			Result := implementation.last
		end

	occurrences (v: like item): INTEGER
			-- Number of times v appears.
			-- (Reference or object equality,
			-- based on object_comparison.)
		do
			Result := implementation.occurrences (v)
		ensure
			non_negative_occurrences: Result >= 0
		end

feature -- Status report

	has (v: like item): BOOLEAN
			-- Does chain include v?
			-- (Reference or object equality,
			-- based on object_comparison.)
		do
			Result := implementation.has (v)
		ensure
			not_found_in_empty: Result implies not is_empty
		end

feature -- Measurement

	count: INTEGER
			-- Number of items
		do
			Result := implementation.count
		end

feature -- Conversion

	linear_representation: LINEAR [SCROLLABLE_LIST_ELEMENT]
			-- Representation as a linear structure
		do
			Result := implementation.linear_representation
		end

feature -- Cursor movement

	back
			-- Move to previous position.
		require
			not_before: not before
		do
			implementation.back
		ensure
			moved_back: index = old index - 1
		end

	finish
			-- Move cursor to last position.
			-- (No effect if is_empty)
		do
			implementation.finish
		ensure
			at_last: not is_empty implies islast
		end

	forth
			-- Move to next position if no next position,
			-- ensure that exhausted will be true.
		require
			not_after: not after
		do
			implementation.forth
		ensure
			moved_forth: index = old index + 1
		end

	go_i_th (i: INTEGER)
			-- Move cursor to i-th position.
		require
			valid_cursor_index: valid_cursor_index (i)
		do
			implementation.go_i_th (i)
		ensure
			position_expected: index = i
		end

	go_to (p: CURSOR)
			-- Move cursor to position p.
		require
			cursor_position_valid: valid_cursor (p)
		do
			implementation.go_to (p)
		end

	move (i: INTEGER)
			-- Move cursor i positions. The cursor
			-- may end up off if the absolute value of i
			-- is too big.
		do
			implementation.move (i)
		ensure
			too_far_right: (old index + i > count) implies exhausted
			too_far_left: (old index + i < 1) implies exhausted
			expected_index: (not exhausted) implies (index = old index + i)
		end

	search (v: like item)
			-- Move to first position (at or after current
			-- position) where item and v are equal.
			-- If structure does not include v ensure that
			-- exhausted will be true.
			-- (Reference or object equality,
			-- based on object_comparison.)
		do
			implementation.search (v)
		ensure
			object_found: (not exhausted and then object_comparison and then v /= void and then item /= void) implies v.is_equal (item)
			item_found: (not exhausted and not object_comparison) implies v = item
		end

	start
			-- Move cursor to first position.
			-- (No effect if is_empty)
		do
			implementation.start
		ensure
			at_first: not is_empty implies isfirst
		end

feature -- Element change

	append (s: SEQUENCE [SCROLLABLE_LIST_ELEMENT])
			-- Append a copy of s.
		require
			argument_not_void: s /= void
		do
			implementation.append (s)
		ensure
			new_count: count >= old count
		end

	extend (v: SCROLLABLE_LIST_ELEMENT)
			-- Add a new occurrence of v.
		require
			extendible: extendible
		do
			implementation.extend (v)
		ensure
			one_more_occurrence: occurrences (v) = old (occurrences (v)) + 1
			item_inserted: has (v)
		end

	fill (other: CONTAINER [SCROLLABLE_LIST_ELEMENT])
			-- Fill with as many items of other as possible.
			-- The representations of other and current structure
			-- need not be the same.
		require
			other_not_void: other /= void
			extendible
		do
			implementation.fill (other)
		end

	force (v: like item)
			-- Add v to end.
		require
			extendible: extendible
		do
			implementation.force (v)
		ensure
			new_count: count = old count + 1
			item_inserted: has (v)
		end

	merge_left (other: ARRAYED_LIST [SCROLLABLE_LIST_ELEMENT])
			-- Merge other into current structure before cursor
			-- position. Do not move cursor. Empty other.
		require
			extendible: extendible
			not_before: not before
			other_exists: other /= void
		do
			implementation.merge_left (other)
		ensure
			new_count: count = old count + old other.count
			new_index: index = old index + old other.count
			other_is_empty: other.is_empty
		end

	merge_right (other: ARRAYED_LIST [SCROLLABLE_LIST_ELEMENT])
			-- Merge other into current structure after cursor
			-- position. Do not move cursor. Empty other.
		require
			extendible: extendible
			not_after: not after
			other_exists: other /= void
		do
			implementation.merge_right (other)
		ensure
			new_count: count = old count + old other.count
			same_index: index = old index
			other_is_empty: other.is_empty
		end

	put (v: like item)
			-- Replace current item by v.
			-- (Synonym for replace)
		require
			extendible: extendible
		do
			implementation.put (v)
		ensure
			same_count: count = old count
			item_inserted: has (v)
		end

	put_front (v: like item)
			-- Add v at beginning.
			-- Do not move cursor.
		do
			implementation.put_front (v)
		ensure
			new_count: count = old count + 1
			item_inserted: first = v
		end

	put_i_th (v: like item i: INTEGER)
			-- Put v at i-th position.
		require
			valid_key: valid_index (i)
		do
			implementation.put_i_th (v,i)
		ensure
			insertion_done: i_th (i) = v
		end

	put_left (v: like item)
			-- Add v to the left of cursor position.
			-- Do not move cursor.
		require
			extendible: extendible
			not_before: not before
		do
			implementation.put_left (v)
		ensure
			new_count: count = old count + 1
			new_index: index = old index + 1
		end

	put_right (v: like item)
			-- Add v to the right of cursor position.
			-- Do not move cursor.
		require
			extendible: extendible
			not_after: not after
		do
			implementation.put_right (v)
		ensure
			new_count: count = old count + 1
			same_index: index = old index
		end

	replace (v: SCROLLABLE_LIST_ELEMENT)
			-- Replace current item by v.
		require
			writable: writable
		do
			implementation.replace (v)
		ensure
			item_replaced: item = v
		end

feature -- Removal

	prune (v: like item)
			-- Remove first occurrence of v, if any,
			-- after cursor position.
			-- If found, move cursor to right neighbor
			-- if not, make structure exhausted.
		require
			prunable: prunable
		do
			implementation.prune (v)
		end

	prune_all (v: like item)
			-- Remove all occurrences of v.
			-- (Reference or object equality,
			-- based on object_comparison.)
			-- Leave structure exhausted.
		require
			prunable
		do
			implementation.prune_all (v)
		ensure
			is_exhausted: exhausted
			no_more_occurrences: not has (v)
		end

	remove
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or after if no right neighbor).
		require
			prunable: prunable
			writable: writable
		do
			implementation.remove
		ensure
			after_when_empty: is_empty implies after
		end

	remove_left
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		require
			not_before: not before
			left_exists: index > 1
		do
			implementation.remove_left
		ensure
			new_count: count = old count - 1
			new_index: index = old index - 1
		end

	remove_right
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		require
			right_exists: index < count
		do
			implementation.remove_right
		ensure
			new_count: count = old count - 1
			same_index: index = old index
		end

	wipe_out
			-- Remove all items.
		require
			prunable: prunable
		do
			implementation.wipe_out
		ensure
			is_before: before
			wiped_out: is_empty
		end

	remove_click_action, remove_selection_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with click selection mode in current scroll list.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.remove_click_action (a_command, argument)
		end;

feature -- Status report

	after: BOOLEAN
			-- Is there no valid cursor position to the right of cursor?
		do
			Result := implementation.after
		end

	before: BOOLEAN
			-- Is there no valid cursor position to the left of cursor?
		do
			Result := implementation.before
		end

	changeable_comparison_criterion: BOOLEAN
			-- May object_comparison be changed?
			-- (Answer: yes by default.)
		do
			Result := implementation.changeable_comparison_criterion
		end

	is_empty: BOOLEAN
			-- Is structure empty?
		do
			Result := implementation.is_empty
		end

	empty: BOOLEAN
			-- Is structure empty?
		obsolete
			"Use `is_empty' instead"
		do
			Result := is_empty
		end

	exhausted: BOOLEAN
			-- Has structure been completely explored?
		do
			Result := implementation.exhausted
		ensure
			exhausted_when_off: off implies Result
		end

	extendible: BOOLEAN
			-- May new items be added?
		do
			Result := implementation.extendible
		end

	full: BOOLEAN
			-- Is structure filled to capacity?
		do
			Result := implementation.full
		end

	isfirst: BOOLEAN
			-- Is cursor at first position?
		do
			Result := implementation.isfirst
		ensure
			valid_position: Result implies not is_empty
		end

	islast: BOOLEAN
			-- Is cursor at last position?
		do
			Result := implementation.islast
		ensure
			valid_position: Result implies not is_empty
		end

	object_comparison: BOOLEAN
			-- Must search operations use equal rather than =
			-- for comparing references? (Default: no, use =.)
		do
			Result := implementation.object_comparison
		end

	off: BOOLEAN
			-- Is there no current item?
		do
			Result := implementation.off
		end

	prunable: BOOLEAN
			-- May items be removed? (Answer: yes.)
		do
			Result := implementation.prunable
		end

	readable: BOOLEAN
			-- Is there a current item that may be read?
		do
			Result := implementation.readable
		end

	selected_count: INTEGER
			-- Number of selected items in current list
		require
			exists: not destroyed;
		do
			Result := implementation.selected_count
		end;

	selected_item: SCROLLABLE_LIST_ELEMENT
			-- Selected item if single or browse selection mode is selected
			-- Void if nothing is selected
		require
			exists: not destroyed;
		do
			Result := implementation.selected_item
		end;

	selected_items: LINKED_LIST [SCROLLABLE_LIST_ELEMENT]
			-- Selected items
		require
			exists: not destroyed;
		do
			Result := implementation.selected_items
		end;

	selected_position: INTEGER
			-- Position of selected item if single or browse selection mode is
			-- selected
			-- 0 if nothing is selected
		require
			exists: not destroyed;
		do
			Result := implementation.selected_position
		end;

	selected_positions: LINKED_LIST [INTEGER]
			-- Positions of the selected items
		require
			exists: not destroyed;
		do
			Result := implementation.selected_positions
		end;

	valid_cursor (p: CURSOR): BOOLEAN
			-- Can the cursor be moved to position p?
		do
			Result := implementation.valid_cursor (p)
		end

	valid_cursor_index (i: INTEGER): BOOLEAN
			-- Is i correctly bounded for cursor movement?
		do
			Result := implementation.valid_cursor_index (i)
		ensure
			valid_cursor_index_definition: Result = ((i >= 0) and (i <= count + 1))
		end

	valid_index (i: INTEGER): BOOLEAN
			-- Is i within allowable bounds?
		do
			Result := implementation.valid_index (i)
		ensure
			valid_index_definition: Result = (i >= 1) and (i <= count)
		end

	visible_item_count: INTEGER
			-- Number of visible item of list
		do
			result := implementation.visible_item_count
		end;

	writable: BOOLEAN
			-- Is there a current item that may be modified?
		do
			Result := implementation.writable
		end

feature -- Status setting

	compare_objects
			-- Ensure that future search operations will use equal
			-- rather than = for comparing references.
		require
			changeable_comparison_criterion
		do
			implementation.compare_objects
		ensure
			object_comparison: object_comparison
		end

	compare_references
			-- Ensure that future search operations will use =
			-- rather than equal for comparing references.
		require
			changeable_comparison_criterion
		do
			implementation.compare_references
		ensure
			reference_comparison: not object_comparison
		end

	deselect_all
			-- Deselect all selected items.
		require
			exists: not destroyed;
		do
			implementation.deselect_all
		ensure
			selected_list_is_empty: selected_count = 0
		end;

	scroll_to_current
			-- Make `item' the first visible item in the list if
			-- `position' < `first_visible_item_position'.
			-- Make `item' the last visible item in the list if
			-- `position' >= `first_visible_item_position'+`visible_item_count'.
			-- Do nothing if `item' is visible.
		require
			exists: not destroyed;
			not_off: not off
		do
			implementation.scroll_to_current
		end;

	select_item
			-- Select item at current position.
		require
			exists: not destroyed;
			not_off: not off
		do
			implementation.select_item
		end;

	deselect_item
			-- Deselect item at current position.
		require
			exists: not destroyed;
			not_off: not off
		do
			implementation.deselect_item
		end;

	select_i_th (i: INTEGER)
			-- Select item at `i'-th position.
		require
			exists: not destroyed;
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		do
			implementation.select_i_th (i)
		end;

	deselect_i_th (i: INTEGER)
			-- Deselect item at `i'-th position.
		require
			exists: not destroyed;
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		do
			implementation.deselect_i_th (i)
		end;

	set_multiple_selection
			-- Set the selection to be multiple items
		require
			exists: not destroyed;
			not_realized: not realized or else not shown
		do
			implementation.set_multiple_selection
		end

	set_single_selection
			-- Set the selection to be single items
		require
			exists: not destroyed;
			not_realized: not realized or else not shown
		do
			implementation.set_single_selection
		end

	set_visible_item_count (a_count: INTEGER)
			-- Set the number of visible items to `a_count'.
		require
			exists: not destroyed;
			a_count_large_enough: a_count > 0
		do
			implementation.set_visible_item_count (a_count)
		end;

feature -- Element change

	add_click_action, add_selection_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of actions to execute when items are
			-- selected with click selection mode in current scroll list.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.add_click_action (a_command, argument)
		end;

feature -- Default Action commands

	add_default_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of actions to
			-- execute when items are selected with double
			-- click or by pressing `RETURN' in current
			-- scroll list.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.add_default_action (a_command,
							   argument)
		end;

	remove_default_action
			-- Remove all actions executed when items are
			-- selected with double click or by pressing
			-- `RETURN' in current scroll list.
		require
			exists: not destroyed;
		do
			implementation.remove_default_action
		end;
feature -- Transformation

	swap (i: INTEGER)
			-- Exchange item at i-th position with item
			-- at cursor position.
		require
			not_off: not off
			valid_index: valid_index (i)
		do
			implementation.swap (i)
		ensure
			swapped_to_item: item = old i_th (i)
			swapped_from_item: i_th (i) = old item
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: SCROLLABLE_LIST_I;
			-- Implementation of list

feature {G_ANY, G_ANY_I, WIDGET_I} -- Implementation

	is_fontable: BOOLEAN = true;
			-- Is current widget an heir of FONTABLE?

	set_default
		do
		end

invariant
	before_definition: not destroyed implies (before = (index = 0))
	after_definition: not destroyed implies (after = (index = count + 1))
	non_negative_index: not destroyed implies (index >= 0)
	index_small_enough: not destroyed implies (index <= count + 1)
	off_definition: not destroyed implies (off = ((index = 0) or (index = count + 1)))
	isfirst_definition: not destroyed implies (isfirst = ((not is_empty) and (index = 1)))
	islast_definition: not destroyed implies (islast = ((not is_empty) and (index = count)))
	item_corresponds_to_index: not destroyed implies ((not off) implies (item = i_th (index)))
	writable_constraint: not destroyed implies (writable implies readable)
	empty_constraint: not destroyed implies (is_empty implies (not readable) and (not writable))
	not_both: not destroyed implies (not (after and before))
	empty_property: not destroyed implies (is_empty implies (after or before))
	before_constraint: not destroyed implies (before implies off)
	after_constraint: not destroyed implies (after implies off)
	empty_constraint: not destroyed implies (is_empty implies off)
	empty_definition: not destroyed implies (is_empty = (count = 0))
	non_negative_count: not destroyed implies (count >= 0)
	extendible: not destroyed implies extendible

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SCROLLABLE_LIST

