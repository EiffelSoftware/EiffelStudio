
-- Rectangle with scrollbars or not which contains a list of
-- selectable strings.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class LIST_MAN_O 

inherit

	LIST_R_O
		export
			{NONE} all
		end;

	LIST_MAN_I
		export
			{NONE} all
		end;

	LINKED_LIST [STRING]
		rename
			add_right as list_add_right,
			add_left as list_add_left,
			put as list_put,
			remove as list_remove,
			merge_right as list_merge_right,
			merge_left as list_merge_left,
			make as list_make,
			remove_left as list_remove_left,
			remove_right as list_remove_right
		export
			{NONE} all
		redefine
			wipe_out
		end;
		
	LINKED_LIST [STRING]
		rename
			make as list_make,
			remove_left as list_remove_left,
			remove_right as list_remove_right
		export
			{ANY} add_left, add_right, 
				back, count, 
				duplicate, empty, 
				finish, first, 
				forth, go, 
				has, i_th, 
				index_of, isfirst, 
				islast, item, 
				last, 
				merge_left, merge_right, 
				move, off, 
				before, after, 
				index, put_i_th, 
				start, 
				swap
		redefine
			wipe_out, add_right, add_left, 
			merge_right, merge_left, remove, put
		select
			add_right, add_left, 
			merge_right, merge_left, remove, put
		end;
			
feature {NONE} -- Openlook list operations

	screen_object: POINTER is 
		deferred
		end;

	items_list: SCROLL_ITEM_L;

	token (a_string: STRING): INTEGER is
		do
			Result := items_list.item_token (a_string)
		end; -- token

	remove_item (a_string: STRING) is
		do
			items_list.remove_item_name (a_string)
		end;

	remove_token (a_token: INTEGER) is
		do
			items_list.remove_item_token (a_token)
		end;

	store_new_item (a_token: INTEGER; a_name: STRING) is
		do
			items_list.add_scroll_item (a_token, a_name);
		end;
	
