indexing
	description: "Scrollable lists"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	SCROLLABLE_LIST_IMP

inherit
	MEL_SCROLLED_LIST
		rename
			make as mel_make_list,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			selected_item_count as selected_count,
			selected_items as mel_selected_items,
			deselect_all_items as deselect_all,
			select_item as mel_select_item,
			deselect_item as mel_deselect_item,
			index_of as mel_index_of,
			is_shown as shown
		undefine
			height, real_x, real_y, realized, width,
			x, y, hide, propagate_event, raise,
			realize, set_x, set_x_y, set_y, show, unrealize,
			copy, setup, lower
		redefine
			set_size, set_height, set_width, parent
		select
			list_make_from_existing
		end
			
	PRIMITIVE_IMP
		rename
			is_shown as shown,
			cursor as screen_cursor
		undefine
			height, real_x, real_y, realized, shown, width,
			x, y, hide, propagate_event, raise,
			realize, set_x, set_x_y, set_y, show, unrealize,
			make_from_existing, create_callback_struct,
			set_no_event_propagation, clean_up, object_clean_up,
			copy, setup, lower
		redefine
			set_size, set_height, set_width,
			set_background_color_from_imp, set_managed, parent,
			set_widget_default
		end

	SCROLLABLE_LIST_I

	PRIMITIVE_COMPOSITE_IMP
		undefine
			set_no_event_propagation, copy, setup
		redefine
			set_size, set_height, set_width
		end;

	FONTABLE_IMP
		undefine
			copy, setup
		end

creation
	make

feature -- Initialization

	make (a_list: SCROLLABLE_LIST; man, is_fixed: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif list, get screen_object value of srolled
			-- window which contains current list.
		local
			ext_name: ANY;
			sb: MEL_SCROLL_BAR;
			mc: MEL_COMPOSITE
		do
			ll_make (10);
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_list.identifier.to_c;
			if is_fixed then
				make_constant (a_list.identifier, mc, man)
			else
				make_resize_if_possible (a_list.identifier, mc, man)
			end;
			set_navigation_to_exclusive_tab_group;
			sb := parent.vertical_scroll_bar;
			sb.set_navigation_to_exclusive_tab_group;
			sb := parent.horizontal_scroll_bar;
			if sb /= Void then
				sb.set_navigation_to_exclusive_tab_group;
			end;
			set_single_select
		end

	set_widget_default is
		local
			a_list: SCROLLABLE_LIST
		do
			a_list ?= widget_oui;
			a_list.set_font_imp (Current);		
		end;

feature -- Access

	parent: MEL_SCROLLED_WINDOW;
			-- Dialog shell parent

	main_widget: MEL_SCROLLED_WINDOW is
			-- Main widget of scroll list (scrolled window)
		do
			Result := parent
		end

feature {NONE} -- Private routines

	private_add (s: STRING; pos: INTEGER) is
		-- Add s in the visual scrollable list 
		local
			loc_string: MEL_STRING
		do
			if not is_destroyed then
				!! loc_string.make_localized (s);
				add_item_unselected (loc_string, pos);
				loc_string.destroy
			end
		end

feature  -- Element change

	append (s: SEQUENCE [SCROLLABLE_LIST_ELEMENT]) is
			-- Append a copy of s.
		local
			list: MEL_STRING_TABLE
		do
			if not is_destroyed then
				list := make_merge_list (s);
				add_items (list, 0);
				list.destroy;
			end
			ll_append (s);
		end;

	extend (v: SCROLLABLE_LIST_ELEMENT) is
			-- Add a new occurrence of v.
		do
			ll_extend (v);
			private_add (v.value, 0)
		end;

	fill (other: CONTAINER [SCROLLABLE_LIST_ELEMENT]) is
			-- Fill with as many items of other as possible.
			-- The representations of other and current structure
			-- need not be the same.
		local
			lin_rep: LINEAR [SCROLLABLE_LIST_ELEMENT]
		do
			ll_fill (other);
			lin_rep := other.linear_representation
			from
				lin_rep.start
			until
				lin_rep.after
			loop
				private_add (lin_rep.item.value, 0)
				lin_rep.forth
			end
		end;

	force (v: like item) is
			-- Add v to end.
		do
			ll_force (v);
			private_add (v.value, 0)
		end;

	merge_left (other: ARRAYED_LIST [SCROLLABLE_LIST_ELEMENT]) is
			-- Merge other into current structure before cursor
			-- position. Do not move cursor. Empty other.
		local
			list: MEL_STRING_TABLE
		do
			if not other.is_empty and then not is_destroyed then
				list := make_merge_list (other);
				add_items (list, index);
				list.destroy
			end;
			ll_merge_left (other)
		end;

	merge_right (other: ARRAYED_LIST [SCROLLABLE_LIST_ELEMENT]) is
			-- Merge other into current structure after cursor
			-- position. Do not move cursor. Empty other.
		local
			list: MEL_STRING_TABLE
		do
			if not other.is_empty and then not is_destroyed then
				list := make_merge_list (other);
				add_items (list, index + 1);
				list.destroy
			end;
			ll_merge_right (other)
		end;

	put_front (v: like item) is
			-- Add v at beginning.
			-- Do not move cursor.
		do
			ll_put_front (v);
			private_add (v.value, 1)
		end;

	put_i_th (v: like item; i: INTEGER) is
			-- Replace `i'-th item, if in index interval, by `v'.
			-- Do not move cursor.
		local
			pos: CURSOR
		do
			pos := cursor
			go_i_th (i)
			replace (v)
			go_to (pos)
		end;

	put_left (v: like item) is
			-- Add v to the left of cursor position.
			-- Do not move cursor.
		do
			private_add (v.value, index);
			ll_put_left (v)
		end;

	put_right (v: like item) is
			-- Add v to the right of cursor position.
			-- Do not move cursor.
		do
			private_add (v.value, index + 1);
			ll_put_right (v)
		end;

	replace (v: SCROLLABLE_LIST_ELEMENT) is
			-- Replace current item by v.
		local
			loc_string: MEL_STRING
		do
			if not is_destroyed then
				!! loc_string.make_localized (v.value);
				replace_item_pos (loc_string, index);
				loc_string.destroy
			end
			ll_replace (v)
		end;

feature  -- Removal

	prune (v: like item) is
			-- Remove first occurrence of v, if any,
			-- after cursor position.
			-- If found, move cursor to right neighbor;
			-- if not, make structure exhausted.
		do
			search (v);
			if not is_destroyed then
				delete_pos (index);
			end;
			ll_prune (v)
		end;

	prune_all (v: like item) is
			-- Remove all occurrences of v.
			-- (Reference or object equality,
			-- based on object_comparison.)
			-- Leave structure exhausted.
		do
			from
				start
			until
				after
			loop
				search (v);
				if not after then
					if not is_destroyed then
						delete_pos (index);
					end
					ll_prune (v)
				end
			end
		end;

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or after if no right neighbor).
		do
			if not is_destroyed then
				delete_pos (index);
			end;
			ll_remove
		end;

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			if not is_destroyed then
				delete_pos (index - 1);
			end;
			ll_remove_left
		end;

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		do
			if not is_destroyed then
				delete_pos (index + 1);
			end;
			ll_remove_right
		end;

	wipe_out is
			-- Remove all items.
		do
			if not is_destroyed then
				delete_all_items;
			end;
			ll_wipe_out
		end;

