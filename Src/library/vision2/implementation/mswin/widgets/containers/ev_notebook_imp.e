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
		local
			a_default_pointer: POINTER
		do
			cwin_set_window_pos (wel_item, a_default_pointer,
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
			wel_tci.set_text ("")
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
				-- | FIXME The WEL_TAB_CONTROL hides and
				-- shows the children depending on if the current tab is visible.
				-- The next line ensures that when we remove the child,
				-- it is always made visible again. This ignores the actual
				-- state of the child set from Vision2, so at some point, we need
				-- to fix this. This behaviour is deemed to be better than always being hidden.
				-- Julian
			v_imp.show
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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

