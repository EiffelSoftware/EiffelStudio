indexing
	description: "Eiffel Vision window. Mswindows implementation."
	status: "See notice at end of class"
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
			{NONE} set_parent
		undefine
			show,
			hide,
			ev_apply_new_size
		redefine
			destroy,
			set_parent,
			client_height,
			client_y,
			parent_ask_resize,
			set_default_minimum_size,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size,
			on_destroy,
			interface,
			initialize,
			on_size,
			insert,
			default_process_message
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
			set_x as set_x_position,
			set_y as set_y_position,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			has_capture as wel_has_capture
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
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			background_brush,
			on_draw_item,
			on_set_cursor,
			on_color_control,
			on_wm_vscroll,
			on_wm_hscroll,
			on_destroy,
			on_char,
			on_desactivate,
			x_position,
			y_position,
			on_sys_key_down,
			on_sys_key_up,
			on_notify,
			default_process_message
		redefine
			has_focus,
			default_ex_style,
			default_style,
			on_size,
			on_get_min_max_info,
			on_destroy,
			on_show,
			on_move,
			on_menu_command,
			window_process_message,
			on_wm_close,
			on_wm_window_pos_changing,
			on_wm_setting_change,
			set_y_position,
			set_x_position,
			show,
			hide
		end

	WEL_CONSTANTS
		export
			{NONE} all
		end

	EV_WINDOW_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			make_top ("")
		end

	initialize is
			-- Initialize `Current'.
		local
			app_imp: EV_APPLICATION_IMP
		do
			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP}
			user_can_resize := True
			init_bars
			app_imp ?= (create {EV_ENVIRONMENT}).application.implementation
			app_imp.add_root_window (Current)
			is_initialized := True
		end	

	init_bars is
			-- Initialize `lower_bar' and `upper_bar'.
		local
			ub_imp, lb_imp: EV_VERTICAL_BOX_IMP
		do
			create upper_bar
			create lower_bar
			ub_imp ?= upper_bar.implementation
			lb_imp ?= lower_bar.implementation
			check
				ub_imp_not_void: ub_imp /= Void
				lb_imp_not_void: lb_imp /= Void
			end
			ub_imp.on_parented
			lb_imp.on_parented
			ub_imp.wel_set_parent (Current)
			lb_imp.wel_set_parent (Current)
			ub_imp.set_top_level_window_imp (Current)
			lb_imp.set_top_level_window_imp (Current)
		end

feature -- Access

	client_y: INTEGER is
			-- Top of the client area of `Current'.
		do
			Result := Precursor {EV_SINGLE_CHILD_CONTAINER_IMP}
			if not interface.upper_bar.is_empty then
					-- Add 1 pixel to separate client area and upper bar.
				Result := Result + interface.upper_bar.minimum_height + 1
			end
			Result := Result.min (height)
		end

	client_height: INTEGER is
			-- Height of the client area of `Current'.
		do
			Result := Precursor {EV_SINGLE_CHILD_CONTAINER_IMP} - client_y
			if not interface.lower_bar.is_empty then
					-- Add 1 pixel to separate client area and lower bar.
				Result := Result - interface.lower_bar.minimum_height - 1
			end
			Result := Result.max (0)
		end

	maximum_height: INTEGER
			-- Maximum height that application wishes widget
			-- instance to have.

	maximum_width: INTEGER
			-- Maximum width that application wishes widget
			-- instance to have.

	title: STRING is
			-- Window text to be displayed by the application manager.
		do
			Result := text
       	end

	top_level_window_imp: like Current is
			-- Top level window that contains `Current'.
			-- As `Current' is a window then we return `Current'
		do
			Result := Current
		end
    
	menu_bar: EV_MENU_BAR
			-- Horizontal bar at top of client area that contains menu's.

	is_modal: BOOLEAN
			-- Must the window be closed before application continues?

