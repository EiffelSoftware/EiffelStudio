--| FIXME NOT_REVIEWED this file has not been reviewed
 indexing
	description: "Eiffel Vision list. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST_IMP

inherit
	EV_LIST_I
		redefine
			interface
		end
		
	EV_LIST_ITEM_LIST_IMP
		redefine
			initialize,
			interface
		end
	
	EV_PRIMITIVE_IMP
		undefine
			set_default_colors
		redefine
			make,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_key_down,
			on_mouse_move,
			pnd_press,
			initialize,
			interface
		end

 	WEL_SINGLE_SELECTION_LIST_BOX
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
			move as wel_move,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			--| All features specific to single selection (ss_*)
			select_item as ss_select_item,
			unselect as ss_unselect,
			selected as ss_selected,
			selected_item as ss_selected_item,
			default_style as ss_default_style
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
			on_lbn_selchange,
			on_lbn_selcancel,
			on_size,
			default_ex_style
		select
			ss_default_style,
			ss_selected,
			ss_select_item
		end

 	WEL_MULTIPLE_SELECTION_LIST_BOX
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
			move as wel_move,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			--| All features specific to multiple selection (ms_*)
			select_item as ms_select_item,
			unselect_item as ms_unselect_item,
			select_items as ms_select_items,
			unselect_items as ms_unselect_items,
			select_all as ms_select_all,
			unselect_all as ms_unselect_all,
			set_caret_index as ms_set_caret_index,
			selected as ms_selected,
			count_selected_items as ms_count_selected_items,
			selected_items as ms_selected_items,
			selected_strings as ms_selected_strings,
			caret_index as ms_caret_index,
			default_style as ms_default_style
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
			on_lbn_selchange,
			on_lbn_selcancel,
			on_size,
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
			-- Create list as single selection.
		do
			base_make (an_interface)
			internal_window_make (default_parent, Void,
				default_style, 0, 0, 0, 0, 0, Default_pointer)
			id := 0
			!! ev_children.make (2)
		end	

	initialize is
		do
			{EV_PRIMITIVE_IMP} Precursor
			{EV_LIST_ITEM_LIST_IMP} Precursor
		end

feature -- Status report

	multiple_selection_enabled: BOOLEAN
			-- Can more than one item be selected?

feature -- Status setting

	select_item (an_index: INTEGER) is
			-- Select item at `an_index'.
		do
			if multiple_selection_enabled then
				ms_select_item (an_index - 1)
			else
				ss_select_item (an_index - 1)
			end
			--| FIXME VB Presumed not to be needed anymore, since
			--| redefinition of onlbn_selcancel
			--|cwin_send_message (parent_item, Wm_command,
			--|	Lbn_selchange * 65536 + id,
			--|	cwel_pointer_to_integer (wel_item))
		end

	deselect_item (an_index: INTEGER) is
			-- Deselect item at `an_index'.
		do
			if multiple_selection_enabled then
				ms_unselect_item (index - 1)
			else
				if ss_selected and then ss_selected_item = an_index - 1 then
					ss_unselect
				end
				--| FIXME VB Presumed not to be needed anymore, since
				--| redefinition of onlbn_selcancel
				--|cwin_send_message (wel_item, Lb_setcursel, -1, 0)
				--|on_lbn_selchange
				--|last_selected_item := Void
			end
		end

	clear_selection is
			-- Ensure there are no `selected_items'.
		do
			if multiple_selection_enabled then
				ms_unselect_all
			else
				ss_unselect
				--| FIXME VB Presumed not to be needed anymore, since
				--| redefinition of onlbn_selcancel
				--|if last_selected_item /= Void then
				--|	-- If there is a selected item then
				--|	on_lbn_selchange
				--|nd
				--|last_selected_item := Void
			end
		end

	enable_multiple_selection is
			-- Allow more than one item to be selected.
		do
			if not multiple_selection_enabled then
				multiple_selection_enabled := True
				last_selected_item := Void
				recreate_list
			end
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.
		do
			if multiple_selection_enabled then
				multiple_selection_enabled := False
				recreate_list
			end
		end

feature {NONE} -- Implementation

	recreate_list is
			-- Re-initialize object.
			--| enable_multiple_selection has been changed.
		local
			wel_win: WEL_WINDOW
		do
			wel_win ?= parent_imp
			wel_destroy
			internal_window_make (wel_win, Void, default_style,
				x_position, y_position, width, height, 0,
			    Default_pointer)
			id := 0
			internal_copy_list
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	is_item_imp_selected (li_imp: EV_LIST_ITEM_IMP): BOOLEAN is
			-- Is `li_imp' selected?
		local
			pos: INTEGER
		do
			pos := index_of_item_imp (li_imp)
			if multiple_selection_enabled then
				if ms_selected then
					Result := ms_selected_items.has (pos - 1)
				end
			else
				if ss_selected then
					Result := ss_selected_item = (pos - 1)
				end
			end
		end

	select_item_imp (li_imp: EV_LIST_ITEM_IMP) is
			-- Set `li_imp' selected.
		local
			pos: INTEGER
		do
			pos := index_of_item_imp (li_imp)
			if multiple_selection_enabled then
				ms_select_item (pos - 1)
			else
				ss_select_item (pos - 1)
			end
		end

	deselect_item_imp (li_imp: EV_LIST_ITEM_IMP) is
			-- Set `li_imp' deselected.
		local
			pos: INTEGER
		do
			pos := index_of_item_imp (li_imp)
			if multiple_selection_enabled then
				ms_unselect_items (pos - 1, pos - 1)
			else
				ss_unselect
			end
		end

	set_item_imp_text (li_imp: EV_LIST_ITEM_IMP; a_text: STRING) is
			-- Set `li_imp'.`text' to `a_text'.
		local
			pos: INTEGER
		do
			pos := index_of_item_imp (li_imp)
			delete_string (pos - 1)
			insert_string_at (a_text, pos - 1)
		ensure then
			a_text_set:
				a_text.is_equal (i_th_text (index_of_item_imp (li_imp) - 1))
		end

