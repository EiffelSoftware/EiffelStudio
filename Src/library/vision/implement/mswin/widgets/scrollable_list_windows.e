indexing
	description: "Scrollable lists"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	SCROLLABLE_LIST_WINDOWS

inherit
	PRIMITIVE_WINDOWS
		rename
			screen_cursor as windows_cursor,
			cursor as screen_cursor
		redefine
			realize, unrealize,
			set_height, set_size, set_width
		end
		
	SCROLLABLE_LIST_I

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
			on_key_down
		redefine
			on_lbn_selchange,
			on_lbn_errspace
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
			ll_make
			!! private_attributes
			parent ?= oui_parent.implementation
			managed := is_managed
			private_attributes.set_width (100)
			private_attributes.set_height (100)
			private_visible_item_count := 6
			fixed_size := is_fixed
		end

	realize is
			-- Realize the list box.
		local
			i: INTEGER
			pos: INTEGER
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
				show
			end
		end

	unrealize is
			-- Destroy the list box.
		do
			wel_destroy
		end

feature  -- Access

	selected: BOOLEAN is
		do
			if multiple_selection then
				Result := count_selected_items > 0
			else
				Result := cwin_send_message_result (wel_item,
					Lb_getcursel, 0, 0) /= Lb_err
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
					Result := i_th (private_selected_position - 1)
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
			-- Null if nothing is selected
		require else
			single_selection: not multiple_selection
		do
			Result := private_selected_position
		end

	selected_positions: LINKED_LIST [INTEGER] is
			-- Positions of the selected items
			--| Void if single selection
		require else
			multiple_selection: multiple_selection
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
			set_height (private_visible_item_count * item_height +
				2 * Border_height)
		end

	set_size (new_width, new_height: INTEGER) is
			-- Set the height to closest `new_height' possible
			-- and the width to `new_width'.
		local
			a_visible_count: INTEGER
		do
			has_width := True
			has_height := True
			a_visible_count := new_height // item_height
			private_attributes.set_height (a_visible_count * item_height +
				2 * Border_height)
			private_attributes.set_width (new_width)
			if realized then
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
			has_height := True
			a_visible_count := new_height // item_height
			private_attributes.set_height (a_visible_count * item_height +
				2 * Border_height)
			if realized then
				set_visible_item_count (a_visible_count)
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

	extend (a_item: SCROLLABLE_LIST_ELEMENT) is
			-- Add `a_item' to end.
			-- Do not move cursor.
		do
			ll_extend (a_item)
			if realized then
				private_add (a_item.value, -1)
			end
		end

	put_right (a_item: SCROLLABLE_LIST_ELEMENT) is
			-- Add `a_item' to the right of cursor position.
			-- Do not move cursor.
		do
			ll_put_right (a_item)
			if realized then
				private_add (a_item.value, index)
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

	prune (a_item: SCROLLABLE_LIST_ELEMENT) is
			-- Remove first occurrence of `a_item', if any,
			-- after cursor position.
			-- If found, move cursor to right neighbor;
			-- if not, make structure `exhausted'.
		local
			i: INTEGER
		do
			ll_prune (a_item)
			if realized then
				i := find_string_exact (index - 1, a_item.value)
				if i /= -1 then
					private_delete (i)
				end
			end
		end

	put_front (a_item: SCROLLABLE_LIST_ELEMENT) is
			-- Add `a_item' to beginning.
			-- Do not move cursor.
		do
			ll_put_front (a_item)
			if realized then
				private_add (a_item.value, 0)
			end
		end

	put_i_th (a_item: SCROLLABLE_LIST_ELEMENT; i: INTEGER) is
			-- Put `a_item' at `i'-th position.
		do
			ll_put_i_th (a_item, i)
			if realized then
				private_add (a_item.value, i - 1)
			end
		end

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor).
		do
			ll_remove
			if realized then
				private_delete (index - 1)
			end
		end

	put (a_item: SCROLLABLE_LIST_ELEMENT) is
			-- Replace current item by `v'.
			-- (Synonym for `replace')
		do
			replace (a_item)				
		end

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		do
			ll_remove_right
			if realized then
				private_delete (index)
			end
		end

	put_left (a_item: SCROLLABLE_LIST_ELEMENT) is
			-- Add `a_item' to the left of cursor position.
			-- Do not move cursor.
		do
			ll_put_left (a_item)
			if realized then
				private_add (a_item.value, index - 1)
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
					private_add (l.item.value, -1);
					l.forth
				end
			end
		end

	replace (a_item: SCROLLABLE_LIST_ELEMENT) is
			-- Replace current item by `v'.
		do
			ll_replace (a_item)
			if realized then
				private_delete (index - 1)
				private_add (a_item.value, index - 1)
			end
		end

	prune_all (a_item: SCROLLABLE_LIST_ELEMENT) is
			-- Remove all occurrences of `a_item'.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			-- Leave structure `exhausted'.
		local
			i: INTEGER
		do
			ll_prune_all (a_item)
			if realized then
				from
					i := find_string_exact (0, a_item.value)
				until
					i = -1
				loop
					private_delete (i)
					i := find_string_exact (0, a_item.value)
				end
			end
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
		do
			if realized then
				from
					other.start
				until
					other.after
				loop
					private_add (other.item.value, index)
					other.forth
				end
			end
			ll_merge_right (other)
		end

	force (a_item: SCROLLABLE_LIST_ELEMENT) is
			-- Add `a_item' to end.
		do
			extend (a_item)
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
					private_add (lin_rep.item.value, -1)
					lin_rep.forth
				end
			end
			ll_fill (other)
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			ll_remove_left
			if realized then
				private_delete (index - 2)
			end
		end

feature {NONE} -- Implementation

	private_fixed_size_flag: BOOLEAN
			-- Is the width of the list box fixed?

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
			valid_i: i <= index
		do
			if realized then
				if multiple_selection then
					select_item_at (i - 1)
				else
					select_item_at (i - 1)
				end
			end
			if multiple_selection
			and then not private_selected_positions.has (i) then
				private_selected_positions.extend (i)
			else
				private_selected_position := i
			end
		end

	private_add (s: STRING; pos: INTEGER) is
			-- Add a string and resize if necessary.
		local
			a_font_windows: FONT_WINDOWS
		do
			if realized then
				a_font_windows ?= private_font.implementation
				if fixed_size then
					if a_font_windows.string_width (Current, s) >= private_scroll_width then
						private_scroll_width := a_font_windows.string_width (Current, s)
						set_horizontal_extent (private_scroll_width + 10)
						show_horizontal_scroll_bar
					end
				end
				if pos = -1 then
					wel_add_string (s)
				else
					wel_insert_string_at (s, pos)
				end
			end
		end

	private_delete (pos: INTEGER) is
			-- Delete a string and resize if necessary.
		local
			s: STRING
			a_font_windows: FONT_WINDOWS
			a_width: INTEGER
		do
			s := clone (i_th_text (pos))
			wel_delete_string (pos)
			if realized then
				a_font_windows ?= private_font.implementation
				if fixed_size then
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
			a_font_windows: FONT_WINDOWS
		do
			a_font_windows ?= private_font.implementation
			from
				i :=0
			until
				i >= count
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
		ensure
			unselected: not selected
		end

	on_lbn_selchange is
			-- The selection is changed, update the
			-- private attributes.
		local
			i: INTEGER
		do
			if multiple_selection then
				from
					i := 0
					private_selected_positions.wipe_out
				until
					i >= count
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
					i >= count or private_selected_position /= 0
				loop
					if is_selected (i) then
						private_selected_position := i + 1
					end
					i := i + 1
				end
			end
			if not multiple_selection then
				selection_change_actions.execute (Current, Void)
			end
		end

	on_lbn_errspace is
			-- Cannot allocate enough memory
			-- to meet a specific request
		do
			information_message_box ("Cannot allocate enough memory to perform%
				%request!","Error")
		end

	has_width: BOOLEAN
			-- Is the default width overruled?

	has_height: BOOLEAN
			-- Is the default height overruled?

	fixed_size: BOOLEAN
			-- Is the size of the list fixed?

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
					Lbs_notify + Lbs_multiplesel
			else
				Result := Ws_visible + Ws_child + Ws_group +
					Ws_tabstop + Ws_border + Ws_vscroll +
					Lbs_notify
			end
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
				count - index
			until
				after
			loop
				private_add (item.value, -1)
				forth
			end
			go_i_th (pos)
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

end -- class SCROLLABLE_LIST_WINDOWS

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

