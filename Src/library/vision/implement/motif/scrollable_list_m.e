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

	make (a_scrollable_list: SCROLL_LIST; is_managed, is_fixed: BOOLEAN; oui_parent: COMPOSITE) is
		do
		end

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

    visible_item_count: INTEGER is
            -- Number of visible item of list
        do
        end;

feature  -- Status setting

    add_click_action (a_command: COMMAND; argument: ANY) is
            -- Add `a_command' to the list of actions to execute when items are
            -- selected with click selection mode in current scroll list.
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