--| FIXME Indentation, names, comments, contracts.

		list_is_pnd_source : BOOLEAN

		pnd_child_source: EV_LIST_ITEM_IMP
				-- If the pnd started in an item, then this is the item.

		set_pnd_child_source (c: EV_LIST_ITEM_IMP) is
			do
				pnd_child_source := c
			end

		set_source_true is
			do
				list_is_pnd_source := True
			end
		

		set_source_false is
			do
				list_is_pnd_source := False
			end

		transport_started_in_item: BOOLEAN

		set_t_item_true is
			do
				transport_started_in_item := True
			end

		set_t_item_false is
			do
				transport_started_in_item := False
			end

feature {EV_ANY_I} -- Implementation

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
		do
			inspect
				press_action
			when
				Ev_pnd_start_transport
			then
					start_transport (a_x, a_y, a_button, 0, 0, 0.5, a_screen_x, a_screen_y)
					set_source_true
					--transport_started_in_list := True
			when
				Ev_pnd_end_transport
			then
				end_transport (a_x, a_y, a_button)
				set_source_false
				--transport_started_in_list := False
			else
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item event.
		local
			it: EV_LIST_ITEM_IMP
			pt: WEL_POINT
		do
			it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
				if it /= Void and it.is_transport_enabled and not list_is_pnd_source then
					it.pnd_press (x_pos, y_pos, 3, pt.x, pt.y)
				elseif pnd_child_source /= Void then 
					pnd_child_source.pnd_press (x_pos, y_pos, 3, pt.x, pt.y)
				end
			if it /= Void then
				it.interface.pointer_button_press_actions.call ([x_pos,y_pos - it.relative_y, button, 0.0, 0.0, 0.0, pt.x, pt.y])
			end
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_LIST_ITEM_IMP is
			-- Result is list item at pixel position `x_pos', `y_pos'.
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
			if multiple_selection_enabled then
				Result := ms_default_style
			else
				Result := ss_default_style
			end
			Result := Result + Lbs_hasstrings + Lbs_nointegralheight
		end

	default_ex_style: INTEGER is
			-- Default extended style of the list.
		do
			Result := Ws_ex_clientedge
		end

	last_selected_item: EV_LIST_ITEM_IMP
			-- Item was last selected as notified by `on_lbn_selchange'.

	on_lbn_selchange is
			-- The selection is about to change.
		local
			li_imp: EV_LIST_ITEM_IMP
		do
			if multiple_selection_enabled then
				li_imp := ev_children @ (ms_caret_index + 1)
				if li_imp.is_selected then
					notify_select (li_imp.interface)
				else
					notify_deselect (li_imp.interface)
				end
			else
				if ss_selected then
					li_imp := ev_children @ (ss_selected_item + 1)
					if last_selected_item /= Void and then li_imp /= last_selected_item then
						notify_deselect (last_selected_item.interface)
					end
					notify_select (li_imp.interface)
					last_selected_item := li_imp
				else
					if last_selected_item /= Void then
						notify_deselect (last_selected_item.interface)
						last_selected_item := Void
					end
				end
			end
		end

	on_lbn_selcancel is
			-- Cancel the selection.
		do
			if multiple_selection_enabled then
				--| FIXME Do we have to do stuff here?
			else
				notify_deselect (last_selected_item.interface)
				last_selected_item := Void
			end
		end

	notify_deselect (i: EV_LIST_ITEM) is
			-- Call action sequences related to deselection of `i'.
		require
			i_not_void: i /= Void
		do
			i.deselect_actions.call ([])
			interface.deselect_actions.call ([i])
		end

	notify_select (i: EV_LIST_ITEM) is
			-- Call action sequences related to selection of `i'.
		require
			i_not_void: i /= Void
		do
			i.select_actions.call ([])
			interface.select_actions.call ([i])
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		do
			internal_propagate_pointer_press (keys, x_pos, y_pos, 1)
			{EV_PRIMITIVE_IMP} Precursor (keys, x_pos, y_pos)
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		do
			internal_propagate_pointer_press (keys, x_pos, y_pos, 2)
			{EV_PRIMITIVE_IMP} Precursor (keys, x_pos, y_pos)
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			pt: WEL_POINT
			it: EV_LIST_ITEM_IMP
			a: BOOLEAN
		do
			a := transport_started_in_item
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			internal_propagate_pointer_press (keys, x_pos, y_pos, 3)
			it := find_item_at_position (x_pos, y_pos)

			if transport_started_in_item = a then
				pnd_press (x_pos, y_pos, 3, pt.x, pt.y)
			end
			interface.pointer_button_press_actions.call ([x_pos, y_pos, 3, 0.0, 0.0, 0.0, pt.x, pt.y])	
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
			pt := client_to_screen (x_pos, y_pos)
			if it /= Void then
				--|FIXME May need to call the pnd cursor changing code in here.
				--|SEE on_mouse_move from EV_WIDGET_IMP.
				--|Julian Rogers
				it.interface.pointer_motion_actions.call ([x_pos,y_pos - it.relative_y, 0.0, 0.0, 0.0, pt.x, pt.y])
			end
			if pnd_child_source /= Void then
				pnd_child_source.pnd_motion (x_pos, y_pos, pt.x, pt.y)
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

feature {EV_ANY_I} -- Implementation

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
--| Revision 1.56  2000/03/30 17:43:56  brendel
--| Moved common features with EV_COMBO_BOX up to EV_LIST_ITEM_LIST_IMP.
--|
--| Revision 1.55  2000/03/29 22:12:11  brendel
--| Added `set_item_imp_text'.
--| Improved contracts.
--|
--| Revision 1.54  2000/03/29 20:31:03  brendel
--| Added is_item_imp_selected, select_item_imp and deselect_item_imp.
--|
--| Revision 1.53  2000/03/29 02:20:47  brendel
--| Revised. Cleaned up.
--| Now inherits from WEL_SINGLE_SELECTION_LIST_BOX and
--| WEL_MULTIPLE_SELECTION_LIST_BOX. Features applying to multiple selection
--| start with ms_* and single sel. with ss_*.
--|
--| Revision 1.52  2000/03/24 19:14:52  rogers
--| Redefined initialize from EV_LIST_ITEM_HOLDER_IMP.
--|
--| Revision 1.51  2000/03/21 01:25:54  rogers
--| Renamed child_source -> pnd_child_source, set_child_source -> set_pnd_child_source. Added pnd_press.
--|
--| Revision 1.50  2000/03/17 23:40:34  rogers
--| Added the following features: list_is_pnd_source, child_source, set_child_Source, set_source_true, set_source_false. These fatures are now being reviewed and will be modified further. Implemented on_mouse_move and pnd_press.
--|
--| Revision 1.49  2000/03/15 17:06:36  rogers
--| Removed commented code. Added internal_propagate_pointer_press, on_left_button_down, on_middle_button_down, on_right_button_down. Removed on_lbn_dblclick.
--|
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
