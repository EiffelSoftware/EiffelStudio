indexing
	description: "Abstract notions of window which can accept children."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_COMPOSITE_WINDOW

inherit
	WEL_WINDOW
		redefine
			minimal_width,
			minimal_height,
			maximal_width,
			maximal_height,
			move_and_resize,
			move,
			process_message,
			on_wm_destroy,
			destroy
		end

	WEL_SYSTEM_METRICS
		export
			{NONE} all
		end

	WEL_GW_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	children: LINKED_LIST [WEL_WINDOW] is
			-- Construct a linear representation of the children.
		require
			exists: exists
		local
			hwnd: POINTER
			win: WEL_WINDOW
		do
			!! Result.make
			from
				hwnd := cwin_get_window (item, Gw_child)
			until
				hwnd = default_pointer
			loop
				win ?= windows.item (hwnd)
				if win /= Void then
					Result.finish
					Result.put_right (win)
				end
				hwnd := cwin_get_window (hwnd, Gw_hwndnext)
			end
		ensure
			result_not_void: Result /= Void
		end

	menu: WEL_MENU is
			-- Associated menu
		require
			exists: exists
			has_menu: has_menu
		do
			!! Result.make_by_pointer (cwin_get_menu (item))
		ensure
			result_not_void: Result /= Void
		end

	system_menu: WEL_MENU is
			-- Associated system menu
		require
			exists: exists
			has_system_menu: has_system_menu
		do
			!! Result.make_by_pointer (cwin_get_system_menu (item,
				False))
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	closeable: BOOLEAN is
			-- Can the user close the window?
			-- Yes by default.
		do
			Result := True
		end

	has_menu: BOOLEAN is
			-- Does the window have a menu?
		require
			exists: exists
		do
			Result := cwin_get_menu (item) /= default_pointer
		end

	has_system_menu: BOOLEAN is
			-- Does the window have a system menu?
		require
			exists: exists
		do
			Result := cwin_get_system_menu (item, False) /=
				default_pointer
		end

	minimal_width: INTEGER is
			-- Minimal width allowed for the window
		do
			Result := window_minimum_width
		end

	maximal_width: INTEGER is
			-- Maximal width allowed for the window
		do
			Result := screen_width
		end

	minimal_height: INTEGER is
			-- Minimal height allowed for the window
		do
			Result := window_minimum_height
		end

	maximal_height: INTEGER is
			-- Maximal height allowed for the window
		do
			Result := screen_height
		end

feature -- Status setting

	set_menu (a_menu: WEL_MENU) is
			-- Set a `menu' for the window.
		require
			exists: exists
			a_menu_not_void: a_menu /= Void
			a_menu_exists: a_menu.exists
		do
			cwin_set_menu (item, a_menu.item)
		ensure
			has_menu: has_menu
			menu_set: menu.item = a_menu.item
		end

	unset_menu is
			-- Unset the current menu associated to the window.
		require
			exists: exists
		do
			cwin_set_menu (item, default_pointer)
		ensure
			menu_unset: not has_menu
		end

feature -- Basic operations

	destroy is
			-- Destroy the window and quit the application
			-- if `Current' is the application's main window.
		do
			exists := False
			unregister_window (Current)
			if application_main_window.is_application_main_window (Current) then
				cwin_post_quit_message (0)
			else
				cwin_destroy_window (item)
			end
		end

	draw_menu is
			-- Draw the menu bar associated with the window.
		require
			exists: exists
			has_menu: has_menu
		do
			cwin_draw_menu_bar (item)
		end

	move_absolute (a_x, a_y: INTEGER) is
			-- Move the window to `a_x', `a_y' absolute position.
		require
			exists: exists
		do
			cwin_set_window_pos (item, default_pointer,
				a_x, a_y, 0, 0, Swp_nosize + Swp_nozorder)
		ensure
			absolute_x_set: absolute_x = a_x
			absolute_y_set: absolute_y = a_y
		end

	move (a_x, a_y: INTEGER) is
			-- Move the window to `a_x', `a_y' position.
		local
			point: WEL_POINT
		do
			if parent = Void then
				move_absolute (a_x, a_y)
			else
				!! point.make (a_x, a_y)
				point.client_to_screen (parent)
				move_absolute (point.x, point.y)
			end
		end

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		local
			point: WEL_POINT
		do
			if parent = Void then
				move_absolute (a_x, a_y)
			else
				!! point.make (a_x, a_y)
				point.client_to_screen (parent)
				cwin_move_window (item, point.x, point.y, a_width, a_height, repaint)
			end
		end

