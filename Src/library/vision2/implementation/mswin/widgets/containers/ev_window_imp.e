note
	description: "Eiffel Vision window. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WINDOW_IMP

inherit
	EV_WINDOW_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface,
			lock_update,
			unlock_update
		end

	EV_SINGLE_CHILD_CONTAINER_IMP
		export
			{NONE} set_parent_imp
		undefine
			show,
			hide,
			ev_apply_new_size,
			has
		redefine
			destroy,
			set_parent_imp,
			client_height,
			client_y,
			parent_ask_resize,
			set_default_minimum_size,
			on_destroy,
			interface,
			on_size,
			insert,
			screen_x, screen_y,
			default_process_message,
			next_tabstop_widget,
			make,
			is_shown_by_default
		end

	WEL_FRAME_WINDOW
		rename
			parent as wel_parent,
			set_parent as wel_set_parent,
			destroy as wel_destroy,
			shown as is_displayed,
			set_width as wel_set_width,
			set_height as wel_set_height,
			item as wel_item,
			enabled as is_sensitive,
			set_x as wel_set_x,
			set_y as wel_set_y,
			width as wel_width,
			height as wel_height,
			x as wel_x,
			y as wel_y,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			has_capture as wel_has_capture,
			show as show_internal
		export {EV_WIDGET_IMP}
			menu_bar_height
		undefine
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
			on_mouse_wheel,
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			background_brush,
			background_brush_gdip,
			on_draw_item,
			on_set_cursor,
			on_color_control,
			on_wm_vscroll,
			on_wm_hscroll,
			on_destroy,
			on_char,
			on_desactivate,
			on_sys_key_down,
			on_sys_key_up,
			on_notify,
			default_process_message,
			on_wm_dropfiles
		redefine
			has_focus,
			default_ex_style,
			default_style,
			on_size,
			on_dpi_changed,
			on_get_min_max_info,
			on_show,
			on_hide,
			on_move,
			on_menu_command,
			window_process_message,
			on_wm_close,
			on_wm_window_pos_changing,
			on_wm_setting_change,
			hide,
			class_requires_icon,
			show_internal,
			class_style
		end

	WEL_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	title_name: STRING
			-- Title name used for registration.
		do
			Result := ""
		end

	is_top_level: BOOLEAN
			-- Does `Current' need to be made as a top-level window?
		do
			Result := True
		end

	make
			-- Initialize `Current'.
		do
			if is_top_level then
				make_top (title_name)
			else
				make_child (application_imp.silly_main_window, title_name)
			end

			create accel_list.make (10)
			create upper_bar
			create lower_bar
			user_can_resize := True

			internal_is_border_enabled := True

			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP}

			application_imp.add_root_window (Current)
			init_bars

			set_is_initialized (True)
		end

	class_style: INTEGER
			-- Standard style used to create the window class.
			-- Can be redefined to return a user-defined style.
		once
			Result := Cs_dblclks
		end

	init_bars
			-- Initialize `lower_bar' and `upper_bar'.
		local
			ub_imp, lb_imp: detachable EV_VERTICAL_BOX_IMP
		do
			ub_imp ?= upper_bar.implementation
			lb_imp ?= lower_bar.implementation
			check
				ub_imp /= Void and lb_imp /= Void then
			end
			ub_imp.on_parented
			lb_imp.on_parented
			ub_imp.wel_set_parent (Current)
			lb_imp.wel_set_parent (Current)
			ub_imp.set_top_level_window_imp (Current)
			lb_imp.set_top_level_window_imp (Current)
		end

feature -- Access

	client_y: INTEGER
			-- Top of the client area of `Current'.
		do
			Result := Precursor {EV_SINGLE_CHILD_CONTAINER_IMP}
			if not upper_bar.is_empty then
					-- Add 1 pixel to separate client area and upper bar.
				Result := Result + upper_bar.minimum_height + 1
			end
			Result := Result.min (height)
		end

	client_height: INTEGER
			-- Height of the client area of `Current'.
		do
			Result := Precursor {EV_SINGLE_CHILD_CONTAINER_IMP} - client_y
			if not lower_bar.is_empty then
					-- Add 1 pixel to separate client area and lower bar.
				Result := Result - lower_bar.minimum_height - 1
			end
			Result := Result.max (0)
		end

	screen_x: INTEGER
			-- Horizontal offset of `Current' relative to screen
		do
			Result := x_position
		end

	screen_y: INTEGER
			-- Vertical offset of `Current' relative to screen
		do
			Result := y_position
		end

	maximum_height: INTEGER
			-- Maximum height that application wishes widget
			-- instance to have.

	maximum_width: INTEGER
			-- Maximum width that application wishes widget
			-- instance to have.

	title: STRING_32
			-- Window text to be displayed by the application manager.
		do
			Result := text
       	end

	top_level_window_imp: like Current
			-- Top level window that contains `Current'.
			-- As `Current' is a window then we return `Current'
		do
			Result := Current
		end

	menu_bar: detachable EV_MENU_BAR
			-- Horizontal bar at top of client area that contains menu's.

