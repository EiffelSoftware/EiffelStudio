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
			if text.count /= 0 then
				Result := text
			else
				Result := Void
			end
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
			set_text (txt)
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
				--| FIXME used to use menu /= Void
				--| but we cannot query it in WEL. Is this correct?
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
			--| FIXME Reformat this code.
			create env
			app_imp ?= env.application.implementation
			check
				app_not_void: app_imp /= Void
			end
			app_imp.clear_override_from_mouse_activate
			msg := cwin_hi_word (lparam)
			source := source_at_pointer_position
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

	source_at_pointer_position: EV_PICK_AND_DROPABLE_IMP is
			-- `Result' is EV_PICK_AND_DROPABLE at current pointer_position.
		local
			wel_window: WEL_WINDOW
			wel_point: WEL_POINT
			widget_imp: EV_WIDGET_IMP
			item_list_imp: EV_ITEM_LIST_IMP [EV_ITEM]
			an_item_imp: EV_ITEM_IMP
			sensitive: EV_SENSITIVE
			pebble_result: ANY
		do	
			create wel_point.make (0, 0)
			wel_point.set_cursor_position
			wel_window := wel_point.window_at
			if wel_window /= Void then
				widget_imp ?= wel_window
				if widget_imp /= Void then
						-- We execute the pebble function
					pebble_result := widget_imp.query_pebble_function (wel_point.x - widget_imp.screen_x,
						wel_point.y - widget_imp.screen_y, wel_point.x, wel_point.y)
					if widget_imp.pebble /= Void or pebble_result /= Void then
						Result := widget_imp
					end
					item_list_imp ?= widget_imp
					if item_list_imp /= Void then
						an_item_imp ?= item_list_imp.find_item_at_position (wel_point.x
							- item_list_imp.screen_x, wel_point.y - item_list_imp.screen_y)
						if an_item_imp /= Void then
									--| FIXME we need to pass the relative coordinates to `query_pebble_function'.
								pebble_result := an_item_imp.query_pebble_function (0, 0, wel_point.x, wel_point.y)
							if an_item_imp.pebble /= Void or pebble_result /= Void then
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

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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
--| Revision 1.57  2001/07/10 00:00:03  rogers
--| Fixed `on_get_min_max_info'. We now actually take into account
--| `maximum_width' and `maximum_height'. Previsouly, calling `set_maximum_*'
--| would not actually cause the size to be limitied.
--|
--| Revision 1.56  2001/06/28 22:53:40  rogers
--| `window_process_message' now  always uses `application_imp'.
--|
--| Revision 1.55  2001/06/13 20:16:37  pichery
--| Moved features to their right "feature" clause.
--|
--| Revision 1.54  2001/06/08 18:55:48  pichery
--| Removed useless code
--|
--| Revision 1.53  2001/06/07 23:08:15  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.17.4.101  2001/06/03 21:43:25  pichery
--| - Now execute `destroy' only when not already destroyed.
--| - Set the focus to the last_focused_widget on Wm_activate ONLY when
--|   we receive a Wm_activate message for an activation (Wm_activate is
--|   sent to both the activated and the deactivate windows)
--|
--| Revision 1.17.4.100  2001/05/25 17:15:05  rogers
--| Fixed window_process_message so that when we receive Wm_activate,
--| we now call the focus_in_actions_internal, as calling
--| `disable_default_processing'stops on_set_focus being called.
--|
--| Revision 1.17.4.99  2001/05/24 17:44:23  pichery
--| Fixed `frame_width', `frame_height', `compute_minimum_width' and
--| `compute_minimum_height'  for non-resizeable dialogs
--|
--| Revision 1.17.4.98  2001/05/18 20:56:40  pichery
--| Fixed bug in `compute_minimum_width' and `compute_minimum_height': the
--| size of the frame border was added even when the window is not resizeable
--| (in this case Windows does not display any frame border)
--|
--| Revision 1.17.4.97  2001/05/18 00:46:37  rogers
--| Removed destroy_just_called.
--|
--| Revision 1.17.4.96  2001/05/18 00:10:59  rogers
--| Connected the close_request_actions. Removed all handling of the
--| close_actions.
--|
--| Revision 1.17.4.95  2001/05/17 20:10:30  rogers
--| Added `last_focused_widget' and `set_last_focused_widget'. We now handle
--| the `Wm_activate' message in `window_process_message' which allows us to
--| restore the focus to a previously focused widget when switching windows
--| using alt-tab.
--|
--| Revision 1.17.4.94  2001/05/17 01:20:15  rogers
--| Connected `show_actions' within `show'.
--|
--| Revision 1.17.4.93  2001/05/15 22:41:49  rogers
--| Removed `last_call_was_destroy'.
--|
--| Revision 1.17.4.92  2001/05/11 21:54:21  rogers
--| Removed unreferenced variable.
--|
--| Revision 1.17.4.91  2001/05/02 22:52:49  rogers
--| Added fire_dialog_actions which is called from window_process_message
--| when we receive the Wm_enteridle message.
--|
--| Revision 1.17.4.90  2001/05/02 17:59:06  rogers
--| Redefined `on_set_focus' so we can call `show_actions_internal'.
--| Added `call_show_actions' which is used to ensure the actions are only
--| called once.
--|
--| Revision 1.17.4.89  2001/04/30 23:39:26  rogers
--| Connected the idle actions from EV_APPLICATION_IMP to the Wm_enteridle
--| message. This is sent when `Current' has a modal dialog as a child.
--|
--| Revision 1.17.4.88  2001/04/23 18:38:21  rogers
--| Fixed bug in on_menu_opened. Previously, clicking on the icon of a window
--| would cause a precondition violation.
--|
--| Revision 1.17.4.87  2001/04/05 23:24:38  rogers
--| Removed limitations on re-sizing the screen. A user can now re-size the
--| screen to as large as they wish.
--|
--| Revision 1.17.4.86  2001/04/05 18:25:52  rogers
--| Destroy now checks that `on_wm_close_executed' has not been called before
--| calling the close actions. This stops an action in the close_actions
--| from being called twice, when inserted after a call to destroy of
--| `Current' in the close actions.
--|
--| Revision 1.17.4.85  2001/04/03 17:21:06  rogers
--| Added on_menu_opened which is called by window_process_message when
--| a menu is being selected. This fixes a bug with menu select_actions
--| never being fired.
--|
--| Revision 1.17.4.84  2001/03/24 16:29:17  manus
--| Cosmetics (fixed indentation)
--| Fixed a bug when calling destroy, because `is_destroyed' was not yet set when
--| calling `wel_destroy_window' and as a result some calls in a vision2 application
--| could fail because the `wel_item' pointer was already reset to `Default_pointer'.
--|
--| Revision 1.17.4.83  2001/03/22 19:27:42  rogers
--| Fixed bug in `destroy' we no longer check `destroy_just_called' before
--| destroying `Current'. Fixed bug in remove_menu_bar, we now only attempt to
--| remove the menu bar if `Current' has a menu_bar.
--|
--| Revision 1.17.4.82  2001/03/21 18:06:45  rogers
--| Redefined ev_apply_new_size to fix bugs in resizing when `Current' has a
--| menu, `lower_bar' ot `upper_bar'. The bug would show when setting the
--| minimum_size of `Current' to be larger than its contents, the menu_bar,
--| `lower_bar' or `upper_bar' would not be displayed.
--|
--| Revision 1.17.4.81  2001/03/14 19:22:23  rogers
--| Modified default_process_message to handle `Wm_syncpaint' by calling
--| `propagate_syncpaint'.
--|
--| Revision 1.17.4.80  2001/02/17 23:22:08  pichery
--| Changed the implementation for `lock_update' / `unlock_update'
--|
--| Revision 1.17.4.79  2001/02/17 02:13:13  manus
--| Cosmetics
--|
--| Revision 1.17.4.78  2001/02/17 01:28:14  rogers
--| Added maximum_window_height and maximum_window_width. These are used to
--| fix a bug with increasing the screen resolution and not being able to
--| resize `Current' larger than the previous resolution.
--|
--| Revision 1.17.4.76  2001/02/13 23:13:45  rogers
--| Source_at_pointer_position now calls query_pebble_function instead of
--| call_pebble_function. Stops bug with the pebble being set to `Void' when
--| ending the transport, but before it should be set to `Void'.
--|
--| Revision 1.17.4.75  2001/02/13 19:30:25  rogers
--| More bug fixes with overriding of windows movement during pick/drag and
--| drop. We now make use of `override_from_mouse_activate' from
--| EV_APPLICATION_IMP.
--|
--| Revision 1.17.4.74  2001/02/13 03:05:19  rogers
--| Fixed bug in source_at_pointer_position. We were passing the relative
--| coordinates of widget instead of the absolute.
--|
--| Revision 1.17.4.72  2001/02/12 22:54:59  rogers
--| Fixed bug in window_process_message. If we receive a Wm_ncactive message,
--| and `Current' is being modified to indicate non active, then we never
--| override this behaviour.
--|
--| Revision 1.17.4.71  2001/02/10 00:26:08  rogers
--| Re-implemented window_process_message. This allows us to handle
--| Wm_ncactivate correctly with regard to the pick/drop and the raising of
--| the window.
--|
--| Revision 1.17.4.70  2001/02/08 22:56:25  pichery
--| Fixed reentrance bug
--|
--| Revision 1.17.4.69  2001/02/08 18:00:27  rogers
--| Re-wrote the code which handles the raising/overiding of `Current' when
--| perfroming pick and drop. Now we always assume `Current' can be raised in
--| on_wm_mouseactivate. If we then find that we are about to execute drag/pick
--| and drop or are currently executing one, then we stop `Current' coming to
--| the foreground.
--| Removed redefinition of window_process_message as it is no longer needed
--| with this new implementation.
--| Modify_z_position has also now been removed as this is now redundent.
--|
--| Revision 1.17.4.68  2001/02/06 20:25:07  rogers
--| Override_movement is assigned `True' on initialization.
--|
--| Revision 1.17.4.67  2001/02/06 19:33:18  rogers
--| Added widget_has_pick, widget_has_drag and source_at_pointer_position.
--| These are used by On_wm_activate to determine when to raise
--| `Current' to foreground.
--|
--| Revision 1.17.4.66  2001/02/04 19:03:47  pichery
--| Changed implementation export clause due to the use of a state
--| pattern in EV_DIALOG_IMP.
--|
--| Revision 1.17.4.65  2001/02/01 01:50:30  rogers
--| On_get_min_max_info now uses interface.maximum_width and
--| interface.maximum_height. This fixes a bug if you set the maximum
--| height of the window to the current minimum_size and then added a widget.
--| Attempting to then resize the height of the window would cause its
--| position to move.
--|
--| Revision 1.17.4.64  2001/01/27 23:55:22  manus
--| Cosmetics
--| Efficiency of Result assignment
--|
--| Revision 1.17.4.63  2001/01/26 23:32:46  rogers
--| Removed undefinition of on_sys_key_down as this is already done in the
--| ancestor EV_WEL_CONTROL_CONTAINER_IMP.
--|
--| Revision 1.17.4.62  2001/01/21 22:43:23  pichery
--| Added `lock_update' and `unlock_update' to lock graphical updates.
--|
--| Revision 1.17.4.61  2001/01/16 22:33:15  rogers
--| Modified on_wm_mouseactivate to work correctly with drag and drop. Added
--| allow movement which assigns `False' to override_movement.
--|
--| Revision 1.17.4.60  2001/01/16 16:41:54  rogers
--| Fixed widget_has_pick. It now takes into account pebble functions.
--|
--| Revision 1.17.4.59  2001/01/15 18:00:25  rogers
--| Added widget_has_pick which returns trus if the widget under the current
--| pointer_position has pick/drag and drop. On_wm_mouse_activate uses this
--| new feature when deciding whether to raise the window on a right click.
--|
--| Revision 1.17.4.58  2001/01/15 01:39:16  manus
--| Improved behavior of Windows management when you click on them. Now, a window
--| is kept in the back only if you do a right click. Otherwise we always bring
--| it to the front. Doing so fix the famous bug of when you where asking Windows
--| to bring your window to the front nothing happened.
--|
--| Revision 1.17.4.57  2001/01/09 19:03:30  rogers
--| Modified default_process_message to now call the Precursor from
--| EV_SINGLE_CHILD_CONTAINER_IMP. This is necessary as default_process_message
--| is now defined in EV_WIDGET_IMP.e
--|
--| Revision 1.17.4.56  2000/12/29 15:49:22  pichery
--| Removed the WEL_BLOCKING_DISPATCHER. It is now useless
--| with the new implementation for Dialogs.
--| As a consequence, `show' and `hide' are no more redefined.
--| Also Removed the modal_destroy_agent (useless now)
--|
--| Revision 1.17.4.55  2000/12/14 17:27:52  rogers
--| Fixed title so it returns void if the string is empty.
--|
--| Revision 1.17.4.54  2000/12/08 03:11:46  manus
--| Size of window was not stored before applying the new size to its children.
--| As a result some resizing operations done in children where still using
--| the old stored size and behavior was incorrect.
--|
--| Revision 1.17.4.53  2000/11/29 17:58:06  rogers
--| Removed destroy_agent as it is no longer put into the close_actions as
--| default. Added already_destroyed which is used to stop the close_actions
--| being called recursively when you call destroy through the interface
--| but also have destroy in the close_actions.
--|
--| Revision 1.17.4.52  2000/11/28 21:35:19  manus
--| Renamed call to `empty' into `is_empty' as now defined in CONTAINER.
--|
--| Revision 1.17.4.51  2000/11/27 20:19:15  rogers
--| Undefined on_notify as we now use the version inherited from
--| EV_CONTAINER_IMP.
--|
--| Revision 1.17.4.48  2000/11/06 18:01:32  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.17.4.47  2000/11/04 00:56:18  manus
--| New way of setting `is_positioned' from EV_POS_INFO. It is now done when user call
--| `set_x_position' or `set_y_position' in EV_WINDOW_IMP.
--| This fixes the bug where all windows were appearing at the top right corner of the screen.
--|
--| Revision 1.17.4.46  2000/11/03 18:24:34  rogers
--| Fixed bug in window_process_message. If you had two titled windows open,
--| one partially obscuring the other, clicking on the non client area of the
--| obscured window would correctly bring it to the front, but both title bars
--| would now be blue, instead of the far one being grayed out.
--|
--| Revision 1.17.4.45  2000/11/01 01:35:25  rogers
--| Removed all code for accelerator handling. It has been moved to
--| EV_TITLED_WINDOW_IMP as only titled windows recieve accelerator commands.
--|
--| Revision 1.17.4.43  2000/10/27 02:33:46  manus
--| Removed undefinition of `set_default_colors' since the inherited one does what we want.
--|
--| Revision 1.17.4.42  2000/10/26 19:46:28  rogers
--| Removed widget_group and set_widget_group as they are no longer in Vision2.
--|
--| Revision 1.17.4.40  2000/10/18 16:21:44  rogers
--| Compute_minimum_width, compute_minimum_size and compute_minimum_height
--| now all take into account whether the child is visible or not.
--|
--| Revision 1.17.4.39  2000/10/10 23:59:46  raphaels
--| Redefined `has_focus' to behave correctly (would return false although a widget in the window would have the focus)
--| Added `on_desactivate' to list of undefined features from WEL_WINDOW.
--|
--| Revision 1.17.4.38  2000/10/05 20:28:21  manus
--| Removed special notebook handling for `Tab' action. Now it will never stop on tab buttons
--| but this is better than completely loosing the focus.
--|
--| Revision 1.17.4.37  2000/10/05 00:40:25  manus
--| `set_x_position' and `set_y_position' have been redefined to use `ev_move' instead of using
--| the WEL implementation that just calls `move' and therefore does not update `child_cell' with
--| the correct information.
--|
--| Revision 1.17.4.36  2000/10/03 00:16:22  raphaels
--| Removed `Environment' which is now inherited from `EV_WIDGET_I'.
--|
--| Revision 1.17.4.35  2000/09/27 16:09:27  rogers
--| Set_menu_bar and remove_menu_bar now set the parent_imp of the menu_bar.
--|
--| Revision 1.17.4.34  2000/09/22 00:30:50  rogers
--| Assigned True to user_can_resize within initialize.
--|
--| Revision 1.17.4.33  2000/09/13 22:11:59  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.17.4.32  2000/09/07 02:37:55  manus
--| Updated creation and desctruction of WEL frame windows with new code of EV_APPLICATION_IMP
--| that just keep a weak reference on the implementation object and not the interface.
--|
--| Revision 1.17.4.31  2000/08/08 17:00:47  manus
--| No need for compute_minimum_size when showing the window. This will be done automatically
--| by `on_show' before showing the window.
--|
--| Revision 1.17.4.30  2000/08/08 16:03:47  manus
--| Updated inheritance with new WEL messages handling
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--|
--| Revision 1.17.4.29  2000/08/04 20:22:37  rogers
--| All action sequence calls through the interface have been replaced with
--| calls to the internal action sequences.
--|
--| Revision 1.17.4.28  2000/07/26 18:06:52  rogers
--| Initialize now calls close_actions directly instead of interface.close_actions.
--|
--| Revision 1.17.4.27  2000/07/24 23:13:00  rogers
--| Now inherits EV_WINDOW_ACTION_SREQUENCES_IMP.
--|
--| Revision 1.17.4.26  2000/07/17 16:51:43  rogers
--| Added internal_height and internal_width to store values set through
--| set_width and set_height. On_show will now use these values if necessary.
--| This fixes bug when calling hide followed by show.
--|
--| Revision 1.17.4.25  2000/07/17 15:57:26  rogers
--| init_bars is now called at very start of initialize.
--|
--| Revision 1.17.4.24  2000/07/13 17:46:58  rogers
--| Exported menu_bar_height to EV_WIDGET_IMP.
--|
--| Revision 1.17.4.23  2000/07/12 21:27:40  brendel
--| Now creates the upper and lower bar before initializing them, since
--| they are no longer created in the interface class.
--|
--| Revision 1.17.4.22  2000/07/12 16:23:38  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.17.4.21  2000/06/14 22:16:07  rogers
--| Destroy now calls remove_root_window on the implementation of the
--| application. Previously, remove_root_window was defined as deferred
--| in EV_APPLICATION_I upon which it was called.
--|
--| Revision 1.17.4.20  2000/06/13 20:11:02  rogers
--| Removed FIXM NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.17.4.19  2000/06/13 18:38:13  rogers
--| Removed undefintion of remove_command.
--|
--| Revision 1.17.4.18  2000/06/12 20:22:03  pichery
--| Added agent to remove the blocking dispatcher when
--| a modal dialog box is closed.
--|
--| Revision 1.17.4.17  2000/06/05 20:52:58  manus
--| Cosmetic on precursor
--| Call `is_displayed' instead of `is_show_requested' to perform hide/show operation.
--| Redefined `show_with_option' from WEL_FRAME_WINDOW.
--| Use of constant `wel_window_constant.size_restored' instead of `0'.
--| Added `compute_minimum_size' in `show' and `show_with_option' before showing the
--| window so that the window appears correctly the first time we display it.
--|
--| Revision 1.17.4.16  2000/05/23 17:30:53  rogers
--| Redefined insert, so when a widget is added to the window, then it will
--| be shown.
--|
--| Revision 1.17.4.15  2000/05/22 19:12:39  rogers
--| Fixed upper_bar and lower_bar. init_bars is now called during initialize.
--| Set_top_level_window_imp now has a check False to ensure that it is never
--| executed. Fixed client_height to display lower_bar correctly.
--|
--| Revision 1.17.4.14  2000/05/15 21:56:17  rogers
--| Redefined window_process_message to move window into the foreground as
--| required. Redefined on_window_pos_changing, and Added move_to_foreground.
--| These changes are used to stop pick/drag and drop from moving the
--| window to the foreground.
--|
--| Revision 1.17.4.13  2000/05/14 07:39:52  pichery
--| Added the blocking window, improved
--| `show' and `hide' to take into account the
--| blocking window.
--|
--| Revision 1.17.4.12  2000/05/09 22:20:58  brendel
--| Corrected init_bars.
--|
--| Revision 1.17.4.11  2000/05/09 19:24:49  pichery
--| Protected `disable_modal' with `exists' condition.
--| Removed commented feature.
--|
--| Revision 1.17.4.10  2000/05/09 19:02:25  brendel
--| Fixed placement of bars. Still not shown d'oh.
--|
--| Revision 1.17.4.9  2000/05/09 00:55:20  manus
--| Now, when you destroy a window, you remove all children of current window and then
--| destroy it. (Done to be consistent with GTK).
--|
--| Revision 1.17.4.8  2000/05/07 03:45:53  manus
--| Cosmetics on comments.
--| Update to follow the new WEL way to destroy windows. A simple call to
--| `cwin_destroy_window' is enough now.
--|
--| Revision 1.17.4.7  2000/05/04 17:38:22  brendel
--| Improved client_x and client_height, to take into account that a window
--| can be made too small to accomodate for upper_bar and lower_bar.
--|
--| Revision 1.17.4.6  2000/05/04 01:09:25  brendel
--| Changed to now use upper_bar and lower_bar.
--|
--| Revision 1.17.4.5  2000/05/03 22:35:02  brendel
--| Fixed resize_actions.
--|
--| Revision 1.17.4.4  2000/05/03 22:16:27  pichery
--| - Cosmetics / Optimization with local variables
--| - Replaced calls to `width' to calls to `wel_width'
--|   and same for `height'.
--|
--| Revision 1.17.4.3  2000/05/03 19:09:41  oconnor
--| mergred from HEAD
--|
--| Revision 1.46  2000/05/03 00:33:36  pichery
--| - Changed constants retrieval
--| - Changed `show' implementation (does not block
--|   anymore even when `is_modal' is set)
--|
--| Revision 1.45  2000/05/01 19:38:03  pichery
--| Changed the implementation of `enable_modal'
--| and `disable_modal'.
--|
--| Revision 1.44  2000/04/29 00:43:56  brendel
--| Improved status bar resizing.
--|
--| Revision 1.43  2000/04/28 23:39:42  brendel
--| Fixed some status bar code. Not quite there yet, though.
--|
--| Revision 1.42  2000/04/28 22:13:30  brendel
--| Commented out statusbar code.
--|
--| Revision 1.41  2000/04/28 21:43:35  brendel
--| Replaced EV_STATUS_BAR with EV_WIDGET.
--|
--| Revision 1.40  2000/04/26 21:01:29  brendel
--| child -> item or item_imp.
--|
--| Revision 1.39  2000/04/20 18:29:24  brendel
--| Moved all close/destroy related features to same place.
--| Does not call wel_destroy anymore, because wel would quit when
--| this window was the application main window and Vision2 does not
--| have such a concept.
--|
--| Revision 1.38  2000/04/20 16:30:20  brendel
--| Moved accelerator code into here.
--| enable_modal and disable_modal still not implemented. See code.
--|
--| Revision 1.37  2000/04/19 00:43:05  brendel
--| Revised.
--|
--| Revision 1.36  2000/04/17 23:40:41  brendel
--| Reverted.
--|
--| Revision 1.35  2000/04/17 17:36:08  brendel
--| Resize agent is now ~integrate_changes.
--|
--| Revision 1.34  2000/04/03 16:40:34  rogers
--| Added on_wm_close_executed.
--|
--| Revision 1.33  2000/03/29 19:12:30  pichery
--| changed `enable_modal' & `disable_modal' to avoid them to capture
--| the mouse with the "heavy" method which should be reserved to the
--| pick&drop.
--|
--| Revision 1.32  2000/03/21 02:29:39  brendel
--| Removed old command code.
--|
--| Revision 1.31  2000/03/17 18:22:23  rogers
--| The following features are now also exported to EV_WIDGET_IMP: title_height, frame_height, frame_width, border_width.
--|
--| Revision 1.30  2000/03/16 21:13:34  brendel
--| Calls {EV_APPLICATION_IMP}.remove_root_window directly.
--|
--| Revision 1.29  2000/03/14 19:59:44  brendel
--| Removed some commented out code.
--|
--| Revision 1.28  2000/03/14 03:02:55  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.27.2.3  2000/03/14 00:08:59  brendel
--| Reworked idle handler. Now uses {EV_APPLICATION_IMP}.do_once_on_idle.
--|
--| Revision 1.27.2.2  2000/03/11 00:18:05  brendel
--| Added redefinition of notify_change, that recomputes the minimum sizes.
--| Renamed move_and_resize, move, resize to wel_*.
--| Added function request_resize that puts a function into
--| {EV_APPLICATION}.internal_idle_actions. The handler `resize_on_idle' is
--| not yet finished.
--|
--| Revision 1.27.2.1  2000/03/09 21:39:48  brendel
--| Replaced x with x_position and y with y_position.
--| Before, both were available.
--|
--| Revision 1.27  2000/02/29 22:15:54  rogers
--| In on_wm_close, after calling the events, now set_default_processing (False)  to stop windows automatically closing the window, or exiting the application.
--|
--| Revision 1.26  2000/02/29 19:24:40  rogers
--| Connected the move_actions.
--|
--| Revision 1.25  2000/02/29 18:04:43  rogers
--| Removed closeable, redefined last_call_was_destroy, which should only be a temporary solution, as it turns off the checking of no_calls_after_destroy for EV_WINDOW_IMP, EV_TITLED_WINDOW_IMP and EV_DIALOG_IMP. Now call the new events from on_wm_close. Removed set_horizontal_resize and set_vertical_resize. in destroy, remove_root_window is now called.
--|
--| Revision 1.24  2000/02/23 02:25:28  brendel
--| Now redefines on_menu_command to propagate the given `id' to the menu-bar,
--| assuming that it has one when this feature is called.
--|
--| Revision 1.23  2000/02/22 20:15:15  rogers
--| Removed FIXME on set_parent as this has always worked correctly, and the FIXME was added mistakenly.
--|
--| Revision 1.22  2000/02/22 18:21:01  pichery
--| added 4 times the same small hack with `wel_parent' in order to
--| avoid a Segmentation Violation with EiffelBench 4.6.008
--|
--| Revision 1.21  2000/02/19 06:34:12  oconnor
--| removed old command stuff
--|
--| Revision 1.20  2000/02/19 05:53:52  oconnor
--| released
--|
--| Revision 1.19  2000/02/14 11:40:43  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.17.4.1.2.14  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.17.4.1.2.13  2000/02/07 20:00:13  rogers
--| On_size now uses the new event system. Commented out implementation of closeable temporarily until fixed.
--|
--| Revision 1.17.4.1.2.12  2000/02/05 02:18:00  brendel
--| Changed type of feature `status_bar' to be of type EV_STATUS_BAR.
--|
--| Revision 1.17.4.1.2.11  2000/02/04 19:22:58  brendel
--| Implemented set_menu_bar and remove_menu_bar.
--|
--| Revision 1.17.4.1.2.10  2000/02/04 19:08:29  rogers
--| Removed make_with_owner.
--|
--| Revision 1.17.4.1.2.9  2000/02/04 01:00:43  brendel
--| Added *menu_bar features. Not yet implemented.
--|
--| Revision 1.17.4.1.2.8  2000/01/29 01:05:03  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.17.4.1.2.7  2000/01/27 19:30:23  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.17.4.1.2.6  2000/01/26 18:35:09  brendel
--| Removed all modal-related features.
--|
--| Revision 1.17.4.1.2.5  2000/01/25 17:37:52  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.17.4.1.2.4  2000/01/21 23:18:46  brendel
--| Renamed set_capture to enable_capture.
--| Renamed release_capture to disable_capture.
--|
--| Revision 1.17.4.1.2.3  2000/01/18 00:25:47  rogers
--| Undefined propagatae_foreground_color and propagate_background_color from EV_WINDOW_I. Re-implemented closeable.
--|
--| Revision 1.17.4.1.2.2  1999/12/17 00:48:45  rogers
--| Altered to fit in with the review branch. Some redefinitions required. is_show_requested replaces shown. Make now takes an interface.
--|
--| Revision 1.17.4.1.2.1  1999/11/24 17:30:29  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.17.2.3  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