feature -- Messages

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
			-- A `notify_code' is received for `control'.
		require
			exists: exists
			control_not_void: control /= Void
			control_exists: control.exists
		do
		end

	on_control_command (control: WEL_CONTROL) is
			-- A command has been received from `control'.
		require
			exists: exists
			control_not_void: control /= Void
			control_exists: control.exists
		do
		end

	on_control_id_command (control_id: INTEGER) is
			-- A command has been received from `control_id'.
		require
			exists: exists
		do
		end

	on_menu_command (menu_id: INTEGER) is
			-- The `menu_id' has been choosen from the menu.
		require
			exists: exists
		do
		end

	on_accelerator_command (accelerator_id: INTEGER) is
			-- The `acelerator_id' has been activated.
		require
			exists: exists
		do
		end

	on_menu_select (menu_item, flags: INTEGER; a_menu: WEL_MENU) is
			-- The `menu_item' from `a_menu' is currently
			-- highlighted by the selection bar. `flags'
			-- indicates the state of `a_menu'.
			-- The selection does not mean that the user has
			-- choosen the option, the option is just highlighted.
		require
			exists: exists
		do
		end

	on_vertical_scroll_control (scroll_code, position: INTEGER;
			bar: WEL_BAR) is
			-- Vertical scroll is received with a
			-- `scroll_code' type. `position' is
			-- the new scrollbox position. `bar'
			-- indicates the scrollbar or trackbar
			-- control activated.
		require
			exists: exists
			bar_not_void: bar /= Void
			bar_exists: bar.exists
		do
		end

	on_horizontal_scroll_control (scroll_code, position: INTEGER;
			bar: WEL_BAR) is
			-- Horizontal scroll is received with a
			-- `scroll_code' type. `position' is
			-- the new scrollbox position. `bar'
			-- indicates the scrollbar or trackbar
			-- control activated.
		require
			exists: exists
			bar_not_void: bar /= Void
			bar_exists: bar.exists
		do
		end

feature {NONE} -- Implementation

	on_wm_command (wparam, lparam: INTEGER) is
			-- Wm_command message.
			-- Dispatch a Wm_command message to
			-- `on_wm_control_id_command', `on_control_command'
			-- `on_menu_command', or `on_accelerator_command'.
		require
			exists: exists
		local
			control: WEL_CONTROL
			control_id: INTEGER
			hwnd_control: POINTER
			notify_code: INTEGER
		do
			control_id := cwin_get_wm_command_id (wparam, lparam)
			hwnd_control := cwin_get_wm_command_hwnd (wparam, lparam)
			notify_code := cwin_get_wm_command_cmd (wparam, lparam)
			if hwnd_control /= default_pointer then
				-- Message comes from a control
				on_wm_control_id_command (control_id)
				control ?= windows.item (hwnd_control)
				if control /= Void then
					check
						control_exists: control.exists
					end
					on_control_command (control)
					notify (control, notify_code)
					control.process_notification (notify_code)
				end
			elseif notify_code = 0 then
				-- Message comes from a menu
				on_wm_menu_command (control_id)
			elseif notify_code = 1 then
				-- Message comes from an accelerator
				on_accelerator_command (control_id)
			end
		end

	on_wm_control_id_command (control_id: INTEGER) is
			-- Wm_command from a `control_id'.
		require
			exists: exists
		do
			on_control_id_command (control_id)
		end

	on_wm_menu_command (menu_id: INTEGER) is
			-- Wm_command from a `menu_id'.
		require
			exists: exists
		do
			on_menu_command (menu_id)
		end

	on_wm_menu_select (wparam, lparam: INTEGER) is
			-- Wm_menuselect message.
		require
			exists: exists
		local
			p: POINTER
			menu_item, flags: INTEGER
			a_menu: WEL_MENU
		do
			p := cwin_get_wm_menuselect_hmenu (wparam, lparam)
			if p /= default_pointer then
				!! a_menu.make_by_pointer (p)
				on_menu_select (cwin_get_wm_menuselect_cmd (wparam, lparam),
					cwin_get_wm_menuselect_flags (wparam, lparam),
					a_menu)
			end
		end

	on_wm_vscroll (wparam, lparam: INTEGER) is
			-- Wm_vscroll message.
		local
			a_bar: WEL_BAR
		do
			a_bar ?= windows.item (cwin_get_wm_vscroll_hwnd (wparam,
				lparam))
			check
				a_bar_not_void: a_bar /= Void
				a_bar_exists: a_bar.exists
			end
			on_vertical_scroll_control (cwin_get_wm_vscroll_code (wparam, lparam),
				cwin_get_wm_vscroll_pos (wparam, lparam),
				a_bar)
		end

	on_wm_hscroll (wparam, lparam: INTEGER) is
			-- Wm_hscroll message.
		local
			a_bar: WEL_BAR
		do
			a_bar ?= windows.item (cwin_get_wm_hscroll_hwnd (wparam,
				lparam))
			check
				a_bar_not_void: a_bar /= Void
				a_bar_exists: a_bar.exists
			end
			on_horizontal_scroll_control (cwin_get_wm_hscroll_code (wparam, lparam),
				cwin_get_wm_hscroll_pos (wparam, lparam),
				a_bar)
		end

	on_wm_close: INTEGER is
			-- Wm_close message.
		require
			exists: exists
		do
			if not closeable then
				-- We have to stop the default process
				Result := -1
			end
		end

	on_wm_destroy is
			-- Wm_destroy message.
			-- Quit the application if `Current' is the
			-- application's main window.
		do
			on_destroy
			exists := False
			unregister_window (Current)
			if application_main_window.is_application_main_window (Current) then
				cwin_post_quit_message (0)
			end
		end

	application_main_window: WEL_APPLICATION_MAIN_WINDOW is
			-- Once object used by `on_wm_destroy' to test if `Current'
			-- is the application's main window.
		once
			!! Result
		ensure
			result_not_void: Result /= Void
		end

