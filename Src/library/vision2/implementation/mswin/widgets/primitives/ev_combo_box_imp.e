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
			count
		end

	EV_LIST_ITEM_HOLDER_IMP

	EV_TEXT_COMPONENT_IMP
		redefine
			set_editable,
			move_and_resize,
			on_key_down,
			paste
		end
		
	EV_BAR_ITEM_IMP

	WEL_DROP_DOWN_LIST_COMBO_BOX
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy,
			select_item as wel_select_item,
			selected_item as wel_selected_item,
			height as wel_height
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
			on_set_focus,
			on_kill_focus,
			on_key_down,
			on_key_up
		redefine
			default_process_message,
			on_cbn_selchange,
			on_cbn_editchange,
			move_and_resize,
			default_style
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create a combo-box.
		do
			internal_window_make (default_parent.item, void, default_style + Cbs_dropdown,
				0, 0, 0, 90, 0, default_pointer)
 			id := 0
			!! ev_children.make (2)
		end

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
			Result := (an_id = wel_selected_item + 1)
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
			Result := cwin_lo_word (cwin_send_message_result (item,
				Cb_geteditsel, 0, 0)) /=
				cwin_hi_word (cwin_send_message_result (item,
				Cb_geteditsel, 0, 0))
		end

feature -- Status setting

	set_text_limit (value: INTEGER) is
			-- Make `value' the new maximal length of the text.
		do
			if is_editable then
				cwin_send_message (item, Cb_limittext, value, 0)
			end
		end

	select_item (index: INTEGER) is
			-- Select an item of the `index'-th item of the list.
			-- We cannot redefine this feature because then a
			-- postcondition is violated because of the change
			-- of index.
		do
			wel_select_item (index - 1)
		end

	deselect_item (index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		do
			unselect
		end

	clear_selection is
			-- Clear the selection of the list.
		do
			unselect
		end

	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		local
			color: EV_COLOR
		do
			if flag then
				set_read_write
			else
				set_read_only
			end
		end

feature -- Element change

	clear_items is
			-- Remove all the elements of the combo-box.
		do
			reset_content
			clear_ev_children
		end

	set_extended_height (value: INTEGER) is
			-- Make `value' the new extended-height of the box.
		do
			move_and_resize (x, y, width, value, True)
		end

feature -- Basic operation

	select_all is
			-- Select all the text.
		do
			cwin_send_message (item, Cb_seteditsel, 0, cwin_make_long (0, -1))
		end

	deselect_all is
			-- Unselect the current selection.
		do
			cwin_send_message (item, Cb_seteditsel, 0, cwin_make_long (-1, 0))
		end

	delete_selection is
			-- Delete the current selection.
		do
			cwin_send_message (item, Wm_clear, 0, 0)
		end

	cut_selection is
			-- Cut the current selection to the clipboard.
		do
			cwin_send_message (item, Wm_cut, 0, 0)
		end

	copy_selection is
			-- Copy the current selection to the clipboard.
		do
			cwin_send_message (item, Wm_copy, 0, 0)
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' postion in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		local
			pos: INTEGER
		do
			cwin_send_message (item, Wm_paste, 0, 0)
		end

feature -- Event : command association

	add_selection_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when the selection has changed.
		do
			add_command (Cmd_selection, cmd, arg)
		end

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the text in the field is activated, i.e. the
			-- user press the enter key.
		do
			add_command (Cmd_activate, cmd, arg)
		end

feature -- Event -- removing command association

	remove_selection_commands is	
			-- Empty the list of commands to be executed
			-- when the selection has changed.
		do
			remove_command (Cmd_selection)
		end

	remove_activate_commands is
			-- Empty the list of commands to be executed
			-- when the text in the field is activated, i.e. the
			-- user press the enter key.
		do
			remove_command (Cmd_activate)
		end

feature {NONE} -- Inapplicable

	caret_position: INTEGER is
			-- Caret position
		do
			check
				Inapplicable: False
			end
		end

	set_caret_position (a_position: INTEGER) is
			-- Set the caret position with `position'.
		do
			check
				Inapplicable: False
			end
		end

feature {NONE} -- Implementation

	set_read_only is
			-- Set the read-only state.
		local
			par_imp: WEL_WINDOW
			temp_list: ARRAYED_LIST [STRING]
		do
			if is_editable then
				par_imp ?= parent_imp
				!! temp_list.make (0)
				save_list (temp_list)
				wel_destroy
  				internal_window_make (par_imp, void, default_style + Cbs_dropdownlist,
					0, 0, 0, 90, 0, default_pointer)
 	 			id := 0
				copy_list (temp_list)
			end
		end

	set_read_write is
			-- Set the read-write state.
		local
			par_imp: WEL_WINDOW
			temp_list: ARRAYED_LIST [STRING]
		do
			if not is_editable then
				par_imp ?= parent_imp
				!! temp_list.make (0)
				save_list (temp_list)
				wel_destroy
  				internal_window_make (par_imp, void, default_style + Cbs_dropdown,
					0, 0, 0, 90, 0, default_pointer)
 	 			id := 0
				copy_list (temp_list)
			end
		end

	read_only: BOOLEAN is
			-- Is the combo-box read-only?
		do
			Result := flag_set (style, Cbs_dropdownlist)
		end

	save_list (temp_list: ARRAYED_LIST [STRING]) is
			-- Take an empty list and initialize all the children with
			-- the contents of `ev_children'.
		do
			if not ev_children.empty then
				from
					ev_children.start
				until
					ev_children.after
				loop
					temp_list.extend (ev_children.item.text)
					ev_children.forth
				end
			end
		end

	copy_list (temp_list: ARRAYED_LIST [STRING]) is
			-- Take an empty list and initialize all the children with
			-- the contents of `ev_children'.
		do
			if not ev_children.empty then
				from
					temp_list.start
				until
					temp_list.after
				loop
					add_string (temp_list.item)
					temp_list.forth
				end
			end
		end

feature {NONE} -- Wel implementation

   	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
   			-- We must not resize the height of the combo-box.
   		do
  			cwin_move_window (item, a_x, a_y, a_width, height, repaint)
  		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- We check if the enter key is pressed)
			-- 13 is the number of the return key.
		do
			{EV_TEXT_COMPONENT_IMP} Precursor (virtual_key, key_data)
			if virtual_key = Vk_return then
				execute_command (Cmd_activate, Void)
			end
		end

	on_cbn_selchange is
			-- The selection is about to be changed.
		do
			execute_command (Cmd_selection, Void)
			if selected then
				(ev_children.i_th (wel_selected_item + 1)).execute_command (Cmd_item_activate, Void)
			end
		end

	on_cbn_editchange is
			-- The edit control portion is about to
			-- display altered text.
		do
			execute_command (Cmd_change, Void)
		end

	default_style: INTEGER is
		do
			Result := Ws_child + Ws_visible + Ws_group 
						+ Ws_tabstop + Ws_vscroll
						+ Cbs_autohscroll --+ Cbs_ownerdrawfixed
						+ Cbs_hasstrings
		end

	default_process_message (msg, wparam, lparam: INTEGER) is
		   -- Process `msg' which has not been processed by
		   -- `process_message'.
		local
			top: INTEGER
			paint_dc: WEL_PAINT_DC
			rect: WEL_RECT
		do
			if msg = Wm_erasebkgnd then
				disable_default_processing
			end
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

	set_selection (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- `start_pos' and `end_pos'. Both `start_pos' and
			-- `end_pos' are selected.
		do
			cwin_send_message (item, Cb_seteditsel, 0, cwin_make_long (start_pos, end_pos))
		end

	wel_selection_start: INTEGER is
			-- Index of the first character selected
		do
			Result := cwin_lo_word (cwin_send_message_result (item, Cb_geteditsel, 0, 0))
		end

	wel_selection_end: INTEGER is
			-- Index of the last character selected
		do
			Result := cwin_hi_word (cwin_send_message_result (item, Cb_geteditsel, 0, 0))
		end

	clip_paste is
			-- Paste at the current caret position the
			-- content of the clipboard.
		do
			Check
				Never_called: False
			end
		end

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
