indexing
	description: "Scrollable lists"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCROLLABLE_LIST_M

inherit

	SCROLLABLE_LIST_I

	PRIMITIVE_COMPOSITE_M

	FONTABLE_M

feature -- Initialization

	make (a_scrollable_list: SCROLL_LIST; is_managed, is_fixed: BOOLEAN;
oui_parent: COMPOSITE) is
		do
		end

feature  -- Access

	cursor: CURSOR is
			-- Current cursor position
		do
		end;

	first: like item is
			-- Item at first position
		do
		end;

	has (v: like item): BOOLEAN is
			-- Does chain include v?
			-- (Reference or object equality,
			-- based on object_comparison.)
		do
		end;

	i_th, infix "@" (i: INTEGER): like item is
			-- Item at i-th position
		do
		end;

	index: INTEGER is
			-- Current cursor index
		do
		end;

	index_of (v: like item; i: INTEGER): INTEGER is
			-- Index of i-th occurrence of item identical to v.
			-- (Reference or object equality,
			-- based on object_comparison.)
			-- 0 if none.
		do
		end;

	item: SCROLLABLE_LIST_ELEMENT is
			-- Item at current position
		do
		end;

	last: like item is
			-- Item at last position
		do
		end;

	occurrences (v: like item): INTEGER is
			-- Number of times v appears.
			-- (Reference or object equality,
			-- based on object_comparison.)
		do
		end;

feature  -- Conversion

	linear_representation: LINEAR [SCROLLABLE_LIST_ELEMENT] is
			-- Representation as a linear structure
		do
		end;

feature  -- Cursor movement

	back is
			-- Move to previous position.
		do
		end;

	finish is
			-- Move cursor to last position.
			-- (No effect if empty)
		do
		end;

	forth is
			-- Move to next position; if no next position,
			-- ensure that exhausted will be true.
		do
		end;

	go_i_th (i: INTEGER) is
			-- Move cursor to i-th position.
		do
		end;

	go_to (p: CURSOR) is
			-- Move cursor to position p.
		do
		end;

	move (i: INTEGER) is
			-- Move cursor i positions. The cursor
			-- may end up off if the absolute value of i
			-- is too big.
		do
		end;

	search (v: like item) is
			-- Move to first position (at or after current
			-- position) where item and v are equal.
			-- If structure does not include v ensure that
			-- exhausted will be true.
			-- (Reference or object equality,
			-- based on object_comparison.)
		do
		end;

	start is
			-- Move cursor to first position.
			-- (No effect if empty)
		do
		end;

feature  -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-chain beginning at current position
			-- and having min (n, from_here) items,
			-- where from_here is the number of items
			-- at or to the right of current position.
		do
		end;

feature  -- Element change

	append (s: SEQUENCE [SCROLLABLE_LIST_ELEMENT]) is
			-- Append a copy of s.
		do
		end;

	extend (v: SCROLLABLE_LIST_ELEMENT) is
			-- Add a new occurrence of v.
		do
		end;

	fill (other: CONTAINER [SCROLLABLE_LIST_ELEMENT]) is
			-- Fill with as many items of other as possible.
			-- The representations of other and current structure
			-- need not be the same.
		do
		end;

	force (v: like item) is
			-- Add v to end.
		do
		end;

	merge_left (other: like Current) is
			-- Merge other into current structure before cursor
			-- position. Do not move cursor. Empty other.
		do
		end;

	merge_right (other: like Current) is
			-- Merge other into current structure after cursor
			-- position. Do not move cursor. Empty other.
		do
		end;

	put (v: like item) is
			-- Replace current item by v.
			-- (Synonym for replace)
		do
		end;

	put_front (v: like item) is
			-- Add v at beginning.
			-- Do not move cursor.
		do
		end;

	put_i_th (v: like item; i: INTEGER) is
			-- Put v at i-th position.
		do
		end;

	put_left (v: like item) is
			-- Add v to the left of cursor position.
			-- Do not move cursor.
		do
		end;

	put_right (v: like item) is
			-- Add v to the right of cursor position.
			-- Do not move cursor.
		do
		end;

	replace (v: SCROLLABLE_LIST_ELEMENT) is
			-- Replace current item by v.
		do
		end;

