indexing
	description: 
		"EiffelVision notebook, Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_NOTEBOOK_IMP

inherit
	EV_NOTEBOOK_I
		redefine	
			interface,
			is_usable
		select
			interface
		end

	EV_WIDGET_LIST_IMP
		undefine
			is_usable,
			count
		redefine
			enable_sensitive,
			disable_sensitive,
			set_default_minimum_size,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size,
			on_key_down,
			on_size,
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
			is_usable
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
			move_and_resize as wel_move_and_resize,
			on_desactivate as wel_on_desactivate,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
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
			on_key_up,
			on_set_cursor,
			on_draw_item,
			on_color_control,
			on_set_focus,
			on_kill_focus,
			on_wm_vscroll,
			on_wm_hscroll,
			on_key_down,
			on_char,
			show,
			hide,
			on_destroy,
			on_size,
			background_brush,
			x_position,
			y_position,
			on_sys_key_down,
			on_sys_key_up,
			on_notify,
			default_process_message
		redefine
			default_style,
			default_ex_style,
			hide_current_selection,
			show_current_selection,
			on_tcn_selchange,
			wel_move_and_resize,
			wel_resize
		end

	WEL_TCIF_CONSTANTS
		export
			{NONE} all
		end

	WEL_VK_CONSTANTS
		export
			{NONE} all
		end

	EV_NOTEBOOK_ACTION_SEQUENCES_IMP

creation
	make


feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make (default_parent, 0, 0, 0, 0, 0)
			tab_pos := interface.tab_top
			index := 0
		end

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_WIDGET_LIST_IMP}
			create ev_children.make (2)
			check_notebook_assertions := True
		end

feature {AV_ANY_I} --  Access

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	tab_pos: INTEGER
			-- Actual position of the tabs.

feature {EV_ANY_I} -- Status report

	current_page: INTEGER is
			-- One-based index of the currently opened page.
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

