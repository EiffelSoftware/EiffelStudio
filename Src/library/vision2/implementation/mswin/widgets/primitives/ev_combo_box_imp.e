--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "EiffelVision Combo-box. Implementation interface"
	note: "We cannot chAnge the feature `set_style' of wel_window%
		% to switch from editable to non editable because it%
		% doesn't for this kind of style changing."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COMBO_BOX_IMP

inherit
	EV_COMBO_BOX_I
		undefine
			set_default_minimum_size
		redefine
			interface
		end

	EV_LIST_ITEM_HOLDER_IMP
		redefine
			interface
		end

	EV_TEXT_COMPONENT_IMP
		export {EV_INTERNAL_COMBO_FIELD_IMP, EV_INTERNAL_COMBO_BOX_IMP}
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_set_cursor
		undefine
			height
		redefine
			set_minimum_width_in_characters,
			set_default_minimum_size,
			move_and_resize,
			set_editable,
			on_key_down,
--			on_key_up
			interface
		end
		
	WEL_DROP_DOWN_COMBO_BOX_EX
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy,
			shown as is_displayed,
			select_item as wel_select_item,
			selected_item as wel_selected_item,
			height as wel_height,
			width as wel_width,
			insert_item as wel_insert_item,
			set_limit_text as set_text_limit,
			set_text as wel_set_text,
			move as move_to,
			item as wel_item,
			enabled as is_sensitive
		export
			{EV_INTERNAL_COMBO_FIELD_IMP} edit_item
			{EV_INTERNAL_COMBO_BOX_IMP} combo_item
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
			on_set_focus,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_set_cursor,
			show,
			hide
		redefine
			on_cben_endedit_item,
			on_cbn_editchange,
			on_cbn_selchange,
			on_cbn_dblclk,
			move_and_resize,
			default_style
		end

	WEL_EM_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a combo-box.
		do
			base_make (an_interface)
			internal_window_make (default_parent, Void, default_style + Cbs_dropdown,
				0, 0, 0, 90, 0, default_pointer)
 			id := 0
			create text_field.make_with_combo (Current)
			create combo.make_with_combo (Current)
			create ev_children.make (2)
		end

feature -- Access

	text_field: EV_INTERNAL_COMBO_FIELD_IMP
			-- An internal text field that forwards the events to the
			-- current combo-box-ex.

	combo: EV_INTERNAL_COMBO_BOX_IMP
			-- The combo_box inside the combo-box-ex. It forwards the
			-- events.

feature -- Measurement

	height: INTEGER is
			-- height of the combo-box when the list is hidden
			-- it is a constant
		do
			Result := window_rect.height
		end

	extended_height: INTEGER is
			-- height of the combo-box when the list is shown
		do
			Result := dropped_rect.height
		end

feature -- Status report

	item_height: INTEGER is
			-- height needed for an item
		do
			Result := wel_font.log_font.height
		end

	is_selected (an_id: INTEGER): BOOLEAN is
			-- Is item given by `an_id' selected?
		do
			Result := (an_id = wel_selected_item)
		end

	selected_item: EV_LIST_ITEM is
			-- Give the item which is currently selected
			-- It start with a zero index in wel and with a
			-- one index for the array.
		do
			Result ?= (ev_children.i_th (wel_selected_item + 1)).interface
		end

	has_selection: BOOLEAN is
			-- Has a current selection?
		do
			Result := cwin_lo_word (cwin_send_message_result (edit_item,
				Em_getsel, 0, 0)) /=
				cwin_hi_word (cwin_send_message_result (edit_item,
				Em_getsel, 0, 0))
		end

	internal_caret_position: INTEGER is
			-- Caret position
		do
			Result := cwin_hi_word (cwin_send_message_result (edit_item,
				Em_getsel, 0, 0))
		end

feature -- Status setting

	set_text (tex: STRING) is
			-- Set the text of the combo box.
		do
			wel_set_text (tex)	
		end

	set_default_minimum_size is
			-- Called after creation. Set the current size and
			-- notify the parent.
		do
			internal_set_minimum_size (30, 22)
		end

	select_item (an_index: INTEGER) is
			-- Select an item of the `an_index'-th item of the list.
			-- We cannot redefine this feature because then a
			-- postcondition is violated because of the change
			-- of index.
		do
			if (not selected) or (selected and then not equal (wel_selected_item, an_index - 1)) then
					-- Only select an item if it is not already selected.
				if selected then
					execute_command (Cmd_unselect, Void)
				end
				wel_select_item (an_index - 1)
				old_selected_item := ev_children @ (index)
					-- Now send `Cbn_selchange' message to Current control
					-- so that we know that a change occured and to handle
					-- it as specified by user.
					cwin_send_message (parent_item, Wm_command, Cbn_selchange * 65536 + id,
					cwel_pointer_to_integer (wel_item))
				execute_command (Cmd_select, Void)
				-- Must now manually inform the combo box that a selection is taking place.
			end
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `an_index'.
		do
			unselect
			old_selected_item := Void
		end

	clear_selection is
			-- Clear the selection of the list.
		do
			unselect
			old_selected_item := Void
		end

	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		do
			if flag then
				set_read_write
			else
				set_read_only
			end
		end

	set_extended_height (value: INTEGER) is
			-- Make `value' the new extended-height of the box.
		do
			resize (width, value)
		end

	internal_set_caret_position (pos: INTEGER) is
			-- Set the caret position with `position'.
		do
			cwin_send_message (edit_item, Em_setsel, pos, pos)
		end

