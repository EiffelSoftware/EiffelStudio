indexing
	description: "Scrollable lists"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	SCROLLABLE_LIST_IMP

inherit
	PRIMITIVE_IMP
		rename
			screen_cursor as windows_cursor,
			cursor as screen_cursor,
			on_key_down as primitive_on_key_down
		redefine
			realize, unrealize,
			set_height, set_size, set_width,
			set_widget_default
		end
		
	SCROLLABLE_LIST_I
		rename
			resize as arrayed_list_resize,
			copy as arrayed_list_copy
		select
			arrayed_list_copy
		end

	FONTABLE_I

	FONTABLE_IMP

	SIZEABLE_WINDOWS

	WEL_LIST_BOX
		rename
			add_string as wel_add_string,
			delete_string as wel_delete_string,
			insert_string_at as wel_insert_string_at,
			make as wel_make,
			item as wel_item,
			set_width as wel_set_width,
			set_y as wel_set_y,
			set_x as wel_set_x,
			width as wel_width,
			count as wel_count,
			show as wel_show,
			font as wel_font,
			height as wel_height,
			destroy as wel_destroy,
			set_height as wel_set_height,
			hide as wel_hide,	
			set_font as wel_set_font,
			shown as wel_shown,
			parent as wel_parent,
			y as wel_y,
			x as wel_x,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			move as wel_move,
			set_capture as wel_set_capture,
			release_capture as wel_release_capture,
			set_text as wel_set_text,
			set_focus as wel_set_focus,
			text as wel_text,
			text_length as wel_text_length,
			select_item as select_item_at
		undefine
			on_show,
			on_hide,
			on_move,
			on_size,
			on_right_button_up,
			on_left_button_down,
			on_left_button_up,
			on_right_button_down,
			on_mouse_move,
			on_destroy,
			on_set_cursor,
			on_key_up,
			background_brush
		redefine
			on_lbn_selchange,
			on_lbn_errspace,
			on_lbn_dblclk,
			on_key_down,
			default_ex_style,
			on_erase_background	
		end

	WEL_LBS_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature -- Initialization

	make (a_scrollable_list: SCROLLABLE_LIST; is_managed, is_fixed: BOOLEAN;
			oui_parent: COMPOSITE) is
		do
			ll_make (10)
			!! private_attributes
			parent ?= oui_parent.implementation
			managed := is_managed
			private_attributes.set_width (100)
			private_attributes.set_height (100)
			private_visible_item_count := 6
			fixed_size_flag := is_fixed
		end

	realize is
			-- Realize the list box.
		do
			if not realized then
				if not has_width then
					set_width (100)
					has_width := False
				end
				create_list_box
				fill_list_box
				select_the_items
				if private_visible_item_count > 0 then
					set_visible_item_count (private_visible_item_count)
				elseif not has_height and not fixed_size then 
					if count > 0 then
						set_visible_item_count (count) 
					else
						set_visible_item_count (1)
					end
					has_height := false
				end
				private_scroll_width := wel_width

				if private_font /= Void then
					set_font (private_font)
				end

				if not managed then
					wel_hide
				elseif parent.shown then
					shown := true
				end
			end
		end

	unrealize is
			-- Destroy the list box.
		do
			wel_destroy
		end

