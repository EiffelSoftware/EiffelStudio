indexing

	description:
		"Rectangle with scrollbars or not which contains a list of %
		%selectable strings";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class LIST_MAN_M 

inherit

	LIST_R_M
		export
			{NONE} all
		end;

	LIST_MAN_I;

feature 

	add_browse_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with browse selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (browse_actions = Void) then
				!! browse_actions.make (list_screen_object, MbrowseSelection, widget_oui)
			end;
			browse_actions.add (a_command, argument)
		end;

	add_click_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with click selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (click_actions = Void) then
				!! click_actions.make (list_screen_object, MdefaultAction, widget_oui)
			end;
			click_actions.add (a_command, argument)
		end; -- add_click_action

	add_extended_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with extended selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (extended_actions = Void) then
				!! extended_actions.make (list_screen_object, MextendedSelection, widget_oui)
			end;
			extended_actions.add (a_command, argument)
		end; -- add_extended_action

	put_left (an_item: STRING) is
			-- Put `an_item' to the left of cursor position.
			-- Do not move cursor.
		require else
			not_before_unless_empty: before implies empty
		local
			ext_name: ANY
		do
			ext_name := an_item.to_c;
			index := xm_list_add_left (list_screen_object,
						$ext_name, index);
			no_change_since_mark := false
		ensure then
--			count = old count+1;
--			(not (index = 2)) implies (index = old index+1)
		end; -- add_left

	add_multiple_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with multiple selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (multiple_actions = Void) then
				!! multiple_actions.make (list_screen_object, MmultipleSelection, widget_oui)
			end;
			multiple_actions.add (a_command, argument)
		end; -- add_multiple_action

	put_right (an_item: STRING) is
			-- Put `an_item' to the right of cursor position.
			-- Do not move cursor.
		require else
			not_after_unless_empty: after implies empty
		local
			ext_name: ANY
		do
			ext_name := an_item.to_c;
			xm_list_add_right (list_screen_object, $ext_name,
						index);
			no_change_since_mark := false
		ensure then
--			count = old count+1;
--			index = old index
		end; -- add_right

	add_single_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with single selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (single_actions = Void) then
				!! single_actions.make (list_screen_object, MsingleSelection, widget_oui)
			end;
			single_actions.add (a_command, argument)
		end; -- add_single_action

	back is
			-- Move cursor backward one position.
		require else
			not_before: index > 0
		do
			index := index - 1
		ensure then
--			index = old index - 1
		end; -- back

feature {NONE}

	browse_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when items are selected
			-- with browse selection mode in current scroll list

	click_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when items are selected
			-- with click selection mode in current scroll list

feature 

	count: INTEGER is
			-- Number of items in current list
		local
			ext_name: ANY
		do
			ext_name := MitemCount.to_c;
			Result := get_int (list_screen_object, $ext_name)
		end;