feature -- Basic operation

	select_all is
			-- Select all the text.
		do
			cwin_send_message (edit_item, Em_setsel, 0, -1)
		end

	deselect_all is
			-- Unselect the current selection.
		do
			cwin_send_message (edit_item, Em_setsel, -1, 0)
		end

	delete_selection is
			-- Delete the current selection.
		do
			cwin_send_message (edit_item, Wm_clear, 0, 0)
		end

	cut_selection is
			-- Cut the current selection to the clipboard.
		do
			cwin_send_message (edit_item, Wm_cut, 0, 0)
		end

	copy_selection is
			-- Copy the current selection to the clipboard.
		do
			cwin_send_message (edit_item, Wm_copy, 0, 0)
		end

	clip_paste is
			-- Paste at the current caret position the
			-- content of the clipboard.
		do
			cwin_send_message (edit_item, Wm_paste, 0, 0)
		end

	replace_selection (txt: STRING) is
			-- Replace the current selection with `new_text'.
			-- If there is no selection, `new_text' is inserted
			-- at the current `caret_position'.
		require
			exists: exists
			text_not_void: txt /= Void
		local
			wel_str: WEL_STRING
		do
			!! wel_str.make (txt)
			cwin_send_message (edit_item, Em_replacesel, 0,
				cwel_pointer_to_integer (wel_str.item))
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when an item has been selected.
		do
			add_command (Cmd_select, cmd, arg)
		end

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when an item has been unselected.
		do
			add_command (Cmd_unselect, cmd, arg)
		end

	add_return_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the text in the field is activated, i.e. the
			-- user press the enter key.
		do
			add_command (Cmd_activate, cmd, arg)
		end

feature -- Event -- removing command association

	remove_select_commands is	
			-- Empty the list of commands to be executed
			-- when an item has been selected.
		do
			remove_command (Cmd_select)
		end

	remove_unselect_commands is	
			-- Empty the list of commands to be executed
			-- when an item has been unselected.
		do
			remove_command (Cmd_unselect)	
		end	

	remove_return_commands is
			-- Empty the list of commands to be executed
			-- when the text in the field is activated, i.e. the
			-- user press the enter key.
		do
			remove_command (Cmd_activate)
		end

feature {NONE} -- Implementation

	graphical_insert_item (item_imp: EV_LIST_ITEM; an_index: INTEGER) is
			-- Insert `item_imp' at the `an_index' position of the 
			-- graphical object.
		local
			citem: WEL_COMBO_BOX_EX_ITEM
		do
			!! citem.make_with_index (an_index)
			citem.set_text (item_imp.text)
			wel_insert_item (citem)
		end

	set_read_only is
			-- Set the read-only state.
		local
			par_imp: WEL_WINDOW
			a, b, c: INTEGER
		do
			if is_editable then
				-- We keep some useful informations
				par_imp ?= parent_imp
				a := x; b := y; c := width

				-- We destroy the old combo
				wel_destroy
				text_field := Void

				-- We create the new combo.
  				internal_window_make (par_imp, Void, default_style + Cbs_dropdownlist,
					a, b, c, 90, 0, default_pointer)
 	 			id := 0
				create combo.make_with_combo (Current)
				--set_text (s)
				--| FIXME huh?
				internal_copy_list
			end
		end

	set_read_write is
			-- Set the read-write state.
		local
			par_imp: WEL_WINDOW
			a, b, c: INTEGER
		do
			if not is_editable then
				-- We keep some useful informations
				par_imp ?= parent_imp
				a := x; b := y; c := width

				-- We destroy the old combo
				wel_destroy
				combo := Void

				-- We create the new combo.
  				internal_window_make (par_imp, Void, default_style + Cbs_dropdown,
					a, b, c, 90, 0, default_pointer)
 	 			id := 0
				create text_field.make_with_combo (Current)
				internal_copy_list
			end
		end

	read_only: BOOLEAN is
			-- Is the combo-box read-only?
		do
			Result := flag_set (style, Cbs_dropdownlist)
		end