feature -- Status setting

	lock_update
			-- Lock updates for this window on certain platforms until
			-- `unlock_update' is called.
		do
			Precursor {EV_WINDOW_I}
			lock_window_update
		end

	unlock_update
			-- Unlock updates for this window on certain platforms.
		do
			Precursor {EV_WINDOW_I}
			unlock_window_update
		end

	insert (v: like item)
			-- Insert `v' into `Current'.
		do
			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP} (v)
			ev_move_and_resize (x_position, y_position, width, height, False)
		end

	set_default_minimum_size
			-- Initialize the size of `Current'.
		do
			ev_set_minimum_size (0, 0, False)
				-- Assign arbitarily large values.
				-- As long as they are bigger than the current screen
				-- resolution there will be no problems from this.
			set_maximum_width (32000)
			set_maximum_height (32000)
		end

	disable_user_resize
			-- Forbid the resize of the window.
		do
			user_can_resize := False
			forbid_resize
		end

	enable_user_resize
			-- Allow the resize of the window.
		do
			user_can_resize := True
			allow_resize
		end

	forbid_resize
			-- Forbid the resize of `Current'.
		local
			new_style: INTEGER
		do
			new_style := style
			new_style := clear_flag (new_style, Ws_maximizebox | Ws_minimizebox | Ws_sizebox)
			if not is_border_enabled then
				new_style := clear_flag (new_style, ws_dlgframe)
			end
			set_style_and_redraw (new_style)
		end

	allow_resize
			-- Allow the resize of `Current'.
		local
			new_style: INTEGER
		do
			new_style := style
			new_style := set_flag (new_style, Ws_maximizebox | Ws_minimizebox | Ws_sizebox | ws_dlgframe)
			set_style_and_redraw (new_style)
		end

	internal_enable_border
			-- Ensure a border is displayed around `Current'.
		local
			new_style: INTEGER
		do
			new_style := style
			if user_can_resize then
				new_style := set_flag (new_style, Ws_sizebox)
			end
			new_style := set_flag (new_style, ws_dlgframe)
			set_style_and_redraw (new_style)
		end

	internal_disable_border
			-- Ensure no border is displayed around `Current'.
		local
			new_style: INTEGER
		do
			new_style := style
			if not user_can_resize then
				new_style := clear_flag (new_style, Ws_sizebox | Ws_dlgframe)
			end
			set_style_and_redraw (new_style)
		end

feature -- Element change

	set_x_position (a_x: INTEGER)
			-- Set `x_position' with `a_x'
		do
			child_cell.set_is_positioned
			ev_move (a_x, y_position)
		end

	set_y_position (a_y: INTEGER)
			-- Set `y_position' with `a_y'
		do
			child_cell.set_is_positioned
			ev_move (x_position, a_y)
		end

	set_parent_imp (par_imp: detachable EV_CONTAINER_IMP)
			-- Make `par' the new parent of `Current'.
			-- `par_imp' can be Void then the parent is the screen.
		local
			ww: detachable WEL_WINDOW
		do
			if par_imp /= Void then
				ww ?= par_imp
				check ww /= Void end
				wel_set_parent (ww)
			else
				wel_set_parent (Void)
			end
		end

	set_maximum_width (value: INTEGER)
			-- Make `value' the new maximum width.
			-- If `width' is larger, then it is reduced.
		do
			maximum_width := value
			if value < ev_width then
				ev_resize (value, ev_height)
			end
		end

	set_maximum_height (value: INTEGER)
			-- Make `value' the new maximum height.
			-- If `height' is larger, then it is reduced.
		do
			maximum_height := value
			if value < ev_height then
				ev_resize (ev_width, value)
			end
		end

	set_title (txt: READABLE_STRING_GENERAL)
			-- Make `txt' the title of `Current'.
		do
			set_text (txt.twin)
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR)
			-- Assign `a_menu_bar' to `menu_bar'.
		local
			mb_imp: detachable WEL_MENU
			mb: detachable EV_MENU_BAR_IMP
		do
			menu_bar := a_menu_bar
			mb_imp ?= a_menu_bar.implementation
			check mb_imp /= Void then end
			set_menu (mb_imp)
			mb ?= a_menu_bar.implementation
			check
				implementation_not_void: mb /= Void then
			end
			mb.set_parent_imp (Current)
			compute_minimum_height (False)
		end

	remove_menu_bar
			-- Assign `Void' to `menu_bar'.
		local
			mb: detachable EV_MENU_BAR_IMP
		do
			if attached menu_bar as l_menu_bar then
				mb ?= l_menu_bar.implementation
				check
					implementation_not_void: mb /= Void then
				end
				mb.set_parent_imp (Void)
				menu_bar := Void
				unset_menu
				compute_minimum_height (False)
			end
		end

feature -- Status Report

	has_focus: BOOLEAN
			-- Does current window have focus?
		do
			Result := foreground_window = Current
		end

feature {EV_ANY, EV_ANY_I} -- Accelerators

	connect_accelerator (an_accel: EV_ACCELERATOR)
			-- Connect key combination `an_accel' to `Current'.
		local
			acc_imp: detachable EV_ACCELERATOR_IMP
		do
			if an_accel /= Void then
				acc_imp ?= an_accel.implementation
				check acc_imp /= Void then end
				accel_list.put (an_accel, acc_imp.hash_code)
			end
		end


	disconnect_accelerator (an_accel: EV_ACCELERATOR)
			-- Disconnect key combination `an_accel' from `Current'.
		local
			acc_imp: detachable EV_ACCELERATOR_IMP
		do
			if an_accel /= Void then
				acc_imp ?= an_accel.implementation
				check acc_imp /= Void then end
				accel_list.remove (acc_imp.hash_code)
			end
		end