feature  -- Measurement

	count: INTEGER is
			-- Number of items
		do
		end;

feature  -- Removal

	prune (v: like item) is
			-- Remove first occurrence of v, if any,
			-- after cursor position.
			-- If found, move cursor to right neighbor;
			-- if not, make structure exhausted.
		do
		end;

	prune_all (v: like item) is
			-- Remove all occurrences of v.
			-- (Reference or object equality,
			-- based on object_comparison.)
			-- Leave structure exhausted.
		do
		end;

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or after if no right neighbor).
		do
		end;

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
		end;

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		do
		end;

	wipe_out is
			-- Remove all items.
		do
		end;

feature  -- Status report

	after: BOOLEAN is
			-- Is there no valid cursor position to the right of cursor?
		do
		end;

	before: BOOLEAN is
			-- Is there no valid cursor position to the left of cursor?
		do
		end;

	changeable_comparison_criterion: BOOLEAN is
			-- May object_comparison be changed?
			-- (Answer: yes by default.)
		do
		end;

	empty: BOOLEAN is
			-- Is structure empty?
		do
		end;

	exhausted: BOOLEAN is
			-- Has structure been completely explored?
		do
		end;

	Extendible: BOOLEAN is 
			-- May new items be added? (Answer: yes.)
		do
		end

	full: BOOLEAN is
			-- Is structure filled to capacity?
		do
		end;

	isfirst: BOOLEAN is
			-- Is cursor at first position?
		do
		end;

	islast: BOOLEAN is
			-- Is cursor at last position?
		do
		end;

	object_comparison: BOOLEAN is
			-- Must search operations use equal rather than =
			-- for comparing references? (Default: no, use =.)
		do
		end

	off: BOOLEAN is
			-- Is there no current item?
		do
		end;

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		do
		end;

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
		end;

    selected_count: INTEGER is
            -- Number of selected items in current list
        do
        end;

    selected_item: SCROLLABLE_LIST_ELEMENT is
            -- Selected item if single or browse selection mode is selected
            -- Void if nothing is selected
        do
        end;

    selected_items: LINKED_LIST [SCROLLABLE_LIST_ELEMENT] is
            -- Selected items
        do
        end;

    selected_position: INTEGER is
            -- Position of selected item if single or browse selection mode is
            -- selected
            -- Null if nothing is selected
        do
        end;

    selected_positions: LINKED_LIST [INTEGER] is
            -- Positions of the selected items
        do
        end;

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Can the cursor be moved to position p?
		do
		end;

	valid_cursor_index (i: INTEGER): BOOLEAN is
			-- Is i correctly bounded for cursor movement?
		do
		end;

	valid_index (i: INTEGER): BOOLEAN is
			-- Is i within allowable bounds?
		do
		end;

    visible_item_count: INTEGER is
            -- Number of visible item of list
        do
        end;

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		do
		end;

feature  -- Status setting

    add_click_action (a_command: COMMAND; argument: ANY) is
            -- Add `a_command' to the list of actions to execute when items are
            -- selected with click selection mode in current scroll list.
        do
        end;

	compare_objects is
			-- Ensure that future search operations will use equal
			-- rather than = for comparing references.
		do
		end;

	compare_references is
			-- Ensure that future search operations will use =
			-- rather than equal for comparing references.
		do
		end;

    deselect_all is
            -- Deselect all selected items.
        do
        end;

    remove_click_action (a_command: COMMAND; argument: ANY) is
            -- Remove `a_command' to the list of action to execute when items are
            -- selected with click selection mode in current scroll list.
        do
        end;

    select_item is
            -- Select item at current position.
        do
        end;

    select_i_th (i: INTEGER) is
            -- Select item at `i'-th position.
		do
        end;

	set_multiple_selection is
			-- Set the selction to multiple items
		do
		end

	set_single_selection is
			-- Set the selction to multiple items
		do
		end

    set_visible_item_count (a_count: INTEGER) is
            -- Set the number of visible items to `a_count'.
        do
        end
feature  -- Transformation

	swap (i: INTEGER) is
			-- Exchange item at i-th position with item
			-- at cursor position.
		do
		end;

end -- class SCROLLABLE_LIST_M

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

