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
			move_and_resize,
			move,
			process_message,
			on_wm_destroy,
			on_wm_notify,
			destroy
		end

	WEL_GW_CONSTANTS
		export
			{NONE} all
		end

	WEL_WM_CTLCOLOR_CONSTANTS
		export
			{NONE} all
		end

	WEL_ICON_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	children: LIST [WEL_WINDOW] is
			-- Construct a linear representation of children.
		require
			exists: exists
		local
			hwnd: POINTER
			win: WEL_WINDOW
		do
			create {ARRAYED_LIST [WEL_WINDOW]} Result.make (10)
			from
				hwnd := cwin_get_window (item, Gw_child)
			until
				hwnd = default_pointer
			loop
				win := window_of_item (hwnd)
				if win /= Void then
					Result.extend (win)
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
			create Result.make_by_pointer (cwin_get_menu (item))
		ensure
			result_not_void: Result /= Void
		end

	system_menu: WEL_MENU is
			-- Associated system menu
		require
			exists: exists
			has_system_menu: has_system_menu
		do
			create Result.make_by_pointer (cwin_get_system_menu (item, False))
		ensure
			result_not_void: Result /= Void
		end

	scroller: WEL_SCROLLER
			-- Scroller object for processing scroll messages.

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

	minimal_height: INTEGER is
			-- Minimal height allowed for the window
		do
			Result := window_minimum_height
		end

	horizontal_position: INTEGER is
			-- Current position of the horizontal scroll box
		require
			exists: exists
			scroller_exists: scroller /= Void
		do
			Result := scroller.horizontal_position
		ensure
			result_small_enough: Result <= maximal_horizontal_position
			result_large_enough: Result >= minimal_horizontal_position
		end

	vertical_position: INTEGER is
			-- Current position of the vertical scroll box
		require
			exists: exists
			scroller_exists: scroller /= Void
		do
			Result := scroller.vertical_position
		ensure
			result_small_enough: Result <= maximal_vertical_position
			result_large_enough: Result >= minimal_vertical_position
		end

	maximal_horizontal_position: INTEGER is
			-- Maxium position of the horizontal scroll box
		require
			exists: exists
			scroller_exists: scroller /= Void
		do
			Result := scroller.maximal_horizontal_position
		ensure
			result_large_enough: Result >= minimal_horizontal_position
		end

	maximal_vertical_position: INTEGER is
			-- Maxium position of the vertical scroll box
		require
			exists: exists
			scroller_exists: scroller /= Void
		do
			Result := scroller.maximal_vertical_position
		ensure
			result_large_enough: Result >= minimal_vertical_position
		end

	minimal_horizontal_position: INTEGER is
			-- Minimum position of the horizontal scroll box
		require
			exists: exists
			scroller_exists: scroller /= Void
		do
			Result := scroller.minimal_horizontal_position
		ensure
			result_small_enough: Result <= maximal_horizontal_position
		end

	minimal_vertical_position: INTEGER is
			-- Minimum position of the vertical scroll box
		require
			exists: exists
			scroller_exists: scroller /= Void
		do
			Result := scroller.minimal_vertical_position
		ensure
			result_small_enough: Result <= maximal_vertical_position
		end

