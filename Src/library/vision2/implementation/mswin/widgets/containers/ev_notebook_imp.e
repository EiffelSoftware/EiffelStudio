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
			set_insensitive,
			set_default_minimum_size,
			child_added,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size
		end

	EV_FONTABLE_IMP
		redefine
			set_font
		end

	WEL_TAB_CONTROL
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			shown as displayed,
			destroy as wel_destroy
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
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_set_cursor,
			on_draw_item,
			on_menu_command,
			on_accelerator_command,
			on_color_control,
			on_wm_vscroll,
			on_wm_hscroll,
			on_key_down,
			show,
			hide
		redefine
			default_ex_style,
			default_style,
			adjust_items,
			hide_current_selection,
			show_current_selection,
			on_tcn_selchange
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
			wel_make (default_parent, 0, 0, 0, 0, 0)
			tab_pos := Pos_top
		end

feature -- Access

	top_level_window_imp: EV_UNTITLED_WINDOW_IMP
			-- Top level window that contains the current widget.

	tab_pos: INTEGER
			-- Actual position of the tab.

feature -- Status report

	current_page: INTEGER is
			-- One-based index of the currently opened page
		do
			Result := current_selection + 1
		end

	tab_position: STRING is
			-- Position of the tabs.
		do
			inspect
				tab_pos
			when Pos_top then
				Result:="top"
			when Pos_bottom then
				Result:="bottom"
			when Pos_left then
				Result:="left"
			when Pos_right then
				Result:="right"
			end
		end

feature -- Status setting

	set_default_minimum_size is
			-- Set the current minimum size.
		do
			set_font (font)
			if tab_pos = Pos_top or tab_pos = Pos_bottom then
				internal_set_minimum_height (tab_height)
			else
				internal_set_minimum_width (tab_height)
			end
		end
	
	set_tab_position (pos: INTEGER) is
			-- set position of tabs (left, right, top or bottom)
		do
 			tab_pos := pos
 			set_style (basic_style)
			set_font (font)
			notify_change (1 + 2)
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
			notify_change (2 + 1)
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
					valid_font: local_font_windows /= Void
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
			delete_item (index - 1)
			notify_change (2 + 1)
		end

	set_top_level_window_imp (a_window: EV_UNTITLED_WINDOW_IMP) is
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
			ww: WEL_WINDOW
		do
			from
				Result := 0
			until
				Result = count or test
			loop
				child_item := get_item (Result)
				ww := child_item.window
				child_imp ?= child_item.window
				if a_child.is_equal (child_imp) then
					test := True
				end
				Result := Result + 1
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