feature -- Status setting

	lock_update is
			-- Lock updates for this window on certain platforms until
			-- `unlock_update' is called.
		do
			{EV_WINDOW_I} Precursor
			lock_window_update
		end

	unlock_update is
			-- Unlock updates for this window on certain platforms.
		do
			{EV_WINDOW_I} Precursor
			unlock_window_update
		end

	insert (v: like item) is
			-- Insert `v' into `Current'.
		do
			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP} (v)
			ev_move_and_resize (x_position, y_position, width, height, False)
		end

	set_default_minimum_size is
			-- Initialize the size of `Current'.
		do
			ev_set_minimum_size (0, 0)
				-- Assign arbitarily large values.
				-- As long as they are bigger than the current screen
				-- resolution there will be no problems from this.
			set_maximum_width (32000)
			set_maximum_height (32000)
		end

	forbid_resize is
			-- Forbid the resize of `Current'.
		local
			new_style: INTEGER
		do
			new_style := style
			new_style := clear_flag (new_style, Ws_maximizebox)
			new_style := clear_flag (new_style, Ws_minimizebox)
			new_style := clear_flag (new_style, Ws_sizebox)
			set_style (new_style)
			compute_minimum_size
			if is_displayed then
				hide
				show
			end
		end

	allow_resize is
			-- Allow the resize of `Current'.
		local
			new_style: INTEGER
		do
			new_style := style
			new_style := set_flag (new_style, Ws_maximizebox)
			new_style := set_flag (new_style, Ws_minimizebox)
			new_style := set_flag (new_style, Ws_sizebox)
			set_style (new_style)
			compute_minimum_size
			if is_displayed then
				hide
				show
			end
		end

feature -- Element change

	set_x_position (a_x: INTEGER) is
			-- Set `x_position' with `a_x'
		do
			child_cell.set_is_positioned
			ev_move (a_x, y_position)
		end

	set_y_position (a_y: INTEGER) is
			-- Set `y_position' with `a_y'
		do
			child_cell.set_is_positioned
			ev_move (x_position, a_y)
		end
	
	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of `Current'.
			-- `par' can be Void then the parent is the screen.
		local
			ww: WEL_WINDOW
		do
			if par /= Void then
				ww ?= par.implementation
				wel_set_parent (ww)
			else
				wel_set_parent (Void)
			end
		end

	set_maximum_width (value: INTEGER) is
			-- Make `value' the new maximum width.
			-- If `width' is larger, then it is reduced.
		do
			maximum_width := value
			if value < ev_width then
				ev_resize (value, ev_height)
			end
		end

	set_maximum_height (value: INTEGER) is
			-- Make `value' the new maximum height.
			-- If `height' is larger, then it is reduced.
		do
			maximum_height := value
			if value < ev_height then
				ev_resize (ev_width, value)
			end
		end

	set_title (txt: STRING) is
			-- Make `txt' the title of `Current'.            
		do
			set_text (clone (txt))
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR) is
			-- Assign `a_menu_bar' to `menu_bar'.
		local
			mb_imp: WEL_MENU
			mb: EV_MENU_BAR_IMP
		do
			menu_bar := a_menu_bar
			mb_imp ?= menu_bar.implementation
			set_menu (mb_imp)
			mb ?= a_menu_bar.implementation
			check
				implementation_not_void: mb /= Void
			end
			mb.set_parent_imp (Current)
			compute_minimum_height
		end

	remove_menu_bar is
			-- Assign `Void' to `menu_bar'.
		local
			mb: EV_MENU_BAR_IMP
		do
			if menu_bar /= Void then
				mb ?= menu_bar.implementation
				check
					implementation_not_void: mb /= Void
				end
				mb.set_parent_imp (Void)
				menu_bar := Void
				unset_menu
				compute_minimum_height
			end
		end

	enable_modal is
			-- Assign `True' to `is_modal' to `True' and set `Current' to be
			-- "Top most".
		local
			loc_ex_style: INTEGER
		do
			if not is_modal then
					-- Change the `ex_style' of the window to turn
					-- it into top most.
				loc_ex_style := ex_style
				if not flag_set (loc_ex_style, Ws_ex_topmost) then
					loc_ex_style := set_flag (loc_ex_style, Ws_ex_topmost)
					set_ex_style (loc_ex_style)
				end
				set_ex_style (default_ex_style + Ws_ex_topmost)
	
				is_modal := True
			end
		end

	disable_modal is
			-- Set `is_modal' to `False', Set `Current' not 
			-- to be "Top most" if it is not part of its 
			-- default style.
		local
			loc_ex_style: INTEGER
		do
			if is_modal then
				if exists then
					-- Remove the TopMost flag only it is not part
					-- of `default_ex_style'.
					loc_ex_style := ex_style
					if (not flag_set (Default_ex_style, Ws_ex_topmost)) and
					   flag_set (loc_ex_style, Ws_ex_topmost)
					then
						loc_ex_style := clear_flag (loc_ex_style, Ws_ex_topmost)
						set_ex_style (loc_ex_style)
					end
				end

				is_modal := False
			end
		end

feature -- Basic operations

	block is
			-- Wait until `Current' is closed by the user.
		local
			app: EV_APPLICATION
		do
			app := Environment.application

				-- Wait until window is closed.
			from until is_destroyed or else not is_displayed loop
				app.process_events
				app.sleep (100)
			end
		end