feature {WEL_DISPATCHER}

	frozen composite_process_message, process_message (hwnd: POINTER;
			msg, wparam, lparam: INTEGER): INTEGER is
		do
			-- Call the `process_message' routine of the
			-- parent class.
			Result := window_process_message (hwnd, msg,
				wparam, lparam)
			if msg = Wm_command then
				on_wm_command (wparam, lparam)
			elseif msg = Wm_menuselect then
				on_wm_menu_select (wparam, lparam)
			elseif msg = Wm_vscroll then
				on_wm_vscroll (wparam, lparam)
			elseif msg = Wm_hscroll then
				on_wm_hscroll (wparam, lparam)
			elseif msg = Wm_close then
				Result := on_wm_close
			end
		end

feature {NONE} -- Externals

	cwin_set_menu (hwnd, hmenu: POINTER) is
			-- SDK SetMenu
		external
			"C [macro <wel.h>] (HWND, HMENU)"
		alias
			"SetMenu"
		end

	cwin_draw_menu_bar (hwnd: POINTER) is
			-- SDK DrawMenuBar
		external
			"C [macro <wel.h>] (HWND)"
		alias
			"DrawMenuBar"
		end

	cwin_get_menu (hwnd: POINTER): POINTER is
			-- SDK GetMenu
		external
			"C [macro <wel.h>] (HWND): EIF_POINTER"
		alias
			"GetMenu"
		end

	cwin_get_system_menu (hwnd: POINTER; revert: BOOLEAN): POINTER is
			-- SDK GetSystemMenu
		external
			"C [macro <wel.h>] (HWND, BOOL): EIF_POINTER"
		alias
			"GetSystemMenu"
		end

	cwin_get_window (hwnd: POINTER; relation_flag: INTEGER): POINTER is
			-- SDK GetWindow
		external
			"C [macro <wel.h>] (HWND, UINT): EIF_POINTER"
		alias
			"GetWindow"
		end

	cwin_post_quit_message (exit_code: INTEGER) is
			-- SDK PostQuitMessage
		external
			"C [macro <wel.h>] (int)"
		alias
			"PostQuitMessage"
		end

	cwin_get_wm_command_id (wparam, lparam: INTEGER): INTEGER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_COMMAND_ID"
		end

	cwin_get_wm_command_hwnd (wparam, lparam: INTEGER): POINTER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_POINTER"
		alias
			"GET_WM_COMMAND_HWND"
		end

	cwin_get_wm_command_cmd (wparam, lparam: INTEGER): INTEGER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_COMMAND_CMD"
		end

	cwin_get_wm_menuselect_cmd (wparam, lparam: INTEGER): INTEGER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_MENUSELECT_CMD"
		end

	cwin_get_wm_menuselect_flags (wparam, lparam: INTEGER): INTEGER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_MENUSELECT_FLAGS"
		end

	cwin_get_wm_menuselect_hmenu (wparam, lparam: INTEGER): POINTER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_POINTER"
		alias
			"GET_WM_MENUSELECT_HMENU"
		end

	cwin_get_wm_vscroll_code (wparam, lparam: INTEGER): INTEGER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_VSCROLL_CODE"
		end

	cwin_get_wm_vscroll_pos (wparam, lparam: INTEGER): INTEGER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_VSCROLL_POS"
		end

	cwin_get_wm_vscroll_hwnd (wparam, lparam: INTEGER): POINTER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_POINTER"
		alias
			"GET_WM_VSCROLL_HWND"
		end

	cwin_get_wm_hscroll_code (wparam, lparam: INTEGER): INTEGER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_HSCROLL_CODE"
		end

	cwin_get_wm_hscroll_pos (wparam, lparam: INTEGER): INTEGER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_HSCROLL_POS"
		end

	cwin_get_wm_hscroll_hwnd (wparam, lparam: INTEGER): POINTER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_POINTER"
		alias
			"GET_WM_HSCROLL_HWND"
		end

end -- class WEL_COMPOSITE_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