feature  -- Status report

	selected_item: SCROLLABLE_LIST_ELEMENT is
			-- Selected item if single or extended selection mode is selected
			-- Void if nothing is selected
		local
			its: like selected_items
		do
			its := selected_items;
			if not its.is_empty then
				Result := its.first
			end
		end;

	selected_items: LINKED_LIST [SCROLLABLE_LIST_ELEMENT] is
			-- Selected items
		local
			loc_selected_positions: like selected_positions
		do
			loc_selected_positions := selected_positions;
			!! Result.make;
			from
				loc_selected_positions.start
			until
				loc_selected_positions.after
			loop
				Result.extend (i_th (loc_selected_positions.item));
				loc_selected_positions.forth
			end
		end;

	selected_position: INTEGER is
			-- Position of selected item if single or extended selection mode is
			-- selected
			-- Null if nothing is selected
		local	
			pos: like selected_positions
		do
			pos := selected_positions;
			if not pos.is_empty then
				Result := pos.first
			end
		end;

feature  -- Default action callbacks
		add_default_action (a_command: COMMAND; argument: ANY) is
				-- Add `a_command' to the list of actions to
				-- execute when items are selected with double
				-- click or by pressing `RETURN' in current
				-- scroll list.
			local
				list: VISION_COMMAND_LIST
			do
				list := vision_command_list (default_action_command)
					if list = Void then
					!! list.make;
					set_default_action_callback (list, Void)
				end;
				list.add_command (a_command, argument)
			end;

		remove_default_action is 
				-- Remove all actions executed when items are
				-- selected with double click or by pressing
				-- `RETURN' in current scroll list.
			local
			do
				remove_default_action_callback 
			end;

feature  -- Status setting

	add_click_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when items are
			-- selected with click selection mode in current scroll list.
		local
			list: VISION_COMMAND_LIST
		do
			if is_single_select then
				list := vision_command_list (single_selection_command)
			else
				list := vision_command_list (extended_selection_command)
			end;
			if list = Void then
				!! list.make;
				if is_single_select then
					set_single_selection_callback (list, Void)
				else
					set_extended_selection_callback (list, Void)
				end
			end;
			list.add_command (a_command, argument)
		end;

	remove_click_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when items are
			-- selected with click selection mode in current scroll list.
		do
			if is_single_select then
				remove_command (single_selection_command, a_command, argument)
			else
				remove_command (extended_selection_command, a_command, argument)
			end
		end;

	select_item is
			-- Select item at current position.
		do
			select_i_th (index)
		end;

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

	deselect_item is
			-- Deselect item at current position.
		do
			deselect_i_th (index)
		end;

	select_i_th (i: INTEGER) is
			-- Select item at `i'-th position.
		do
			select_pos (i, False)
		end;

	deselect_i_th (i: INTEGER) is
			-- Deselect item at `i'-th position.
		do
			deselect_pos (i)
		end;

	set_multiple_selection is
			-- Set the selction to multiple items
		local
			list: VISION_COMMAND_LIST
		do
			if is_single_select then
				set_extended_select;
				list := vision_command_list (single_selection_command);
				if list /= Void then
					remove_single_selection_callback;
					set_extended_selection_callback (list, Void)
				end;
			end
		end;

	set_single_selection is
			-- Set the selction to multiple items
		local
			list: VISION_COMMAND_LIST
		do
			if is_extended_select then
				list := vision_command_list (extended_selection_command);
				set_single_select;
				if list /= Void then
					remove_extended_selection_callback;
					set_single_selection_callback (list, Void)
				end
			end
		end

feature -- Status setting

	set_managed (flag: BOOLEAN) is
			-- Enable geometry managment on screen widget implementation,
			-- by window manager of parent widget if `flag', disable it
			-- otherwise.
		do
			if flag then
				parent.manage;
				manage;
			else
				parent.unmanage;
				unmanage;
			end
		end;

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Set both width and height to `new_width'
			-- and `new_height'.
		local
			was_shown, was_unmanaged: BOOLEAN
		do
			if not managed then
				manage;
				was_unmanaged := True
			end;
			parent.set_size (new_width, new_height)
			if was_unmanaged then
				manage
			end
		end;

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
		local
			was_unmanaged: BOOLEAN
		do
			if not managed then
				manage
				was_unmanaged := True
			end;
			parent.set_width (new_width)
			if was_unmanaged then
				unmanage
			end
		end;

	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		local
			was_unmanaged: BOOLEAN;
		do
			if not managed then
				manage
				was_unmanaged := True
			end;
			parent.set_height (new_height);
			if was_unmanaged then
				unmanage
			end
		end;

	set_background_color_from_imp (color_imp: COLOR_IMP) is
			-- Set the background color from implementation `color_imp'.
		local
			w: MEL_WIDGET
		do
			mel_set_background_color (color_imp);
			update_colors;
			parent.set_background_color (color_imp)
			w := parent.vertical_scroll_bar;
			if w /= Void then
				w.set_background_color (color_imp);
				w.update_colors
			end;
			w := parent.horizontal_scroll_bar;
			if w /= Void then
				w.set_background_color (color_imp);
				w.update_colors
			end;
			if private_foreground_color /= Void then
				update_foreground_color
			end
		end

feature -- Update

	update is
			-- Update the content of the scrollable list from
			-- `list'.
		local
			list: MEL_STRING_TABLE;
			pos: INTEGER
		do
			pos := index;
			list := make_merge_list (Current);
			delete_all_items;
			add_items (list, 0);
			if pos > count then
				finish
			else
				go_i_th (pos);
			end;
			list.destroy;
		end;

feature {NONE} -- Implementation
	
	make_merge_list (other: SEQUENCE [SCROLLABLE_LIST_ELEMENT]): MEL_STRING_TABLE is
			-- Make a merge list to `merge_left' and `merge_right'.
		require
			other_exists: other /= Void
		local
			i: INTEGER;
			value: STRING
		do
			if not other.is_empty then
				!! Result.make (other.count);
				from
					other.start;
					i := 1
				until
					other.after
				loop
					value := other.item.value;
					Result.put_string (other.item.value, i);
					i := i + 1;
					other.forth
				end;
				other.start
			end
		end;

end -- class SCROLLABLE_LIST_IMP



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