feature  -- Access

	scroll_to_current is
			-- Scroll to currently selected item.
		do
			if realized and then selected then
				if multiple_selection then
					set_top_index (private_selected_positions.first - 1)
				else
					set_top_index (private_selected_position - 1)
				end
			end
		end

	deselect_i_th (a_index: INTEGER) is
			-- Deselect item at position `a_index' if selected.
		do
			if is_selected (a_index - 1) then
				private_deselect (a_index)
			end
		end

	deselect_item is
			-- Deselect current item if selected.
		do
			if is_selected (index - 1) then
				private_deselect (index)
			end
		end
			
	selected: BOOLEAN is
			-- Is there at least one item selected?
		do
			if wel_item /= default_pointer then
				if multiple_selection then
					Result := count_selected_items > 0
				else
					Result := cwin_send_message_result (wel_item,
						Lb_getcursel, 0, 0) /= Lb_err
				end
			end
		end

	count_selected_items: INTEGER is
			-- Number of items selected
		require
			exits: exists
			multiple_selection: multiple_selection
		do
			Result := cwin_send_message_result (wel_item,
				Lb_getselcount, 0, 0)
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result <= count
		end

	select_item_at (a_index: INTEGER) is
			-- Select item at position `a_index'.
		do
			if multiple_selection then
				cwin_send_message (wel_item, Lb_setsel, 1, a_index)
			else
				cwin_send_message (wel_item, Lb_setcursel, a_index, 0)
			end
		ensure then
			selected: not multiple_selection implies selected
		end

	selected_count: INTEGER is
			-- Number of selected items in current list
		do
			if multiple_selection then
				Result := count_selected_items
			elseif selected then
				Result :=1
			end
		end

	selected_item: SCROLLABLE_LIST_ELEMENT is
			-- Selected item if single or browse selection mode is selected
			-- Void if nothing is selected
		do
			if selected then
				if multiple_selection then
					if not private_selected_positions.empty then
						Result := i_th (private_selected_positions.first)
					end
				else
					Result := i_th (private_selected_position)
				end
			end
		end

	selected_items: LINKED_LIST [SCROLLABLE_LIST_ELEMENT] is
			-- Selected items
		do
			if selected then
				if multiple_selection then
					!! Result.make
					from
						private_selected_positions.start
					until
						private_selected_positions.after
					loop
						Result.extend (i_th (private_selected_positions.item))
						private_selected_positions.forth
					end
				else
					!! Result.make
					Result.extend (i_th (private_selected_position))
				end
			end
		end

	selected_position: INTEGER is
			-- Position of selected item if single or browse selection mode is
			-- selected
			-- Position of the first selected item, if in multiple_selection mode
			-- 0 if nothing is selected			
		do
			if multiple_selection then
				if not private_selected_positions.empty then
					Result := private_selected_positions.first
				end
			else
				Result := private_selected_position
			end
		end

	selected_positions: LINKED_LIST [INTEGER] is
			-- Positions of the selected items
			-- Void if single selection
		do
			Result := private_selected_positions	
		end

	visible_item_count: INTEGER is
			-- Number of visible item of list
		do
			Result := private_visible_item_count
		end

feature -- Status report

	multiple_selection: BOOLEAN
			-- Is the list capable of multiple selection?

feature -- Default action callbacks
	add_default_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute
			-- when items are selected with double click or by
			-- pressing 'RETURN'
			-- in current scroll list.
		do
			default_actions.add (Current, a_command, argument)
		end

	remove_default_action  is
			-- Remove all actions executed 
			-- when items are selected with click double click or by
			-- pressing 'RETURN'
			-- in current scroll list.
		do
			default_actions.delete (Current)
		end