feature -- Insertions

	add_right (v: like first) is
				-- Put item `v' to the right of cursor index.
				-- Do not move cursor.
		local
			ext_name: ANY;
		do
			ext_name := v.to_c;
			if empty or else islast then
				store_new_item (c_append_item (screen_object, $ext_name, index), v)
			else
				forth;
				store_new_item (c_insert_item (screen_object, $ext_name, index+1, token (item)), v);
				back;
			end;
			list_add_right (v);
		ensure then
			count = old count + 1;
			active = old active;
			index = old index;
			not (next = Void);
			next.item = v
		end;

	add_left (v: like first) is
				-- Put item `v' to the left of cursor index.
				-- Do not move cursor.
		local
			ext_name: ANY;
		do
			ext_name := v.to_c;
			if empty then
				store_new_item (c_append_item (screen_object, $ext_name, index), v)	
			else
				store_new_item (c_insert_item (screen_object, $ext_name, index+1, token (item)), v)
			end;
			list_add_left (v);
		ensure then
			count = old count + 1;
			active = old active;
			(not (index = 2)) implies (index = old index + 1);
			not (previous = Void);
			previous.item = v
		end;

	put (v: like first) is
			-- Put item `v' at cursor index.
		local
			ext_name: ANY;
		do
			c_remove_token (screen_object, token (item));
			ext_name := v.to_c;		
			if islast then
				store_new_item (c_append_item (screen_object, $ext_name, index), v);
			else
				forth;
				store_new_item (c_insert_item (screen_object, $ext_name, index, token (item)), v);
				back;
			end;
			list_put (v);
		end;

	merge_left (other: like Current) is
		do
			from
				other.start;
				c_prevent_list_update (screen_object);
			until
				other.after
			loop
				add_left (other.item);
				other.forth
			end;
			list_merge_left (other);
			c_update_list (screen_object);
		end;

	merge_right (other: like Current) is
		do
			from
				other.finish;
				c_prevent_list_update (screen_object);;
			until
				other.before
			loop
				add_right (other.item);
				other.back
			end;
			list_merge_right (other);
			c_update_list (screen_object);
		end;

feature	--Deletions

	remove_right (n: INTEGER) is
            -- Remove min (`n', count - position) items
            -- to the right of cursor position.
            -- Do not move cursor.
        do
        end; 

	remove_left (n: INTEGER) is
            -- Remove min (`n', index - 1) items
            -- to the left of cursor position.
            -- Do not move cursor
            -- (but its position will be decreased by up to n).
        do
        end;

	remove is
			-- Remove item at cursor index
			-- and move cursor to its right neigbor
			-- (or after if no right neighbor).
		do
			c_remove_token (screen_object, token (item));
			remove_item (item);
			list_remove
		end;

	wipe_out is
			-- Make list empty
		do
			from
				start
			until
				empty
			loop
				remove;
			end;
		end;
	
feature	-- Selection

	selected_position: INTEGER is
			-- Position of selected item if single or browse selection mode is selected
			-- Void if nothing is selected
		local
			token_read: INTEGER
		do
			if selected_count = 1 then
				token_read := c_get_selected_token (screen_object);
				Result := items_list.item_position (token_read)
			end
		end;

	select_item is
			-- Select item at current position.
		require else
			not_off: not off
		do
			select_i_th (index)
		end;

	selected_item: STRING is
			-- Selected item if single or browse selection mode is selected
			-- Void if nothing is selected
		local
			token_read: INTEGER
		do
			if selected_count = 1 then
				token_read := c_get_selected_token (screen_object);
				Result := items_list.item_name (token_read)
			end;
		end; 

	scroll_to_current is
			-- Make `item' the first visible item in the list if
			-- `index' < `first_visible_item_index'.
			-- Make `item' the last visible item in the list if
			-- `index' >= `first_visible_item_index'+`visible_item_count'.
			-- Do nothing if `item' is visible.
		require else
			not_off: not off
		do
			show_current	
		end;

	selected_count: INTEGER is
			-- Number of items selected in current list
		do
			Result := 1;
		end;

	set_visible_item_count (a_count: INTEGER) is
			-- Set the number of visible items to `a_count'.
		require else
			a_count_large_enough: a_count >0
		local
			ext_name: ANY;
		do
			ext_name := OvisibleItemCount.to_c;		
			set_int (screen_object, a_count, $ext_name)
		end;

	show_current is
			-- Make item at current index the first visible item.
		require else
			not_off: not off
		do
			show_i_th (index)
		end;

	show_first is
			-- Make first item the first visible item.
		do
			if not empty then
				show_i_th (1)
			end
		end;

	show_i_th (i: INTEGER) is
			-- Make item at `i'-th index the first visible item.
			-- Move cursor position to `i'.
		require else
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		do
			go_i_th (i);
			c_show_item_at_first (screen_object, token (item));
		end;

	show_last is
			-- Make last item the last visible item.
		local
			count_local, visible_item_count_local : INTEGER
		do
			if not empty then
				count_local := count;
				visible_item_count_local := visible_item_count;
				if visible_item_count_local < count_local then
					show_i_th (1+count_local-visible_item_count_local)
				else
					show_first
				end
			end
		end; 

	visible_item_count: INTEGER is
			-- Number of visible item of current list
		local
			ext_name: ANY;
		do
			ext_name := OvisibleItemCount.to_c;		
			Result := get_int (screen_object, $ext_name);
		ensure then
			visible_item_count_large_enough: Result >0
		end; 

	first_visible_item_position: INTEGER is
			-- Position of the first visible item in the list
			--! not implemented
		do	
			if not empty then
				if Result = 0 then
					Result := count
				end
			end
		ensure then
			Result <= count;
			empty = (Result = 0)
		end; 

	set_single_selection is
			-- Set selection mode of current list to
			-- single. At most only one item can be selected
			-- at a time.
		do
		end; 
	
feature {NONE}

	widget_oui: WIDGET is
			-- Object user interface widget associated with current
			-- implementation
		deferred
		end;

feature	-- Callback

	add_single_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with single selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (single_actions = Void) then
				!!single_actions.make (screen_object, OuserMakeCurrent, widget_oui, Current)
			end;
			single_actions.add (a_command, argument)
		end;

	remove_single_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with single selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
			single_actions.remove (a_command, argument)
		end;

feature {NONE}

	single_actions: SINGLE_SEL_O;
			-- An event handler to manage call-backs when items are selected
			-- with single selection mode in current scroll list

feature -- Selection

	deselect_all is
			-- Deselect all selected items.
		do
			c_deselect_item (screen_object)			
		ensure then
			selected_list_is_empty: selected_count = 0
		end;

	select_i_th (i: INTEGER) is
			-- Select item at `i'-th index.
			-- Move cursor position to `i'.
		require else
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		do
			go_i_th (i);		
			c_select_item (screen_object, token (item))
		end;

feature

	set_browse_selection is
			-- Set selection mode of current list to
			-- browse. At most only one item can be selected
			-- at a time but dragging select button moves
			-- the selection along with the cursor.
		
		do
		end; -- set_browse_selection

	set_extended_selection is
			-- Set selection mode of current list to
			-- extended. Any number of items can be selected
			-- at any time using dragging mode, otherwise
			-- pressing an item selects it but deselect any
			-- other selected items.
		
		do
		end;

	set_multiple_selection is
			-- Set selection mode of current list to
			-- multiple. Any item can be selected at any
			-- time in this mode.
		
		do
		end;

	add_browse_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with browse selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
		end;

	add_click_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with click selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
		end;

	add_extended_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with extended selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
		end;

	add_multiple_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when items are
			-- selected with multiple selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
		end;
	
feature {NONE}

	browse_actions: EVENT_HAND_O;
			-- An event handler to manage call-backs when items are selected
			-- with browse selection mode in current scroll list

	click_actions: EVENT_HAND_O;
			-- An event handler to manage call-backs when items are selected
			-- with click selection mode in current scroll list

	extended_actions: EVENT_HAND_O;
			-- An event handler to manage call-backs when items are selected
			-- with extended selection mode in current scroll list

	multiple_actions: EVENT_HAND_O;
			-- An event handler to manage call-backs when items are selected
			-- with multiple selection mode in current scroll list

feature 

	selected_items: LINKED_LIST [STRING] is
		do
		end;

	selected_positions: LINKED_LIST [INTEGER] is
		do
		end;

	remove_browse_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with browse selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
		end;

	remove_click_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with click selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
		end;

	remove_extended_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with extended selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
		end; 

	remove_multiple_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with multiple selection mode in current scroll list.
		require else
			not_a_command_void: not (a_command = Void)
		do
		end;

feature {NONE} -- External features

	c_append_item (scr_obj: POINTER; a_name: ANY; pos: INTEGER): INTEGER is
		external
			"C"
		end;

	c_insert_item (scr_obj: POINTER; a_name: ANY; pos: INTEGER; ref: INTEGER): INTEGER is
		external
			"C"
		end;

	c_select_item (scr_obj: POINTER; a_token: INTEGER) is
		external
			"C"
		end;

	c_deselect_item (scr_obj: POINTER) is
		external
			"C"
		end;

	c_update_list (scr_obj: POINTER) is
		external
			"C"
		end;

	c_prevent_list_update (scr_obj: POINTER) is
		external
			"C"
		end;

	set_unsigned_char (scr_obj: POINTER; val: INTEGER; resource: ANY) is
		external
			"C"
		end;

	c_get_selected_token (scr_obj: POINTER) : INTEGER is
		external
			"C"
		end; 

	c_show_item_at_first (scr_obj: POINTER; a_token: INTEGER) is
		external
			"C"
		end; 

	set_int (scr_obj: POINTER; val: INTEGER; resource: ANY) is
		external
			"C"
		end; 

	get_int (scr_obj: POINTER; resource: ANY): INTEGER is
		external
			"C"
		end; 

	c_remove_token (scr_obj: POINTER; a_token: INTEGER) is
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
