--| FIXME NOT_REVIEWED this file has not been reviewed
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
		redefine	
			interface,
			is_useable
		select
			interface
		end

	EV_WIDGET_LIST_IMP
		rename
			on_set_focus as widget_on_set_focus
		undefine
			is_useable,
			count
		redefine
			enable_sensitive,
			disable_sensitive,
			set_default_minimum_size,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size,
			on_key_down,
			notebook_parent,
			interface,
			child_added,
			initialize,
			insert_i_th,
			remove_i_th,
			i_th
		end

	EV_FONTABLE_IMP
		rename
			interface as ev_fontable_imp_interface
		undefine
			is_useable
		redefine
			set_font
		end

	WEL_TAB_CONTROL
		rename
			make as wel_make,
			parent as wel_window_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			shown as is_displayed,
			destroy as wel_destroy,
			item as wel_item,
			enabled as is_sensitive, 
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			move as wel_move,
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
			on_key_up,
			on_kill_focus,
			on_set_cursor,
			on_draw_item,
			on_color_control,
			on_wm_vscroll,
			on_wm_hscroll,
			on_key_down,
			show,
			hide,
			on_destroy
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

	make (an_interface: like interface) is
			-- Create an empty notebook.
		do
			base_make (an_interface)
		--	create ev_children.make (3)
			wel_make (default_parent, 0, 0, 0, 0, 0)
			tab_pos := interface.tab_top
			index := 0
		end

	initialize is
			-- Initialize notebook
		do
			{EV_WIDGET_LIST_IMP} precursor
			check_notebook_assertions := True
		end

feature -- Access

	wel_parent: WEL_WINDOW is
			--|---------------------------------------------------------------
			--| FIXME ARNAUD
			--|---------------------------------------------------------------
			--| Small hack in order to avoid a SEGMENTATION VIOLATION
			--| with Compiler 4.6.008. To remove the hack, simply remove
			--| this feature and replace "parent as wel_window_parent" with
			--| "parent as wel_parent" in the inheritance clause of this class
			--|---------------------------------------------------------------
		do
			Result := wel_window_parent
		end

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains the current widget.

	tab_pos: INTEGER
			-- Actual position of the tabs.

feature -- Status report

	current_page: INTEGER is
			-- One-based index of the currently opened page
		do
			Result := current_selection + 1
		end

	tab_position: INTEGER is
			-- Position of the tabs.
		do
			if tab_pos = interface.Tab_top then
				Result:= interface.Tab_top
			elseif tab_pos = interface.Tab_bottom then
				Result:= interface.Tab_bottom
			elseif tab_pos = interface.Tab_left then
				Result:= interface.Tab_left
			elseif tab_pos = interface.Tab_right then
				Result:= interface.Tab_right
			end
		end

feature -- Status setting

	set_default_minimum_size is
			-- Set the current minimum size.
		do
			set_font (font)
			if tab_pos = interface.Tab_top
					or else tab_pos = interface.Tab_bottom then
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

	set_current_page (an_index: INTEGER) is
			-- Make the `an_index'-th page the currently opened page.
		do
			set_current_selection (an_index - 1)
		end

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
   			-- `flag'.
		local
			counter: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
		do
			if not is_sensitive /= flag then
				from
					counter := 0
				until
					counter = count
				loop
					child_item := get_item (counter)
					child_imp ?= child_item.window
					check
						child_imp_not_void: child_imp /= Void
					end
					if flag then
						child_imp.disable_sensitive
					else
						child_imp.enable_sensitive
					end
					counter := counter + 1
				end
			end
		end

	enable_sensitive is
			-- Enable notebook.
		do
			set_insensitive (False)
			Precursor
		end

	disable_sensitive is
			-- Disable notebook.
		do
			set_insensitive (True)
			Precursor
		end

