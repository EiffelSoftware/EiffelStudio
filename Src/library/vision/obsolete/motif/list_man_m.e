indexing

	description:
		"EiffelVision implementation of a Motif list which is rectangle %
		%with scrollbars or not which contains a list of selectable strings";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	LIST_MAN_M 

inherit

	LIST_MAN_I;

	PRIMITIVE_IMP
		undefine
			create_callback_struct
		end;

	MEL_LIST
		rename
			make as list_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			item_count as count,
			selected_item_count as selected_count,
			selected_items as mel_selected_items,
			deselect_all_items as deselect_all,
			select_item as mel_select_item,
			index_of as mel_index_of
		end

feature -- Access
	
	index: INTEGER;
			-- Current cursor index, 0 if empty

	empty: BOOLEAN is
			-- Is the chain empty?
		do
			Result := (count = 0)
		end;

	first: STRING is
			-- Item at first position
		do
			Result := items.item (1).to_eiffel_string
		end;

	first_visible_item_position: INTEGER is
			-- Position of the first visible item in the list
		do
			if not empty then
				Result := top_item_position;
				if Result = 0 then
					Result := count
				end
			end
		end;

	has (an_item: STRING): BOOLEAN is
			-- Does `an_item' exist in current scroll list?
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (an_item);
			Result := item_exists (ms);
			ms.destroy
		end; 

	i_th (i: INTEGER): STRING is
			-- Item at `i'-th position
		do
			Result := items.item (i).to_eiffel_string
		end;

	index_of (an_item: STRING; i: INTEGER): INTEGER is
			-- Index of `i'-th item `v'; 0 if none
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (an_item);
			Result := mel_index_of (ms, i);
			ms.destroy
		end;

	isfirst: BOOLEAN is
			-- Is cursor at first position in the chain?
		do
			Result := (index = 1)
		end;

	islast: BOOLEAN is
			-- Is cursor at last position in the chain?
		do
			Result := (index = count) and (not empty)
		end;

	item: STRING is
			-- Item at cursor position
		do
			Result := items.item (index).to_eiffel_string
		end;

	last: STRING is
			-- Item at last position
		do
			Result := items.item (count).to_eiffel_string
		end;

feature -- Status report

	off: BOOLEAN is
			-- Is cursor off?
		do
			Result := (index = 0) or else (index = count + 1)
		end;

	before: BOOLEAN is
			-- Is cursor off left edge?
		do
			Result := (index = 0)
		end;

	after: BOOLEAN is
			-- Is cursor off right edge?
		do
			Result := (count = 0) or (index = count + 1)
		end;

	selected_item: STRING is
			-- Selected item if single or browse selection mode is selected
			-- Void if nothing is selected
		local
			mel_table: MEL_STRING_TABLE 
		do
			if selected_count = 1 then
				mel_table := mel_selected_items;
				Result := mel_table.item (1).to_eiffel_string
			end
		end;

	selected_items: LINKED_LIST [STRING] is
			-- Selected items
		local
			c, i: INTEGER;
			mel_table: MEL_STRING_TABLE;
			ms: MEL_STRING
		do
			!! Result.make;
			c := selected_count;
			if c > 0 then
				mel_table := mel_selected_items;
				from
					i := 1;
				until
					i > c
				loop
					ms := mel_table.item (i);
					Result.extend (ms.to_eiffel_string);
					i := i + 1;
				end
			end
		end;

	selected_position: INTEGER is
			-- Position of selected item if single or browse selection mode is
			-- selected
			-- Null if nothing is selected
		local
			motif_table: POINTER;
		do
			if selected_count = 1 then
				Result := selected_positions.first
			end
		end;