feature -- Status setting

	add_click_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute
			-- when items are selected with click selection mode
			-- in current scroll list.
		do
			selection_change_actions.add (Current, a_command, argument)
		end

	deselect_all is
			-- Deselect all selected items.
		do
			if realized then
				if multiple_selection then
					unselect_all_items
				else
					unselect_single_item
				end
			end
			if multiple_selection then
				private_selected_positions.wipe_out
			else
				private_selected_position := 0
			end
		end

	remove_click_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute
			-- when items are selected with click selection mode in
			-- current scroll list.
		do
			selection_change_actions.remove (Current, a_command,
				argument)
		end

	select_item is
			-- Select item at current position.
		do
			private_select (index)
		end

	select_i_th (i: INTEGER) is
			-- Select item at `i'-th position.
		do
			private_select (i)
		end

	set_multiple_selection is
			-- Set the selection to multiple items
		do
			multiple_selection := True
		end

	set_single_selection is
			-- Set the selection to single items
		do
			multiple_selection := False
		end

	set_visible_item_count (a_count: INTEGER) is
			-- Set the number of visible items to `a_count'.
		do
			private_visible_item_count := a_count
			if realized then
				set_height (a_count * item_height + 2 * Border_height)
			end
		end

	set_size (new_width, new_height: INTEGER) is
			-- Set the height to closest `new_height' possible
			-- and the width to `new_width'.
		local
			a_visible_count: INTEGER
		do
			private_attributes.set_height (new_height)
			private_attributes.set_width (new_width)
			has_width := True
			has_height := True
			if realized then
				a_visible_count := new_height // item_height
				private_attributes.set_height (a_visible_count * item_height +
					2 * Border_height)
				private_attributes.set_width (new_width)
				set_visible_item_count (a_visible_count)
				set_width (new_width)
			end
			if parent /= Void then
				parent.child_has_resized
			end
		end

	set_width (new_width: INTEGER) is
			-- Set the width to `new_width'
		do
			has_width := True
			if realized then
				wel_set_width (new_width)
			end
			private_attributes.set_width (new_width)
			if parent /= Void then
				parent.child_has_resized
			end
		end

	set_height (new_height: INTEGER) is
			-- Set the height to closest `new_height' possible.
		local
			a_visible_count: INTEGER
		do
			private_attributes.set_height (new_height)
			has_height := True
			if realized then
				a_visible_count := new_height // item_height
				private_attributes.set_height (a_visible_count * item_height +
					2 * Border_height)
				wel_set_height (a_visible_count * item_height +
					2 * Border_height)
			end
			if parent /= Void then
				parent.child_has_resized
			end
		end

	valid_height (a_height: INTEGER): BOOLEAN is
			-- Is `a_height' valid?
		do
			Result := (count * item_height + 2 * Border_height) = a_height
		end

feature -- Element change

	extend (an_item: SCROLLABLE_LIST_ELEMENT) is
			-- Add `an_item' to end.
			-- Do not move cursor.
		do
			ll_extend (an_item)
			if realized then
				private_add (an_item.value, 0)
			end
		end

	put_right (an_item: SCROLLABLE_LIST_ELEMENT) is
			-- Add `an_item' to the right of cursor position.
			-- Do not move cursor.
		do
			ll_put_right (an_item)
			if realized then
				private_add (an_item.value, index + 1)
			end
		end

	wipe_out is
			-- Remove all items.
		do
			ll_wipe_out
			if realized then
				reset_content
			end
		end

	prune (an_item: SCROLLABLE_LIST_ELEMENT) is
			-- Remove first occurrence of `an_item', if any,
			-- after cursor position.
			-- If found, move cursor to right neighbor;
			-- if not, make structure `exhausted'.
		local
			i: INTEGER
		do
			ll_prune (an_item)
			if exhausted then
				index := 1
			end
			if realized then
				i := find_string_exact (index - 1, an_item.value)
					-- i is a zero-based index
				if i /= -1 then
					private_delete (i + 1)
				end
			end
		end

	put_front (an_item: SCROLLABLE_LIST_ELEMENT) is
			-- Add `an_item' to beginning.
			-- Do not move cursor.
		do
			ll_put_front (an_item)
			if realized then
				private_add (an_item.value, 1)
			end
		end

	put_i_th (an_item: SCROLLABLE_LIST_ELEMENT; i: INTEGER) is
			-- Replace `i'-th item, if in index interval, by `an_item'.
			-- Do not move cursor.
		local
			pos: CURSOR
		do
			pos := cursor
			go_i_th (i)
			replace (an_item)
			go_to (pos)
		end

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor).
		do
			if realized then
				private_delete (index)
			end
			ll_remove
		end

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		do
			if realized then
				private_delete (index + 1)
			end
			ll_remove_right
		end

	put_left (an_item: SCROLLABLE_LIST_ELEMENT) is
			-- Add `an_item' to the left of cursor position.
			-- Do not move cursor.
		do
			ll_put_left (an_item)
			if realized then
				private_add (an_item.value, index - 1)
			end
		end

	append (s: SEQUENCE [SCROLLABLE_LIST_ELEMENT]) is
			-- Append a copy of `s'.
		local
			l: like s
		do
			ll_append (s)
			if realized then
				l := deep_clone (s)
				from
					l.start
				until
					l.exhausted
				loop
					private_add (l.item.value, 0)
					l.forth
				end
			end
		end

	replace (an_item: SCROLLABLE_LIST_ELEMENT) is
			-- Replace current item by `v'.
		do
			if realized then
				if 1 <= index and then index <= wel_count then
					private_delete (index)
				end
				private_add (an_item.value, index)
			end
			ll_replace (an_item)
		end

	prune_all (an_item: SCROLLABLE_LIST_ELEMENT) is
			-- Remove all occurrences of `an_item'.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			-- Leave structure `exhausted'.
		local
			i: INTEGER
		do
			if realized then
				from
					i := find_string_exact (0, an_item.value)
				until
					i = - 1
				loop
					if wel_count > 0 then
						i := find_string_exact (0, an_item.value)
					else
						i := -1
					end
					if i /= -1 then
						private_delete (i + 1)
					end
				end
			end
			ll_prune_all (an_item)
		end

	merge_left (other: like Current) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'.
		do
			if realized then
				from
					other.start
				until
					other.after
				loop
					private_add (other.item.value, index - 1)
					other.forth
				end
			end
			ll_merge_left (other)
		end

	merge_right (other: like Current) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'.
		local
			i: INTEGER
		do
			i := index
			if realized then
				from
					other.start
				until
					other.after
				loop
					i := i + 1
					private_add (other.item.value, i)
					other.forth
				end
			end
			ll_merge_right (other)
		end

	force (an_item: SCROLLABLE_LIST_ELEMENT) is
			-- Add `an_item' to end.
		do
			extend (an_item)
		end

	fill (other: CONTAINER [SCROLLABLE_LIST_ELEMENT]) is
			-- Fill with as many items of `other' as possible.
			-- The representations of `other' and current structure
			-- need not be the same.
		local
			lin_rep: LINEAR [SCROLLABLE_LIST_ELEMENT]
		do
			if realized then
				lin_rep := other.linear_representation
				from
					lin_rep.start
				until
					not extendible or else lin_rep.off
				loop
					private_add (lin_rep.item.value, 0)
					lin_rep.forth
				end
			end
			ll_fill (other)
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			if realized then
				private_delete (index - 1)
			end
			ll_remove_left
		end

feature {NONE} -- Implementation

	private_visible_item_count: INTEGER
			-- Count of visible items

	private_selected_position: INTEGER
			-- Selected position
			--|Single selection mode

	private_selected_positions: LINKED_LIST [INTEGER]
			-- Selected positions
			--|Multiple selection mode

	private_scroll_width: INTEGER
			-- Scrollable width of the list box

	private_select (i: INTEGER) is
			-- Selection of item `i'
		require
			positive_i: i > 0
			valid_i: i <= count
		do
			if realized then
				select_item_at (i - 1)
			end
			if
				multiple_selection
				and then not private_selected_positions.has (i)
			then
				private_selected_positions.extend (i)
			else
				private_selected_position := i
			end
		end

	private_deselect (a_index: INTEGER) is
			-- Deselect item at position `a_index' and
			-- update private attributes.
		require
			item_selected: is_selected (a_index - 1)
		do
			if multiple_selection then
				cwin_send_message (wel_item, Lb_setsel, 0, a_index - 1)
				private_selected_positions.prune (a_index)
			else
				cwin_send_message (wel_item, Lb_setcursel, -1, 0)
				private_selected_position := 0
			end
		ensure
			not_item_selected: not is_selected (a_index - 1)
		end

	private_add (s: STRING; pos: INTEGER) is
			-- Add a string and resize if necessary.
		local
			a_font_windows: FONT_IMP
		do
			if realized then
				if fixed_size_flag then
					a_font_windows ?= font.implementation
					if a_font_windows.string_width (Current, s) >= private_scroll_width then
						private_scroll_width := a_font_windows.string_width (Current, s)
						set_horizontal_extent (private_scroll_width + 10)
						show_horizontal_scroll_bar
					end
				end
			-- WEL list start from zero
				if pos = 0 then
					wel_add_string (s)
				else
					wel_insert_string_at (s, pos - 1)
				end
			end
			-- Change the selection, if added element affected it
			if
				multiple_selection and then
				not private_selected_positions.empty and then pos < private_selected_positions.first or else
				not multiple_selection and then pos < private_selected_position
			then
				update_private_selection
			end
		end

	private_delete (pos: INTEGER) is
			-- Delete a string and resize if necessary.
		require
			exists: exists
			pos_large_enough: pos >= 1
			pos_small_enough: pos <= wel_count
		local
			s: STRING
			a_font_windows: FONT_IMP
			a_width: INTEGER
		do
			s := clone (i_th_text (pos - 1))
			wel_delete_string (pos - 1)
				-- WEL list starts from zero
			if realized then
				a_font_windows ?= font.implementation
				if fixed_size_flag then
					if private_scroll_width > wel_width then
						if not (a_font_windows.string_width (Current, s) < private_scroll_width) then
							a_width := longest_string_width
							set_horizontal_extent (a_width)
							if a_width <= wel_width then
								hide_horizontal_scroll_bar
								private_scroll_width := wel_width
							else
								private_scroll_width := a_width
							end
						end
					end
				else
					if a_font_windows.string_width (Current, s) >= wel_width then
						a_width := longest_string_width
						set_width (a_width)
					end
				end
			end
		end

	longest_string_width: INTEGER is
			-- Width of the longest string
		local
			i: INTEGER
			a_font_windows: FONT_IMP
		do
			a_font_windows ?= font.implementation
			from
				i := 0
			until
				i >= wel_count
			loop
				Result := Result.max (a_font_windows.string_width (parent,
					i_th_text (i)))
				i := i + 1
			end
		end

	unselect_all_items is
			-- Unselect all the selected items.
		require
			exists: exists
			multiple_selection: multiple_selection
		do
			unselect_items (0, count - 1)
		ensure
			count_items_selected: count_selected_items = 0
		end

	unselect_items (start_index, end_index: INTEGER) is
			-- Unselect items between `start_index'
			-- and `end_index' (zero-based index).
		require
			exists: exists
			multiple_selection: multiple_selection
			valid_range: end_index >= start_index
			start_index_small_enough: start_index < count
			start_index_large_enough: start_index >= 0
			end_index_small_enough: end_index < count
			end_index_large_enough: end_index >= 0
			valid_range: end_index >= start_index
		do
			cwin_send_message (wel_item, Lb_selitemrange, 0,
				cwin_make_long (start_index, end_index))
			private_selected_positions.wipe_out
		ensure
			no_selection: count_selected_items = 0
		end

	unselect_single_item is
			-- Unselect the selected item.
		require
			exists: exists
			single_selection: not multiple_selection
		do
			cwin_send_message (wel_item, Lb_setcursel, -1, 0)
			private_selected_position := 0
		ensure
			unselected: not selected
		end

	update_private_selection is
			-- Updates the private selection
		local
			i: INTEGER
		do
			if multiple_selection then
				from
					i := 0
					private_selected_positions.wipe_out
				until
					i >= wel_count
				loop
					if is_selected (i) then
						private_selected_positions.extend (i + 1)
					end
					i := i + 1
				end
			else
				from
					i := 0
					private_selected_position := 0
				until
					i >= wel_count or private_selected_position /= 0
				loop
					if is_selected (i) then
						private_selected_position := i + 1
					end
					i := i + 1
				end
			end
		end


	on_lbn_selchange is
			-- The selection is changed, update the
			-- private attributes.
	
		do
			update_private_selection

		-- Feature add_click_action of SCROLLABLE_LIST did not work
		-- because of this if-clause.
		-- After commenting this out, add_click_action works
		-- 	if not multiple_selection then
				selection_change_actions.execute (Current, Void)
		--	end
		end

	on_lbn_errspace is
			-- Cannot allocate enough memory
			-- to meet a specific request
		local
			msg_box: WEL_MSG_BOX
		do
			!! msg_box.make
			msg_box.information_message_box (Void, "Cannot allocate enough memory to%
				% perform request!", "Error")
		end

	on_lbn_dblclk is
			-- List item is double clicked
			-- This feature implements the default action together 
			-- with feature on_key_down
		do
			default_actions.execute (Current, Void)
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- a key is pressed when an item is selected. 
			-- This procedure checks if the pressed key is 
			-- 'RETURN' and executes the default action then.
			-- This feature implements the default action together 
			-- with feature on_lbn_dblclk 
		do
			primitive_on_key_down (virtual_key, key_data)
			if virtual_key = Vk_return then
				default_actions.execute (Current, Void)
			end
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
		end

	has_width: BOOLEAN
			-- Is the default width overruled?

	has_height: BOOLEAN
			-- Is the default height overruled?

	Border_height: INTEGER is
			-- Height of the border
		once
			Result := window_border_height
		end

	create_list_box is
			-- Create the list
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			if multiple_selection then
				!! private_selected_positions.make
			end
			wc ?= parent
			wel_make (wc, x, y, width, height, id_default)
		end

	default_style: INTEGER is
			-- Style for creation
		do
			if multiple_selection then
				Result := Ws_visible + Ws_child + Ws_group +
					Ws_tabstop + Ws_border + Ws_vscroll +
					Lbs_notify + Lbs_multiplesel +
					Lbs_nointegralheight + Ws_hscroll
			else
				Result := Ws_visible + Ws_child + Ws_group +
					Ws_tabstop + Ws_border + Ws_vscroll +
					Lbs_notify + Ws_hscroll +
					Lbs_nointegralheight
			end
		end

	default_ex_style: INTEGER is
			-- Extended style for creation
		do
			Result := Ws_ex_clientedge
		end

	fill_list_box is
			-- Fill the box with the items.
		local
			pos: INTEGER
		do
			from
				pos := index
				start
			variant
				count + 1 - index
			until
				after
			loop
				private_add (item.value, 0)
				forth
			end
			go_i_th (pos)
		ensure
			consistent_count: count = wel_count
		end

	select_the_items is
			-- Select the selected items in the list box.
		do
			if multiple_selection then
				from
					private_selected_positions.start
				until
					private_selected_positions.after
				loop
					select_item_at (
						private_selected_positions.item - 1)
					private_selected_positions.forth
				end
			else
				if private_selected_position /= 0 then
					select_item_at (
						private_selected_position - 1)
				end
			end
		end

	set_widget_default is
			-- Set the defaults for current widget.
		local
			sl: SCROLLABLE_LIST
		do
			sl ?= owner
			if sl /= Void then
				sl.set_font_imp (Current)
			end
			if managed and parent.realized then
				realize;
				parent.child_has_resized
			end
		end;

end -- class SCROLLABLE_LIST_IMP

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