feature -- Element change

	set_page_title (an_index: INTEGER; str: STRING) is
			-- Set the label of the `an_index' page of the notebook.
			-- The first page is the page number 1.
		local
			a_wel_item: WEL_TAB_CONTROL_ITEM
		do
			a_wel_item := get_item (an_index - 1)
			a_wel_item.set_text (str)
			delete_item (an_index - 1)
			insert_item (an_index - 1, a_wel_item)
		end
	
	append_page (child_imp: EV_WIDGET_I; label: STRING) is
		-- Add a new page for notebook containing 'child_imp' with tab 
		-- label `label'.
		local
			a_wel_item: WEL_TAB_CONTROL_ITEM
			ww: WEL_WINDOW
			widget_imp: EV_WIDGET_IMP
		do
			ww ?= child_imp
			!! a_wel_item.make
			a_wel_item.set_text (label)
			a_wel_item.set_window (ww)
			insert_item (count, a_wel_item)
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
			if (tab_pos = interface.Tab_top)
				or else (tab_pos = interface.Tab_bottom) then
				private_font := f
				local_font_windows ?= private_font.implementation
				check
					valid_font: local_font_windows /= Void
				end
				wel_set_font (local_font_windows.wel_font)
			else
				cwin_send_message (wel_item, wm_setfont, 0,
					cwin_make_long (1, 0))
			end
		end

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		local
			counter: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
		do
			top_level_window_imp := a_window
			from
				counter := 0
			until
				counter = count
			loop
				child_item := get_item (counter)
				child_imp ?= child_item.window
				check
					child_imp_not_void: child_imp /= Void
				end
				child_imp.set_top_level_window_imp (a_window)
				counter := counter + 1
			end
		end

