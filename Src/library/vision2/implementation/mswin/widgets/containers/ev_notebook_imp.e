indexing
	description: 
		"EiffelVision notebook, Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_NOTEBOOK_IMP

inherit
	EV_NOTEBOOK_I

	EV_CONTAINER_IMP
		redefine
			child_minheight_changed,
			child_minwidth_changed,
			on_first_display,
			set_insensitive,
			set_default_minimum_size,
			child_added
		end

	EV_FONTABLE_IMP
		redefine
			set_font
		end

	WEL_TAB_CONTROL
		rename
			make as wel_make,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy
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
			on_char,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_draw_item,
			on_menu_command
		redefine
			default_ex_style,
			default_style,
			adjust_items,
			on_tcn_selchange,
			on_key_down
		end

	WEL_TCIF_CONSTANTS
		export
			{NONE} all
		end

	WEL_VK_CONSTANTS
		export
			{NONE} all
		end

creation
	make
	
feature {NONE} -- Initialization

	make is
			-- Create an empty notebook.
		do
			wel_make (default_parent.item, 0, 0, 0, 0, 0)
			tab_pos := Pos_top
		end

feature -- Access

	top_level_window_imp: WEL_WINDOW
			-- Top level window that contains the current widget.

	tab_pos: INTEGER
			-- Actual position of the tab.

feature -- Status report

	current_page: INTEGER is
			-- One-based index of the currently opened page
		do
			Result := current_selection + 1
		end

feature -- Status setting

	set_default_minimum_size is
			-- Set the current minimum size.
		do
			set_font (font)
			if tab_pos = Pos_top or tab_pos = Pos_bottom then
				set_minimum_height (tab_height)
			else
				set_minimum_width (tab_height)
			end
		end
	
	set_tab_position (pos: INTEGER) is
			-- set position of tabs (left, right, top or bottom)
		do
 			tab_pos := pos
 			set_style (basic_style)
			set_font (font)
		end

	set_current_page (index: INTEGER) is
			-- Make the `index'-th page the currently opened page.
		do
			set_current_selection (index - 1)
		end

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
   			-- `flag'.
		local
			index: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
		do
			if insensitive /= flag then
				from
					index := 0
				until
					index = count
				loop
					child_item := get_item (index)
					child_imp ?= child_item.window
					check
						child_imp_not_void: child_imp /= Void
					end
					child_imp.set_insensitive (flag)
					index := index + 1
				end
				{EV_CONTAINER_IMP} Precursor (flag)
			end
		end

feature -- Element change

	set_page_title (index: INTEGER; str: STRING) is
			-- Set the label of the `index' page of the notebook.
			-- The first page is the page number 1.
		local
			wel_item: WEL_TAB_CONTROL_ITEM
		do
			wel_item := get_item (index - 1)
			wel_item.set_text (str)
			delete_item (index - 1)
			insert_item (index - 1, wel_item)
		end
	
	append_page (child_imp: EV_WIDGET_I; label: STRING) is
		-- Add a new page for notebook containing 'child_imp' with tab 
		-- label `label'.
		local
			wel_item: WEL_TAB_CONTROL_ITEM
			ww: WEL_WINDOW
			widget_imp: EV_WIDGET_IMP
		do
			ww ?= child_imp
			!! wel_item.make
			wel_item.set_text (label)
			wel_item.set_window (ww)
			insert_item (count, wel_item)
			widget_imp ?= child_imp
			child_minwidth_changed (widget_imp.minimum_width, widget_imp)
			child_minheight_changed (widget_imp.minimum_height, widget_imp)
		end

	set_font (f: EV_FONT) is
			-- Set `font' to `f'.
			-- When the tabs are vertical, we set back the default font
			-- by using `cwin_send_message' (feature not implemented in WEL)
			-- because vertical fonts doesn't work with everything.
		local
			local_font_windows: EV_FONT_IMP
		do
			if (tab_pos = Pos_top) or (tab_pos = Pos_bottom) then
				private_font := f
				local_font_windows ?= private_font.implementation
				check
					valid_font: local_font_windows /= void
				end
				wel_set_font (local_font_windows.wel_font)
			else
				cwin_send_message (item, wm_setfont, 0, cwin_make_long (1, 0))
			end
		end

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite. In this container, `child' is the
			-- child of the container whose page is currently selected.
		do
			child_imp.hide
		end

	remove_child (a_child: EV_WIDGET_IMP) is
			-- Remove the given child from the children of
			-- the container.
		local
			index: INTEGER
		do
			index := get_child_index (a_child)
			child_minwidth_changed (0, a_child)
			child_minheight_changed (0, a_child)
			delete_item (index - 1)
		end

	set_top_level_window_imp (a_window: WEL_WINDOW) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		local
			index: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
		do
			top_level_window_imp := a_window
			from
				index := 0
			until
				index = count
			loop
				child_item := get_item (index)
				child_imp ?= child_item.window
				check
					child_imp_not_void: child_imp /= Void
				end
				child_imp.set_top_level_window_imp (a_window)
				index := index + 1
			end
		end