feature -- Status setting

	set_menu (a_menu: WEL_MENU) is
			-- Set `menu' with `a_menu'.
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

	set_icon (a_small_icon: WEL_ICON; a_big_icon: WEL_ICON) is
			-- Set the small (16x16) and the normal (32x32) icon for this window.
			--
			-- Note: Set `a_small_icon' to Void to remove the small icon and
			--       `a_big_icon' to Void to remove the big icon.
		do
			if a_small_icon /= Void then
				cwin_send_message (item, Wm_seticon, Icon_small, cwel_pointer_to_integer(a_small_icon.item))
			else
				cwin_send_message (item, Wm_seticon, Icon_small, 0)
			end

			if a_big_icon /= Void then
				cwin_send_message (item, Wm_seticon, Icon_big, cwel_pointer_to_integer(a_big_icon.item))
			else
				cwin_send_message (item, Wm_seticon, Icon_big, 0)
			end
		end

	set_horizontal_position (position: INTEGER) is
			-- Set `horizontal_position' with `position'.
		require
			exists: exists
			scroller_exists: scroller /= Void
			position_small_enough: position <= maximal_horizontal_position
			position_large_enough: position >= minimal_horizontal_position
		do
			scroller.set_horizontal_position (position)
		ensure
			horizontal_position_set: horizontal_position = position
		end

	set_vertical_position (position: INTEGER) is
			-- Set `vertical_position' with `position'.
		require
			exists: exists
			scroller_exists: scroller /= Void
			position_small_enough: position <= maximal_vertical_position
			position_large_enough: position >= minimal_vertical_position
		do
			scroller.set_vertical_position (position)
		ensure
			vertical_position_set: vertical_position = position
		end

	set_horizontal_range (minimum, maximum: INTEGER) is
			-- Set `minimal_horizontal_position' and
			-- `maximal_horizontal_position' with `minimum' and
			-- `maximum'.
		require
			exists: exists
			scroller_exists: scroller /= Void
			consistent_range: minimum <= maximum
		do
			scroller.set_horizontal_range (minimum, maximum)
		ensure
			minimal_horizontal_position_set: minimal_horizontal_position =
				minimum
			maximal_horizontal_position_set: maximal_horizontal_position =
				maximum
		end

	set_vertical_range (minimum, maximum: INTEGER) is
			-- Set `minimal_vertical_position' and
			-- `maximal_vertical_position' with `minimum' and
			-- `maximum'.
		require
			exists: exists
			scroller_exists: scroller /= Void
			consistent_range: minimum <= maximum
		do
			scroller.set_vertical_range (minimum, maximum)
		ensure
			minimal_vertical_position_set: minimal_vertical_position =
				minimum
			maximal_vertical_position_set: maximal_vertical_position =
				maximum
		end

	horizontal_update (inc, position: INTEGER) is
			-- Update the window and the horizontal scroll box with
			-- `inc' and `position'.
		require
			exists: exists
			position_small_enough: position <= maximal_horizontal_position
			position_large_enough: position >= minimal_horizontal_position
		do
			scroll (inc, 0)
			set_horizontal_position (position)
			update
		ensure
			horizontal_position_set: horizontal_position = position
		end

	vertical_update (inc, position: INTEGER) is
			-- Update the window and the vertical scroll box with
			-- `inc' and `position'.
		require
			exists: exists
			position_small_enough: position <= maximal_vertical_position
			position_large_enough: position >= minimal_vertical_position
		do
			scroll (0, inc)
			set_vertical_position (position)
			update
		ensure
			vertical_position_set: vertical_position = position
		end

feature -- Basic operations

	destroy is
			-- Destroy the window and quit the application
			-- if `Current' is the application's main window.
		do
			cwin_destroy_window (item)
			if application_main_window.is_application_main_window (Current) then
				cwin_post_quit_message (0)
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
		local
			point: WEL_POINT
		do
			if parent /= Void then
				create point.make (a_x, a_y)
				point.screen_to_client (parent)
				move (point.x, point.y)
			else
				move (a_x, a_y)
			end
		end

	move (a_x, a_y: INTEGER) is
			-- Move the window to `a_x', `a_y' position.
		do
			cwin_set_window_pos (item, default_pointer,
				a_x, a_y, 0, 0,
				Swp_nosize + Swp_nozorder + Swp_noactivate)
		end

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		local
			point: WEL_POINT
		do
			if parent = Void then
				move_absolute (a_x, a_y)
				resize (a_width, a_height)
				if repaint then
					invalidate
				end
			else
				create point.make (a_x, a_y)
				point.client_to_screen (parent)
				cwin_move_window (item, point.x, point.y, a_width, a_height, repaint)
			end
		end

