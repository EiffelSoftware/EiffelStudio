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

	EV_LIST_ITEM_CONTAINER_IMP

	EV_TEXT_COMPONENT_IMP
		undefine
			build
		redefine
			set_editable,
			move_and_resize
		end
		
	EV_BAR_ITEM_IMP

	WEL_DROP_DOWN_LIST_COMBO_BOX
		rename
			make as wel_make,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy,
			select_item as wel_select_item,
			selected_item as wel_selected_item,
			height as wel_height
		undefine
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- EV_PRIMITIVE_IMP and EV_TEXT_CONTAINER_IMP.
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
			on_char,
			on_key_down,
			on_key_up
		redefine
			default_process_message,
			on_cbn_selchange,
			on_cbn_editupdate,
			move_and_resize,
			default_style
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a combo-box with `par' as parent.
		local
			par_imp: WEL_WINDOW
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
			is_editable := True
			wel_make (par_imp, 0, 0, 0, 90, 0)
			!! ev_children.make
		end

feature -- Access

	selected_item: EV_LIST_ITEM is
			-- Give the item which is currently selected
			-- It start with a zero index in wel and with a
			-- one index for the array.
		do
			Result ?= (ev_children.i_th (wel_selected_item + 1)).interface
		end

	is_editable: BOOLEAN
			-- Is the combo-box editable

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

	set_extended_height (value: INTEGER) is
			-- Make `value' the new extended-height of the box.
		do
			move_and_resize (x, y, width, value, True)
		end

feature -- Status setting

	select_item (index: INTEGER) is
			-- Select an item of the `index'-th item of the list.
			-- We cannot redefine this feature because then a
			-- postcondition is violated because of the change
			-- of index.
		do
			wel_select_item (index - 1)
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
			check
				not_yet_implemented: False
			end
			add_command (Cmd_activate, cmd, arg)
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

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

feature {NONE} -- Implementation

	caret_position: INTEGER is
			-- Caret position
		do
			check
				not_yet_implemented: False
			end
		end

	set_caret_position (a_position: INTEGER) is
			-- Set the caret position with `position'.
		do
			check
				not_yet_implemented: False
			end
		end

	set_selection (start_position, end_position: INTEGER) is
			-- Set the selection between `start_position'
			-- and `end_position'.
		do
			check
				not_yet_implemented: False
			end
		end

	set_read_only is
			-- Set the read-only state.
		local
			par_imp: WEL_WINDOW
			temp_list: ARRAYED_LIST [STRING]
		do
			if is_editable then
				is_editable := False
				par_imp ?= parent_imp
				!! temp_list.make (0)
				save_list (temp_list)
				wel_destroy
				wel_make (par_imp, 0, 0, 0, 90, 0)
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
				is_editable := True
				par_imp ?= parent_imp
				!! temp_list.make (0)
				save_list (temp_list)
				wel_destroy
				wel_make (par_imp, 0, 0, 0, 90, 0)
				copy_list (temp_list)
			end
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

	on_cbn_selchange is
			-- The selection is about to be changed.
		do
			execute_command (Cmd_selection, Void)
			(ev_children.i_th (wel_selected_item + 1)).execute_command (Cmd_item_activate, Void)
		end

	on_cbn_editupdate is
			-- The edit control portion is about to
			-- display altered text.
		do
		end

	default_style: INTEGER is
		do
			Result := Ws_visible + Ws_child + Ws_group +
					  Ws_tabstop + Ws_vscroll + Cbs_autohscroll +
					  Cbs_ownerdrawfixed + Cbs_hasstrings
			if is_editable then
				Result := Result + Cbs_dropdown
			else
				Result := Result + Cbs_dropdownlist
			end
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