feature {EV_ANY_I} -- Status setting

	set_default_minimum_size is
			-- Set the current minimum size.
		do
			internal_set_font
			if tab_pos = interface.Tab_top
					or else tab_pos = interface.Tab_bottom then
				ev_set_minimum_height (tab_height)
			else
				ev_set_minimum_width (tab_height)
			end
		end
	
	set_tab_position (pos: INTEGER) is
			-- set position of tabs (left, right, top or bottom) according
			-- to value of `pos'.
		local
			ww: EV_WIDGET_IMP
		do
 			tab_pos := pos
 			set_style (basic_style)
			internal_set_font
			ww ?= selected_window
			notify_change (Nc_minsize, ww)
		end

	set_current_page (an_index: INTEGER) is
			-- Make the `an_index'-th page the currently opened page.
		do
			set_current_selection (an_index - 1)
		end

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
   			-- `flag', otherwise make sensitive.
		local
			counter: INTEGER
			child_imp: EV_WIDGET_IMP
		do
			if not is_sensitive /= flag then
				from
					counter := 0
				until
					counter = count
				loop
					child_imp ?= get_item (counter).window
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

feature {EV_ANY_I} -- Element change
	
	append_page (child_imp: EV_WIDGET_IMP; label: STRING) is
		-- Add a new page for notebook containing 'child_imp' with tab 
		-- label `label'.
		local
			a_wel_item: WEL_TAB_CONTROL_ITEM
			ww: WEL_WINDOW
		do
			ww ?= child_imp
			create a_wel_item.make
			a_wel_item.set_text (label)
			a_wel_item.set_window (ww)
			insert_item (count, a_wel_item)
			notify_change (Nc_minsize, child_imp)
		end

	set_font (f: EV_FONT) is
			-- Set `font' to `f'.
			-- When the tabs are vertical, we set back the default font
			-- by using `cwin_send_message' (feature not implemented in WEL)
			-- because vertical fonts doesn't work with everything.
		do
			private_font := f
			internal_set_font
		end

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		local
			counter: INTEGER
			child_imp: EV_WIDGET_IMP
		do
			top_level_window_imp := a_window
			from
				counter := 0
			until
				counter = count
			loop
				child_imp ?= get_item (counter).window
				check
					child_imp_not_void: child_imp /= Void
				end
				child_imp.set_top_level_window_imp (a_window)
				counter := counter + 1
			end
		end

feature {EV_ANY_I} -- Basic operation

	get_child_index (a_child: EV_WIDGET_IMP): INTEGER is
			-- `Result' is 1 based index of `a_child' in `Current' or 0 if not
			-- contained.
		require
			valid_child: is_child (a_child)
		local
			test: BOOLEAN
			child_imp: EV_WIDGET_IMP
			nb: INTEGER
		do
			from
				Result := 0
				nb := count
			until
				test or else Result = nb
			loop
				child_imp ?= get_item (Result).window
				test := a_child.is_equal (child_imp)
				Result := Result + 1
			end
		end

feature -- Assertion features

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of `Current'?
			-- We cannot use the usual context.
			-- A child is a child if the notebook is
			-- its parent.
		local
			counter: INTEGER
			child_imp: EV_WIDGET_IMP
		do
			from
				counter := 0
			until
				(counter = count) or Result
			loop
				child_imp ?= get_item (counter).window
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
			hwnd := next_dlgtabitem (top_level_window_imp.wel_item,
				wel_item, direction)
			window := window_of_item (hwnd)
			window.set_focus
		end

	process_tab_key (virtual_key: INTEGER) is
			-- Process a tab or arrow key press to give the focus to the next
			-- widget. Need to be called in the feature on_key_down when the
			-- control need to process this kind of keys.
		do
			if virtual_key = Vk_tab then
				tab_action (not key_down (Vk_shift))
			end
		end

	compute_minimum_width is
			-- Recompute the minimum_width of `Current'.
		local
			child_imp: EV_WIDGET_IMP
			counter, nb, value: INTEGER
		do
			from
				nb := count
			until
				counter = nb
			loop
				child_imp ?= get_item (counter).window
				check
					valid_cast: child_imp /= Void
				end
				value := child_imp.minimum_width.max (value)
				counter := counter + 1
			end

				-- We found the biggest child.
			if
				tab_pos = interface.Tab_right
				or else tab_pos = interface.Tab_left
			then
				ev_set_minimum_width (value + tab_height + 4)
			else
				ev_set_minimum_width (value + 6)
			end
		end

	compute_minimum_height is
			-- Recompute the minimum_height of `Current'.
		local
			counter: INTEGER
			child_imp: EV_WIDGET_IMP
			value: INTEGER
		do
			from
				counter := 0
				value := 0
			until
				counter = count
			loop
				child_imp ?= get_item (counter).window
				check
					valid_cast: child_imp /= Void
				end
				value := child_imp.minimum_height.max (value)
				counter := counter + 1
			end

				-- We found the biggest child.
			if
				tab_pos = interface.Tab_top
				or else tab_pos = interface.Tab_bottom
			then
				ev_set_minimum_height (value + tab_height + 4)
			else
				ev_set_minimum_height (value + 6)
			end
		end

	compute_minimum_size is
			-- Recompute both the minimum_width and then
			-- minimum_height of `Current'.
		local
			counter: INTEGER
			child_imp: EV_WIDGET_IMP
			mw, mh: INTEGER
		do
			from
				counter := 0
				mw := 0; mh := 0
			until
				counter = count
			loop
				child_imp ?= (get_item (counter)).window
				check
					valid_cast: child_imp /= Void
				end
				mw := child_imp.minimum_width.max (mw)
				mh := child_imp.minimum_height.max (mh)
				counter := counter + 1
			end

			-- We found the biggest child.
			if
				tab_pos = interface.Tab_top
				or else tab_pos = interface.Tab_bottom
			then
				ev_set_minimum_size (mw + 6, mh + tab_height + 4)
			elseif
				tab_pos = interface.Tab_left
				or else tab_pos = interface.Tab_right
			then
				ev_set_minimum_size (mw + tab_height + 4, mh + 6)
			end
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN) is
				-- Apply new size when minimum size changed but not size.
		local
			counter: INTEGER
			child_imp: EV_WIDGET_IMP
			tab_rect: WEL_RECT
		do
			from
				counter := 0
				tab_rect := sheet_rect
			until
				counter = count
			loop
				child_imp ?= (get_item (counter)).window
				check
					valid_cast: child_imp /= Void
				end
				child_imp.ev_apply_new_size (tab_rect.x, tab_rect.y,
					tab_rect.width, tab_rect.height, True)
				counter := counter + 1
			end
		end

feature {NONE} -- WEL Implementation

 	default_style: INTEGER is
 			-- Default windows style used to create `Current'.
		do
			Result := Ws_child + Ws_group + Ws_tabstop 
				+ Ws_visible + Ws_clipchildren + Ws_clipsiblings
				+ Tcs_singleline
		end

 	default_ex_style: INTEGER is
 			-- Default windows style used to create `Current'.
		do
			Result := Ws_ex_controlparent
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
			-- The height of the tabs in `Tab_top' or `Tab_bottom' status,
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
			-- Hide the currently selected page.
		local
			ww: EV_WIDGET_IMP
		do
			ww ?= selected_window
			if ww /= Void and then ww.exists then
				ww.show_window (ww.wel_item, Sw_hide)
			end
		end

	show_current_selection is
			-- Show the currently selected page.
			-- Do not use directly show, because there is no use to notify
			-- back the parent. Though, if there was any change done on the
			-- child, it should be reset directly on the child.
		local
			ww: EV_WIDGET_IMP
		do
			ww ?= selected_window
			if ww /= Void and then ww.exists then
				ww.wel_move_and_resize (ww.x_position, ww.y_position,
					ww.width, ww.height, True)
				ww.show_window (ww.wel_item, Sw_show)
			end
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- `Current' has been resized.
		local
			child_imp: EV_WIDGET_IMP
			tab_rect: WEL_RECT
		do
			Precursor {EV_WIDGET_LIST_IMP} (size_type, a_width, a_height)
			child_imp ?= selected_window
			if child_imp /= Void then
				tab_rect := sheet_rect
				child_imp.set_move_and_size (tab_rect.x, tab_rect.y,
					tab_rect.width, tab_rect.height)
			end
		end

	on_tcn_selchange is
			-- Selection has changed.
			-- Shows the current selected page by default.
		local
			ww: EV_WIDGET_IMP
			tab_rect: WEL_RECT
		do
			show_current_selection

				-- New sizes have been computed, simply apply them
			tab_rect := sheet_rect
			ww ?= selected_window
			ww.ev_move_and_resize (tab_rect.x, tab_rect.y,
							tab_rect.width, tab_rect.height, True)

			if selection_actions_internal /= Void then
				selection_actions_internal.call ([])
			end
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed.
		do
			process_tab_key (virtual_key)
			Precursor {EV_WIDGET_LIST_IMP} (virtual_key, key_data)
		end

	interface: EV_NOTEBOOK

	wel_move_and_resize (a_x, a_y, a_width, a_height: INTEGER;
			repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		do
			cwin_move_window (wel_item, a_x, a_y,
				a_width, a_height, repaint)
		end

	wel_resize (a_width, a_height: INTEGER) is
			-- Resize the window with `a_width', `a_height'.
		do
			cwin_set_window_pos (wel_item, default_pointer,
				0, 0, a_width, a_height,
				Swp_nomove + Swp_nozorder + Swp_noactivate)
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

	check_notebook_assertions: BOOLEAN
		-- Are assertions for `Current' from Ev_NOTEBOOK_I going to be checked?

	disable_notebook_assertions is
			-- Effectively turn of assertions from EV_NOTEBOOK_I
		do
			check_notebook_assertions := False
		end

	enable_notebook_assertions is
			-- Effectively turn on assertions from EV_NOTEBOOK_I
		do
			check_notebook_assertions := True
		end

	is_usable: BOOLEAN is
			-- Is `Current' usable?
		do
			if check_notebook_assertions then
				Result := Precursor {EV_NOTEBOOK_I}
			end
		end

