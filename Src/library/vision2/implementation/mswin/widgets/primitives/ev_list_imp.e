--| FIXME NOT_REVIEWED this file has not been reviewed
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
		redefine
			interface
		select
			interface
		end

	EV_ITEM_EVENTS_CONSTANTS_IMP
		rename
			command_count as ev_item_events_constants_imp_command_count
		end
		
	EV_LIST_ITEM_HOLDER_IMP
		redefine
			interface
		end
	
	EV_PRIMITIVE_IMP
		rename
			interface as ev_primitive_imp_interface
		undefine
			set_default_colors
		redefine
			make,
			on_key_down,
			on_mouse_move
		end

 	WEL_LIST_BOX
		rename
			make as wel_make,
			parent as wel_parent,
			destroy as wel_destroy,
			shown as is_displayed,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			font as wel_font,
			set_font as wel_set_font,
			select_item as wel_select_item,
			move as wel_move,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize
		undefine
			window_process_message,
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
			show,
			hide
		redefine
			wel_select_item,
			on_lbn_dblclk,
			on_lbn_selchange,
			on_size,
			default_style,
			default_ex_style
		end

	WEL_LBS_CONSTANTS
		export
			{NONE} all
		end

creation
	make
	
feature {NONE} -- Initialization
	
	make (an_interface: like interface) is         
			-- Create a list widget.
			-- By default, it is a single selection list,
			-- use set_selection to change it into a multiple
			-- selection list.
		do
			base_make (an_interface)
			internal_window_make (default_parent, Void,
				default_style, 0, 0, 0, 0, 0, default_pointer)
			id := 0
			!! ev_children.make (2)
		end	

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			if multiple_selection_enabled then
				Result := count_selected_items > 0
			else
				Result := cwin_send_message_result (wel_item,
					Lb_getcursel, 0, 0) /= Lb_err
			end
		end

	multiple_selection_enabled: BOOLEAN is
			-- True if the user can choose several items,
			-- False otherwise
		do
			Result := flag_set (style, Lbs_multiplesel)
		end

feature -- Status setting

	select_item (an_index: INTEGER) is
			-- Select item at the one-based `an_index'.
		do
			wel_select_item (an_index - 1)
			cwin_send_message (parent_item, Wm_command, Lbn_selchange * 65536 + id,
				cwel_pointer_to_integer (wel_item))
		end

	select_all is
			-- Select all the items of the list.
		require
			multiple_selection: multiple_selection_enabled
		do
			select_items (0, count - 1)			
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `an_index'.
		do
			if multiple_selection_enabled then
				cwin_send_message (wel_item, Lb_setsel, 0, an_index - 1)
			else
				cwin_send_message (wel_item, Lb_setcursel, -1, 0)
				on_lbn_selchange
				last_selected_item := Void
			end
		end

	clear_selection is
			-- Clear the selection of the list.
		do
			if multiple_selection_enabled then
				unselect_items (0, count - 1)
			else
				cwin_send_message (wel_item, Lb_setcursel, -1, 0)
				if last_selected_item /= Void then
					-- If there is a selected item then
					on_lbn_selchange
				end
				last_selected_item := Void
			end
		end

	enable_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		local
			wel_imp: WEL_WINDOW
			a, b, c, d: INTEGER
		do
			if not multiple_selection_enabled then
				last_selected_item := Void
				wel_imp ?= parent_imp
				a := x_position
				b := y_position
				c := width
				d := height
				wel_destroy
				internal_window_make (wel_imp, Void,
					default_style + Lbs_multiplesel,
				   	a, b, c, d, 0, default_pointer)
				id := 0
				internal_copy_list
			end
		end

	disable_multiple_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list
		local
			wel_imp: WEL_WINDOW
			a, b, c, d: INTEGER
		do
			if multiple_selection_enabled then
				wel_imp ?= parent_imp
				a := x_position
				b := y_position
				c := width
				d := height
				wel_destroy
				internal_window_make (wel_imp, Void,
					default_style, a, b, c, d, 0,
				    default_pointer)
				id := 0
				internal_copy_list
			end
		end

feature {NONE} -- Implementation

	last_selected_item: EV_LIST_ITEM_IMP
			-- Last selected item

	graphical_insert_item (item_imp: EV_LIST_ITEM; an_index: INTEGER) is
			-- Insert `item_imp' at the `an_index' position of the
			-- graphical object.
		do
			if item_imp.text = Void then
				insert_string_at ("", an_index)
			else
				insert_string_at (item_imp.text, an_index)
			end
		end