feature 

	deselect_all is
			-- Deselect all selected items.
		do
			xm_list_deselect_all_items (list_screen_object)
		ensure then
			selected_list_is_empty: selected_count = 0
		end;

	duplicate (n: INTEGER): LINKED_LIST [STRING] is
			-- Copy of the sub-list beginning at cursor position
			-- and comprising min (`n', count-position+1) items
		require else
			not_off: not off;
			valid_sublist: n >= 0
		local
			last_position, current_position: INTEGER;
			current_count: INTEGER;
			motif_table: POINTER;
			ext_name: ANY
		do
			from
				!! Result.make;
				ext_name := Mitems.to_c;
				motif_table := get_xmstring_tab (list_screen_object,
							$ext_name);
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
				Result.put_left (get_i_th_table (motif_table, current_position));
				current_position := current_position + 1
			end
		end;

	empty: BOOLEAN is
			-- Is the chain empty?
		do
			Result := (count = 0)
		end; -- empty

feature {NONE}

	extended_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when items are selected
			-- with extended selection mode in current scroll list

feature 

	finish is
			-- Move cursor to last position
			-- (no effect if chain is empty).
		do
			index := count
		ensure then
			empty or islast
		end; -- finish

	first: STRING is
			-- Item at first position
		require else
			not_empty: not empty
		local
			ext_name: ANY
		do
			ext_name := MItems.to_c;
			Result := get_i_th_xmstring_table (list_screen_object, 1,
						$ext_name)
		end;

	first_visible_item_position: INTEGER is
			-- Position of the first visible item in the list
		do
			if not empty then
				Result := get_top_item_position (list_screen_object);
				if Result = 0 then
					Result := count
				end
			end
		ensure then
			Result <= count;
			empty = (Result = 0)
		end;

	forth is
			-- Move cursor forward one position.
		require else
			not empty and then index <= count
		do
			index := index + 1
		ensure then
			index >= 1 and index <= count + 1
		end; -- forth

	go_i_th (i: INTEGER) is
			-- Move cursor to position `i'.
		require else
			index_large_enough: i >= 0;
			index_small_enough: i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		do
			index := i
		ensure then
			index = i
		end; -- go

	has (an_item: STRING): BOOLEAN is
			-- Does `an_item' exist in current scroll list?
		require else
			not_an_item_void: not (an_item = Void)
		local
			ext_name: ANY
		do
			ext_name := an_item.to_c;
			Result := xm_list_has (list_screen_object, $ext_name)
		end; -- has

	i_th (i: INTEGER): STRING is
			-- Item at `i'-th position
		require else
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		local
			ext_name: ANY
		do
			ext_name := MItems.to_c;
			Result := get_i_th_xmstring_table (list_screen_object, i,
							$ext_name)
		end;

	index_of (an_item: STRING; i: INTEGER): INTEGER is
			-- Index of `i'-th `an_item'; 0 if none
		require else
			positive_occurrence: i > 0
		local
			ext_name: ANY
		do
			ext_name := an_item.to_c;
			Result := xm_list_index_of (list_screen_object,
						$ext_name, i)
		ensure then
			Result >= 0
		end;

	isfirst: BOOLEAN is
			-- Is cursor at first position in the chain?
		do
			Result := (index = 1)
		ensure then
			Result implies (not empty)
		end;

	islast: BOOLEAN is
			-- Is cursor at last position in the chain?
		do
			Result := (index = count) and (not empty)
		ensure then
			Result implies (not empty)
		end;

	item: STRING is
			-- Item at cursor position
		local
			ext_name: ANY
		do
			ext_name := MItems.to_c;
			Result := get_i_th_xmstring_table (list_screen_object,
						index, $ext_name)
		end;

	last: STRING is
			-- Item at last position
		require else
			not_empty: not empty
		do
			Result := get_last_xmlist_item (list_screen_object)
		end;

feature {NONE}

	list_screen_object: POINTER;
			-- Pointer on current list widget

	make_merge_list (other: LIST [STRING]): POINTER is
			-- Make a merge list to `merge_left' and `merge_right'.
		require
			other_exists: not (other = Void)
		local
			i: INTEGER;
			ext_name: ANY
		do
			if not other.empty then
				Result := xm_create_merge_list (other.count);
				from
					other.start;
					i := 1
				until
					i > other.count
				loop
					ext_name := other.item.to_c;
					xm_add_item_merge_list (Result, $ext_name, i);
					i := i+1;
					other.forth
				end
			end
		ensure
			other.after
		end;

	
feature 

	merge_left (other: LIST [STRING]) is
			-- Merge `other' into the current list before
			-- cursor position.
			-- Do not move cursor.
			-- Empty other.
		require else
			empty_or_not_before: empty or not before;
			other_exists: not (other = Void)
		
		local
			list: POINTER
		do
			if not other.empty then
				list := make_merge_list (other);
				if empty then
					xmlistadditems (list_screen_object, list, other.count, 1);
					index := other.count+1;
					check
						after
					end
					elseif after then
					xmlistadditems (list_screen_object, list, other.count, 0);
					index := count+1;
					check
						after
					end
				else
					xmlistadditems (list_screen_object, list, other.count, index);
					index := index+other.count
				end;
				xm_free_merge_list (list, other.count);
				other.wipe_out
			end;
			no_change_since_mark := False
		ensure then
--			count = old count + old other.count;
			other.empty
		end;

	merge_right (other: LIST [STRING]) is
			-- Merge `other' into the current list after
			-- cursor position.
			-- Do not move cursor.
			-- Empties other.
		require else
			not_after_unless_empty: empty or not after;
			other_exists: not (other = Void)
		
		local
			list: POINTER
		do
			if not other.empty then
				list := make_merge_list (other);
				if empty then
					xmlistadditems (list_screen_object, 
													list, other.count, 1);
					check before end
				elseif islast then
					xmlistadditems (list_screen_object, 
													list, other.count, 0)
				else
					xmlistadditems (list_screen_object, 
											list, other.count, index+1)
				end;
				xm_free_merge_list (list, other.count);
				other.wipe_out
			end;
			no_change_since_mark := False
		ensure then
--			count = old count+old other.count;
			other.empty
		end;

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		require else
			stay_right: index + i >= 0;
			stay_left: index + i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		do
			index := index + i
		ensure then
--			index = old index + i
		end;

feature {NONE}

	multiple_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when items are selected
			-- with multiple selection mode in current scroll list

	no_change_since_mark: BOOLEAN;
			-- Is the list changed since last mark?

feature 

	off: BOOLEAN is
			-- Is cursor off?
		do
			Result := (index = 0) or else (index = count+1)
		end;

	before: BOOLEAN is
			-- Is cursor off left edge?
		do
			Result := (index = 0)
		end;

	after: BOOLEAN is
			-- Is cursor off right edge?
		do
			Result := (count = 0) or (index = count+1)
		end;

	index: INTEGER;
			-- Current cursor index, 0 if empty

	put (an_item: STRING) is
			-- Put `an_item' at cursor position.
		require else
			not_off: not off
		local
			ext_name: ANY
		do
			ext_name := an_item.to_c;
			xm_list_put (list_screen_object, $ext_name, index);
			no_change_since_mark := False
		ensure then
			not empty;
			has (an_item)
		end;

	put_i_th (an_item: STRING; i: INTEGER) is
			-- Put `an_item' at `i'-th position.
		require else
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		local
			ext_name: ANY
		do
			ext_name := an_item.to_c;
			xm_list_put (list_screen_object, $ext_name, i);
			no_change_since_mark := False
		ensure then
			has (an_item);
			not empty
		end;

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
				xm_list_delete_pos (list_screen_object, index + 1);
				num := num - 1
			end;
			no_change_since_mark := false
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
				xm_list_delete_pos (list_screen_object, index - 1);
				index := index -1;
				num := num -1
			end;
			no_change_since_mark := false
		end; 

	remove is
			-- Remove item at cursor index
			-- and move cursor to its right neighbor
			-- (or after if no right neighbor).
		do
			xm_list_delete_pos (list_screen_object, index);
			no_change_since_mark := False
--		ensure then
--			count = old count-1;
--			not empty implies index = old index
		end;

	prune_all (an_item: STRING) is
			-- Remove all items `an_item' from list.
			-- Put cursor after.
		local
			ext_name: ANY
		do
			from
				ext_name := an_item.to_c
			until
				xm_list_has (list_screen_object, $ext_name) 
			loop
				xm_remove_item (list_screen_object, $ext_name)
			end;
			index := count + 1;
			no_change_since_mark := False
		ensure then
			after
		end;

	remove_browse_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items
			-- are selected with browse selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
			browse_actions.remove (a_command, argument)
		end;

	remove_click_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items
			-- are selected with click selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
			click_actions.remove (a_command, argument)
		end;

	remove_extended_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items
			-- are selected with extended selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
			extended_actions.remove (a_command, argument)
		end;

	remove_multiple_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items
			-- are selected with multiple selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
			multiple_actions.remove (a_command, argument)
		end;

	remove_single_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items
			-- are selected with single selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
			single_actions.remove (a_command, argument)
		end;

	scroll_to_current is
			-- Make `item' the first visible item in the list if
			-- `index' < `first_visible_item_index'.
			-- Make `item' the last visible item in the list if
			-- `index' >= `first_visible_item_position'+`visible_item_count'.
			-- Do nothing if `item' is visible.
		require else
			not_off: not off
		
		local
			first_visible: INTEGER
		do
			first_visible := get_top_item_position (list_screen_object);
			if first_visible = 0 then
				first_visible := count
			end;
			if index < first_visible then
				xm_list_set_pos (list_screen_object, index)
			elseif index >= first_visible+visible_item_count then
				xm_list_set_bottom_pos (list_screen_object, index)
			end
		end;

	search_equal (an_item: STRING) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where item is equal to `an_item' (shallow equality);
			-- go off right if none.
		local
			ext_name: ANY
		do
			ext_name := an_item.to_c;
			index := xm_list_search_equal (list_screen_object,
						$ext_name, index);
			if index = 0 then
				index := count + 1
			end
		ensure then
			(not off) implies (an_item.is_equal (item))
		end;

	select_item is
			-- Select item at current position.
		require else
			not_off: not off
		do
			xm_list_select_pos (list_screen_object, index, False)
		end;

	select_i_th (i: INTEGER) is
			-- Select item at `i'-th position.
		require else
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		do
			xm_list_select_pos (list_screen_object, i, False)
		end;

	selected_count: INTEGER is
			-- Number of items selected in current list
		local
			ext_name: ANY
		do
			ext_name := MselectedItemCount.to_c;
			Result := get_int (list_screen_object, $ext_name)
		end;

	selected_item: STRING is
			-- Selected item if single or browse selection mode is selected
			-- Void if nothing is selected
		local
			motif_table: POINTER;
			ext_name: ANY
		do
			if selected_count = 1 then
				ext_name := MselectedItems.to_c;
				motif_table := get_xmstring_tab (list_screen_object,
							$ext_name);
				Result := get_i_th_table (motif_table, 1)
			end
		end;

	selected_items: LINKED_LIST [STRING] is
			-- Selected items
		local
			last_position, current_position: INTEGER;
			motif_table: POINTER;
			ext_name: ANY
		do
			from
				!! Result.make;
				ext_name := MselectedItems.to_c;
				motif_table := get_xmstring_tab (list_screen_object,
							$ext_name);
				current_position := 1;
				last_position := selected_count + 1
			until
				current_position = last_position
			loop
				Result.extend (get_i_th_table (motif_table, current_position));
				current_position := current_position + 1
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
				motif_table := get_xmint_tab (list_screen_object);
				Result := get_int_table (motif_table, 1);
				c_free (motif_table);
			end
		end;

	selected_positions: LINKED_LIST [INTEGER] is
			-- Positions of the selected items
		local
			motif_table: POINTER;
			current_position, last_position: INTEGER;
			a_position: INTEGER
		do
			from
				!! Result.make;
				motif_table := get_xmint_tab (list_screen_object);
				current_position := 1;
				last_position := selected_count + 1
			until
				current_position = last_position
			loop
				a_position := get_int_table (motif_table, current_position);
				Result.put_left (a_position);
				current_position := current_position+1
			end;
			c_free (motif_table)
		end;

	set_browse_selection is
			-- Set selection mode of current list to
			-- browse. At most only one item can be selected
			-- at a time but dragging select button moves
			-- the selection along with the cursor.
		local
			ext_name: ANY
		do
			ext_name := MselectionPolicy.to_c;
			set_unsigned_char (list_screen_object, MBROWSE_SELECT,
						$ext_name)
		end;

	set_extended_selection is
			-- Set selection mode of current list to
			-- extended. Any number of items can be selected
			-- at any time using dragging mode, otherwise
			-- pressing an item selects it but deselect any
			-- other selected items.
		local
			ext_name: ANY
		do
			ext_name := MselectionPolicy.to_c;
			set_unsigned_char (list_screen_object, MEXTENDED_SELECT,
						$ext_name)
		end;

	set_multiple_selection is
			-- Set selection mode of current list to
			-- multiple. Any item can be selected at any
			-- time in this mode.
		local
			ext_name: ANY
		do
			ext_name := MselectionPolicy.to_c;
			set_unsigned_char (list_screen_object, MMULTIPLE_SELECT,
						$ext_name)
		end;

	set_single_selection is
			-- Set selection mode of current list to
			-- single. At most only one item can be selected
			-- at a time.
		local
			ext_name: ANY
		do
			ext_name := MselectionPolicy.to_c;
			set_unsigned_char (list_screen_object, MSINGLE_SELECT,
						$ext_name)
		end;

	set_visible_item_count (a_count: INTEGER) is
			-- Set the number of visible items to `a_count'.
		require else
			a_count_large_enough: a_count >0
		local
			ext_name: ANY
		do
			ext_name := MvisibleItemCount.to_c;
			set_int (list_screen_object, a_count, $ext_name)
		end;

	show_current is
			-- Make item at current position the first visible item.
		require else
			not_off: not off
		do
			xm_list_set_pos (list_screen_object, index)
		end;

	show_first is
			-- Make first item the first visible item.
		do
			if not empty then
				xm_list_set_pos (list_screen_object, 1)
			end
		end;

	show_i_th (i: INTEGER) is
			-- Make item at `i'-th position the first visible item.
		require else
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		do
			xm_list_set_pos (list_screen_object, i)
		end;

	show_last is
			-- Make last item the last visible item.
		local
			count_local, visible_item_count_local : INTEGER
		do
			count_local := count;
			visible_item_count_local := visible_item_count;
			if not empty then
				if visible_item_count_local < count_local then
					xm_list_set_pos (list_screen_object, 1 +
							count_local - visible_item_count_local)
				else
					xm_list_set_pos (list_screen_object, 1)
				end
			end
		end;

feature {NONE}

	single_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when items are selected
			-- with single selection mode in current scroll list

feature 

	start is
			-- Move cursor to first position.
		do
			if not empty then
				index := 1
			end
		ensure then
			empty or isfirst
		end;

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
		require else
			cursor_not_off: not off;
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		do
			xm_list_exchange (list_screen_object, index, i);
			no_change_since_mark := false
		end;

	visible_item_count: INTEGER is
			-- Number of visible item of current list
		local
			ext_name: ANY
		do
			ext_name := MvisibleItemCount.to_c;
			Result := get_int (list_screen_object, $ext_name);
		ensure then
			visible_item_count_large_enough: Result >0
		end;

feature {NONE}

	widget_oui: WIDGET is
			-- Object user interface widget associated with current
			-- implementation
		deferred
		end;

feature 

	wipe_out is
			-- Make list empty
		do
			if not empty then
				xm_list_deselect_all_items (list_screen_object);
				xm_list_set_pos (list_screen_object, 1);
				xm_list_delete_all_items (list_screen_object);
				index := 0;
				no_change_since_mark := false
			end
		end

feature {NONE} -- External features

	xm_list_add_left (scr_obj: POINTER; name: POINTER; pos: INTEGER): INTEGER is
		external
			"C"
		end;

	xm_list_delete_all_items (scr_obj: POINTER) is
		external
			"C"
		end;

	xm_list_exchange (scr_obj: POINTER; pos, value: INTEGER) is
		external
			"C"
		end;

	set_int (scr_obj: POINTER; a_count: INTEGER; name: POINTER) is
		external
			"C"
		end;

	set_unsigned_char (scr_obj: POINTER; value: INTEGER; name: POINTER) is
		external
			"C"
		end;

	c_free (value: POINTER) is
		external
			"C"
		end;

	get_int_table (value: POINTER; pos: INTEGER): INTEGER is
		external
			"C"
		end;

	get_xmint_tab (scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	xm_list_select_pos (scr_obj: POINTER; pos: INTEGER; bool: BOOLEAN) is
		external
			"C"
		end;

	xm_list_search_equal (scr_obj: POINTER; i_name: POINTER; pos: INTEGER): INTEGER is
		external
			"C"
		end;

	xm_list_set_bottom_pos (scr_obj: POINTER; pos: INTEGER) is
		external
			"C"
		end;

	xm_list_set_pos (scr_obj: POINTER; pos: INTEGER) is
		external
			"C"
		end;

	xm_remove_item (scr_obj: POINTER; i_name: POINTER) is
		external
			"C"
		end;

	xm_list_delete_pos (scr_obj: POINTER; pos: INTEGER) is
		external
			"C"
		end;

	xm_list_put (scr_obj: POINTER; i_name: POINTER; pos: INTEGER) is
		external
			"C"
		end;

	xm_free_merge_list (value: POINTER; a_count: INTEGER) is
		external
			"C"
		end;

	xmlistadditems (scr_obj: POINTER; value1: POINTER; a_count, value2: INTEGER) is
		external
			"C"
		end;

	xm_add_item_merge_list (list: POINTER; i_name: POINTER; pos: INTEGER) is
		external
			"C"
		end;

	xm_create_merge_list (a_count: INTEGER): POINTER is
		external
			"C"
		end;

	get_last_xmlist_item (scr_obj: POINTER): STRING is
		external
			"C"
		end;

	xm_list_index_of (scr_obj: POINTER; name: POINTER; pos: INTEGER): INTEGER is
		external
			"C"
		end;

	xm_list_has (scr_obj: POINTER; name: POINTER): BOOLEAN is
		external
			"C"
		end;

	get_top_item_position (scr_obj: POINTER): INTEGER is
		external
			"C"
		end;

	get_i_th_xmstring_table (scr_obj: POINTER; pos: INTEGER; name: POINTER): STRING is
		external
			"C"
		end;

	get_xmstring_tab (scr_obj: POINTER; name: POINTER): POINTER is
		external
			"C"
		end;

	get_i_th_table (table: POINTER; value2: INTEGER): STRING is
		external
			"C"
		end;

	xm_list_deselect_all_items (scr_obj: POINTER) is
		external
			"C"
		end;

	get_int (scr_obj: POINTER; name: POINTER): INTEGER is
		external
			"C"
		end;

	xm_list_add_right (scr_obj: POINTER; name: POINTER; pos: INTEGER) is
		external
			"C"
		end;

end



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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