feature {NONE} -- Implementation

	ev_children: ARRAYED_LIST [EV_WIDGET_IMP]
			-- Internal list of children.

	i_th (i: INTEGER): EV_WIDGET is
			-- `Result' is item at `i'-th position.
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
			ev_children.go_i_th (i)
			ev_children.put_left (v_imp)
			wel_win ?= v_imp
			check
				wel_win_not_void: wel_win /= Void
			end
			create wel_tci.make
			wel_tci.set_window (wel_win)
			insert_item (i - 1, wel_tci)
			v_imp.wel_set_parent (Current)
			v_imp.set_top_level_window_imp (top_level_window_imp)
			notify_change (Nc_minsize, v_imp)
				-- Call `new_item_actions' on `Current'.
			new_item_actions.call ([v])
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
			remove_item_actions.call ([v_imp.interface])
			ev_children.go_i_th (i)
			ev_children.remove
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
			notify_change (Nc_minsize, v_imp)
		end

feature {NONE} -- Implementation

	selected_item_index: INTEGER is
			-- One based index of topmost page.	
		do
			Result := current_page
		end

	select_item (v: like item) is
			-- Select page containing `v'.
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
			create a_wel_item.make
			a_wel_item.set_text (a_text)
			a_wel_item.set_mask (Tcif_text)
			update_item (child_index - 1, a_wel_item)
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
			child_imp: EV_WIDGET_IMP
		do
			child_imp ?= get_item (current_selection).window
			if child_imp /= Void then
				Result := child_imp.interface
			end
		end

feature {NONE} -- Font implementation

	internal_set_font is
			-- Set actual font.
		local
			local_font_windows: EV_FONT_IMP
		do
			if
				(tab_pos = interface.Tab_top)
				or else (tab_pos = interface.Tab_bottom)
			then
				if private_font /= Void then
					local_font_windows ?= private_font.implementation
					check
						valid_font: local_font_windows /= Void
					end
					wel_set_font (local_font_windows.wel_font)
				else
					set_default_font
				end
			else
				cwin_send_message (wel_item, Wm_setfont, 0,
					cwin_make_long (1, 0))
			end
		end

end -- EV_NOTEBOOK_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.61  2001/07/02 21:02:36  rogers
--| `insert_i_th' now calls the `new_item_actions'.
--|
--| Revision 1.60  2001/07/02 18:14:36  rogers
--| Correct fix for last commit. Removed `correctr_child_sensitivity' as the
--| `remove_item_actions' already call a feature which does this. The problem
--| was that `remove_item_actions' was not called from `remove_i_th'.
--|
--| Revision 1.59  2001/07/02 17:59:06  rogers
--| `remove_i_th' now calls `correct_child_sensitivity' which fixes the bug
--| described below:
--|
--| call `disable_sensitive' on a notebook.
--| Add a widget that is sensitive
--| remove the widget and place in another container that is_sensitive.
--| The widget was still disabled.
--|
--| Revision 1.58  2001/06/07 23:08:15  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.41.4.36  2001/05/26 23:51:09  manus
--| Removed comments.
--|
--| Revision 1.41.4.35  2001/03/04 22:29:43  pichery
--| Used `update_item' instead of delete+insert
--|
--| Revision 1.41.4.34  2001/02/15 23:54:20  rogers
--| Replaced is_useable with usable.
--|
--| Revision 1.41.4.33  2001/02/02 00:53:34  rogers
--| On_key_down now calls process_tab_key before Precursor. This ensures that
--| any tab movement we do in our implementation can be overriden by the user
--| with key_press_actions.
--|
--| Revision 1.41.4.32  2001/01/26 23:34:07  rogers
--| Removed undefinition of on_sys_key_down as this is already done in the
--| ancestor EV_WEL_CONTROL_CONTAINER_IMP.
--|
--| Revision 1.41.4.31  2001/01/09 19:05:42  rogers
--| Undefined default_process_message from WEL.
--|
--| Revision 1.41.4.30  2000/12/04 23:12:57  rogers
--| Formatting to 80 columns.
--|
--| Revision 1.41.4.29  2000/11/27 20:21:37  rogers
--| Undefined on_notify from WEL_TAB_CONTROL as we now use the version
--| inherited from EV_CONTAINER_IMP.
--|
--| Revision 1.41.4.26  2000/11/06 18:02:25  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.41.4.25  2000/10/20 01:26:59  manus
--| Removed non-used local variable `rect' in minimum sizes recomputation. Changed the minimum
--| sizes to add `4' instead of `2' pixels on the size that have the tabs. Why `4' instead of `2'
--| I don't know, but if you don't 2 pixels of the contents are missing. I haven't find their
--| meaning yet.
--|
--| Revision 1.41.4.24  2000/10/11 23:36:49  raphaels
--| Added rename clause for `on_activate' from WEL.
--|
--| Revision 1.41.4.23  2000/10/05 22:07:05  rogers
--| Removed set_page_title as it is redundent.
--|
--| Revision 1.41.4.22  2000/10/05 20:28:47  manus
--| Removed special notebook handling for `Tab' action. Now it will never stop on tab buttons
--| but this is better than completely loosing the focus.
--|
--| Revision 1.41.4.21  2000/09/19 15:36:41  rogers
--| Removed unreferenced variable from set_font.
--|
--| Revision 1.41.4.20  2000/09/13 22:11:59  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.41.4.19  2000/09/13 18:21:47  manus
--| Improved font usage in Notebook.
--|
--| Revision 1.41.4.18  2000/09/13 15:51:02  manus
--| Redefinition of `set_font' take into consideration if user set the font or not. If he did not
--| we simply call `set_default_font' that will not use any GDI resource.
--|
--| Revision 1.41.4.17  2000/08/11 20:29:50  rogers
--| removed fixme NOT_REVIEWED. Comments, formatting. Fixed copyright clause
--| at end of file.
--|
--| Revision 1.41.4.16  2000/08/09 23:15:09  manus
--| `on_size' can be called when there is no child in the widget, meaning that
--| you should not call `set_move_and_size' on a child that does not exist.
--|
--| Revision 1.41.4.15  2000/08/08 16:08:47  manus
--| Updated inheritance with new WEL messages handling
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--| No more wel_window_parent hack.
--| No more special redefinition of `notify_change'.
--|
--| Revision 1.41.4.14  2000/08/04 20:22:09  rogers
--| All action sequence calls through the interface have been replaced with
--| calls to the internal action sequences.
--|
--| Revision 1.41.4.13  2000/07/24 23:17:49  rogers
--| Now inherits EV_NOTEBOOK_ACTION_SREQUENCES_IMP.
--|
--| Revision 1.41.4.12  2000/07/21 23:05:28  rogers
--| Removed add_child and add_child_ok as no longer used in Vision2.
--|
--| Revision 1.41.4.11  2000/07/21 18:55:23  rogers
--| Removed romve_child as it is no longer needed in Vision2.
--|
--| Revision 1.41.4.10  2000/07/12 16:23:59  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.41.4.9  2000/06/13 18:38:30  rogers
--| Removed undefintion of remove_command.
--|
--| Revision 1.41.4.8  2000/06/05 17:36:48  manus
--| Fixed a small typo in conformance of `selected_window' with second
--| parameter of `notify_change'.
--|
--| Revision 1.41.4.7  2000/06/05 17:24:10  manus
--| 1 - New ìmplementation of `notify_change' that takes an extra parameter:
--| the child that requested the size change notification. In the case of a
--| NOTEBOOK, we will take into the account the `notify_change' action only if
--| the child that requested it is the child whose tab is selected.
--|Otherwise we do nothing.
--|
--| 2 - Updated all call to `notify_change' to conform the new signature by
--| passing the correct child.
--|
--| 3 - Improved use of `get_item' and use new `selected_window' coming from
--| WEL_TAB_CONTROL whenever possible.
--|
--| 4 - `show_current_selection' does not resize its content anymore because we
--| make the assumption that the size won't change from one window to another.
--| This improves performance but it also fixes a bug where `sheet_rect' was not
--| returning a correctl sized rectangle.
--|
--| Revision 1.41.4.6  2000/05/30 16:03:35  rogers
--| Removed unreferenced variables.
--|
--| Revision 1.41.4.5  2000/05/23 20:17:46  rogers
--| Insert_i_th no longer hides the widget being added. This fixes the problem
--| with a tab's widget not being shown without clicking on that tab.
--|
--| Revision 1.41.4.4  2000/05/09 00:53:30  manus
--| Update with WEL changes:
--| - replace `windows.item (hwnd)' by `window_of_item (hwnd)'.
--|
--| Revision 1.41.4.3  2000/05/08 16:58:29  rogers
--| Ev_children is now updated in insert_i_th and remove.
--|
--| Revision 1.41.4.2  2000/05/03 22:35:02  brendel
--| Fixed resize_actions.
--|
--| Revision 1.41.4.1  2000/05/03 19:09:36  oconnor
--| mergred from HEAD
--|
--| Revision 1.55  2000/04/28 21:53:45  rogers
--| Connected selection_actions,  as selecting a tab by clicking did not call
--| them.
--|
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