feature {NONE} -- Implementation : WEL features

	find_item_at_position (x_pos, y_pos: INTEGER): EV_LIST_ITEM_IMP is
			-- Result  is list item at pixel position `x_pos', `y_pos'.
		local
			temporary_position: INTEGER
		do
			temporary_position := (y_pos // item_height) + 1
			if top_index > 0 then
				temporary_position := top_index + temporary_position
			end
			if temporary_position <= count then
				Result := ev_children @ temporary_position
			end
		end

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

	on_lbn_selchange is
			-- The selection has changed.
			-- We call the selection command of the list and the select
			-- command of the item if necessary.
		local
			last, actual: EV_LIST_ITEM_IMP
			actual_index: INTEGER
		do
			-- A local variable for speed
			last := last_selected_item
			
			-- In multiple selection mode, no `last_selected_item'
			-- has no use.
			if multiple_selection_enabled then
				actual := ev_children @ (caret_index + 1)
				if actual.is_selected then
					actual.interface.select_actions.call ([])
					interface.select_actions.call ([actual.interface])
					--| FIXME actual.execute_command (Cmd_item_activate, Void)
					--| FIXME execute_command (Cmd_select, Void)
				else
					actual.interface.deselect_actions.call ([])
					interface.deselect_actions.call ([actual.interface])
					--| FIXME actual.execute_command (Cmd_item_deactivate, Void)
					--| FIXME execute_command (Cmd_unselect, Void)
				end

			-- Another treatment in single selection mode.
			else
				if selected then
					actual := ev_children @ (selected_index + 1)
					actual_index := interface.index_of (actual.interface, 1)
						-- Get the selected item.
					if last /= Void and then last /= actual then
							-- If there was a previously selected item, different
							-- from the item now selected then call the deselect events
							-- on this previously selected item.
						last.interface.deselect_actions.call ([])
						interface.deselect_actions.call ([last.interface])
					end
					if last = Void or last /= actual then
							-- If there is no previously selected child (Required for at
							-- start when last and actual may be void, so => equal), or
							-- the selected item is different from the previously selected
							-- item then call the deselect events on the previously selected item.
						actual.interface.select_actions.call ([])
						interface.select_actions.call ([actual.interface])
					end
					if selected then
						-- Check that the user has not done something that may have
						-- unselected and item.
						last_selected_item := ev_children @ (selected_index + 1)
					else
						-- If so then there will be no last selected item, and we need
						-- to call the deselect actions.
						if actual /= Void then
								-- We check that `actual' has not been destroyed during the agent call.
							actual.interface.deselect_actions.call ([])
						end
						interface.deselect_actions.call ([actual.interface])
					end
				else
						-- Call the deselect events on the previously selected item.
					last_selected_item := Void
					last.interface.deselect_actions.call ([])
					interface.deselect_actions.call ([last.interface])
				end
			end
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
			if multiple_selection_enabled then
				actual := ev_children @ (caret_index + 1)
			else
				actual := ev_children @ (selected_index + 1)
			end
			if actual /= Void then
				--| FIXME actual.execute_command (Cmd_item_dblclk, Void)
			end
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		do
			{EV_PRIMITIVE_IMP} Precursor (virtual_key, key_data)
			process_tab_key (virtual_key)
		end

	on_size (size_type, a_height, a_width: INTEGER) is
			-- List resized.
		do
			Precursor (size_type, a_height, a_width)
			interface.resize_actions.call ([screen_x, screen_y, a_width, a_height])
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse move.
		local
			it: EV_LIST_ITEM_IMP
			pt: WEL_POINT
			offets: TUPLE [INTEGER, INTEGER]
		do
			it := find_item_at_position (x_pos, y_pos)
			if it /= Void then
				it.interface.pointer_motion_actions.call ([0,0, 0.0, 0.0, 0.0, 0, 0])
			end
			{EV_PRIMITIVE_IMP} Precursor (keys, x_pos, y_pos)
		end 


	wel_background_color: WEL_COLOR_REF is
		do
			Result := background_color_imp
		end

	wel_foreground_color: WEL_COLOR_REF is
		do
			Result := foreground_color_imp
		end

feature {NONE} -- Copy of WEL features

	wel_select_item (an_index: INTEGER) is
			-- Select item at the one-based `index'.
		do
			if multiple_selection_enabled then
				cwin_send_message (wel_item, Lb_setsel, 1, an_index)
			else
				cwin_send_message (wel_item, Lb_setcursel, an_index, 0)
			end
		end

 	selected_index: INTEGER is
 			-- Zero-based index of the selected item
 		require
 			exists: exists
			single_selection: not multiple_selection_enabled
 			selected: selected
 		do
 			Result := cwin_send_message_result (wel_item,
				Lb_getcursel, 0, 0)
 		ensure
 			result_large_enough: Result >= 0
 			result_small_enough: Result < count
 		end

	select_items (start_index, end_index: INTEGER) is
			-- Select items between `start_index'
			-- and `end_index' (zero-based index).
		require
			multiple_selection: multiple_selection_enabled
			exists: exists
			valid_range: end_index >= start_index
			start_index_small_enough: start_index < count
			start_index_large_enough: start_index >= 0
			end_index_small_enough: end_index < count
			end_index_large_enough: end_index >= 0
			valid_range: end_index >= start_index
		do
			cwin_send_message (wel_item, Lb_selitemrange, 1,
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
			multiple_selection: multiple_selection_enabled
			exists: exists
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
			-- For every `i' in `start_index'..`end_index',
			-- `is_selected' (`i') = False
		end

	count_selected_items: INTEGER is
			-- Number of items selected
		require
			exits: exists
			multiple_selection: multiple_selection_enabled
		do
			Result := cwin_send_message_result (wel_item,
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
			Result := cwin_send_message_result (wel_item,
				Lb_getcaretindex, 0, 0)
		end

feature {NONE} -- Feature that should be directly implemented by externals

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
			check
				Never_called: False
			end
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

feature {NONE} -- Implementation

	interface: EV_LIST

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.47  2000/03/14 23:53:09  rogers
--| Redefined on_mouse_move from EV_PRIMITIVE_IMP so items events can be called. Added find_item_at_position.
--|
--| Revision 1.46  2000/03/14 19:24:14  rogers
--| renamed
--| 	move -> wel_move
--| 	height -> wel_height
--| 	x -> x_position
--| 	y -> y_position
--| 	resize -> wel_resize
--| 	move_and_resize -> wel_move_and_resize
--|
--| Revision 1.45  2000/03/07 17:53:53  rogers
--| Redefined on_size from WEL_LIST_BOX, so the resize_actions can be called.
--|
--| Revision 1.44  2000/03/07 00:11:56  rogers
--| The select actions are now always called on the child first before the list
--|
--| Revision 1.43  2000/03/06 20:47:36  rogers
--| The list select and deselect action sequences now only return the selected item, so any calls to these action sequences have been modified.
--|
--| Revision 1.42  2000/02/29 23:13:24  rogers
--| Removed selected_item as it is no longer platform dependent, it now comes from EV_LIST_I.
--|
--| Revision 1.41  2000/02/29 19:35:21  rogers
--| Selected item now returns the first item that is selected in the list when multiple selection is enabled.
--|
--| Revision 1.40  2000/02/25 21:41:12  rogers
--| In on_lbn_selchange, added code to handle the possibility of an item being destroyed within an action sequence.
--|
--| Revision 1.39  2000/02/25 00:34:41  rogers
--| Clear selection, will only now call on_lbn_selchange when not in multiple_selection mode when there was an item selected. Fixes bug where an attempt to call the events on last_selected_item when it is Voidlast.interface.deselect_actions.call ([])
--|
--| Revision 1.38  2000/02/24 21:18:58  rogers
--| Connected the select and de-select events to the list when in single selection mode. Multiple selection mode still needs connecting.
--|
--| Revision 1.37  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.36  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.35.6.9  2000/02/10 18:01:12  rogers
--| Removed the old command association. Implemented part of the new event system calls.
--|
--| Revision 1.35.6.8  2000/02/09 17:36:49  rogers
--| Altered inheritence of interface. Now redefined and selected from EV_LIST_I, redefined from EV_LIST_ITEM_HOLDER_IMP, and renamed to ev_primitive_imp_interface from EV_PRIMITIVE_IMP.
--|
--| Revision 1.35.6.7  2000/02/02 20:49:50  rogers
--| Altered the inheritcance of interfaces slightly. See diff.
--|
--| Revision 1.35.6.6  2000/01/27 19:30:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.35.6.5  2000/01/25 17:37:52  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.35.6.4  2000/01/18 23:32:45  rogers
--| Renamed
--| 	set_single_selection -> disable_multiple_selection
--| 	set_multiple_selection -> enable_multiple_selection
--| 	is_multiple_selection -> multiple_selection_enabled
--|
--| Revision 1.35.6.3  2000/01/15 01:47:40  rogers
--| Modified to comply with the major vision2 changes. For redefinitions, see diff. Implemanted interface.
--|
--| Revision 1.35.6.2  1999/12/17 00:38:43  rogers
--| Altered to fit in with the review branch. Basic alterations, redefinitaions of name clashes etc. Make now takes an interface.
--|
--| Revision 1.35.6.1  1999/11/24 17:30:32  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.35.2.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