feature -- Basic operation

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
			counter: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
		do
			from
				counter := 0
			until
				(counter = count) or Result
			loop
				child_item := get_item (counter)
				child_imp ?= child_item.window
				Result := a_child.is_equal (child_imp)
				counter := counter + 1
			end
		end

	child_added (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Has `a_child' been added properly?
		do
			Result := not a_child.is_show_requested
		end

feature {NONE} -- Implementation

	tab_action (direction: BOOLEAN) is
			-- Go to the next widget that takes the focus through to the tab
			-- key. If `direction' it goes to the next widget otherwise, it
			-- goes to the previous one.
		local
			hwnd: POINTER
			window: WEL_WINDOW
		do
			hwnd := next_dlgtabitem (wel_item, default_pointer, direction)
			window := windows.item (hwnd)
			window.set_focus
		end


	process_tab_key (virtual_key: INTEGER) is
			-- Process a tab or arrow key press to give the focus to the next
			-- widget. Need to be called in the feature on_key_down when the
			-- control need to process this kind of keys.
		local
			tab_control: WEL_TAB_CONTROL_ITEM
			window: WEL_WINDOW
			window2: WEL_WINDOW
			found: BOOLEAN
			hwnd: POINTER
		do
			if virtual_key = Vk_tab then
				if key_down (Vk_shift) then
					tab_action (False)
				else
					tab_control := get_item (current_selection)
					window ?= tab_control.window
					window.set_focus
				end
			end
		end

	compute_minimum_width is
			-- Recompute the minimum_width of the object.
		local
			counter: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
			rect: WEL_RECT
			value: INTEGER
		do
			from
				counter := 0
				value := 0
				rect := sheet_rect
			until
				counter = count
			loop
				child_item := get_item (counter)
				child_imp ?= child_item.window
				check
					valid_cast: child_imp /= Void
				end
				if child_imp.minimum_width > value then
					value := child_imp.minimum_width
				end
				counter := counter + 1
			end

			-- We found the biggest child
			if tab_pos = interface.Tab_top
					or else tab_pos = interface.Tab_bottom then
				internal_set_minimum_width (value + 6)
			else
				internal_set_minimum_width (value + tab_height + 2)
			end
		end

	compute_minimum_height is
			-- Recompute the minimum_width of the object.
		local
			counter: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
			rect: WEL_RECT
			value: INTEGER
		do
			from
				counter := 0
				value := 0
				rect := sheet_rect
			until
				counter = count
			loop
				child_item := get_item (counter)
				child_imp ?= child_item.window
				check
					valid_cast: child_imp /= Void
				end
				if child_imp.minimum_height > value then
					value := child_imp.minimum_height
				end
				counter := counter + 1
			end

			-- We found the biggest child
			if tab_pos = interface.Tab_left
					or else tab_pos = interface.Tab_right then
				internal_set_minimum_height (value + tab_height + 2)
			else
				internal_set_minimum_height (value + 6)
			end
		end

	compute_minimum_size is
			-- Recompute both the minimum_width and then
			-- minimum_height of the object.
		local
			counter: INTEGER
			child_imp: EV_WIDGET_IMP
			rect: WEL_RECT
			mw, mh: INTEGER
		do
			from
				counter := 0
				mw := 0; mh := 0
				rect := sheet_rect
			until
				counter = count
			loop
				child_imp ?= (get_item (counter)).window
				check
					valid_cast: child_imp /= Void
				end
				if child_imp.minimum_width > mw then
					mw := child_imp.minimum_width
				end
				if child_imp.minimum_height > mh then
					mh := child_imp.minimum_height
				end
				counter := counter + 1
			end

			-- We found the biggest child
			if tab_pos = interface.Tab_top
					or else tab_pos = interface.Tab_bottom then
				internal_set_minimum_size (mw + 6, mh + tab_height + 2)
			elseif tab_pos = interface.Tab_left
					or else tab_pos = interface.Tab_right then
				internal_set_minimum_size (mw + tab_height + 2, mh + 6)
			end
		end

	notebook_parent: ARRAYED_LIST[EV_NOTEBOOK_IMP] is
			-- if current widget has a parent then search
			-- recursively for the ancestors of type notebook.
			-- If an ancestor of type notebook is found then add
			-- it to the list.
			
		do
			if parent_imp /= Void then
				Result := parent_imp.notebook_parent
				if Result = Void then
					create Result.make (1)
				end
				Result.extend(Current)
			end
		end

feature {NONE} -- WEL Implementation

	adjust_items is
			-- Adjust the size of the windows of the items
			-- to the current size.
		local
			counter: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
			rect: WEL_RECT
		do
			from
				counter := 0
				rect := sheet_rect
			until
				counter = count
			loop
				child_item := get_item (counter)
				child_imp ?= child_item.window
				check
					child_imp_not_void: child_imp /= Void
				end
				child_imp.set_move_and_size (rect.left, rect.top, rect.width,
					rect.height)
				counter := counter + 1
			end
		end

 	default_style: INTEGER is
 			-- Default style used to create the control
		do
			Result := Ws_child + Ws_group + Ws_tabstop 
				+ Ws_visible + Ws_clipchildren + Ws_clipsiblings
				+ Tcs_singleline -- + Tcs_focusonbuttondown
		end

	default_ex_style: INTEGER is
		do
			Result := 0 --Ws_ex_controlparent
		end

 	basic_style: INTEGER is
 			-- Default style used to create the control
 		do
 			Result := Ws_child + Ws_group + Ws_tabstop
				+ Ws_clipchildren + Ws_clipsiblings
				+ Ws_visible
			if tab_pos = interface.tab_top then
				Result := Result + Tcs_singleline
			elseif tab_pos = interface.tab_bottom then
 				Result := Result + Tcs_bottom + Tcs_singleline
 			elseif tab_pos = interface.tab_left then
 				Result := Result + Tcs_vertical + Tcs_fixedwidth 
					+ Tcs_multiline
			elseif tab_pos = interface.tab_right then
 				Result := Result + Tcs_right + Tcs_vertical
					+ Tcs_fixedwidth + Tcs_multiline
 			end
 		end

	tab_height: INTEGER is
			-- The height of the tabs in `Tab_top' ot `Tab_bottom' status,
			-- the width of the tabs otherwise.
		do
			
			if tab_pos = interface.Tab_top then
				Result := sheet_rect.top - client_rect.top
			elseif tab_pos = interface.Tab_left then
				Result := sheet_rect.left - client_rect.left
			elseif tab_pos = interface.Tab_bottom then
				Result := client_rect.bottom - sheet_rect.bottom
			elseif tab_pos = interface.Tab_right then
				Result := client_rect.right - sheet_rect.right
			else
				Result := 0
			end
		end

	hide_current_selection is
			-- Hide the current selected page.
		local
			ww: EV_WIDGET_IMP
		do
			ww ?= (get_item (current_selection)).window
			if ww /= Void and then ww.exists then
				ww.show_window (ww.wel_item, Sw_hide)
			end
		end

	show_current_selection is
			-- Show the current selected page.
			-- Do not use directly show, because there is no use to notify
			-- back the parent. Though, if there was any change done on the
			-- child, it should be reset directly on the child.
		local
			ww: EV_WIDGET_IMP
			rect: WEL_RECT
		do
			ww ?= (get_item (current_selection)).window
			if ww /= Void and then ww.exists then
				ww.show_window (ww.wel_item, Sw_show)
				rect := sheet_rect
				ww.wel_move_and_resize (rect.left, rect.top, rect.width,
					height, True)
			end
		end

	on_tcn_selchange is
			-- Selection has changed.
			-- Shows the current selected page by default.
		do
			show_current_selection
			notify_change (2 + 1)
			--| FIXME execute_command (Cmd_switch, Void)			
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		do
			{EV_WIDGET_LIST_IMP} Precursor (virtual_key, key_data)
			process_tab_key (virtual_key)
		end

	interface: EV_NOTEBOOK

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

	check_notebook_assertions: BOOLEAN

	disable_notebook_assertions is
			-- Effectively turn of assertions in EV_NOTEBOOK_I
		do
			check_notebook_assertions := False
		end

	enable_notebook_assertions is
			-- Effectively turn of assertions in EV_NOTEBOOK_I
		do
			check_notebook_assertions := True
		end

	is_useable: BOOLEAN is
			-- Is the notebook useable
		do
			if check_notebook_assertions then
				Result := {EV_NOTEBOOK_I} Precursor
			end
		end

feature {NONE} -- Implementation

	ev_children: ARRAYED_LIST [EV_WIDGET_IMP]
			-- Internal list of children.

	i_th (i: INTEGER): EV_WIDGET is
			-- Item at `i'-th position.
		local
			wel_win: WEL_WINDOW
			v_imp: EV_WIDGET_IMP
		do
			wel_win := get_item (i - 1).window
			v_imp ?= wel_win
			check
				v_imp_not_void: v_imp /= Void
			end
			Result := v_imp.interface
		end

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			wel_tci: WEL_TAB_CONTROL_ITEM
			wel_win: WEL_WINDOW
			v_imp: EV_WIDGET_IMP
		do
				-- Should `v' be a pixmap,
				-- promote implementation to EV_WIDGET_IMP.
			v.implementation.on_parented

			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			wel_win ?= v_imp
			check
				wel_win_not_void: wel_win /= Void
			end
			create wel_tci.make
			wel_tci.set_window (wel_win)
			insert_item (i - 1, wel_tci)
			v_imp.wel_set_parent (Current)
			v_imp.set_top_level_window_imp (top_level_window_imp)
			v_imp.hide
			notify_change (2 + 1)
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		local
			v_imp: EV_WIDGET_IMP
			wel_win: WEL_WINDOW
		do
			v_imp ?= i_th (i).implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			wel_win ?= v_imp
			check
				wel_win_not_void: wel_win /= Void
			end
			disable_notebook_assertions
			if selected_item_index = i then
				if selected_item_index > 1 then
					set_current_page (selected_item_index - 1)
				elseif count > selected_item_index then
					set_current_page (selected_item_index + 1)
				end
			end
			delete_item (i - 1)
			v_imp.wel_set_parent (Default_parent)
			enable_notebook_assertions
			notify_change (2 + 1)
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
			an_index: INTEGER
		do
			an_index := get_child_index (a_child)
			delete_item (an_index - 1)
			a_child.set_parent (Void)
			notify_change (2 + 1)
		end

feature {NONE} -- Implementation

	selected_item_index: INTEGER is
			-- One based index of topmost page.	
		do
			Result := current_page
		end

	select_item (v: like item) is
			-- Select page containing `v'
		local
			an_index: INTEGER
			child_imp: EV_WIDGET_IMP
		do
			child_imp ?= v.implementation
			an_index := get_child_index (child_imp)
			set_current_selection (an_index - 1)
		end

	set_item_text (v: like item; a_text: STRING) is
			-- Assign `a_text' to the label for `an_item'.
		local
			a_wel_item: WEL_TAB_CONTROL_ITEM
			child_index: INTEGER
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= v.implementation
			child_index := get_child_index (item_imp)
			a_wel_item := get_item (child_index - 1)
			a_wel_item.set_text (a_text)
			delete_item (child_index - 1)
			insert_item (child_index - 1, a_wel_item)	
		end

	item_text (v: like item): STRING is
			-- Label of `v'.
		local
			a_wel_item: WEL_TAB_CONTROL_ITEM
			child_index: INTEGER
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= v.implementation
			child_index := get_child_index (item_imp)
			a_wel_item := get_item (child_index - 1)
			Result := a_wel_item.text
		end
	
	selected_item: like item is
			-- Page displayed topmost.
		local
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
		do
			child_item := get_item (current_page - 1)
			child_imp ?= child_item.window
			if child_imp /= Void then
				Result := child_imp.interface
			end
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.54  2000/04/28 21:42:54  rogers
--| Fixed child resizing bug when new tab is selected.
--|
--| Revision 1.53  2000/04/28 21:13:03  rogers
--| Removed old command association and a redundent FIXME.
--|
--| Revision 1.52  2000/04/14 21:32:51  brendel
--| Fixed insert_i_th for PIXMAP's.
--|
--| Revision 1.51  2000/04/05 21:16:12  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.50.2.2  2000/04/05 19:55:06  brendel
--| Fixed insert_i_th and remove_i_th.
--|
--| Revision 1.50.2.1  2000/04/03 18:23:10  brendel
--| Revised with new EV_DYNAMIC_LIST.
--| New add/remove features still need to be checked.
--|
--| Revision 1.50  2000/03/21 02:34:11  brendel
--| Removed on_accelerator_command from undefine clause.
--|
--| Revision 1.49  2000/03/14 03:02:55  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.48.2.3  2000/03/14 00:07:52  brendel
--| Renamed move_and_resize to wel_move_and_resize.
--|
--| Revision 1.48.2.2  2000/03/11 00:19:16  brendel
--| Renamed move to wel_move.
--| Renamed resize to wel_resize.
--| Renamed move_and_resize to wel_move_and_resize.
--|
--| Revision 1.48.2.1  2000/03/09 21:39:48  brendel
--| Replaced x with x_position and y with y_position.
--| Before, both were available.
--|
--| Revision 1.48  2000/03/03 19:41:05  brendel
--| Removed feature `put_left'.
--|
--| Revision 1.47  2000/03/03 18:34:43  brendel
--| Implemented feature `put_left'.
--|
--| Revision 1.46  2000/02/23 02:23:56  brendel
--| Removed on_menu_command from inh. clause.
--|
--| Revision 1.45  2000/02/19 06:34:12  oconnor
--| removed old command stuff
--|
--| Revision 1.44  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.43  2000/02/14 11:40:43  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.41.6.17  2000/02/08 00:46:37  rogers
--| Removed the FIXME from item_text as it now works.
--|
--| Revision 1.41.6.16  2000/02/03 19:21:23  rogers
--| Added missing comments, implemented remaining features and removed some
--| redundent code.
--|
--| Revision 1.41.6.15  2000/02/02 20:57:37  rogers
--| Redefined useable, so it can be turned on and off from within this class,
--| to enable the assertions from EV_NOTEBOOK_I, to be effectively ignored
--| during WEL calls by setting check_notebook_assertions to false. Redefined
--| initialize, and set check_notebook_assertions to true within this.
--| Impleemnted remove. Also implemented enable_notebook_assertions and
--| disable_notebook_assertions.
--|
--| Revision 1.41.6.14  2000/01/31 19:29:46  brendel
--| Added redefine of child_added.
--|
--| Revision 1.41.6.13  2000/01/31 17:27:20  brendel
--| Commented out code to do with old parenting.
--|
--| Revision 1.41.6.12  2000/01/29 02:28:49  brendel
--| Added empty implementation of `go_to'.
--|
--| Revision 1.41.6.11  2000/01/29 02:24:11  rogers
--| Implemented a lot of the features that are deferred from EV_WIDGET_LIST_I.
--|
--| Revision 1.41.6.10  2000/01/29 01:05:03  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.41.6.9  2000/01/27 19:30:22  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.41.6.8  2000/01/27 17:47:51  rogers
--| redefined interface in EV_NOTEBOOK_I, EV_WIDGET_LIST_I, EV_CONTAINER_IMP
--| and renamed it in EV_FONTABLE_IMP. ev_notebook_imp.e
--|
--| Revision 1.41.6.7  2000/01/25 17:37:52  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.41.6.6  2000/01/18 20:12:19  rogers
--| Any reference to tab_left, tab_right, tab_top or tab_bottom now come from
--| the interface. Index has been defined, so all internal temporary variables
--| named index have been renamed.
--|
--| Revision 1.41.6.5  2000/01/18 18:02:42  rogers
--| Now inherits from EV_WIDGET_LIST_I. All the deferred features have been
--| added to this class, but not yet implemented.
--|
--| Revision 1.41.6.4  2000/01/18 00:28:46  rogers
--| Commented out propagate_foreground_color and propagate_background_color in
--| class text, as they are now inherited from EV_NOTEBOOK_I, added a fixme
--| or when notebooks are reviewed.
--|
--| Revision 1.41.6.3  2000/01/14 19:30:07  rogers
--| Added features required by notebook. None of them are yet implementaed.
--|
--| Revision 1.41.6.2  1999/12/17 00:50:09  rogers
--| Altered to fit in with the review branch. Make now takes an interface.
--|
--| Revision 1.41.6.1  1999/11/24 17:30:27  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.41.2.3  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