feature -- Status Report

	has_focus: BOOLEAN is
			-- Does current window have focus?
		do
			Result := foreground_window = Current
		end

feature {NONE} -- Implementation

	on_wm_setting_change is
			-- Wm_settingchange message
			-- Update the system fonts.
		local
			mb_imp: EV_MENU_BAR_IMP
		do
			Precursor {WEL_FRAME_WINDOW}
			
			if menu_bar /= Void then
				mb_imp ?= menu_bar.implementation
				mb_imp.rebuild_control
			end
		end
		
	wel_destroy_window is
			-- Destroy the window-widget
		do
			cwin_destroy_window (wel_item)
		end

	ev_apply_new_size (a_x_position, a_y_position,
			a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Move the window to `a_x_position', `a_y_position' position and
			-- resize it with `a_width', `a_height'.
			-- This feature must be redefine by the containers to readjust its
			-- children too.
		local
			bar_imp: EV_VERTICAL_BOX_IMP 
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			if item /= Void then
				item_imp.ev_apply_new_size (client_x, client_y,
					client_width, client_height, True)
			end
			if menu_bar /= Void then
				draw_menu
			end
			if not interface.upper_bar.is_empty then
				bar_imp ?= interface.upper_bar.implementation
				check
					bar_imp_not_void: bar_imp /= Void
				end
				bar_imp.set_move_and_size (0, 0, client_width, client_y)
			end
			if not interface.lower_bar.is_empty then
				bar_imp ?= interface.lower_bar.implementation
				check
					bar_imp_not_void: bar_imp /= Void
				end
				bar_imp.set_move_and_size (0,
					client_y + client_height + 1,
					client_width, bar_imp.minimum_height)
			end
		end

	on_menu_command (menu_id: INTEGER) is
			-- `menu_id' has been chosen from the menu.
		local
			menu_bar_imp: EV_MENU_BAR_IMP
		do
			if menu_bar /= Void then
				menu_bar_imp ?= menu_bar.implementation
				menu_bar_imp.menu_item_clicked (menu_id)
			end
		end
		
	on_menu_opened (a_menu: WEL_MENU) is
			-- `a_menu' has been opened.
		local
			menu_bar_imp: EV_MENU_BAR_IMP
		do
			if has_menu then
				menu_bar_imp ?= menu_bar.implementation
				menu_bar_imp.menu_opened (a_menu)
			end
		end

feature {EV_WIDGET_IMP} -- Implementation
		
	last_focused_widget: POINTER
		-- Last focused widget in `Current'.
	
	set_last_focused_widget (windows_pointer: POINTER) is
			-- Assign `windows_pointer' to `last_focused_widget'.
		do
			last_focused_widget := windows_pointer
		end

feature {EV_MENU_ITEM_LIST_IMP} -- Implementation

	compute_minimum_width is
			-- Recompute the minimum width of `Current'.
		local
			mw: INTEGER
		do
			if user_can_resize then
				mw := 2 * window_frame_width
			else
				mw := 2 * dialog_window_frame_width
			end
			
			if item_imp /= Void and item_imp.is_show_requested then
				mw := mw + item_imp.minimum_width
			end
			mw := mw.max (interface.upper_bar.minimum_width).max
				(interface.lower_bar.minimum_width)
			ev_set_minimum_width (
				mw.max (interface.upper_bar.minimum_width).max
					(interface.lower_bar.minimum_width))
		end

	compute_minimum_height is
			-- Recompute the minimum height of `Current'.
		local
			mh: INTEGER
		do
			if user_can_resize then
				mh := 2 * window_frame_height
			else
				mh := 2 * dialog_window_frame_height
			end
			if has_menu then
				mh := mh + menu_bar_height
			end
			if not interface.upper_bar.is_empty then
				mh := mh + interface.upper_bar.minimum_height + 1
			end
			if item_imp /= Void and item_imp.is_show_requested then
				mh := mh + item_imp.minimum_height
			end
			if not interface.lower_bar.is_empty then
				mh := mh + interface.lower_bar.minimum_height + 1
			end
			ev_set_minimum_height (mh)
		end

	compute_minimum_size is
			-- Recompute the minimum size of `Current'.
		local
			mw, mh: INTEGER
		do
			if user_can_resize then
				mw := 2 * window_frame_width
			else
				mw := 2 * dialog_window_frame_width
			end
			
			if item_imp /= Void and item_imp.is_show_requested then
				mw := mw + item_imp.minimum_width
			end
			mw := mw.max (interface.upper_bar.minimum_width).max
				(interface.lower_bar.minimum_width)

			if user_can_resize then
				mh := 2 * window_frame_height
			else
				mh := 2 * dialog_window_frame_height
			end
			if has_menu then
				mh := mh + menu_bar_height
			end
			if not interface.upper_bar.is_empty then
				mh := mh + interface.upper_bar.minimum_height + 1
			end
			if item_imp /= Void then
				mh := mh + item_imp.minimum_height
			end
			if not interface.lower_bar.is_empty then
				mh := mh + interface.lower_bar.minimum_height + 1
			end
			ev_set_minimum_size (
				mw.max (interface.upper_bar.minimum_width).max
				(interface.lower_bar.minimum_width), mh)
		end

feature {NONE} -- Inapplicable

	parent_ask_resize (a_width, a_height: INTEGER) is
			-- When the parent asks the resize, it's not
			-- necessary to send him back the information
			-- Can be called but do nothing.
		do
			--| This does not need to do anything.
			check
				Inapplicable: True
			end
		end

	set_top_level_window_imp (a_window: EV_TITLED_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		do
			--| This should never be called for a window.
			check
				inapplicable: False
			end
		end

feature {EV_ANY_I} -- Implementation

	default_style: INTEGER is
			-- Default style of `Current'.
			-- Set with the option `Ws_clipchildren' to avoid flashing.
		do
			Result := Ws_popup + Ws_overlapped + Ws_dlgframe
					+ Ws_clipchildren + Ws_clipsiblings
		end

	default_ex_style: INTEGER is
			-- Default extended style of `Current.
		do
			Result := Ws_ex_controlparent
		end

	default_process_message (msg, wparam, lparam: INTEGER) is
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
			if msg = Wm_mouseactivate then
				on_wm_mouseactivate (wparam, lparam)
			elseif msg= Wm_syncpaint then
				if item_imp /= Void then
					item_imp.propagate_syncpaint
				end
			else
				Precursor {EV_SINGLE_CHILD_CONTAINER_IMP} (msg, wparam, lparam)
			end
		end
		
	show is
			-- Show `Current'.
		do
			if not is_displayed then
				call_show_actions := True
				Precursor {WEL_FRAME_WINDOW}
					-- We call show actions
				if call_show_actions then
					if show_actions_internal /= Void then
						show_actions_internal.call ([])
					end
					call_show_actions := False
				end
			end
		end
		
	hide is
			-- Hide `Current'.
		do
			Precursor {WEL_FRAME_WINDOW}
			call_show_actions := False
		end
		
	call_show_actions: BOOLEAN
		-- Should the `show_actions_internal' be called?
		-- used to ensure they are only called once.

	on_show is
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

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Called when `Current' is resized.
		local
			bar_imp: EV_VERTICAL_BOX_IMP
			w_rect: WEL_RECT
		do
			if size_type /= Wel_window_constants.Size_minimized then
				w_rect := window_rect
				internal_set_size (w_rect.width, w_rect.height)

				if not interface.upper_bar.is_empty then
					bar_imp ?= interface.upper_bar.implementation
					check
						bar_imp_not_void: bar_imp /= Void
					end
					bar_imp.set_move_and_size (0, 0, client_width, client_y)
				end

				if item /= Void then
					item_imp.set_move_and_size (client_x, client_y,
						client_width, client_height)
				end

				if not interface.lower_bar.is_empty then
					bar_imp ?= interface.lower_bar.implementation
					check
						bar_imp_not_void: bar_imp /= Void
					end
					bar_imp.set_move_and_size (0,
						client_y + client_height + 1,
						client_width, bar_imp.minimum_height)
				end

					-- Calls user actions if any
				if resize_actions_internal /= Void then
					resize_actions_internal.call (
						[screen_x, screen_y, a_width, a_height])
				end
			end
		end

   	on_move (x_pos, y_pos: INTEGER) is
   			-- Wm_move message.
   			-- This message is sent after a window has been moved.
   			-- `x_position_pos' specifies the x_position-coordinate
			-- of the upper-left corner of the client area of the window.
   			-- `y_pos' specifies the y-coordinate of the upper-left
   			-- corner of the client area of the window.
   		do
			interface.move_actions.call ([x_pos, y_pos, ev_width, ev_height])
 		end

	on_get_min_max_info (min_max_info: WEL_MIN_MAX_INFO) is
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

	on_destroy is
			-- Called when `Current' is destroyed.
			-- Set the parent sensitive if it exists.
		do
			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP}
			if parent_imp /= Void and not parent_imp.destroyed and then not
				parent_imp.is_sensitive then
				parent_imp.disable_sensitive
			end
		end

	on_wm_close is
			-- User clicked on "close" ('X').
		do
			if close_request_actions_internal /= Void then
				close_request_actions_internal.call ([])
			end
				-- Do not actually close the window.
			set_default_processing (False)
		end

	on_wm_mouseactivate (wparam, lparam: INTEGER) is
			-- `Current' has been activated thanks to the click of a window.
		local
			msg: INTEGER
			env: EV_ENVIRONMENT
			app_imp: EV_APPLICATION_IMP
			source: EV_PICK_AND_DROPABLE_IMP
		do
			create env
			app_imp ?= env.application.implementation
			check
				app_not_void: app_imp /= Void
			end
			app_imp.clear_override_from_mouse_activate
			msg := cwin_hi_word (lparam)
				--| We need to pass the mouse_button to `source_at_pointer_position'.
				--| This enables it to only call `pebble_function' if really necessary,
				--| i.e. the pressed button matches the type of transport.
			if msg = Wm_lbuttondown then
				source := source_at_pointer_position (1)
			elseif msg = Wm_rbuttondown then
				source := source_at_pointer_position (3)
			else
				source := Void
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
				app_imp.pick_and_drop_source /= Void then
						--| If we have reached here, then we do not want to raise the window, as
						--| the click is either going to start a drag/pick and drop or there is
						--| one currently executing (quered on `app_imp').
					set_message_return_value (Wel_input_constants.Ma_noactivate)
					disable_default_processing
					override_movement := True
					if not has_focus and not widget_has_drag (source) then
						app_imp.set_override_from_mouse_activate
					end
				else
						--| If we have reached here, then if there is no pick/drag and drop
						--| executing, so we explicitly call `move_to_foreground' to ensure
						--| `Current' is raised. If we do not call `move_to_foreground', in some
						--| cases, on_window_pos_changing may not be called.
					if app_imp.pick_and_drop_source = Void then
						move_to_foreground
					end
				end
			else
					--| We reach here if the mouse click that caused the wm_mouseactivate message
					--| was over a widget that does not have pick/drag and drop. Clicking on the
					--| non client area of a window will also cause us to be here.
				if app_imp.pick_and_drop_source = Void then
						--| We are here if there is no drag/pick and drop currently executing.
						--| So we must raise `Current'.
					move_to_foreground
				else
						--| If we are here, then there is a drag/pick and drop executing, so
						--| we override the movement.
					set_message_return_value (Wel_input_constants.Ma_noactivate)
					disable_default_processing
					override_movement := True
					if not has_focus then
						app_imp.set_override_from_mouse_activate
					end
				end
			end
		end
	
	widget_has_pick (pick_and_dropable: EV_PICK_AND_DROPABLE_IMP): BOOLEAN is
			-- Does `pick_and_dropable' have a pick and drop?
		do
			if pick_and_dropable /= Void then
				Result := pick_and_dropable.mode_is_pick_and_drop
			end
		end

	widget_has_drag (pick_and_dropable: EV_PICK_AND_DROPABLE_IMP): BOOLEAN is
			-- Does `pick_and_dropable' have a drag and drop?
		do
			if pick_and_dropable /= Void then
				Result :=  pick_and_dropable.mode_is_drag_and_drop
			end
		end

	source_at_pointer_position (button_pressed: INTEGER): EV_PICK_AND_DROPABLE_IMP is
			-- `Result' is EV_PICK_AND_DROPABLE at current pointer_position.
			-- `button_pressed' is pointer button which caused this feature to be
			-- called. This allows us to avoid excessive processing when we know
			-- that the type of transport of the widget does not match the button.
		local
			wel_window: WEL_WINDOW
			wel_point: WEL_POINT
			widget_imp: EV_WIDGET_IMP
			item_list_imp: EV_ITEM_LIST_IMP [EV_ITEM]
			an_item_imp: EV_ITEM_IMP
			sensitive: EV_SENSITIVE
		do	
			create wel_point.make (0, 0)
			wel_point.set_cursor_position
			wel_window := wel_point.window_at
			if wel_window /= Void then
				widget_imp ?= wel_window
				if widget_imp /= Void then
						--| We only need to perform further processing if the pointer
						--| button matches the type of transport of `widget_imp'.
					if (button_pressed = 1 and widget_imp.mode_is_drag_and_drop) or
						(button_pressed = 3 and widget_imp.mode_is_pick_and_drop) then
							-- This feature may get called more then once, so we only
							-- perform the pebble query the first time, before the
							-- transport has started.
						if application_imp.pick_and_drop_source = Void then
						widget_imp.call_pebble_function (wel_point.x - widget_imp.screen_x,
							wel_point.y - widget_imp.screen_y, wel_point.x, wel_point.y)
						end
						if widget_imp.pebble /= Void then
							Result := widget_imp
						end
						item_list_imp ?= widget_imp
						if item_list_imp /= Void then
							an_item_imp ?= item_list_imp.find_item_at_position (wel_point.x
								- item_list_imp.screen_x, wel_point.y - item_list_imp.screen_y)
							if an_item_imp /= Void then
										--| FIXME we need to pass the relative coordinates to `query_pebble_function'.
									an_item_imp.call_pebble_function (0, 0, wel_point.x, wel_point.y)
								if an_item_imp.pebble /= Void then--or pebble_result /= Void then
										-- If the cursor is over an item and the item is a
										-- pick and drop target then we set the target id to that of the
										-- item, as the items are conceptually 'above' the list and so
										-- if a list and one of its items are pnd targets then the 
										-- item should recieve.
									sensitive ?= an_item_imp.interface
										-- If an item is not `sensitive' then it cannot be dropped on.
									if sensitive = Void or (sensitive /= Void and then sensitive.is_sensitive) then
										Result := an_item_imp
									end
								end
							end
						end
					end				
				end
			end
		end

	on_wm_window_pos_changing (lparam: INTEGER) is
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
				create info.make_by_pointer (cwel_integer_to_pointer (lparam))
				create flag_cst
				cur_flag := info.flags
				cur_flag := set_flag (cur_flag, flag_cst.Swp_nozorder)
				info.set_flags (cur_flag)
			end
			override_movement := False
		end
		
	window_process_message (hwnd: POINTER; msg,
			wparam, lparam: INTEGER): INTEGER is
			-- Call the routine `on_*' corresponding to the
			-- message `msg'.
		local
			a_menu: WEL_MENU
			titled_window: EV_TITLED_WINDOW_IMP
		do
				-- The `Wm_ncactive' message is sent by windows when the
				-- non client area of Current needs to be changed to indicate an
				-- active or non active state (Blue or Grey as default).
			if msg = Wm_ncactivate then
					-- `wparam' is equal to 1 then the non client area of
					-- `Current' is being changed to indicate active.				
				if wparam = 1 then
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
			elseif msg = Wm_activate then
				if wparam /= Wel_window_constants.Wa_inactive then
						-- We must now restore the focus to `last_focused_widget'
						-- as the window is now being re-activated.
					if is_window (last_focused_widget) then
						window_of_item (last_focused_widget).set_focus
							-- Calling disable_default_processing is required in order to
							-- stop the focus being removed from `last_focused_widget' after
							-- we set it. However, this stops on_set_focus being called, so we
							-- call the relevent parts by ourself.
						disable_default_processing
						titled_window ?= Current
						if titled_window /= Void then
							application_imp.set_window_with_focus (titled_window.interface)
						end
						if focus_in_actions_internal /= Void then
							focus_in_actions_internal.call ([])
						end
					end
				end
			elseif msg = Wm_initmenupopup then
				create a_menu.make_by_pointer (cwel_integer_to_pointer (wparam))
				on_menu_opened (a_menu)
			elseif msg = Wm_enteridle then
					--| FIXME This message is sent when `Current' has a modal dialog
					--| as a child. This message is only sent once, and not repeatedly as
					--| we require for the idle actions.
				if application_imp.idle_actions /= Void then
					application_imp.idle_actions.call ([])	
				end
				fire_dialog_show_actions (cwel_integer_to_pointer (lparam))
			else
				Result := Precursor {WEL_FRAME_WINDOW} (hwnd, msg, wparam, lparam)
			end
		end
		
	fire_dialog_show_actions (dialog: POINTER) is
			-- Call `show_actions' on a dialog referenced by `dialog'.
			--| We need to ensure that all widgets in the dialog
			--| are completely visible, and this was the only message that
			--| I could find which was called at the correct time.
			--| If a better method of doing this can be found, then there
			--| should be no consequences. Just make sure that you can call set_focus
			--| on a widget within the dialog from the on_show actions. Julian.
		local
			windows: LINEAR [EV_WINDOW]
			dialog_imp_modal: EV_DIALOG_IMP_MODAL
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

	internal_height, internal_width: INTEGER
		-- Calling `hide' then `show' would loose the settings of
		-- `height' and `width'. Therefore we store them internally,
		-- and restore them in on_show if necessary.

feature -- {EV_PICK_AND_DROPABLE_IMP, EV_SPLIT_AREA_IMP}

	allow_movement is
		do
			override_movement := False
		end

	move_to_foreground is
			-- Move `Current' to foreground.
		do
			override_movement := False
			cwin_set_window_pos (wel_item, Hwnd_top, 0, 0, 0, 0,
				Swp_nosize + Swp_nomove)
		end

feature {EV_PND_TRANSPORTER_IMP, EV_WIDGET_IMP}

	title_height: INTEGER is
			-- `Result' is absolute x position of client rect.
		do
			Result := title_bar_height
		end

	frame_height: INTEGER is
			-- `Result' is frame height of `Current'.
		do
			if user_can_resize then
				Result := window_frame_height
			else
				Result := dialog_window_frame_height
			end
		end

	frame_width: INTEGER is
			-- `Result' is frame width of `Current'.
		do
			if user_can_resize then
				Result := window_frame_width
			else
				Result := dialog_window_frame_width
			end
		end
	
	border_width: INTEGER is
			-- `Result' is border width of `Current'.
		do
			Result := window_border_width
		end

feature {NONE} -- Features that should be directly implemented by externals

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

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: EV_WINDOW

	destroy is
			-- Destroy `Current', but set the parent sensitive
			-- in case it was set insensitive by the child.
		local
			app_i: EV_APPLICATION_I
			app_imp: EV_APPLICATION_IMP
		do
			if not is_destroyed then
				app_i := (create {EV_ENVIRONMENT}).application.implementation
				app_imp ?= app_i
				check
					implementation_not_void: app_imp /= Void
				end
				app_imp.remove_root_window (Current)
	
					-- Remove parent/children relationship
				interface.wipe_out
	
					-- No one should be referencing Current anymore.
				is_destroyed := True	
					
					--| Instead of calling Precursor {WEL_COMPOSITE_WINDOW},
					--| We do about the same except we do not quit the application
					--| if `Current' is application main window, since Vision2
					--| Does not have such a concept.
				wel_destroy_window
			end
		end

end -- class EV_WINDOW_IMP

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

