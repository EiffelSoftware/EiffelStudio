 indexing
	description: "EiffelVision list. Mswindows implementation."
	note: "In the wel_list, the index starts with the element%
		% number zero although in the linked_list, it starts%
		% with number one. That is the reason for the graps in%
		% the list calls."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST_IMP

inherit
	EV_LIST_I
		undefine
			count
		end

	EV_LIST_ITEM_HOLDER_IMP

	EV_PRIMITIVE_IMP
		undefine
			set_default_colors
		redefine
			make
		end

   WEL_LIST_BOX
		rename
			make as wel_make,
			parent as wel_parent,
			destroy as wel_destroy,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			font as wel_font,
			set_font as wel_set_font,
			select_item as wel_select_item
		undefine
			remove_command,
			set_width,
			set_height,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_set_cursor,
			wel_background_color,
			wel_foreground_color,
			default_process_message
		redefine
			wel_select_item,
			on_lbn_dblclk,
			on_lbn_selchange,
			default_style,
			default_ex_style,
			default_process_message
		end

	WEL_LBS_CONSTANTS
		export
			{NONE} all
		end

creation
	make
	
feature {NONE} -- Initialization
	
	make is         
			-- Create a list widget.
			-- By default, it is a single selection list,
			-- use set_selection to change it into a multiple
			-- selection list.
		do
			internal_window_make (default_parent.item, Void,
				default_style, 0, 0, 0, 0, 0, default_pointer)
			id := 0
			!! ev_children.make (2)
		end	

feature -- Access

	selected_item: EV_LIST_ITEM is
			-- Item which is currently selected, for a multiple
			-- selection, it gives the last selected item.
		do
			if not is_multiple_selection and selected then
				Result ?= (ev_children.i_th (selected_index + 1)).interface
			end
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			if is_multiple_selection then
				Result := count_selected_items > 0
			else
				Result := cwin_send_message_result (item,
					Lb_getcursel, 0, 0) /= Lb_err
			end
		end

	is_multiple_selection: BOOLEAN is
			-- True if the user can choose several items,
			-- False otherwise
		do
			Result := flag_set (style, Lbs_multiplesel)
		end