feature {NONE}-- Messages

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

	on_sys_command (a_command, x_pos, y_pos: INTEGER) is
			-- Wm_syscommand message.
			-- This message is sent when the user selects a command
			-- from the system menu or when the user selects the
			-- Maximize or Minimize button.
			-- See class WEL_SC_CONSTANTS for `a_command' values.
			-- `x_pos' and `y_pos' specify the x and y coordinates
			-- of the cursor.
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

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_paint message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		require
			paint_dc_not_void: paint_dc /= Void
			paint_dc_exists: paint_dc.exists
			invalid_rect_not_void: invalid_rect /= Void
		do
		end

	on_vertical_scroll_control (scroll_code, position: INTEGER;
			bar: WEL_BAR) is
			-- Vertical scroll is received with a
			-- `scroll_code' type. See class WEL_SB_CONSTANTS
			-- for `scroll_code' values. `position' is the new
			-- scrollbox position. `bar' indicates the scrollbar
			-- or trackbar control activated.
		require
			exists: exists
			bar_not_void: bar /= Void
			bar_exists: bar.exists
		do
		end

	on_horizontal_scroll_control (scroll_code, position: INTEGER;
			bar: WEL_BAR) is
			-- Horizontal scroll is received with a
			-- `scroll_code' type. See class WEL_SB_CONSTANTS
			-- for `scroll_code' values. `position' is the new
			-- scrollbox position. `bar' indicates the scroll bar
			-- or track bar control activated.
		require
			exists: exists
			bar_not_void: bar /= Void
			bar_exists: bar.exists
		do
		end

	on_vertical_scroll (scroll_code, position: INTEGER) is
			-- Vertical scroll is received with a
			-- `scroll_code' type. See class WEL_SB_CONSTANTS for
			-- `scroll_code' values. `position' is the new
			-- scrollbox position.
		require
			exists: exists
		do
			if scroller /= Void then
				scroller.on_vertical_scroll (scroll_code,
					position)
			end
		end

	on_horizontal_scroll (scroll_code, position: INTEGER) is
			-- Horizontal scroll is received with a
			-- `scroll_code' type. See class WEL_SB_CONSTANTS for
			-- `scroll_code' values. `position' is the new
			-- scrollbox position.
		require
			exists: exists
		do
			if scroller /= Void then
				scroller.on_horizontal_scroll (scroll_code,
					position)
			end
		end

	on_draw_item (control_id: INTEGER; draw_item: WEL_DRAW_ITEM_STRUCT) is
			-- Wm_drawitem message.
			-- A owner-draw control identified by `control_id' has
			-- been changed and must be drawn. `draw_item' contains
			-- information about the item to be drawn and the type
			-- of drawing required.
		require
			exists: exists
			draw_item_not_void: draw_item /= Void
		do
		end

	on_color_control (control: WEL_COLOR_CONTROL; paint_dc: WEL_PAINT_DC) is
			-- Wm_ctlcolorstatic, Wm_ctlcoloredit, Wm_ctlcolorlistbox 
			-- and Wm_ctlcolorscrollbar messages.
			-- To change its default colors, the color-control `control'
			-- needs :
			-- 1. a background color and a foreground color to be selected
			--    in the `paint_dc',
			-- 2. a backgound brush to be returned to the system.
 		require
			exists: exists
			control_not_void: control /= Void
			control_exists: control.exists
			paint_dc_not_void: paint_dc /= Void
			paint_dc_exists: paint_dc.exists
		do
				-- Typical implementation:
				-- paint_dc.set_text_color (control.foreground_color)
				-- paint_dc.set_background_color (control.background_color)
				-- create brush.make_solid (control.background_color)
				-- set_message_return_value (brush.to_integer)
				-- disable_default_processing
		end

	on_get_min_max_info (min_max_info: WEL_MIN_MAX_INFO) is
			-- Wm_getminmaxinfo message.
			-- The size or position of the window is about to
			-- change. An application can change `min_max_info' to
			-- override the window's default maximized size and
			-- position, or its default minimum or maximum tracking
			-- size.
		require
			exists: exists
			min_max_info_not_void: min_max_info /= Void
		do
		end

	on_window_pos_changed (window_pos: WEL_WINDOW_POS) is
			-- Wm_windowpschanged message.
			-- This message is sent to a window whose size,
			-- position, or place in the Z order has changed as a
			-- result of a call to `move' or `resize'.
		require
			exists: exists
			window_pos_not_void: window_pos /= Void
		do
		end

	on_window_pos_changing (window_pos: WEL_WINDOW_POS) is
			-- Wm_windowposchanging
			-- This message is sent to a window whose size,
			-- position or place in the Z order is about to change
			-- as a result of a call to `move', `resize'.
			-- `window_pos' can be changed to override the default
			-- values.
		require
			exists: exists
			window_pos_not_void: window_pos /= Void
		do
		end

	on_palette_is_changing (window: WEL_WINDOW) is
			-- Wm_paletteischanging.
			-- Inform that an application is going to realize its
			-- logical palette. `window' identifies the window
			-- that is going to realize its logical palette.
		require
			exists: exists
		do
		end

	on_palette_changed (window: WEL_WINDOW) is
			-- Wm_palettechanged message.
			-- This message is sent after the window with the
			-- keyboard focus has realized its logical palette.
			-- `window' identifies the window that caused the
			-- system palette to change.
		require
			exists: exists
		do
		end

	on_query_new_palette is
			-- Wm_querrynewpalette message.
			-- Inform an application that is about to receive the
			-- keyboard focus, giving the application an opportunity
			-- to realize its logical palette when it receives the
			-- focus. If the window realizes its logical palette,
			-- it must return True; otherwise it must return False.
			-- (False by default)
		require
			exists: exists
		do
		end

feature {NONE} -- Implementation

	on_wm_notify (wparam, lparam: INTEGER) is
			-- Wm_notify message
		local
			info: WEL_NMHDR
			control: WEL_CONTROL
		do
			create info.make_by_pointer (cwel_integer_to_pointer (lparam))
			on_notify (wparam, info)
			control ?= info.window_from
			if control /= Void and then control.exists then
				control.process_notification_info (info)
			end
		end

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
				control ?= window_of_item (hwnd_control)
				if control /= Void then
					if exists and then control.exists then
						on_control_command (control)
					end
					if exists and then control.exists then
						notify (control, notify_code)
					end
					if control.exists then
						control.process_notification (notify_code)
					end
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
			a_menu: WEL_MENU
		do
			p := cwin_get_wm_menuselect_hmenu (wparam, lparam)
			if p /= default_pointer then
				create a_menu.make_by_pointer (p)
				on_menu_select (cwin_get_wm_menuselect_cmd (wparam, lparam),
					cwin_get_wm_menuselect_flags (wparam, lparam),
					a_menu)
			else
				on_menu_select (cwin_get_wm_menuselect_cmd (wparam, lparam),
					cwin_get_wm_menuselect_flags (wparam, lparam),
					Void)
			end
		end

	on_wm_paint (wparam: INTEGER) is
			-- Wm_paint message.
			-- A WEL_DC and WEL_PAINT_STRUCT are created and
			-- passed to the `on_paint' routine.
			-- To be more efficient when the windows does not
			-- need to paint something, this routine can be
			-- redefined to do nothing (eg. The object creation are
			-- useless).
		require
			exists: exists
		local
			paint_dc: WEL_PAINT_DC
		do
			create paint_dc.make_by_pointer (Current, cwel_integer_to_pointer(wparam))
			paint_dc.get
			if scroller /= Void then
				paint_dc.set_viewport_origin (-scroller.horizontal_position,
					-scroller.vertical_position)
			end
			on_paint (paint_dc, paint_dc.paint_struct.rect_paint)
			paint_dc.release
		end

	on_wm_vscroll (wparam, lparam: INTEGER) is
			-- Wm_vscroll message.
		require
			exists: exists
		local
			a_bar: WEL_BAR
			p: POINTER
		do
			p := cwin_get_wm_vscroll_hwnd (wparam, lparam)
			if p /= default_pointer then
				-- The message comes from a scroll bar control
				a_bar ?= window_of_item (p)
				if a_bar /= Void then
					check
						a_bar_exists: a_bar.exists
					end
					on_vertical_scroll_control (cwin_get_wm_vscroll_code (wparam, lparam),
						cwin_get_wm_vscroll_pos (wparam, lparam),
						a_bar)
				end
			else
				-- The message comes from a window scroll bar
				on_vertical_scroll (cwin_get_wm_vscroll_code (wparam, lparam),
					cwin_get_wm_vscroll_pos (wparam, lparam))
			end
		end

	on_wm_hscroll (wparam, lparam: INTEGER) is
			-- Wm_hscroll message.
		require
			exists: exists
		local
			a_bar: WEL_BAR
			p: POINTER
		do
			p := cwin_get_wm_hscroll_hwnd (wparam, lparam)
			if p /= default_pointer then
				-- The message comes from a scroll bar control
				a_bar ?= window_of_item (p)
				if a_bar /= Void then
					check
						a_bar_exists: a_bar.exists
					end
					on_horizontal_scroll_control (cwin_get_wm_hscroll_code (wparam, lparam),
						cwin_get_wm_hscroll_pos (wparam, lparam),
						a_bar)
				end
			else
				-- The message comes from a window scroll bar
				on_horizontal_scroll (cwin_get_wm_hscroll_code (wparam, lparam),
					cwin_get_wm_hscroll_pos (wparam, lparam))
			end
		end

	on_wm_draw_item (wparam, lparam: INTEGER) is
			-- Wm_drawitem message
		require
			exists: exists
		local
			di: WEL_DRAW_ITEM_STRUCT
		do
			create di.make_by_pointer (cwel_integer_to_pointer (lparam))
			on_draw_item (wparam, di)
		end

	on_wm_get_min_max_info (lparam: INTEGER) is
			-- Wm_getminmaxinfo message
		require
			exists: exists
		local
			mmi: WEL_MIN_MAX_INFO
		do
			create mmi.make_by_pointer (cwel_integer_to_pointer (lparam))
			on_get_min_max_info (mmi)
		end

	on_wm_window_pos_changed (lparam: INTEGER) is
			-- Wm_windowposchanged message
		require
			exists: exists
		local
			wp: WEL_WINDOW_POS
		do
			create wp.make_by_pointer (cwel_integer_to_pointer (lparam))
			on_window_pos_changed (wp)
		end

	on_wm_window_pos_changing (lparam: INTEGER) is
			-- Wm_windowposchanging message
		require
			exists: exists
		local
			wp: WEL_WINDOW_POS
		do
			create wp.make_by_pointer (cwel_integer_to_pointer (lparam))
			on_window_pos_changing (wp)
		end

	on_wm_ctlcolor (wparam, lparam: INTEGER) is
			-- Common routine for Wm_ctlcolor messages.
		require
			exists: exists
		local
			control: WEL_COLOR_CONTROL
			hwnd_control: POINTER
			paint_dc: WEL_PAINT_DC
		do
			hwnd_control := cwin_get_wm_command_hwnd (wparam, lparam)
			if hwnd_control /= default_pointer then
				control ?= window_of_item (hwnd_control)
				if control /= Void and then control.exists then
					create paint_dc.make_by_pointer (Current, cwel_integer_to_pointer (wparam))
					on_color_control (control, paint_dc)
				end
			end
		end

	on_wm_close is
			-- Wm_close message.
			-- If `closeable' is False further processing is halted.
		require
			exists: exists
		do
			set_default_processing (closeable)
		end

	on_wm_destroy is
			-- Wm_destroy message.
			-- Quit the application if `Current' is the
			-- application's main window.
		do
			on_destroy
			destroy_item
			if application_main_window.is_application_main_window (Current) then
				cwin_post_quit_message (0)
			end
		end

	application_main_window: WEL_APPLICATION_MAIN_WINDOW is
			-- Once object used by `on_wm_destroy' to test if `Current'
			-- is the application's main window.
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end
		