feature -- Element change

	add_single_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with single selection mode in current scroll list.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (single_selection_command);
			if list = Void then
				!! list.make;
				set_single_selection_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end; 

	put_left (an_item: STRING) is
			-- Put `an_item' to the left of cursor position.
			-- Do not move cursor.
		local
			ms: MEL_STRING;
			i: INTEGER
		do
			!! ms.make_localized (an_item);
			i := index;
			if i = 0 then	
				i := i + 1;
			end;
			add_item_unselected (ms, i);
			index := i + 1;
			ms.destroy;
		end; 

	put_right (an_item: STRING) is
			-- Put `an_item' to the right of cursor position.
			-- Do not move cursor.
		local
			ms: MEL_STRING;
			i: INTEGER
		do
			!! ms.make_localized (an_item);
			if count > 0 then
				i := index + 1
			end;
			add_item_unselected (ms, i);
			ms.destroy
		end; 

	merge_left (other: LIST [STRING]) is
			-- Merge `other' into the current list before
			-- cursor position.
			-- Do not move cursor.
			-- Empty other.
		local
			list: MEL_STRING_TABLE
		do
			if not other.empty then
				list := make_merge_list (other);
				if empty then
					add_items (list, 1);
					index := other.count + 1;
					check
						after: after
					end
				elseif after then
					add_items (list, 0);
					index := count + 1;
					check
						after: after
					end
				else
					add_items (list, index);
					index := index + other.count
				end;
				list.destroy;
				other.wipe_out
			end;
		end;

	merge_right (other: LIST [STRING]) is
			-- Merge `other' into the current list after
			-- cursor position.
			-- Do not move cursor.
			-- Empties other.
		local
			list: MEL_STRING_TABLE
		do
			if not other.empty then
				list := make_merge_list (other);
				if empty then
					add_items (list, 1);
					check 
						before: before 
					end
				elseif islast then
					add_items (list, 0);
				else
					add_items (list, index + 1);
				end;
				list.destroy;
				other.wipe_out
			end;
		end;

	put (an_item: STRING) is
			-- Put `an_item' at cursor position.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (an_item);
			replace_item_pos (ms, index);
			ms.destroy
		end;

	put_i_th (an_item: STRING; i: INTEGER) is
			-- Put `an_item' at `i'-th position.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (an_item);
			replace_item_pos (ms, i);
			ms.destroy
		end;

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
		local
			f, s: MEL_STRING;
			mel_table: like items;
		do
			mel_table := items;
			f := mel_table.item (index).duplicate;
			s := mel_table.item (i).duplicate;
			replace_item_pos (f, i);
			replace_item_pos (s, index);
			f.destroy;
			s.destroy;
		end;