feature -- Status setting

	select_item (index: INTEGER) is
			-- Select item at the one-based `index'.
		do
			wel_select_item (index - 1)
		end

	select_all is
			-- Select all the items of the list.
		require
			multiple_selection: is_multiple_selection
		do
			select_items (0, count - 1)			
		end

	deselect_item (index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		do
			if is_multiple_selection then
				cwin_send_message (item, Lb_setsel, 0, index - 1)
			else
				cwin_send_message (item, Lb_setcursel, -1, 0)
				last_selected_item := Void
			end
		end

	clear_selection is
			-- Clear the selection of the list.
		do
			if is_multiple_selection then
				unselect_items (0, count - 1)
			else
				cwin_send_message (item, Lb_setcursel, -1, 0)
				last_selected_item := Void
			end
		end

	set_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		local
			wel_imp: WEL_WINDOW
		do
			if not is_multiple_selection then
				last_selected_item := Void
				wel_imp ?= parent_imp
				wel_destroy
				internal_window_make (wel_imp, Void,
					default_style + Lbs_multiplesel,
				   	0, 0, 0, 0, 0, default_pointer)
				id := 0
				copy_list
			end
		end

	set_single_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list
		local
			wel_imp: WEL_WINDOW
		do
			if is_multiple_selection then
				wel_imp ?= parent_imp
				wel_destroy
				internal_window_make (wel_imp, Void,
					default_style, 0, 0, 0, 0, 0,
				    default_pointer)
				id := 0
				copy_list
			end
		end

feature -- Element change

	clear_items is
			-- Clear all the items of the list.
		do
			clear_ev_children
			reset_content
		end

feature -- Event : command association

	add_selection_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when the selection has changed.
		do
			add_command (Cmd_selection, cmd, arg)
		end

feature -- Event -- removing command association

	remove_selection_commands is	
			-- Empty the list of commands to be executed
			-- when the selection has changed.
		do
			remove_command (Cmd_selection)
		end

feature {NONE} -- Implementation

	last_selected_item: EV_LIST_ITEM_IMP
			-- Last selected item

	copy_list is
			-- Take an empty list and initialize all the children with
			-- the contents of `ev_children'.
		local
			list: ARRAYED_LIST [EV_LIST_ITEM_IMP]
		do
			list := ev_children
			if not list.empty then
				from
					list.start
				until
					list.after
				loop
					add_string (list.item.text)
					list.forth
				end
			end
		end

	on_lbn_selchange is
			-- The selection has changed.
			-- We call the selection command of the list and the select
			-- command of the item if necessary.
		local
			last, actual: EV_LIST_ITEM_IMP
		do
			-- A local variable for speed
			last := last_selected_item

			-- In multiple selection mode, no `last_selected_item'
			-- has no use.
			if is_multiple_selection then
				actual := ev_children @ (caret_index + 1)
				if actual.is_selected then
					actual.execute_command (Cmd_item_activate, Void)
				else
					actual.execute_command (Cmd_item_deactivate, Void)
				end

			-- Another treatment in single selection mode.
			else
				if selected then
					actual := ev_children @ (selected_index + 1)
					if last /= Void and then last /= actual then
						last.execute_command (Cmd_item_deactivate, Void)
					end
					last_selected_item := actual
					actual.execute_command (Cmd_item_activate, Void)
				else
					last_selected_item := Void
					last.execute_command (Cmd_item_deactivate, Void)
				end
			end

			-- We launch the command of the list
			execute_command (Cmd_selection, Void)
		end

	on_lbn_dblclk is
			-- Double click on a string.
			-- Send the event to the current selected item or to the one
			-- that has the focus.
		local
			actual: EV_LIST_ITEM_IMP
		do
			-- In multiple selection mode, the item can be selected or
			-- unselected.
			if is_multiple_selection then
				actual := ev_children @ (caret_index + 1)
			else
				actual := ev_children @ (selected_index + 1)
			end
			if actual /= Void then
				actual.execute_command (Cmd_item_dblclk, Void)
			end
		end

feature {NONE} -- Implementation : WEL features

	default_style: INTEGER is
			-- Default style of the list.
		do
			Result := Ws_child + Ws_visible + Ws_group 
						+ Ws_tabstop + Ws_border + Ws_vscroll
						+ Lbs_notify --+ Lbs_ownerdrawfixed 
						+ Lbs_hasstrings + Lbs_nointegralheight
		end

	default_ex_style: INTEGER is
			-- Default extended style of the list.
		do
			Result := Ws_ex_clientedge
		end

	default_process_message (msg, wparam, lparam: INTEGER) is
		   -- Process `msg' which has not been processed by
		   -- `process_message'.
		local
			top: INTEGER
			paint_dc: WEL_PAINT_DC
			rect: WEL_RECT
		do
--			if msg = Wm_erasebkgnd then
--				!! paint_dc.make_by_pointer (Current, cwel_integer_to_pointer(wparam))
--				!! rect.make_client (Current)
--				top := item_height * (count - top_index)
--				if top < rect.bottom then
--					rect.set_top (top)
--					paint_dc.fill_rect (rect, background_brush)
--				end
--				disable_default_processing
--			end
 		end

	wel_background_color: WEL_COLOR_REF is
		do
			Result := background_color_imp
		end

	wel_foreground_color: WEL_COLOR_REF is
		do
			Result := foreground_color_imp
		end

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlggroupitem (hdlg, hctl, previous)
		end

feature {NONE} -- Copy of WEL features

	wel_select_item (index: INTEGER) is
			-- Select item at the one-based `index'.
		do
			if is_multiple_selection then
				cwin_send_message (item, Lb_setsel, 1, index)
			else
				cwin_send_message (item, Lb_setcursel, index, 0)
				last_selected_item := ev_children @ (index + 1)
			end
		end

 	selected_index: INTEGER is
 			-- Zero-based index of the selected item
 		require
 			exists: exists
			single_selection: not is_multiple_selection
 			selected: selected
 		do
 			Result := cwin_send_message_result (item,
				Lb_getcursel, 0, 0)
 		ensure
 			result_large_enough: Result >= 0
 			result_small_enough: Result < count
 		end

	select_items (start_index, end_index: INTEGER) is
			-- Select items between `start_index'
			-- and `end_index' (zero-based index).
		require
			multiple_selection: is_multiple_selection
			exists: exists
			valid_range: end_index >= start_index
			start_index_small_enough: start_index < count
			start_index_large_enough: start_index >= 0
			end_index_small_enough: end_index < count
			end_index_large_enough: end_index >= 0
			valid_range: end_index >= start_index
		do
			cwin_send_message (item, Lb_selitemrange, 1,
				cwin_make_long (start_index, end_index))
		ensure
			selected: selected
			-- For every `i' in `start_index'..`end_index',
			-- `is_selected' (`i') = True
		end

	unselect_items (start_index, end_index: INTEGER) is
			-- Unselect items between `start_index'
			-- and `end_index' (zero-based index).
		require
			multiple_selection: is_multiple_selection
			exists: exists
			valid_range: end_index >= start_index
			start_index_small_enough: start_index < count
			start_index_large_enough: start_index >= 0
			end_index_small_enough: end_index < count
			end_index_large_enough: end_index >= 0
			valid_range: end_index >= start_index
		do
			cwin_send_message (item, Lb_selitemrange, 0,
				cwin_make_long (start_index, end_index))
		ensure
			-- For every `i' in `start_index'..`end_index',
			-- `is_selected' (`i') = False
		end

	count_selected_items: INTEGER is
			-- Number of items selected
		require
			exits: exists
			multiple_selection: is_multiple_selection
		do
			Result := cwin_send_message_result (item,
				Lb_getselcount, 0, 0)
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result <= count
		end

	caret_index: INTEGER is
			-- Index of the item that has the focus
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Lb_getcaretindex, 0, 0)
		end

end -- class EV_LIST_IMP

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
--|---------------------------------------------------------------