feature {EV_INTERNAL_COMBO_FIELD_IMP, EV_INTERNAL_COMBO_BOX_IMP} -- WEL Implementation

	on_key_down (virtual_key, key_data: INTEGER) is
			-- We check if the enter key is pressed)
			-- 13 is the number of the return key.
		local
			list: ARRAYED_LIST [EV_LIST_ITEM_IMP]
			counter: INTEGER
			found: BOOLEAN
		do
			{EV_TEXT_COMPONENT_IMP} Precursor (virtual_key, key_data)
			process_tab_key (virtual_key)
			if virtual_key = Vk_return then
				-- If return pressed, select item with matching text.
				from
					list := ev_children
					list.start
					counter := 1
				until
					counter = list.count + 1 or found
				loop
					if equal (list.item.text, text) then
						if not selected or (selected and not is_selected (counter - 1)) then
							select_item (counter)
						end
						found := True
					end
					list.forth
					counter := counter + 1
				end
			else
				if selected and equal (text, selected_item.text) and (virtual_key /= 9) and
					(virtual_key /= 40) and (virtual_key /= 38) then
					clear_selection
					execute_command (Cmd_unselect, Void)
				end
			end
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
		do
			Result := Ws_child + Ws_visible + Ws_group 
						+ Ws_tabstop + Ws_vscroll
						+ Cbs_autohscroll
		end

	old_selected_item: EV_LIST_ITEM_IMP
			-- The previously selected item

	last_edit_change: STRING
			-- The string resulting from the last edit change.

	on_cben_endedit_item (info: WEL_NM_COMBO_BOX_EX_ENDEDIT) is
			-- The user has concluded an operation within the edit box
			-- or has selected an item from the control's drop-down list.
		do
			if info.why = Cbenf_return then
				set_caret_position (0)
				execute_command (Cmd_activate, Void)
			end
		end

	on_cbn_selchange is
			-- The selection is about to be changed.
		do
			if selected and then wel_selected_item /= Void then
				if selected and then not equal (old_selected_item, ev_children.i_th (wel_selected_item + 1)) then
					if old_selected_item /= Void then
						--|FIXME The events have changed
						--old_selected_item.execute_command (Cmd_item_deactivate, Void)
						execute_command (Cmd_unselect, Void)
					end
	
						-- Only performed if an item is selected and the new selection is not equal to
						-- the current selection.
					old_selected_item := ev_children.i_th (wel_selected_item + 1)
					--|FIXME The events have changed
					--old_selected_item.execute_command (Cmd_item_activate, Void)
					execute_command (Cmd_select, Void)
						-- Must now manually inform combo box that a selection is taking place
				elseif wel_selected_item/= Void and then not equal (old_selected_item, ev_children.i_th (wel_selected_item + 1)) then
					old_selected_item := Void
				end
			end
		end

	on_cbn_dblclk is
			-- The user double-clicks a string in the list box.
		do
			if selected then
				--|FIXME Events have changed
				--(ev_children.i_th (wel_selected_item + 1)).execute_command (Cmd_item_dblclk, Void)
			end
		end

	on_cbn_editchange is
			-- The edit control portion is about to
			-- display altered text.
		local
			s1,s2: STRING
		do
			if not equal (text, last_edit_change) then
				execute_command (Cmd_change, Void)
			end
			last_edit_change := text
		end

   	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
   			-- We must not resize the height of the combo-box.
   		do
  			cwin_move_window (wel_item, a_x, a_y, a_width, height, repaint)
  		end

	set_selection (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- `start_pos' and `end_pos'. Both `start_pos' and
			-- `end_pos' are selected.
		do
			cwin_send_message (wel_item, Cb_seteditsel, 0, cwin_make_long (start_pos, end_pos))
		end

	wel_selection_start: INTEGER is
			-- Index of the first character selected
		do
			Result := cwin_lo_word (cwin_send_message_result (edit_item, Em_getsel, 0, 0))
		end

	wel_selection_end: INTEGER is
			-- Index of the last character selected
		do
			Result := cwin_hi_word (cwin_send_message_result (edit_item, Em_getsel, 0, 0))
		end

Feature -- Temp

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
			-- We add nine for the borders.
		do
			set_minimum_width (nb * 6 + 9)
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

feature {NONE} -- Interface

	interface: EV_COMBO_BOX

end -- class EV_COMBO_BOX_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.51  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.50.2.1.2.3  2000/01/29 02:19:55  rogers
--| Modified to comply with the major vision2 changes. It is not currently working.
--|
--| Revision 1.50.2.1.2.2  2000/01/27 19:30:26  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.50.2.1.2.1  1999/11/24 17:30:31  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.47.2.3  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