feature -- Duplication

	duplicate (n: INTEGER): LINKED_LIST [STRING] is
			-- Copy of the sub-list beginning at cursor position
			-- and comprising min (`n', count-position+1) items
		local
			last_position, current_position: INTEGER;
			current_count: INTEGER;
			mel_table: like items;
			ms: MEL_STRING
		do
			from
				!! Result.make;
				mel_table := items;
				current_count := count;
				current_position := index;
				if n > current_count - index + 1 then
					last_position := current_count + 1
				else
					last_position := index + n
				end
			until
				current_position = last_position
			loop
				ms := mel_table.item (current_position);
				Result.put_left (ms.to_eiffel_string);
				current_position := current_position + 1
			end
		end;

feature -- Cursor movement

	start is
			-- Move cursor to first position.
		do
			if not empty then
				index := 1
			end
		end;

	finish is
			-- Move cursor to last position
			-- (no effect if chain is empty).
		do
			index := count
		end; 

	back is
			-- Move cursor backward one position.
		do
			index := index - 1
		end; 

	forth is
			-- Move cursor forward one position.
		do
			index := index + 1
		end;

	go_i_th (i: INTEGER) is
			-- Move cursor to position `i'.
		do
			index := i
		end; 

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		require else
			stay_right: index + i >= 0;
			stay_left: index + i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		do
			index := index + i
		end;

	search_equal (an_item: STRING) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where item is equal to `an_item' (shallow equality);
			-- go off right if none.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (an_item);	
			index := item_pos_from (ms, index);
			ms.destroy;
			if index = 0 then
				index := count + 1
			end
		end;

feature -- Removal

	wipe_out is
			-- Make list empty
		do
			if not empty then
				deselect_all;
				set_pos (1);
				delete_all_items;
				index := 0;
			end
		end

	remove_right (n: INTEGER) is
			-- Remove min (`n', count - position) items
			-- to the right of cursor position.
			-- Do not move cursor.
		local
			num, current_count: INTEGER
		do
			from
				num := n;
				current_count := count;
				if (current_count - index) < num then
					num := current_count - index
				end;
			until
				num = 0
			loop
				delete_pos (index + 1);
				num := num - 1
			end;
		end;

	remove_left (n: INTEGER) is
			-- Remove min (`n', index - 1) items
			-- to the left of cursor index.
			-- Do not move cursor
			-- (but its index will be decreased by up to n).
		local
			num: INTEGER
		do
			from
				num := n;
				if index-1 < num then
					num := index-1
				end;
			until
				num = 0
			loop
				delete_pos (index - 1);
				index := index -1;
				num := num -1
			end;
		end; 

	remove is
			-- Remove item at cursor index
			-- and move cursor to its right neighbor
			-- (or after if no right neighbor).
		do
			delete_pos (index);
		end;

	prune_all (an_item: STRING) is
			-- Remove all items `an_item' from list.
			-- Put cursor after.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (an_item);
			from
			until
				item_exists (ms)
			loop
				delete_item (ms)
			end;
			ms.destroy;
			index := count + 1;
		end;

	remove_single_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items
			-- are selected with single selection mode in current scroll list.
		do
			remove_command (single_selection_command, a_command, argument)
		end;

feature -- Update display

	scroll_to_current is
			-- Make `item' the first visible item in the list if
			-- `index' < `first_visible_item_index'.
			-- Make `item' the last visible item in the list if
			-- `index' >= `first_visible_item_position'+`visible_item_count'.
			-- Do nothing if `item' is visible.
		local
			first_visible: INTEGER
		do
			first_visible := top_item_position;
			if first_visible = 0 then
				first_visible := count
			end;
			if index < first_visible then
				set_pos (index)
			elseif index >= first_visible+visible_item_count then
				set_bottom_pos (index)
			end
		end;

	select_item is
			-- Select item at current position.
		do
			select_pos (index, False)
		end;

	select_i_th (i: INTEGER) is
			-- Select item at `i'-th position.
		do
			select_pos (i, False)
		end;

	show_current is
			-- Make item at current position the first visible item.
		do
			set_pos (index)
		end;

	show_first is
			-- Make first item the first visible item.
		do
			if not empty then
				set_pos (1)
			end
		end;

	show_i_th (i: INTEGER) is
			-- Make item at `i'-th position the first visible item.
		do
			set_pos (i)
		end;

	show_last is
			-- Make last item the last visible item.
		local
			count_local, visible_item_count_local: INTEGER
		do
			count_local := count;
			visible_item_count_local := visible_item_count;
			if not empty then
				if visible_item_count_local < count_local then
					set_pos (1 + count_local - visible_item_count_local)
				else
					set_pos (1);
					xm_list_set_pos (screen_object, 1)
				end
			end
		end;

feature -- Status setting

	set_browse_selection is
			-- Set selection mode of current list to
			-- browse. At most only one item can be selected
			-- at a time but dragging select button moves
			-- the selection along with the cursor.
		do
			set_browse_select
		end;

	set_extended_selection is
			-- Set selection mode of current list to
			-- extended. Any number of items can be selected
			-- at any time using dragging mode, otherwise
			-- pressing an item selects it but deselect any
			-- other selected items.
		do
			set_extended_select
		end;

	set_multiple_selection is
			-- Set selection mode of current list to
			-- multiple. Any item can be selected at any
			-- time in this mode.
		do
			set_multiple_select
		end;

	set_single_selection is
			-- Set selection mode of current list to
			-- single. At most only one item can be selected
			-- at a time.
		do
			set_single_select
		end;

feature {NONE} -- Implementation

	make_merge_list (other: LIST [STRING]): MEL_STRING_TABLE is
			-- Make a merge list to `merge_left' and `merge_right'.
		require
			other_exists: other /= Void
		local
			i: INTEGER
		do
			if not other.empty then
				!! Result.make (other.count);
				from
					other.start;
					i := 1
				until
					i > other.count
				loop
					Result.put_string (other.item, i);
					i := i + 1;
					other.forth
				end
			end
		ensure
			other_is_after: other.after
		end;

feature {NONE} -- Obsolete features

	add_browse_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with browse selection mode in current scroll list.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (browse_selection_command);
			if list = Void then
				!! list.make;
				set_browse_selection_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_click_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with click selection mode in current scroll list.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (default_action_command);
			if list = Void then
				!! list.make;
				set_default_action_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_extended_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with extended selection mode in current scroll list.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (extended_selection_command);
			if list = Void then
				!! list.make;
				set_extended_selection_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_multiple_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with multiple selection mode in current scroll list.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (multiple_selection_command);
			if list = Void then
				!! list.make;
				set_multiple_selection_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	remove_click_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with click selection mode in current scroll list.
		do
			remove_command (default_action_command, a_command, argument)
		end;

	remove_extended_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with extended selection mode in current scroll list.
		do
			remove_command (extended_selection_command, a_command, argument)
		end;

	remove_multiple_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with multiple selection mode in current scroll list.
		do
			remove_command (multiple_selection_command, a_command, argument)
		end;

	remove_browse_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with browse selection mode in current scroll list.
		do
			remove_command (browse_selection_command, a_command, argument)
		end;

end -- class LIST_MAN_M


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