feature -- Event - command association
	
	add_switch_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed
			-- when a page is switch in the notebook.
		do
			add_command (Cmd_switch, cmd, arg)
		end	

feature -- Event -- removing command association

	remove_switch_commands is
			-- Empty the list of commands to be executed
			-- when a page is switch in the notebook.
		do
			remove_command (Cmd_switch)
		end	

feature -- Basic operation

	propagate_background_color is
			-- Propagate the current background color of the container
			-- to the children.
		local
			index: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
		do
			from
				index := 0
			until
				index = count
			loop
				child_item := get_item (index)
				child_imp ?= child_item.window
				check
					child_imp_not_void: child_imp /= Void
				end
				child_imp.set_background_color (background_color)
				index := index + 1
			end
		end

	propagate_foreground_color is
			-- Propagate the current foreground color of the container
			-- to the children.
		local
			index: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
		do
			from
				index := 0
			until
				index = count
			loop
				child_item := get_item (index)
				child_imp ?= child_item.window
				check
					child_imp_not_void: child_imp /= Void
				end
				child_imp.set_foreground_color (foreground_color)
				index := index + 1
			end
		end

	get_child_index (a_child: EV_WIDGET_IMP): INTEGER is
			-- Return the index of the children in the notebook.
		require
			valid_child: is_child (a_child)
		local
			test: BOOLEAN
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
		do
			from
				Result := 0
			until
				(Result = count) or test
			loop
				Result := Result + 1
				child_item := get_item (Result)
				child_imp ?= child_item.window
				if a_child.is_equal (child_imp) then
					test := True
				end
			end
		end

	on_first_display is
			-- Called by the top_level window.
			-- Almost the same action than adjust_items.
		local
			index: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
		do
			from
				index := 0
			until
				index = count
			loop
				child_item := get_item (index)
				child_imp ?= child_item.window
				check
					child_imp_not_void: child_imp /= Void
				end
				child_imp.on_first_display
				index := index + 1
			end
		end

