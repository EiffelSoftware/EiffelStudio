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

	EV_LIST_ITEM_CONTAINER_IMP

	EV_PRIMITIVE_IMP
		undefine
			set_default_colors
		redefine
			make
		end

	WEL_SINGLE_SELECTION_LIST_BOX
		rename
			make as wel_make,
			destroy as wel_desroy,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			font as wel_font,
			set_font as wel_set_font,
			-- The signatures are differents in WEL and Vision.
			selected_item as single_selected_item,
			select_item as single_select_item
		undefine
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- and EV_PRIMITIVE_IMP
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
			on_key_up,
			on_set_focus,
			on_kill_focus,
			wel_background_color,
			wel_foreground_color,
			default_process_message
		redefine
			selected,
			on_lbn_dblclk,
			on_lbn_selchange,
			default_style,
			default_process_message
		select
			single_select_item
		end

	WEL_MULTIPLE_SELECTION_LIST_BOX
		rename
			make as wel_make,
			destroy as wel_destroy,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			font as wel_font,
			set_font as wel_set_font,
			-- The signatures are differents in WEL and Vision.
			selected_items as multiple_selected_items,
			select_item as multiple_select_item
		undefine
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- and EV_PRIMITIVE_IMP
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
			on_key_up,
			on_set_focus,
			on_kill_focus,
			wel_background_color,
			wel_foreground_color,
			default_process_message
		redefine
			selected,
			on_lbn_dblclk,
			on_lbn_selchange,
			default_style,
			default_process_message
		select
			wel_destroy
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
			wel_make (default_parent.item, 0, 0, 0, 0, 0)
			!! ev_children.make
			is_multiple_selection := False
		end	

feature -- Access

	selected_item: EV_LIST_ITEM is
			-- Item which is currently selected, for a multiple
			-- selection, it gives the last selected item.
		do
			if not is_multiple_selection and selected then
				Result ?= (ev_children.i_th (single_selected_item + 1)).interface
			end
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			if is_multiple_selection then
				Result := {WEL_MULTIPLE_SELECTION_LIST_BOX}	Precursor
			else
				Result := {WEL_SINGLE_SELECTION_LIST_BOX} Precursor
			end
		end

	is_multiple_selection: BOOLEAN
			-- True if the user can choose several items,
			-- False otherwise

feature -- Status setting

	select_item (index: INTEGER) is
			-- Select item at the one-based `index'.
			-- We cannot redefine this feature because 
			-- of the postconditions.
		do
			if is_multiple_selection then
				multiple_select_item (index - 1)
			else
				single_select_item (index - 1)
			end
		end

	set_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		local
			wel_imp: WEL_WINDOW
		do
			if not is_multiple_selection then
				is_multiple_selection := True
				wel_imp ?= parent_imp
				wel_destroy
				wel_make (wel_imp, 0, 0, 0, 0, 0)
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
				is_multiple_selection := False
				wel_imp ?= parent_imp
				wel_destroy
				wel_make (wel_imp, 0, 0, 0, 0, 0)
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
		do
			if not ev_children.empty then
				from
					ev_children.start
				until
				ev_children.after
				loop
					add_string (ev_children.item.text)
					ev_children.forth
				end
			end
		end

	on_lbn_selchange is
			-- The selection has changed.
			-- We call the selection command of the list and the select
			-- command of the item if necessary.
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			if selected then
				if is_multiple_selection then
					item_imp := ev_children @ (caret_index + 1)
					if item_imp.is_selected then
						item_imp.execute_command (Cmd_item_activate, Void)
						last_selected_item := item_imp
					else
						item_imp.execute_command (Cmd_item_deactivate, Void)
					end
					execute_command (Cmd_selection, Void)
				else
					item_imp := ev_children @ (single_selected_item + 1)
					if last_selected_item /= item_imp then
						item_imp.execute_command (Cmd_item_activate, Void)
						if last_selected_item /= Void then
							last_selected_item.execute_command (Cmd_item_deactivate, Void)
						end
						last_selected_item := item_imp
						execute_command (Cmd_selection, Void)
					end
				end
			else
				last_selected_item := Void
				execute_command (Cmd_selection, Void)
			end
		end

	on_lbn_dblclk is
			-- Double click on a string.
			-- Send the event to the current selected item or to the one
			-- that has the focus.
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			if is_multiple_selection then
				item_imp := ev_children @ (caret_index + 1)
			else
				item_imp := ev_children @ (single_selected_item + 1)
			end
			if item_imp /= Void then
				item_imp.execute_command (Cmd_item_dblclk, Void)
			end
		end

feature {NONE} -- Implementation : WEL features

	default_style: INTEGER is
		do
			Result := Ws_child + Ws_visible + Ws_group 
						+ Ws_tabstop + Ws_border + Ws_vscroll
						+ Lbs_notify --+ Lbs_ownerdrawfixed 
						+ Lbs_hasstrings + Lbs_nointegralheight
			if is_multiple_selection then
				Result := Result + Lbs_multiplesel
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
				!! paint_dc.make_by_pointer (Current, cwel_integer_to_pointer(wparam))
				!! rect.make_client (Current)
				top := item_height * (count - top_index)
				if top < rect.bottom then
					rect.set_top (top)
					paint_dc.fill_rect (rect, background_brush)
				end
				disable_default_processing
			end
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
