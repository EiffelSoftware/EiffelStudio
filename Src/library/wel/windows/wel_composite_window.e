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
		do
			Result := cwin_get_scroll_pos (item, Sb_horz)
		ensure
			result_small_enough: Result <= maximal_horizontal_position
			result_large_enough: Result >= minimal_horizontal_position
		end

	vertical_position: INTEGER is
			-- Current position of the vertical scroll box
		require
			exists: exists
		do
			Result := cwin_get_scroll_pos (item, Sb_vert)
		ensure
			result_small_enough: Result <= maximal_vertical_position
			result_large_enough: Result >= minimal_vertical_position
		end

	maximal_horizontal_position: INTEGER is
			-- Maxium position of the horizontal scroll box
		require
			exists: exists
		local
			min, max: INTEGER
		do
			cwin_get_scroll_range (item, Sb_horz, $min, $max)
			Result := max
		ensure
			result_large_enough: Result >= minimal_horizontal_position
		end

	maximal_vertical_position: INTEGER is
			-- Maxium position of the vertical scroll box
		require
			exists: exists
		local
			min, max: INTEGER
		do
			cwin_get_scroll_range (item, Sb_vert, $min, $max)
			Result := max
		ensure
			result_large_enough: Result >= minimal_vertical_position
		end

	minimal_horizontal_position: INTEGER is
			-- Minimum position of the horizontal scroll box
		require
			exists: exists
		local
			min, max: INTEGER
		do
			cwin_get_scroll_range (item, Sb_horz, $min, $max)
			Result := min
		ensure
			result_small_enough: Result <= maximal_horizontal_position
		end

	minimal_vertical_position: INTEGER is
			-- Minimum position of the vertical scroll box
		require
			exists: exists
		local
			min, max: INTEGER
		do
			cwin_get_scroll_range (item, Sb_vert, $min, $max)
			Result := min
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

	set_horizontal_position (position: INTEGER) is
			-- Set `horizontal_position' with `position'.
		require
			exists: exists
			position_small_enough: position <= maximal_horizontal_position
			position_large_enough: position >= minimal_horizontal_position
		do
			cwin_set_scroll_pos (item, Sb_horz, position, True)
		ensure
			horizontal_position_set: horizontal_position = position
		end

	set_vertical_position (position: INTEGER) is
			-- Set `vertical_position' with `position'.
		require
			exists: exists
			position_small_enough: position <= maximal_vertical_position
			position_large_enough: position >= minimal_vertical_position
		do
			cwin_set_scroll_pos (item, Sb_vert, position, True)
		ensure
			vertical_position_set: vertical_position = position
		end

	set_horizontal_range (minimum, maximum: INTEGER) is
			-- Set `minimal_horizontal_position' and
			-- `maximal_horizontal_position' with `minimum' and
			-- `maximum'.
		require
			exists: exists
			consistent_range: minimum <= maximum
		do
			cwin_set_scroll_range (item, Sb_horz, minimum,
				maximum, True)
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
			consistent_range: minimum <= maximum
		do
			cwin_set_scroll_range (item, Sb_vert, minimum,
				maximum, True)
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
				a_x, a_y, 0, 0,
				Swp_nosize + Swp_nozorder + Swp_noactivate)
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
				resize (a_width, a_height)
				if repaint then
					invalidate
				end
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
				-- !! brush.make_solid (control.background_color)
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
			!! info.make_by_pointer (cwel_integer_to_pointer (lparam))
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
				control ?= windows.item (hwnd_control)
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
				!! a_menu.make_by_pointer (p)
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
			!! paint_dc.make_by_pointer (Current, cwel_integer_to_pointer(wparam))
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
				a_bar ?= windows.item (p)
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
				a_bar ?= windows.item (p)
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
			!! di.make_by_pointer (cwel_integer_to_pointer (lparam))
			on_draw_item (wparam, di)
		end

	on_wm_get_min_max_info (lparam: INTEGER) is
			-- Wm_getminmaxinfo message
		require
			exists: exists
		local
			mmi: WEL_MIN_MAX_INFO
		do
			!! mmi.make_by_pointer (cwel_integer_to_pointer (lparam))
			on_get_min_max_info (mmi)
		end

	on_wm_window_pos_changed (lparam: INTEGER) is
			-- Wm_windowposchanged message
		require
			exists: exists
		local
			wp: WEL_WINDOW_POS
		do
			!! wp.make_by_pointer (cwel_integer_to_pointer (lparam))
			on_window_pos_changed (wp)
		end

	on_wm_window_pos_changing (lparam: INTEGER) is
			-- Wm_windowposchanging message
		require
			exists: exists
		local
			wp: WEL_WINDOW_POS
		do
			!! wp.make_by_pointer (cwel_integer_to_pointer (lparam))
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
			brush: WEL_BRUSH
		do
			hwnd_control := cwin_get_wm_command_hwnd (wparam, lparam)
			if hwnd_control /= default_pointer then
				control ?= windows.item (hwnd_control)
				if control /= Void and then control.exists then
					!! paint_dc.make_by_pointer (Current, cwel_integer_to_pointer (wparam))
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
			Result := window_process_message (hwnd, msg, wparam, lparam)

			if msg = Wm_paint then
				on_wm_paint (wparam)
			elseif msg = Wm_ctlcolorstatic then
				on_wm_ctlcolor (wparam, lparam)
			elseif msg = Wm_ctlcoloredit then
				on_wm_ctlcolor (wparam, lparam)
			elseif msg = Wm_ctlcolorlistbox then
				on_wm_ctlcolor (wparam, lparam)
			elseif msg = Wm_ctlcolorscrollbar then
				on_wm_ctlcolor (wparam, lparam)
			elseif msg = Wm_command then
				on_wm_command (wparam, lparam)
			elseif msg = Wm_syscommand then
				on_sys_command (wparam, cwin_lo_word (lparam),
					cwin_hi_word (lparam))
			elseif msg = Wm_menuselect then
				on_wm_menu_select (wparam, lparam)
			elseif msg = Wm_vscroll then
				on_wm_vscroll (wparam, lparam)
			elseif msg = Wm_hscroll then
				on_wm_hscroll (wparam, lparam)
			elseif msg = Wm_drawitem then
				on_wm_draw_item (wparam, lparam)
			elseif msg = Wm_getminmaxinfo then
				on_wm_get_min_max_info (lparam)
			elseif msg = Wm_windowposchanged then
				on_wm_window_pos_changed (lparam)
			elseif msg = Wm_windowposchanging then
				on_wm_window_pos_changing (lparam)
			elseif msg = Wm_paletteischanging then
				on_palette_is_changing (windows.item (
					cwel_integer_to_pointer (wparam)))
			elseif msg = Wm_palettechanged then
				on_palette_changed (windows.item (
					cwel_integer_to_pointer (wparam)))
			elseif msg = Wm_querynewpalette then
				on_query_new_palette
			elseif msg = Wm_close then
				on_wm_close
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

	cwin_set_scroll_pos (hwnd: POINTER; flag, a_position: INTEGER;
			redraw: BOOLEAN) is
			-- SDK SetScrollPos
		external
			"C [macro <wel.h>] (HWND, int, int, BOOL)"
		alias
			"SetScrollPos"
		end

	cwin_set_scroll_range (hwnd: POINTER; flag, min, max: INTEGER;
			redraw: BOOLEAN) is
			-- SDK SetScrollRange
		external
			"C [macro <wel.h>] (HWND, int, int, int, BOOL)"
		alias
			"SetScrollRange"
		end

	cwin_get_scroll_pos (hwnd: POINTER; flag: INTEGER): INTEGER is
			-- SDK GetScrollPos
		external
			"C [macro <wel.h>] (HWND, int): EIF_INTEGER"
		alias
			"GetScrollPos"
		end

	cwin_get_scroll_range (hwnd: POINTER; flag: INTEGER;
			min, max: POINTER) is
			-- SDK GetScrollRange
		external
			"C [macro <wel.h>] (HWND, int, LPINT, LPINT)"
		alias
			"GetScrollRange"
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