feature -- Assertion features

	add_child_ok: BOOLEAN is
			-- True, if it is ok to add a child to
			-- container. With a notebook, it is 
			-- always ok.
		do
			Result := True
		end

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of the container?
			-- We cannot use the usual context.
			-- A child is a child if the notebook is
			-- its parent.
		local
			index: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
		do
			from
				index := 0
			until
				(index = count) or Result
			loop
				child_item := get_item (index)
				child_imp ?= child_item.window
				Result := a_child.is_equal (child_imp)
				index := index + 1
			end
		end

	child_added (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Has `a_child' been added properly?
		do
			Result := not a_child.shown
		end

feature {NONE} -- Implementation for automatic size compute

	child_minwidth_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the minimum width of the container because
			-- the child changed his wn minimum value.
			-- We add 6 or 2 for the border size.
		do
			if tab_pos = Pos_top or tab_pos = Pos_top then
				if value + 6 > minimum_width then
					set_minimum_width (value + 6)
				end
			else
				if value + tab_height > minimum_width then
					set_minimum_width (value + tab_height + 2)
				end
			end
		end

	child_minheight_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the minimum height of the container because
			-- the child changed his own minimum width.
			-- We add 6 or 2 for the border size.
		do
			if tab_pos = Pos_left or tab_pos = Pos_right then
				if value + 6 > minimum_height then
					set_minimum_height (value + 6)
				end
			else
				if value + tab_height > minimum_height then
					set_minimum_height (value + tab_height + 2)
				end
			end
		end

feature {NONE} -- WEL Implementation

	adjust_items is
			-- Adjust the size of the windows of the items
			-- to the current size.
		local
			index: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
			rect: WEL_RECT
		do
			from
				index := 0
				rect := sheet_rect
			until
				index = count
			loop
				child_item := get_item (index)
				child_imp ?= child_item.window
				check
					child_imp_not_void: child_imp /= Void
				end
				child_imp.set_move_and_size (rect.left, rect.top, rect.width, rect.height)
				index := index + 1
			end
		end

 	default_style: INTEGER is
 			-- Default style used to create the control
		do
			Result := Ws_child + Ws_visible + Ws_group
				+ Ws_tabstop + Ws_clipchildren + Ws_clipsiblings
				+ Tcs_singleline
		end

 	basic_style: INTEGER is
 			-- Default style used to create the control
 		do
 			Result := Ws_visible + Ws_child + Ws_group + Ws_tabstop
				+ Ws_clipchildren + Ws_clipsiblings
			if tab_pos = Pos_top then
				Result := Result + Tcs_singleline
			elseif tab_pos = Pos_bottom then
 				Result := Result + Tcs_bottom + Tcs_singleline
 			elseif tab_pos = Pos_left then
 				Result := Result + Tcs_vertical + Tcs_fixedwidth 
					+ Tcs_multiline
			elseif tab_pos = Pos_right then
 				Result := Result + Tcs_right + Tcs_vertical
					+ Tcs_fixedwidth + Tcs_multiline
 			end
 		end

	default_ex_style: INTEGER is
		do
			Result := Ws_ex_controlparent
		end

	tab_height: INTEGER is
			-- The height of the tabs in `Pos_top' ot `Pos_bottom' status,
			-- the width of the tabs otherwise.
		do
			inspect tab_pos 
			when Pos_top then
				Result := sheet_rect.top - client_rect.top
			when Pos_left then
				Result := sheet_rect.left - client_rect.left
			when Pos_bottom then
				Result := client_rect.bottom - sheet_rect.bottom
			when Pos_right then
				Result := client_rect.right - sheet_rect.right
			else
				Result := 0
			end
		end

	on_tcn_selchange is
			-- Selection has changed.
			-- Shows the current selected page by default.
		do
			show_current_selection
			execute_command (Cmd_switch, Void)			
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Use the tab key to jump from one control
			-- to another. Use also the arrows.
		local
			hwnd: POINTER
			window: WEL_WINDOW
		do
			if virtual_key = Vk_tab then
				hwnd := next_dlgtabitem (top_level_window_imp.item, item, True)
				window := windows.item (hwnd)
				window.set_focus
			elseif virtual_key = Vk_down then
				hwnd := next_dlggroupitem (top_level_window_imp.item, item, True)
				window := windows.item (hwnd)
				window.set_focus
			elseif virtual_key = Vk_up then
				hwnd := next_dlggroupitem (top_level_window_imp.item, item, False)
				window := windows.item (hwnd)
				window.set_focus
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

end -- EV_NOTEBOOK_IMP

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