feature {NONE} -- Implementation

	on_wm_setting_change
			-- Wm_settingchange message
			-- Update the system fonts.
		local
			mb_imp: detachable EV_MENU_BAR_IMP
		do
			Precursor {WEL_FRAME_WINDOW}

			if attached menu_bar as l_menu_bar then
				mb_imp ?= l_menu_bar.implementation
				check mb_imp /= Void then end
				mb_imp.rebuild_control
			end
		end

	wel_destroy_window
			-- Destroy the window-widget
		do
			destroy_item_from_context (False)
		end

	ev_apply_new_size (a_x_position, a_y_position,
			a_width, a_height: INTEGER; repaint: BOOLEAN)
			-- Move the window to `a_x_position', `a_y_position' position and
			-- resize it with `a_width', `a_height'.
			-- This feature must be redefine by the containers to readjust its
			-- children too.
		local
			bar_imp: detachable EV_VERTICAL_BOX_IMP
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			if attached item_imp as l_item_imp then
				l_item_imp.ev_apply_new_size (client_x, client_y,
					client_width, client_height, True)
			end
			if menu_bar /= Void then
				draw_menu
			end
			if not upper_bar.is_empty then
				bar_imp ?= upper_bar.implementation
				check
					bar_imp_not_void: bar_imp /= Void then
				end
				bar_imp.set_move_and_size (0, 0, client_width, client_y)
			end
			if not lower_bar.is_empty then
				bar_imp ?= lower_bar.implementation
				check
					bar_imp_not_void: bar_imp /= Void then
				end
				bar_imp.set_move_and_size (0,
					client_y + client_height + 1,
					client_width, bar_imp.minimum_height)
			end
		end

	on_menu_command (menu_id: INTEGER)
			-- `menu_id' has been chosen from the menu.
		local
			menu_bar_imp: detachable EV_MENU_BAR_IMP
		do
			if attached menu_bar as l_menu_bar then
				menu_bar_imp ?= l_menu_bar.implementation
				check menu_bar_imp /= Void then end
				menu_bar_imp.menu_item_clicked (menu_id)
			end
		end

	on_menu_opened (a_menu: WEL_MENU)
			-- `a_menu' has been opened.
		local
			menu_bar_imp: detachable EV_MENU_BAR_IMP
		do
			if has_menu and then attached menu_bar as l_menu_bar then
				menu_bar_imp ?= l_menu_bar.implementation
				check menu_bar_imp /= Void then end
				menu_bar_imp.menu_opened (a_menu)
			end
		end

feature {EV_WIDGET_IMP} -- Implementation

	last_focused_widget: POINTER
		-- Last focused widget in `Current'.

	set_last_focused_widget (windows_pointer: POINTER)
			-- Assign `windows_pointer' to `last_focused_widget'.
		do
			last_focused_widget := windows_pointer
		end