feature {NONE} -- Implementation

	compute_minimum_width is
			-- Recompute the minimum_width of the object.
		local
			index: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
			rect: WEL_RECT
			value: INTEGER
		do
			from
				index := 0
				value := 0
				rect := sheet_rect
			until
				index = count
			loop
				child_item := get_item (index)
				child_imp ?= child_item.window
				check
					valid_cast: child_imp /= Void
				end
				if child_imp.minimum_width > value then
					value := child_imp.minimum_width
				end
				index := index + 1
			end

			-- We found the biggest child
			if tab_pos = Pos_top or tab_pos = Pos_bottom then
				internal_set_minimum_width (value + 6)
			else
				internal_set_minimum_width (value + tab_height + 2)
			end
		end

	compute_minimum_height is
			-- Recompute the minimum_width of the object.
		local
			index: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
			rect: WEL_RECT
			value: INTEGER
		do
			from
				index := 0
				value := 0
				rect := sheet_rect
			until
				index = count
			loop
				child_item := get_item (index)
				child_imp ?= child_item.window
				check
					valid_cast: child_imp /= Void
				end
				if child_imp.minimum_height > value then
					value := child_imp.minimum_height
				end
				index := index + 1
			end

			-- We found the biggest child
			if tab_pos = Pos_left or tab_pos = Pos_right then
				internal_set_minimum_height (value + tab_height + 2)
			else
				internal_set_minimum_height (value + 6)
			end
		end

	compute_minimum_size is
			-- Recompute both the minimum_width and then
			-- minimum_height of the object.
		local
			index: INTEGER
			child_imp: EV_WIDGET_IMP
			rect: WEL_RECT
			mw, mh: INTEGER
		do
			from
				index := 0
				mw := 0; mh := 0
				rect := sheet_rect
			until
				index = count
			loop
				child_imp ?= (get_item (index)).window
				check
					valid_cast: child_imp /= Void
				end
				if child_imp.minimum_width > mw then
					mw := child_imp.minimum_width
				end
				if child_imp.minimum_height > mh then
					mh := child_imp.minimum_height
				end
				index := index + 1
			end

			-- We found the biggest child
			inspect tab_pos
			when Pos_top, Pos_bottom then
				internal_set_minimum_size (mw + 6, mh + tab_height + 2)
			when Pos_left, Pos_right then
				internal_set_minimum_size (mw + tab_height + 2, mh + 6)
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
			Result := Ws_child + Ws_group + Ws_tabstop 
				+ Ws_visible + Ws_clipchildren + Ws_clipsiblings
				+ Tcs_singleline + Tcs_focusonbuttondown
		end

	default_ex_style: INTEGER is
		do
			Result := Ws_ex_controlparent
		end

 	basic_style: INTEGER is
 			-- Default style used to create the control
 		do
 			Result := Ws_child + Ws_group + Ws_tabstop
				+ Ws_clipchildren + Ws_clipsiblings
				+ Ws_visible
			inspect tab_pos
			when Pos_top then
				Result := Result + Tcs_singleline
			when Pos_bottom then
 				Result := Result + Tcs_bottom + Tcs_singleline
 			when Pos_left then
 				Result := Result + Tcs_vertical + Tcs_fixedwidth 
					+ Tcs_multiline
			when Pos_right then
 				Result := Result + Tcs_right + Tcs_vertical
					+ Tcs_fixedwidth + Tcs_multiline
 			end
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

	hide_current_selection is
			-- Hide the current selected page.
		local
			ww: WEL_WINDOW
		do
			ww := (get_item (current_selection)).window
			if ww /= Void and then ww.exists then
				cwin_show_window (ww.item, Sw_hide)
			end
		end

	show_current_selection is
			-- Show the current selected page.
			-- Do not use directly show, because there is no use to notify back the parent.
			-- Though, if there was any change done on the child, it should be reset directly
			-- on the child.
		local
			ww: EV_WIDGET_IMP
			rect: WEL_RECT
		do
			ww ?= (get_item (current_selection)).window
			if ww /= Void and then ww.exists then
				cwin_show_window (ww.item, Sw_show)
				rect := sheet_rect
				ww.move_and_resize (rect.left, rect.top, rect.width, rect.height, True)
			end
		end

	on_tcn_selchange is
			-- Selection has changed.
			-- Shows the current selected page by default.
		do
			show_current_selection
			execute_command (Cmd_switch, Void)			
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
			Result := cwin_get_next_dlggroupitem (hdlg, hctl, previous)
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

	get_wm_hscroll_code (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_hscroll_code.
		do
			Result := cwin_get_wm_hscroll_code (wparam, lparam)
		end

	get_wm_hscroll_hwnd (wparam, lparam: INTEGER): POINTER is
			-- Encapsulation of the external cwin_get_wm_hscroll_hwnd
		do
			Result := cwin_get_wm_hscroll_hwnd (wparam, lparam)
		end

	get_wm_hscroll_pos (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_hscroll_pos
		do
			Result := cwin_get_wm_hscroll_pos (wparam, lparam)
		end

	get_wm_vscroll_code (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_vscroll_code.
		do
			Result := cwin_get_wm_vscroll_code (wparam, lparam)
		end

	get_wm_vscroll_hwnd (wparam, lparam: INTEGER): POINTER is
			-- Encapsulation of the external cwin_get_wm_vscroll_hwnd
		do
			Result := cwin_get_wm_vscroll_hwnd (wparam, lparam)
		end

	get_wm_vscroll_pos (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_vscroll_pos
		do
			Result := cwin_get_wm_vscroll_pos (wparam, lparam)
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
