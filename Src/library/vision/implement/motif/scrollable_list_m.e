indexing
	description: "Scrollable lists"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	SCROLLABLE_LIST_M

inherit
	MEL_SCROLLED_LIST
		rename
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen,
			selected_item_count as selected_count,
			selected_items as mel_selected_items,
			deselect_all_items as deselect_all,
			select_item as mel_select_item,
			deselect_item as me_deselect_item,
			index_of as mel_index_of,
			is_shown as shown
		undefine
			height, real_x, real_y, realized, width,
			x, y, hide, lower, propagate_event, raise,
			realize, set_x, set_x_y, set_y, show, unrealize
		redefine
			set_size, set_height, set_width, parent
		select
			list_make_from_existing
		end
			
	PRIMITIVE_M
		rename
			is_shown as shown,
			cursor as screen_cursor
		undefine
			height, real_x, real_y, realized, shown, width,
			x, y, hide, lower, propagate_event, raise,
			realize, set_x, set_x_y, set_y, show, unrealize,
			make_from_existing, create_callback_struct,
			set_no_event_propagation, clean_up, object_clean_up
		redefine
			set_size, set_height, set_width,
			set_background_color_from_imp, set_managed, parent,
			set_widget_default
		end

	SCROLLABLE_LIST_I

	PRIMITIVE_COMPOSITE_M
		undefine
			set_no_event_propagation
		redefine
			set_size, set_height, set_width
		end;

	FONTABLE_M

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
			ll_make;
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
			!! loc_string.make_localized (s);
			add_item_unselected (loc_string, pos)
		end

feature  -- Element change

	append (s: SEQUENCE [SCROLLABLE_LIST_ELEMENT]) is
			-- Append a copy of s.
		local
			l: like s;
		do
			ll_append (s);
			l := deep_clone (s)
			from
				l.start
			until
				l.exhausted
			loop
				private_add (l.item.value, 0);
				l.forth
			end
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
				not extendible or else lin_rep.off
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

	merge_left (other: like Current) is
			-- Merge other into current structure before cursor
			-- position. Do not move cursor. Empty other.
		do
			from
				other.finish
			until
				other.before
			loop
				private_add (other.item.value, index);
				other.back
			end;
			ll_merge_left (other)
		end;

	merge_right (other: like Current) is
			-- Merge other into current structure after cursor
			-- position. Do not move cursor. Empty other.
		do
			from
				other.finish
			until
				other.before
			loop
				private_add (other.item.value, index + 1);
				other.back
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
			-- Put v at i-th position.
		-- REMPLACEMENT OU PAS ?
		do
			ll_put_i_th (v, i);
			private_add (v.value, i)
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
			!! loc_string.make_localized (v.value);
			replace_item_pos (loc_string, index);
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
			delete_pos (index);
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
				if not off then
					delete_pos (index);
					ll_prune (v)
				end
			end
		end;

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or after if no right neighbor).
		do
			delete_pos (index);
			ll_remove
		end;

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			delete_pos (index - 1);
			ll_remove_left
		end;

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		do
			delete_pos (index + 1);
			ll_remove_right
		end;

	wipe_out is
			-- Remove all items.
		do
			delete_all_items;
			ll_wipe_out
		end;

feature  -- Status report

	selected_item: SCROLLABLE_LIST_ELEMENT is
			-- Selected item if single or browse selection mode is selected
			-- Void if nothing is selected
		do
			Result := selected_items.first
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
				Result.extend (i_th (loc_selected_positions.item))
			end
		end;

	selected_position: INTEGER is
			-- Position of selected item if single or browse selection mode is
			-- selected
			-- Null if nothing is selected
		do
			Result := selected_positions.first
		end;

feature  -- Status setting

	add_click_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when items are
			-- selected with click selection mode in current scroll list.
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
			select_i_th (index)
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
		do
			set_multiple_select
		end

	set_single_selection is
			-- Set the selction to multiple items
		do
			set_single_select
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

	set_background_color_from_imp (color_imp: COLOR_X) is
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