feature {EV_MENU_ITEM_LIST_IMP} -- Implementation

	compute_minimum_width (a_is_size_forced: BOOLEAN)
			-- Recompute the minimum width of `Current'.
		local
			mw: INTEGER
		do
			mw := extra_minimum_rect.width
			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mw := mw + l_item_imp.minimum_width
			end
			ev_set_minimum_width (mw, a_is_size_forced)
		end

	compute_minimum_height (a_is_size_forced: BOOLEAN)
			-- Recompute the minimum height of `Current'.
		local
			mh: INTEGER
		do
			mh := extra_minimum_rect.height
			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mh := mh + l_item_imp.minimum_height
			end
			ev_set_minimum_height (mh, a_is_size_forced)
		end

	compute_minimum_size (a_is_size_forced: BOOLEAN)
			-- Recompute the minimum size of `Current'.
		local
			mw, mh: INTEGER
			l_rect: WEL_RECT
		do
			l_rect := extra_minimum_rect
			mw := l_rect.width
			mh := l_rect.height

			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mw := mw + l_item_imp.minimum_width
				mh := mh + l_item_imp.minimum_height
			end
			ev_set_minimum_size (mw, mh, a_is_size_forced)
		end

	extra_minimum_rect: WEL_RECT
			-- Extra width and height between the client rect and the window rect.
		require
			exists: exists
		local
			l_client_rect: WEL_RECT
		do
			l_client_rect := client_rect
			Result := window_rect
			Result.set_rect (0, 0, Result.width - l_client_rect.width, Result.height - l_client_rect.height)
		end

feature {NONE} -- Inapplicable

	parent_ask_resize (a_width, a_height: INTEGER)
			-- When the parent asks the resize, it's not
			-- necessary to send him back the information
			-- Can be called but do nothing.
		do
			--| This does not need to do anything.
			check
				Inapplicable: True
			end
		end

	set_top_level_window_imp (a_window: EV_TITLED_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		do
			--| This should never be called for a window.
			check
				inapplicable: False
			end
		end

feature {EV_ANY_I} -- Implementation

	default_style: INTEGER
			-- Default style of `Current'.
			-- Set with the option `Ws_clipchildren' to avoid flashing.
		do
			Result := Ws_popup + Ws_overlapped + Ws_dlgframe
					+ Ws_clipchildren + Ws_clipsiblings + Ws_sizebox
		end

	default_ex_style: INTEGER
			-- Default extended style of `Current.
		do
			Result := Ws_ex_controlparent --| ws_ex_composited
				-- Uncomment ws_ex_composited to allow for backbuffered toplevel windows.
		end

	default_process_message (msg: INTEGER; wparam, lparam: POINTER)
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
			if msg = Wm_mouseactivate then
				on_wm_mouseactivate (wparam, lparam)
			else
				Precursor {EV_SINGLE_CHILD_CONTAINER_IMP} (msg, wparam, lparam)
			end
		end

	show_relative_to_window (a_parent: EV_WINDOW)
			-- Show `Current' with respect to `a_window'.
		do
			if not is_parented_window then
				is_parented_window := True
				switch_between_parented_window (a_parent)
			end
			show_internal
		end

	show
			-- Show `Current'.
		do
			if is_parented_window then
				is_parented_window := False
				switch_between_parented_window (Void)
			end
			show_internal
		end

	hide
			-- Hide `Current'.
		do
			Precursor {WEL_FRAME_WINDOW}
			call_show_actions := False
		end

	call_show_actions: BOOLEAN
		-- Should the `show_actions_internal' be called?
		-- used to ensure they are only called once.

	on_show
			-- When the window receives the on_show message,
			-- it resizes the window at the size of the child.
			-- And it sends the message to the child because wel
			-- does not.
		do
				-- We check if there is a menu, and if so we draw it.
			if has_menu then
				draw_menu
			end

			if child_cell.is_positioned then
					-- We need to move window to specified location
				wel_move (child_cell.x, child_cell.y)
			end

				-- We resize everything.
			wel_resize (
				width.min (maximum_width),
				height.min (maximum_height)
				)
		end

	on_hide
			-- Wm_showwindow message.
			-- The window is being hidden.
		do
			Precursor
			if hide_actions_internal /= Void then
				hide_actions_internal.call (Void)
			end
		end

	on_size (size_type, a_width, a_height: INTEGER)
			-- Called when `Current' is resized.
		local
			bar_imp: detachable EV_VERTICAL_BOX_IMP
			w_rect: WEL_RECT
		do
			if interface /= Void and then size_type /= Wel_window_constants.Size_minimized then
				w_rect := window_rect
				internal_set_size (w_rect.width, w_rect.height)

				if not upper_bar.is_empty then
					bar_imp ?= upper_bar.implementation
					check
						bar_imp_not_void: bar_imp /= Void then
					end
					bar_imp.set_move_and_size (0, 0, client_width, client_y)
				end

				if attached item_imp as l_item_imp then
					l_item_imp.set_move_and_size (client_x, client_y,
						client_width, client_height)
				end

				if not lower_bar.is_empty then
					bar_imp ?= lower_bar.implementation
					check
						bar_imp_not_void: bar_imp /= Void then
					end
					bar_imp.set_move_and_size (0,
						client_y + client_height + 1,
						client_width, bar_imp.minimum_height)
				end

					-- Calls user actions if any
				execute_resize_actions (a_width, a_height)
			end
		end

	execute_resize_actions (a_width, a_height: INTEGER)
			-- execute `resize_actions_internal' if not Void.
		do
			trigger_resize_actions (a_width, a_height)
		end

   	on_move (x_pos, y_pos: INTEGER)
   			-- Wm_move message.
   			-- This message is sent after a window has been moved.
   			-- `x_position_pos' specifies the x_position-coordinate
			-- of the upper-left corner of the client area of the window.
   			-- `y_pos' specifies the y-coordinate of the upper-left
   			-- corner of the client area of the window.
   		do
   			if interface /= Void then
   				interface.move_actions.call ([x_position, y_position, ev_width, ev_height])
   			end
 		end

	on_get_min_max_info (min_max_info: WEL_MIN_MAX_INFO)
			-- Called by WEL to request min/max size of `Current'.
			-- Is called just before move and/or resize.
		local
			min_track, max_track: WEL_POINT
		do
			create min_track.make (minimum_width, minimum_height)
			create max_track.make (maximum_width, maximum_height)
			min_max_info.set_min_track_size (min_track)
			min_max_info.set_max_track_size (max_track)
		end

	on_destroy
			-- Called when `Current' is destroyed.
			-- Set the parent sensitive if it exists.
		do
			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP}
			if attached parent_imp as l_parent_imp and then not l_parent_imp.destroyed and then not
				l_parent_imp.is_sensitive then
				l_parent_imp.disable_sensitive
			end
		end

	on_wm_close
			-- User clicked on "close" ('X').
		do
			if close_request_actions_internal /= Void then
				close_request_actions.call (Void)
			end
				-- Do not actually close the window.
			set_default_processing (False)
		end

	on_wm_mouseactivate (wparam, lparam: POINTER)
			-- `Current' has been activated thanks to the click of a window.
		local
			msg: INTEGER
			source: detachable EV_PICK_AND_DROPABLE_IMP
		do
			application_imp.clear_override_from_mouse_activate
			msg := cwin_hi_word (lparam)
				--| We need to pass the mouse_button to `source_at_pointer_position'.
				--| This enables it to only call `pebble_function' if really necessary,
				--| i.e. the pressed button matches the type of transport.

			if not has_focus then
					-- We only need to prevent activation on PND if the window doesn't have focus.
				if msg = Wm_lbuttondown then
					source := pnd_source_at_pointer_position (1)
				elseif msg = Wm_rbuttondown then
					source := pnd_source_at_pointer_position (3)
				else
					source := Void
				end
			end

				--| We set `override movement' to False. It is easier to then assign `True
				--| if we find (below) that `Current' must not be raised due to the widget
				--| at the pointer_position having a drag/pick and drop.
			override_movement := False
			if source /= Void then
					--| We reach here if the mouse click that caused the Wm_mouse_activate message
					--| to be raised was over a widget that has either pick or drag and drop.
				if (msg = Wm_rbuttondown and widget_has_pick (source))
				or (msg = Wm_lbuttondown and widget_has_drag (source)) or
				application_imp.pick_and_drop_source /= Void then
						--| If we have reached here, then we do not want to raise the window, as
						--| the click is either going to start a drag/pick and drop or there is
						--| one currently executing (quered on `application_imp').
					set_message_return_value (to_lresult (Wel_input_constants.Ma_noactivate))
					disable_default_processing
					override_movement := True
					if not has_focus and not widget_has_drag (source) then
						application_imp.set_override_from_mouse_activate
					end
				else
						--| If we have reached here, then if there is no pick/drag and drop
						--| executing, so we explicitly call `move_to_foreground' to ensure
						--| `Current' is raised. If we do not call `move_to_foreground', in some
						--| cases, on_window_pos_changing may not be called.
					if application_imp.pick_and_drop_source = Void then
						move_to_foreground
					end
				end
			else
					--| We reach here if the mouse click that caused the wm_mouseactivate message
					--| was over a widget that does not have pick/drag and drop. Clicking on the
					--| non client area of a window will also cause us to be here.
				if application_imp.pick_and_drop_source = Void then
						--| We are here if there is no drag/pick and drop currently executing.
						--| So we must raise `Current'.
					move_to_foreground
				else
						--| If we are here, then there is a drag/pick and drop executing, so
						--| we override the movement.
					set_message_return_value (to_lresult (Wel_input_constants.Ma_noactivate))
					disable_default_processing
					override_movement := True
					if not has_focus then
						application_imp.set_override_from_mouse_activate
					end
				end
			end
		end

	widget_has_pick (pick_and_dropable: EV_PICK_AND_DROPABLE_IMP): BOOLEAN
			-- Does `pick_and_dropable' have a pick and drop?
		do
			if pick_and_dropable /= Void then
				Result := pick_and_dropable.mode_is_pick_and_drop
			end
		end

	widget_has_drag (pick_and_dropable: EV_PICK_AND_DROPABLE_IMP): BOOLEAN
			-- Does `pick_and_dropable' have a drag and drop?
		do
			if pick_and_dropable /= Void then
				Result :=  pick_and_dropable.mode_is_drag_and_drop
			end
		end

	pnd_source_at_pointer_position (button_pressed: INTEGER): detachable EV_PICK_AND_DROPABLE_IMP
			-- `Result' is EV_PICK_AND_DROPABLE at current pointer_position.
			-- `button_pressed' is pointer button which caused this feature to be
			-- called. This allows us to avoid excessive processing when we know
			-- that the type of transport of the widget does not match the button.
			-- Used in conjunction with preventing activation when in pick or drag and drop mode.
		local
			wel_window: detachable WEL_WINDOW
			wel_point: WEL_POINT
			widget_imp: detachable EV_WIDGET_IMP
			item_list_imp: detachable EV_ITEM_LIST_IMP [EV_ITEM, EV_ITEM_IMP]
			an_item_imp: detachable EV_ITEM_IMP
			sensitive: detachable EV_SENSITIVE
			combo_field: detachable EV_INTERNAL_COMBO_FIELD_IMP
		do
			create wel_point.make (0, 0)
			wel_point.set_cursor_position
			wel_window := wel_point.window_at
			if wel_window /= Void then
				widget_imp ?= wel_window
				if widget_imp = Void then
					-- We must now check for an internal combo field, and
					-- use its parent as the widget.
					combo_field ?= wel_window
					if combo_field /= Void then
						widget_imp := combo_field.parent
					end
				end
				if widget_imp /= Void and then not widget_imp.mode_is_target_menu then
						--| We only need to perform further processing if the pointer
						--| button matches the type of transport of `widget_imp'.
					if (button_pressed = 1 and widget_imp.mode_is_drag_and_drop) or
						(button_pressed = 3 and widget_imp.mode_is_pick_and_drop) then
						if application_imp.pick_and_drop_source = Void then
							widget_imp.call_pebble_function (wel_point.x - widget_imp.screen_x,
								wel_point.y - widget_imp.screen_y, wel_point.x, wel_point.y)
						end
						if widget_imp.pebble /= Void then
							Result := widget_imp
						end
							-- We clear the result of the pebble function call (even if not actually made, it doesn't hurt
							-- and simplify the code flow), if any, to avoid side effects.
						widget_imp.reset_pebble_function
						item_list_imp ?= widget_imp
						if item_list_imp /= Void then
							an_item_imp ?= item_list_imp.find_item_at_position (wel_point.x
								- item_list_imp.screen_x, wel_point.y - item_list_imp.screen_y)
							if an_item_imp /= Void then
										--| FIXME we need to pass the relative coordinates to `query_pebble_function'.
								an_item_imp.call_pebble_function (0, 0, wel_point.x, wel_point.y)
								if an_item_imp.pebble /= Void then
										-- If the cursor is over an item and the item is a
										-- pick and drop target then we set the target id to that of the
										-- item, as the items are conceptually 'above' the list and so
										-- if a list and one of its items are pnd targets then the
										-- item should receive.
									sensitive ?= an_item_imp.interface
										-- If an item is not `sensitive' then it cannot be dropped on.
									if sensitive = Void or (sensitive /= Void and then sensitive.is_sensitive) then
										Result := an_item_imp
									end
								end
									-- We clear the result of the pebble function call, if any, to avoid side effects.
								an_item_imp.reset_pebble_function
							end
						end
					end
				end
			end
		end

	on_wm_window_pos_changing (lparam: POINTER)
			-- The position of `Current' is changing.
		local
			info: WEL_WINDOW_POS
			flag_cst: WEL_SWP_CONSTANTS
			cur_flag: INTEGER
		do
				-- Do not allow movement if `override_movement'. This stops
				-- a drag/pick and drop raising `Current'.
			if override_movement then
					--We retain the z order of `Current'.
				create info.make_by_pointer (lparam)
				create flag_cst
				cur_flag := info.flags
				cur_flag := set_flag (cur_flag, flag_cst.Swp_nozorder)
				info.set_flags (cur_flag)
			end
			override_movement := False
		end

	on_wm_ncactivate (hwnd: POINTER; wparam, lparam: POINTER): POINTER
			-- Handle wm_ncactive message
			-- With this handling, we can have mulitple title bar focused windows which are first used by Photoshop.
			-- This implementation is learn from www.codeproject.com "Docking Toolbars in Plain C"
		local
			l_windows: LINEAR [EV_WINDOW]
			l_tool_window: detachable EV_POPUP_WINDOW--FAKE_FOCUS_GROUPABLE
			l_imp: detachable EV_WINDOW_IMP
			l_keep_alive: INTEGER
			l_syn_others: BOOLEAN
			l_test: detachable EV_WINDOW--FAKE_FOCUS_GROUPABLE
		do
			--| Removed use of EV_FAKE_FOCUS windows.
			l_keep_alive := wparam.to_integer_32
			l_test ?= interface
			if l_test /= Void then
				l_syn_others := True
					-- Retrieve a list of all visible windows.
				l_windows := application_imp.windows_internal (False)
				from
					l_windows.start
				until
					l_windows.after
				loop
					l_imp ?= l_windows.item.implementation
					check not_void: l_imp /= Void then end
					l_tool_window ?= l_windows.item
			      -- UNDOCUMENTED FEATURE:
			      -- If the other window being activated/deactivated (i.e. not the one that
			      -- called here) is one of our tool windows, then go (or stay) active.			
					if l_tool_window /= Void and then lparam = l_imp.wel_item then
						l_keep_alive := 1
						l_syn_others := False
					end
					l_windows.forth
				end

				if l_syn_others then
					from
						l_windows.start
					until
						l_windows.after
					loop
						l_imp ?= l_windows.item.implementation
						check not_void: l_imp /= Void then end
						l_tool_window ?= l_windows.item

						-- We don't send message to ourself
						if l_tool_window /= Void and then l_imp.wel_item /= wel_item and wel_item /= lparam then
							{WEL_API}.send_message (l_imp.wel_item, wm_ncactivate, to_wparam (l_keep_alive), to_lparam (-1))
						end
						l_windows.forth
					end
				end
			end

			Result := call_default_window_procedure (hwnd, wm_ncactivate, to_wparam (l_keep_alive), lparam)
			disable_default_processing
		end

	window_process_message (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER
			-- Call the routine `on_*' corresponding to the
			-- message `msg'.
		local
			a_menu: WEL_MENU
			modeless_dialog_imp: detachable EV_DIALOG_IMP_MODELESS
		do
				-- The `Wm_ncactive' message is sent by windows when the
				-- non client area of Current needs to be changed to indicate an
				-- active or non active state (Blue or Grey as default).
			inspect msg
			when wm_ncactivate then
				if lparam.to_integer_32 = -1 then
					-- This is a message send by ourself.
					-- Windows will never sent wm_ncactive with lparam -1
					Result := call_default_window_procedure (hwnd, msg, wparam, to_lparam (0))
					disable_default_processing
				else
						-- `wparam' is equal to 1 then the non client area of
						-- `Current' is being changed to indicate active.
						-- We could use class INTERNAL to find this out, but I do not
						-- want to add inheritance from another class. If you think it is a better
						-- solution, then I see no reason why we should not do it. Julian 08/14/02
					modeless_dialog_imp ?= Current
					if modeless_dialog_imp /= Void then
						if wparam.to_integer_32 = 1 then
							if application_imp.pick_and_drop_source /= Void or application_imp.awaiting_movement or
								application_imp.transport_just_ended or application_imp.override_from_mouse_activate then
								disable_default_processing
								override_movement := False
								application_imp.clear_transport_just_ended
							end
						else
							if application_imp.override_from_mouse_activate then
								disable_default_processing
								application_imp.clear_override_from_mouse_activate
							end
						end
					end

					Result := on_wm_ncactivate (hwnd, wparam, lparam)
				end
			when Wm_activate then
				window_on_wm_activate (wparam, lparam)
			when Wm_initmenupopup then
				create a_menu.make_by_pointer (wparam)
				on_menu_opened (a_menu)
			when Wm_enteridle then
					--| This message is sent when `Current' has a modal dialog as a child.
				application_imp.process_event_queue (False)
				fire_dialog_show_actions (lparam)
			else
				Result := Precursor {WEL_FRAME_WINDOW} (hwnd, msg, wparam, lparam)
			end
		end

	window_on_wm_activate (wparam, lparam: POINTER)
			-- `Wm_activate' message received form Windows by `Current'.
		local
			l_is_minimized: BOOLEAN
		do
			l_is_minimized := cwin_hi_word (wparam) /= 0
			if cwin_lo_word (wparam) /= Wel_window_constants.Wa_inactive then
						-- We must now restore the focus to `last_focused_widget'
						-- as the window is now being re-activated.
				if not l_is_minimized then
					application_imp.set_window_with_focus (Current)
					if application_imp.focus_in_actions_internal /= Void then
						application_imp.focus_in_actions.call ([attached_interface])
					end
					if focus_in_actions_internal /= Void then
						focus_in_actions_internal.call (Void)
					end
					if is_window (last_focused_widget) then
						if attached window_of_item (last_focused_widget) as l_window then
							l_window.set_focus
							-- Calling disable_default_processing is required in order to
							-- stop the focus being removed from `last_focused_widget' after
							-- we set it. However, this stops on_set_focus being called, so we
							-- execute the code ourselves.
							disable_default_processing
						end
					end
				end
			else
					-- Make sure that the default push button for a dialog is correctly updated.
				update_current_push_button
					-- Window is losing focus so reset once functions.
				application_imp.set_window_with_focus (Void)
				focus_on_widget.put (Void)
				if application_imp.focus_out_actions_internal /= Void then
					application_imp.focus_out_actions.call ([attached_interface])
				end
				if focus_out_actions_internal /= Void then
					focus_out_actions.call (Void)
				end
			end
		end

	fire_dialog_show_actions (dialog: POINTER)
			-- Call `show_actions' on a dialog referenced by `dialog'.
			--| We need to ensure that all widgets in the dialog
			--| are completely visible, and this was the only message that
			--| I could find which was called at the correct time.
			--| If a better method of doing this can be found, then there
			--| should be no consequences. Just make sure that you can call set_focus
			--| on a widget within the dialog from the on_show actions. Julian.
		local
			windows: LINEAR [EV_WINDOW]
			dialog_imp_modal: detachable EV_DIALOG_IMP_MODAL
			found: BOOLEAN
		do
			windows := application_imp.windows
			from
				windows.start
			until
				windows.off or found
			loop
				dialog_imp_modal ?= windows.item.implementation
				if dialog_imp_modal /= Void and then dialog_imp_modal.wel_item = dialog then
					if dialog_imp_modal.call_show_actions then
						dialog_imp_modal.execute_show_actions
					end
					found := True
				end
				windows.forth
			end
		end

	override_movement: BOOLEAN
			-- Used to override on_window_pos_changing.
			-- If `True', then on_window_pos_changing will not raise
			-- `Current' to foreground.

	has_title_bar: BOOLEAN
			-- Does current have a title bar?
		do
		end

	internal_height, internal_width: INTEGER
		-- Calling `hide' then `show' would loose the settings of
		-- `height' and `width'. Therefore we store them internally,
		-- and restore them in on_show if necessary.


	on_dpi_changed (a_dpi: NATURAL_32;  a_wp: WEL_WINDOW_POS)
			-- WM_dpichange message.
			-- This message is sent to a window whose dpi changed,
		local
			bar_imp: detachable EV_VERTICAL_BOX_IMP
			w_rect: WEL_RECT
		do
			if interface /= Void then
				w_rect := window_rect
				internal_set_size (w_rect.width, w_rect.height)

				if not upper_bar.is_empty then
					bar_imp ?= upper_bar.implementation
					check
						bar_imp_not_void: bar_imp /= Void then
					end
					bar_imp.set_move_and_size (0, 0, client_width, client_y)
				end

				if attached item_imp as l_item_imp then
					l_item_imp.set_move_and_size (client_x, client_y,
						client_width, client_height)
				end

				if not lower_bar.is_empty then
					bar_imp ?= lower_bar.implementation
					check
						bar_imp_not_void: bar_imp /= Void then
					end
					bar_imp.set_move_and_size (0,
						client_y + client_height + 1,
						client_width, bar_imp.minimum_height)
				end

					-- Calls user actions if any
				execute_dpi_actions (a_dpi, client_width, client_height)
			end
		end

	execute_dpi_actions (a_dpi: NATURAL_32; a_width, a_height: INTEGER)
			-- execute `resize_actions_internal' if not Void.
		do
			trigger_dpi_actions  (a_dpi, a_width, a_height)
		end

feature {EV_ANY_I} -- Implementation

	--accelerators: WEL_ACCELERATORS
			-- List of accelerators connected to this window.
			-- Used in EV_TITLED_WINDOW_IMP but added here to
			-- avoid assignment attempt in {EV_APPLICATION_IMP}.process_message.

	allow_movement
		do
			override_movement := False
		end

	move_to_foreground
			-- Move `Current' to foreground.
		local
			l_result: BOOLEAN
		do
			override_movement := False
			l_result := {WEL_API}.set_window_pos (wel_item, Hwnd_top, 0, 0, 0, 0,
				Swp_nosize + Swp_nomove)
		end

	set_style_and_redraw (new_style: INTEGER)
			-- Set `style' to `new_style', recompute
			-- sizing dimensions and redraw.
		do
			set_style (new_style)
			notify_change (nc_minsize, Current, False)
			if is_displayed then
				invalidate
			end
		end

	next_tabstop_widget (start_widget: EV_WIDGET; search_pos: INTEGER; forwards: BOOLEAN): EV_WIDGET_IMP
			-- Return the next widget that may by tabbed to as a result of pressing the tab key from `start_widget'.
			-- `search_pos' is the index where searching must start from for containers, and `forwards' determines the
			-- tabbing direction. If `search_pos' is less then 1 or more than `count' for containers, the parent of the
			-- container must be searched next.
		require else
			valid_search_pos: search_pos >= 0 and search_pos <= count + 1
		local
			w: detachable EV_WIDGET_IMP
			container: detachable EV_CONTAINER
			l_item: like item
		do
				-- A window cannot receive the tabstop, so we simply
				-- continue the search within `item'.
			l_item := item
			check l_item /= Void then end
			w ?= l_item.implementation
			check w /= Void then end
			if forwards then
				Result := w.next_tabstop_widget (start_widget, 1, forwards)
			else
				container ?= w.interface
				if container /= Void then
					Result := w.next_tabstop_widget (start_widget, container.count, forwards)
				else
					Result := w.next_tabstop_widget (start_widget, 1, forwards)
				end
			end
		end

feature {EV_WIDGET_IMP} -- Implementation

	title_height: INTEGER
			-- `Result' is absolute x position of client rect.
		do
			if has_title_bar then
				Result := title_bar_height
			end
		end

	frame_height: INTEGER
			-- `Result' is frame height of `Current'.
		do
			if user_can_resize then
				Result := window_frame_height
			elseif internal_is_border_enabled then

				Result := dialog_window_frame_height
			end
		end

	frame_width: INTEGER
			-- `Result' is frame width of `Current'.
		do
			if user_can_resize then
				Result := window_frame_width
			elseif internal_is_border_enabled then
				Result := dialog_window_frame_width
			end
		end

	border_width: INTEGER
			-- `Result' is border width of `Current'.
		do
			if internal_is_border_enabled then
				Result := window_border_width
			end
		end

	class_requires_icon: BOOLEAN
			-- Does `Current' require an icon to be registered?
			-- If `True' `register_class' assigns a class icon, otherwise
			-- no icon is assigned.
		do
			Result := False
		end

feature {NONE} -- Implementation for switch non-parented and parented windows

	show_internal
			-- Show `Current'.
		do
			if not is_displayed then
				call_show_actions := True
				cwin_show_window (wel_item, show_flags)
				if item_imp /= Void then
					notify_change (nc_minsize, item_imp, False)
				end
					-- We call show actions
				if call_show_actions then
					if show_actions_internal /= Void then
						show_actions_internal.call (Void)
					end
					call_show_actions := False
				end
			end
		end

	show_flags: INTEGER
			-- Flags used for `ShowWindow'.
		do
			Result := sw_show
		end

	is_parented_window: BOOLEAN
			-- If current is parented window?

	switch_between_parented_window (a_parent: detachable EV_WINDOW)
			-- Change window native item to parent window if `a_parent' not void.
			-- If `a_parent' void then change to not parented window.
		local
			l_window: detachable WEL_WINDOW
			l_width, l_height, l_x, l_y: INTEGER
			l_old_child: detachable EV_WIDGET
			l_old_child_upper, l_old_child_lower: EV_WIDGET
			l_result: INTEGER
			l_menu_bar: detachable EV_MENU_BAR
		do
			l_width := {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (width)
			l_height :={EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (height)
			l_x := screen_x
			l_y := screen_y

			l_old_child := item
			clear_parent (l_old_child)
			l_old_child_lower := lower_bar
			clear_parent (l_old_child_lower)
			l_old_child_upper := upper_bar
			clear_parent (l_old_child_upper)

			l_menu_bar := menu_bar
			if l_menu_bar /= Void then
				remove_menu_bar
			end

			l_result := cwin_destroy_window (wel_item)
			-- Possibe bugs: a thread cannot use DestroyWindow to destroy a window created by a different thread.		
			check success: l_result = 1 end
			application_imp.remove_root_window (Current)

			if a_parent /= Void then
				l_window ?= a_parent.implementation
				check not_void: l_window /= Void then end

				make_child (l_window, "")

				-- If we don't clear wel_parent here, features like position calculation, extend... will have problem.
				wel_parent := Void
			else
				make_top ("")
			end
			application_imp.add_root_window (Current)

			set_size (l_width, l_height)
			set_position (l_x, l_y)

			set_widget_parent (l_old_child, Current)
			set_widget_parent (l_old_child_lower, Current)
			set_widget_parent (l_old_child_upper, Current)

			if l_menu_bar /= Void then
				set_menu_bar (l_menu_bar)
			end
		ensure
			switched: wel_item /= old wel_item
		end

	clear_parent (a_widget: detachable EV_WIDGET)
			-- Clear the parent of `a_widget'.
		local
			l_imp: detachable EV_WIDGET_IMP
		do
			if a_widget /= Void then
				l_imp ?= a_widget.implementation
				check not_void: l_imp /= Void then end
				l_imp.wel_set_parent (application_imp.silly_main_window)
			end
		end

	set_widget_parent (a_widget: detachable EV_WIDGET; a_parent_imp: WEL_WINDOW)
			-- Set `a_widget_imp' parent to `a_parent_imp' if possible.
		require
			not_void: a_parent_imp /= Void
		local
			l_widget_imp: detachable EV_WIDGET_IMP
		do
 			if a_widget /= Void then
 				l_widget_imp ?= a_widget.implementation
 				check l_widget_imp /= Void then end
				l_widget_imp.wel_set_parent (a_parent_imp)
			end
		end

feature {NONE} -- Features that should be directly implemented by externals

	cwin_get_next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER
			-- SDK GetNextDlgGroupItem
		do
			Result := {WEL_CONTROL}.c_cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

	get_wm_hscroll_code (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_hscroll_code.
		do
			Result := cwin_get_wm_hscroll_code (wparam, lparam)
		end

	get_wm_hscroll_hwnd (wparam, lparam: POINTER): POINTER
			-- Encapsulation of the external cwin_get_wm_hscroll_hwnd
		do
			Result := cwin_get_wm_hscroll_hwnd (wparam, lparam)
		end

	get_wm_hscroll_pos (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_hscroll_pos
		do
			Result := cwin_get_wm_hscroll_pos (wparam, lparam)
		end

	get_wm_vscroll_code (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_vscroll_code.
		do
			Result := cwin_get_wm_vscroll_code (wparam, lparam)
		end

	get_wm_vscroll_hwnd (wparam, lparam: POINTER): POINTER
			-- Encapsulation of the external cwin_get_wm_vscroll_hwnd
		do
			Result := cwin_get_wm_vscroll_hwnd (wparam, lparam)
		end

	get_wm_vscroll_pos (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_vscroll_pos
		do
			Result := cwin_get_wm_vscroll_pos (wparam, lparam)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_WINDOW note option: stable attribute end

	destroy
			-- Destroy `Current', but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if not is_destroyed then
				application_imp.remove_root_window (Current)

					-- Remove parent/children relationship
				replace (Void)

					-- No one should be referencing Current anymore.
				set_is_destroyed (True)

					--| Instead of calling Precursor {WEL_COMPOSITE_WINDOW},
					--| We do about the same except we do not quit the application
					--| if `Current' is application main window, since Vision2
					--| Does not have such a concept.
				wel_destroy_window
			end
		end

	is_shown_by_default: BOOLEAN
			-- <Precursor>
		do
				-- Windows and descendents are not shown by default.
			-- Result := False
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