feature {WEL_DISPATCHER}

	frozen composite_process_message, process_message (hwnd: POINTER;
			msg, wparam, lparam: INTEGER): INTEGER is
		do
			inspect msg
			when Wm_paint then
				on_wm_paint (wparam)
			when Wm_ctlcolorstatic then
				on_wm_ctlcolor (wparam, lparam)
			when Wm_ctlcoloredit then
				on_wm_ctlcolor (wparam, lparam)
			when Wm_ctlcolorlistbox then
				on_wm_ctlcolor (wparam, lparam)
			when Wm_ctlcolorscrollbar then
				on_wm_ctlcolor (wparam, lparam)
			when Wm_ctlcolorbtn then
				on_wm_ctlcolor (wparam, lparam)
			when Wm_command then
				on_wm_command (wparam, lparam)
			when Wm_syscommand then
				on_sys_command (wparam, cwin_lo_word (lparam),
					cwin_hi_word (lparam))
			when Wm_menuselect then
				on_wm_menu_select (wparam, lparam)
			when Wm_vscroll then
				on_wm_vscroll (wparam, lparam)
			when Wm_hscroll then
				on_wm_hscroll (wparam, lparam)
			when Wm_drawitem then
				on_wm_draw_item (wparam, lparam)
			when Wm_getminmaxinfo then
				on_wm_get_min_max_info (lparam)
			when Wm_windowposchanged then
				on_wm_window_pos_changed (lparam)
			when Wm_windowposchanging then
				on_wm_window_pos_changing (lparam)
			when Wm_paletteischanging then
				on_palette_is_changing (window_of_item (
					cwel_integer_to_pointer (wparam)))
			when Wm_palettechanged then
				on_palette_changed (window_of_item (
					cwel_integer_to_pointer (wparam)))
			when Wm_querynewpalette then
				on_query_new_palette
			when Wm_close then
				on_wm_close
			else
				-- Call the `process_message' routine of the
				-- parent class.
				Result := window_process_message (hwnd, msg, wparam, lparam)
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
		end

	cwin_get_wm_hscroll_hwnd (wparam, lparam: INTEGER): POINTER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_POINTER"
		alias
			"GET_WM_HSCROLL_HWND"
		end

end -- class WEL_COMPOSITE_WINDOW


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

