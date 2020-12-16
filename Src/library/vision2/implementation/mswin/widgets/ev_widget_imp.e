note
	description: "[
		EiffelVision widget, mswindows implementation.

		Note:
		1 - The parent of a widget cannot be void, except for a
			window. Therefore, each feature that call the parent
			here need to be redefine by EV_TITLED_WINDOW to check if
			parent is `Void'.
		2 - The current class would be the equivalent of a wel_window
			Yet, it doesn't inherit from wel_window. Then, all the
			feature we used are defined as deferred. They will be
			implemented directly by the heirs thanks to inheritance
			from a heir of wel_window.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET_IMP

inherit
	EV_WIDGET_I
		redefine
			interface
		end

	EV_SIZEABLE_IMP
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_IMP
		redefine
			interface, enable_capture, disable_capture
		end

	EV_DOCKABLE_SOURCE_IMP
		redefine
			interface
		end

	EV_WIDGET_ACTION_SEQUENCES_I

	EV_WEL_KEY_CONVERSION
		rename
			Key_down as Key_down_arrow,
			Key_up as Key_up_arrow
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			initialize_sizeable
			set_default_minimum_size
			if is_shown_by_default then
				show
			end
			set_is_initialized (True)
		end

feature -- Basic Operations

	refresh_now
			-- Refresh now.
		do
			update
		end

feature -- Access

	pointer_position: EV_COORDINATE
			-- Position of the screen pointer relative to `Current'.
		local
			wel_point: WEL_POINT
		do
			create wel_point.make (0, 0)
			wel_point.set_cursor_position
			create Result.set (wel_point.x - screen_x, wel_point.y -
				screen_y)
		end

	pointer_style: detachable EV_POINTER_STYLE
			-- Pointer displayed when the pointing device is over `Current'.
		do
			Result := cursor_pixmap
		end

	background_color_internal: detachable EV_COLOR
			-- Color used for the background of `Current'.
		do
			if attached background_color_imp as l_background_color_imp then
				Result := l_background_color_imp.attached_interface
			else
				Result := application_imp.stock_colors.default_background_color
			end
		end

	foreground_color_internal: detachable EV_COLOR
			-- Color used for the foreground of `Current'.
		do
			if attached foreground_color_imp as l_foreground_color_imp then
				Result := l_foreground_color_imp.attached_interface
			else
				Result := application_imp.stock_colors.default_foreground_color
			end
		end

	top_level_window: detachable EV_WINDOW
			-- Top level window that contains `Current'.
		do
			if attached top_level_window_imp as l_top_level_window_imp then
				Result ?= l_top_level_window_imp.attached_interface
			end
		end

	Default_parent: EV_INTERNAL_SILLY_WINDOW_IMP
			-- A default parent for creation of `Current'.
		once
			create Result.make_top ("Eiffel Vision default parent window")
		ensure
			valid_parent: Result /= Void
		end

	Focus_on_widget: CELL [detachable EV_WIDGET_IMP]
			-- Widget that has currently the focus.
		once
			create Result.put (Void)
		end

	Cursor_on_widget: CELL [detachable EV_WIDGET_IMP]
			-- This cell contains the widget_imp that currently
			-- has the pointer of the mouse. As it is a once
			-- feature, it is a shared data.
			-- it is used for the `mouse_enter' and `mouse_leave'
			-- events.
			--| The mouse leave event has been fixed so that it no longer
			--| requires a mouse motion event in a widget belonging to the
			--| current application. The implementation is still using this
			--| feature although it could now just use a boolean. The downside
			--| to using a boolean is that it would also require setting
			--| functions as the boolean would be returned by a once, as this
			--| function does. This is why for now this has not been changed,
			--| but just used. Julian 01/09/01
		once
			create Result.put (Void)
		ensure then
			result_exists: Result /= Void
		end

	parent: detachable EV_CONTAINER
			-- Parent of `Current'
		local
			l_parent_imp: like parent_imp
		do
			l_parent_imp := parent_imp
			if l_parent_imp /= Void then
				Result := l_parent_imp.interface
			end
		end

	wel_width: INTEGER
		deferred
		end

	width: INTEGER
			-- Width of `Current'.
		do
			Result := minimum_width.max (ev_width)
		end

	wel_height: INTEGER
		deferred
		end

	height: INTEGER
			-- Height of `Current'.
		do
			Result := minimum_height.max (ev_height)
		end

	screen_x: INTEGER
			-- Horizontal offset of `Current' relative to screen
		local
			l_wind: detachable EV_WINDOW_IMP
			l_parent: like parent_imp
		do
			if is_displayed then
				Result := absolute_x
			else
				l_parent := parent_imp
				if l_parent /= Void and then not l_parent.is_destroyed then
					Result := x_position + l_parent.screen_x
					l_wind := top_level_window_imp
					if l_parent = l_wind then
						check l_wind /= Void then end
							-- Parent is a window, since `screen_y' for a window gives
							-- the coordinate of the top left corner of the window within
							-- the screen, we need to add the the frame and the border
							-- to get the right screen coordinates for Current.
						Result := Result + l_wind.frame_width
					end
				end
			end
		end

	screen_y: INTEGER
			-- Vertical offset of `Current' relative to screen.
		local
			l_wind: detachable EV_WINDOW_IMP
			l_parent: like parent_imp
		do
			if is_displayed then
				Result := absolute_y
			else
				l_parent := parent_imp
				if l_parent /= Void and then not l_parent.is_destroyed then
					Result := y_position + l_parent.screen_y
					l_wind := top_level_window_imp
					if l_wind = l_parent then
						check l_wind /= Void then end
							-- Parent is a window, since `screen_y' for a window gives
							-- the coordinate of the top left corner of the window within
							-- the screen, we need to add the title bar if any, the frame,
							-- and the menu bar if any to get the right screen coordinates
							-- for Current.
						Result := Result + l_wind.title_height + l_wind.frame_height
						if l_wind.has_menu then
							Result := Result + l_wind.menu_bar_height
						end
					end
				end
			end
		end

	x_position: INTEGER
			-- `Result' is x_position of `Current' in pixels.
			-- If `wel_parent' not Void then `Result' is relative to `wel_parent' else
			-- `Result' is relative to screen.
			--| This has been redefined as the version from WEL_WINDOW would not return
			--| Correct result if `Current' is contained in a split area.
		local
			rect: WEL_RECT
			point: WEL_POINT
		do
			if is_show_requested then
				if attached wel_parent as l_wel_parent then
					rect := window_rect
					create point.make (rect.x, rect.y)
					point.screen_to_client (l_wel_parent)
					Result := point.x
				else
					Result := absolute_x
				end
			else
				Result := child_cell.x
			end
		end

	y_position: INTEGER
			-- `Result' is x_position of `Current' in pixels.
			-- If `wel_parent' not Void then `Result' is relative to `wel_parent' else
			-- `Result' is relative to screen.
			--| This has been redefined as the version from WEL_WINDOW would not return
			--| Correct result if `Current' is contained in a split area.
		local
			rect: WEL_RECT
			point: WEL_POINT
		do
			if is_show_requested then
				if attached wel_parent as l_wel_parent then
					rect := window_rect
					create point.make (rect.x, rect.y)
					point.screen_to_client (l_wel_parent)
					Result := point.y
				else
					Result := absolute_y
				end
			else
				Result := child_cell.y
			end
		end

feature -- Status report

	destroyed: BOOLEAN
			-- Is `Current' destroyed ?
		do
			Result := not exists
		end

	is_show_requested: BOOLEAN
			-- Is `Current' displayed in its parent?
		do
			Result := flag_set (style, {WEL_WINDOW_CONSTANTS}.Ws_visible)
		end

	managed: BOOLEAN = true
		-- All widgets are managed.

	has_capture: BOOLEAN
			-- Does `Current' have capture?
		do
			if has_heavy_capture or wel_has_capture then
				Result := True
			end
		end

	has_heavy_capture: BOOLEAN
			-- Does `Current' have heavy capture?
		deferred
		end

	wel_has_capture: BOOLEAN
			-- Does `Current' have a windows capture?
		deferred
		end

feature -- Status setting

	destroy
			-- Destroy `Current', but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if attached parent_imp as l_parent_imp then
				l_parent_imp.attached_interface.prune (attached_interface)
			end
			wel_destroy
			set_is_destroyed (True)
		end

	show
			-- Show `Current'.
			-- Need to notify the parent.
		local
			p_imp: like parent_imp
		do
			show_window (wel_item, {WEL_WINDOW_CONSTANTS}.Sw_show)
			p_imp := parent_imp
			if p_imp /= Void then
				p_imp.notify_change (Nc_minsize, attached_interface.implementation, False)
			end
		end

	hide
			-- Hide `Current'.
		local
			p_imp: like parent_imp
		do
			show_window (wel_item, {WEL_WINDOW_CONSTANTS}.Sw_hide)
			p_imp := parent_imp
			if p_imp /= Void then
				p_imp.notify_change (Nc_minsize, Current, False)
			end
		end

	parent_is_sensitive: BOOLEAN
			-- Is parent of `Current' sensitive?
		do
			Result := attached parent_imp as l_parent_imp and then l_parent_imp.is_sensitive
		end

	has_parent: BOOLEAN
			-- Is `Current' parented?
		do
			Result := parent_imp /= Void
		end

	disable_sensitive
			-- Set `Current' to insensitive mode.
			-- This means that any events with an
			-- event type of KeyPress, KeyRelease,
			-- ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or
			-- FocusOut will not be dispatched to current
			-- widget and to all its children.  Set it to
			-- sensitive mode otherwise.
		do
			disable
		end

	enable_sensitive
			-- Set `Current' to sensitive mode.
			--| See comment for `disable_sensitive'.
		do
			enable
		end

	set_default_minimum_size
			-- Initialize the size of `Current'.
			-- Redefined by many widgets.
		do
			ev_set_minimum_size (0, 0, False)
		end

	enable_capture
			-- Enable capture.
			--| Accessible through the interface of widget.
		do
			if not has_capture then
				Precursor {EV_PICK_AND_DROPABLE_IMP}
				application_imp.set_captured_widget (interface)
			end
		end

	disable_capture
			-- Release all user events.
		do
			if has_capture then
				Precursor {EV_PICK_AND_DROPABLE_IMP}
				application_imp.set_captured_widget (Void)
			end
		end

feature -- Element change

	set_default_colors
			-- Set foreground and background color to their default values.
		do
			background_color_imp := Void
			foreground_color_imp := Void
			if is_displayed then
					-- If the widget is not hidden then invalidate.
				invalidate
			end
		end

	set_parent_imp (par: detachable EV_CONTAINER_IMP)
			-- Make `par' the new parent of `Current'.
			-- `par' can be Void then the parent is
			-- `Default_parent'.
		deferred
		end

	set_background_color (color: EV_COLOR)
			-- Make `color' the new `background_color'
		do
			if background_color_imp /= color.implementation then
				background_color_imp ?= color.twin.implementation
				if is_displayed then
					-- If the widget is not hidden then invalidate.
					invalidate
				end
			end
		end

	set_foreground_color (color: EV_COLOR)
			-- Make `color' the new `foreground_color'
		do
			if foreground_color_imp /= color.implementation then
				foreground_color_imp ?= color.twin.implementation
				if is_displayed then
					-- If the widget is not hidden then invalidate.
					invalidate
				end
			end
		end

feature -- Event handling

	init_file_drop_actions (a_file_drop_actions: like file_drop_actions)
			-- Create and initialize
		do
			a_file_drop_actions.not_empty_actions.extend (agent enable_drag_accept_files)
			a_file_drop_actions.empty_actions.extend (agent disable_drag_accept_files)
		end

	init_resize_actions (a_resize_actions: like resize_actions)
		do
		end

	init_dpi_changed_actions (a_dpi_changed_actions: like dpi_changed_actions)
		do
		end

feature {EV_CONTAINER_IMP, EV_PRIMITIVE_IMP, EV_INTERNAL_COMBO_BOX_IMP, EV_WEL_CONTROL_CONTAINER_IMP, EV_THEME_DRAWER_IMP, EV_WIDGET_IMP} -- Implementation

	background_color_imp: detachable EV_COLOR_IMP
			-- Color used for the background of `Current'.

	foreground_color_imp: detachable EV_COLOR_IMP
			-- Color used for the foreground of `Current'
			-- usually the text.

	parent_imp: detachable EV_CONTAINER_IMP
			-- Parent container of `Current'.
		do
			Result ?= wel_parent
				-- `default_parent' is not a descendent of EV_CONTAINER_IMP so Result will be void on assignment attempt.
		end

feature {NONE} -- Implementation, mouse_button_events

	call_pointer_actions (
		actions: detachable EV_POINTER_BUTTON_ACTION_SEQUENCE;
		a_x, a_y, s_x, s_y, button: INTEGER)
			-- If `actions' not `Void' call with
			-- `a_x', `a_y', `s_x', `s_y', and `button'.
		do
			if actions /= Void then
				actions.call ([a_x, a_y, button, 0.0, 0.0, 0.0, s_x, s_y])
			end
		end

	on_button_down (x_pos, y_pos, button: INTEGER)
			-- Executed when the a button is pressed.
		local
			t: like translate_coordinates
			actions_called: BOOLEAN
		do
			--| `pointer_button_press_actions_internal' must be called before
			--| a pick and drop starts, but after a pick and drop ends.
			t := translate_coordinates (x_pos, y_pos)
			if not is_dnd_in_transport and not is_pnd_in_transport and not is_dock_executing then
				if application_imp.pointer_button_press_actions_internal /= Void then
					application_imp.pointer_button_press_actions.call ([attached_interface, button, t.screen_x, t.screen_y])
				end
				call_pointer_actions (pointer_button_press_actions_internal, t.x, t.y, t.screen_x, t.screen_y, button)
				actions_called := True
			end
			if not is_destroyed and then attached_interface.is_dockable then
				dragable_press (t.x, t.y, button, t.screen_x, t.screen_y)
			end
				-- `widget_source_being_dragged' is not Void, if a docking
				-- transport just started. There is no need to now call
				-- `pnd_press' as docking will override drag and drop.
			if not is_destroyed and not is_dock_executing then
					-- We do not call the user actions regardless of them having been called or not.
				actions_called := actions_called or press_action = ev_pnd_end_transport
				pnd_press (t.x, t.y, button, t.screen_x, t.screen_y)
			end
			if not actions_called then
				if application_imp.pointer_button_press_actions_internal /= Void then
					application_imp.pointer_button_press_actions.call ([attached_interface, button, t.screen_x, t.screen_y])
				end
				call_pointer_actions (pointer_button_press_actions_internal, t.x, t.y, t.screen_x, t.screen_y, button)
			end
		end

	on_button_up (x_pos, y_pos, button: INTEGER)
			-- Executed when the a button is pressed.
		local
			t: like translate_coordinates
		do
			if motion_action /= ev_pnd_execute then
				t := translate_coordinates (x_pos, y_pos)
				if application_imp.pointer_button_release_actions_internal /= Void then
					application_imp.pointer_button_release_actions.call ([attached_interface, button, t.screen_x, t.screen_y])
				end
				call_pointer_actions (pointer_button_release_actions_internal, t.x, t.y, t.screen_x, t.screen_y, button)
			end
		end

	on_button_double_click (x_pos, y_pos, button: INTEGER)
			-- Executed when the a button is pressed.
		local
			t: like translate_coordinates
			actions_called: BOOLEAN
		do
			t := translate_coordinates (x_pos, y_pos)
			if not is_dnd_in_transport and not is_pnd_in_transport then
				if application_imp.pointer_double_press_actions_internal /= Void then
					application_imp.pointer_double_press_actions.call ([attached_interface, button, t.screen_x, t.screen_y])
				end
				call_pointer_actions (pointer_double_press_actions_internal, t.x, t.y, t.screen_x, t.screen_y, button)
				actions_called := True
			end

			actions_called := actions_called or press_action = ev_pnd_end_transport
			pnd_press (t.x, t.y, button, t.screen_x, t.screen_y)

			if not actions_called then
				if application_imp.pointer_double_press_actions_internal /= Void then
					application_imp.pointer_double_press_actions.call ([attached_interface, button, t.screen_x, t.screen_y])
				end
				call_pointer_actions (pointer_double_press_actions_internal, t.x, t.y, t.screen_x, t.screen_y, button)
			end
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER)
			-- Executed when the left button is pressed.
		do
				-- If this button press will end a pick and drop
				-- then we disable the default windows processing
				-- for `Current'.
			if is_pnd_in_transport then
				disable_default_processing
			end
			on_button_down (x_pos, y_pos, 1)
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER)
			-- Executed when the middle button is pressed.
		do
			on_button_down (x_pos, y_pos, 2)
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER)
			-- Executed when the right button is pressed.
		do
			on_button_down (x_pos, y_pos, 3)
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER)
			-- Executed when the left button is released.
		do
			check_drag_and_drop_release (x_pos, y_pos)
			on_button_up (x_pos, y_pos, 1)
			check_dragable_release (x_pos, y_pos)
		end

	on_middle_button_up (keys, x_pos, y_pos: INTEGER)
			-- Executed when the middle button is released.
		do
			on_button_up (x_pos, y_pos, 2)
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER)
			-- Executed when the right button is released.
		do
			on_button_up (x_pos, y_pos, 3)
		end

	on_left_button_double_click (keys, x_pos, y_pos: INTEGER)
			-- Executed when the left button is double clicked.
		do
			on_button_double_click (x_pos, y_pos, 1)
		end

	on_middle_button_double_click (keys, x_pos, y_pos: INTEGER)
			-- Executed when the middle button is double clicked.
		do
			on_button_double_click (x_pos, y_pos, 2)
		end

	on_right_button_double_click (keys, x_pos, y_pos: INTEGER)
			-- Executed when the right button is double clicked.
		do
			on_button_double_click (x_pos, y_pos, 3)
		end

feature {NONE} -- Implementation

	default_process_message (msg: INTEGER; wparam, lparam: POINTER)
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
			if msg = ({WEL_WINDOW_CONSTANTS}.Wm_mouseleave) then
				on_mouse_leave
				Cursor_on_widget.put (Void)
			end
		end

	client_to_screen (a_x, a_y: INTEGER): WEL_POINT
			-- Absolute screen coordinates in pixels
			-- of coordinates `a_x', a_y' on `Current'.
		local
			ww: detachable WEL_WINDOW
		do
			create Result.make (a_x, a_y)
			ww ?= Current
			check
				wel_window_not_void: ww/= Void then
			end
			Result.client_to_screen (ww)
		end

	translate_coordinates (a_x, a_y: INTEGER): TUPLE [x, y, screen_x, screen_y: INTEGER]
			-- For `a_x', `a_y', give actual x and y and screen x and y.
			-- By default, actual x and y are the same as `a_x', `a_y'.
			-- Redefined in EV_PIXMAP_IMP_WIDGET.
		local
			pt: WEL_POINT
		do
			pt := client_to_screen (a_x, a_y)
			Result := [a_x, a_y, pt.x, pt.y]
		end

	track_mouse_event (info: WEL_TRACK_MOUSE_EVENT): BOOLEAN
		deferred
		end

	is_dockable_source (x_pos, y_pos: INTEGER): BOOLEAN
			-- Is current `enabled as dockable?
			-- Redefined in descendents such as EV_TOOL_BAR_IMP to
			-- handle items.
		do
			Result := is_dockable
		end


	on_mouse_move (keys, x_pos, y_pos: INTEGER)
			-- Executed when the mouse move.
		local
			t: like translate_coordinates
			track_mouse: WEL_TRACK_MOUSE_EVENT
			track_mouse_successful: BOOLEAN
			l_last_coords_updated: BOOLEAN
		do
				--| We check the position of the cursor, as when in a pick and
				--| drop, `cursor_on_widget' is `Void' meaning every time the
				--| mouse moves while not over the original widget for the pick,
				--| the enter and leave actions are fired.
			if
				cursor_on_widget.item = Void and x_pos >= 0 and y_pos >= 0 and
				x_pos <= width and y_pos <= height
			then
					-- Create a WEL_TRACK_MOUSE_EVENT structure so
					-- we will receive the Wm_mouse_leave notification
					-- message when the pointer leaves `Current'.
				create track_mouse.make
				track_mouse.set_hwndtrack (wel_item)
				track_mouse.set_dwflags ({WEL_TME_CONSTANTS}.tme_leave)
				track_mouse_successful := track_mouse_event (track_mouse)
				check
					mouse_successfully_tracking: track_mouse_successful = True
				end

				on_mouse_enter
				Cursor_on_widget.replace (Current)
				track_mouse.dispose
			end
			t := translate_coordinates (x_pos, y_pos)
			l_last_coords_updated := t.x /= last_x or else t.y /= last_y
			if l_last_coords_updated then
					-- Store last_x coords
				last_x := t.x
				last_y := t.y
			end
			if
				(awaiting_movement and is_dockable_source (x_pos, y_pos)) or
				application_imp.dockable_source /= Void
			then
				dragable_motion (t.x, t.y, t.screen_x, t.screen_y)
			elseif
				(is_transport_enabled and mode_is_drag_and_drop) or
				(mode_is_pick_and_drop and is_pnd_in_transport)
			then
					-- Only start a pick and drop if a dock is not currently executing.
					-- It may have been started by the previous call to `dragable_motion'.
				if l_last_coords_updated or awaiting_movement then
					pnd_motion (t.x, t.y, t.screen_x, t.screen_y)
				end
			end
			if application_imp.pointer_motion_actions_internal /= Void then
				if l_last_coords_updated then
					application_imp.pointer_motion_actions.call ([attached_interface, t.screen_x, t.screen_y])
				end
			end
			if pointer_motion_actions_internal /= Void then
				if l_last_coords_updated then
					pointer_motion_actions.call ([t.x, t.y, 0.0, 0.0, 0.0, t.screen_x, t.screen_y ])
				end
			end
		end

	last_x, last_y: INTEGER
			-- Last x, y.

	on_mouse_enter
			-- Called when the mouse enters `Current'.
		do
			if pointer_enter_actions_internal /= Void then
				pointer_enter_actions_internal.call (Void)
			end
		end

feature {EV_WIDGET_IMP} -- Implementation

	on_mouse_leave
			-- Called when the mouse leaves `Current'.
			-- This is called by the WEL_TRACK_MOUSE_EVENT instantiated
			-- in on_mouse_move.
		do
				-- Reset `last_x' and `last_y' to negative value, so that the code
				-- using them in `on_mouse_move' will cause the `pointer_motion_actions'
				-- to be called when coming back to the widget.
			last_x := -1
			last_y := -1
			if pointer_leave_actions_internal /= Void then
				pointer_leave_actions_internal.call (Void)
			end
		end

feature {EV_DIALOG_IMP_COMMON} -- Implementation

	process_standard_key_press (virtual_key: INTEGER)
			-- Process key press represented by `virtual_key'.
		local
			key: EV_KEY
			l_top_level_window_imp: detachable EV_WINDOW_I
			l_current: EV_WIDGET_I
			l_pnd_finished: BOOLEAN
			l_disable_default_processing: BOOLEAN
			l_accel: detachable EV_ACCELERATOR
		do
				-- If escape or tab has been pressed then end pick and drop.
				--| This is to stop the user from ever using Alt + tab

				--| to switch between applications while in PND.
			if virtual_key = vk_menu or virtual_key = vk_escape then
				l_pnd_finished := transport_executing
				escape_pnd
			end
			if not l_pnd_finished and valid_wel_code (virtual_key) then
				create key.make_with_code (key_code_from_wel (virtual_key))

				l_disable_default_processing := disable_default_processing_on_key (key)

				if not l_disable_default_processing and then propagate_key_event_to_toplevel_window (True) then
						-- Propagate key event to top level window
					l_top_level_window_imp ?= top_level_window_imp
					l_current := Current
					if l_top_level_window_imp /= Void then
						if l_top_level_window_imp /= l_current then
							l_top_level_window_imp.key_press_actions.call ([key])
						end
						l_accel := accelerator_from_key_code (key.code)
						if l_accel /= Void then
								-- We have found an accelerator to execute.
								-- Add to the idle actions so that it gets fired during no activity.
							application_imp.do_once_on_idle (agent (l_accel.actions).call (Void))

								-- Disable all default processing if an accelerator is being fired.
							l_disable_default_processing := True
						end
					end
				end
				if application_imp.key_press_actions_internal /= Void then
					application_imp.key_press_actions.call ([attached_interface, key])
				end
				if key_press_actions_internal /= Void then
					key_press_actions.call ([key])
				end
				if virtual_key = vk_return and then not l_disable_default_processing then
						-- Fire `select_actions' on Current widget if it is the expected
						-- behavior. For now, only EV_BUTTON_IMP instances do that.
					fire_select_actions_on_enter
				end
				if l_disable_default_processing then
					disable_default_processing
				elseif is_tabable_from and then not l_disable_default_processing then
					process_navigation_key (virtual_key)
				end
			end
		end

	accelerator_from_key_code (a_key_code: INTEGER): detachable EV_ACCELERATOR
			-- Return accelerator from current key pressed if any.
		require
			a_key_code_valid: a_key_code > 0
		local
			l_accel_list: HASH_TABLE [EV_ACCELERATOR, INTEGER_32]
			l_accel: EV_ACCELERATOR
			l_accel_imp: detachable EV_ACCELERATOR_IMP
			l_top_level_window_imp: like top_level_window_imp
		do
			l_top_level_window_imp := top_level_window_imp
			if l_top_level_window_imp /= Void then
				l_accel_list := l_top_level_window_imp.accel_list
				if l_accel_list.count > 0 then
						-- We have accelerators so we need to check if one needs to be fired.
					l_accel_list.start
					if not l_accel_list.after then
						l_accel := l_accel_list.item_for_iteration
						if l_accel /= Void then
							l_accel_imp ?= l_accel.implementation
							check l_accel_imp /= Void then end
								-- Search for an accelerator based on current key combinations.
							Result := l_accel_list.item (l_accel_imp.hash_code_function (a_key_code, application_imp.ctrl_pressed, application_imp.alt_pressed, application_imp.shift_pressed))
						end
					end
				end
			end
		end

	process_standard_key_release (virtual_key: INTEGER)
			-- Process key release represented by `virtual_key'.
		local
			key: EV_KEY
			l_top_level_window_imp: detachable EV_WINDOW_I
			l_current: EV_WIDGET_I
			l_disable_default_processing: BOOLEAN
			l_app_imp: like application_imp
		do
			if valid_wel_code (virtual_key) then
				create key.make_with_code (key_code_from_wel (virtual_key))

				l_disable_default_processing := disable_default_processing_on_key (key)

				if not l_disable_default_processing and then propagate_key_event_to_toplevel_window (False) then
					l_top_level_window_imp ?= top_level_window_imp
					l_current := Current
					if l_top_level_window_imp /= Void and then l_current /= l_top_level_window_imp then
						l_top_level_window_imp.key_release_actions.call ([key])
					end
				end
				l_app_imp := application_imp
				if l_app_imp.key_release_actions_internal /= Void then
					l_app_imp.key_release_actions.call ([attached_interface, key])
				end
				if key_release_actions_internal /= Void then
					key_release_actions_internal.call ([key])
				end
				if l_disable_default_processing then
					disable_default_processing
				end
			end
		end

	propagate_key_event_to_toplevel_window (is_pressed: BOOLEAN): BOOLEAN
			-- Should we propagate a key event if `Current' is parented in a dialog?
			-- If `is_pressed', then it is a key_press event, otherwise a key_release event.
		do
			Result := True
		end

	fire_select_actions_on_enter
			-- Call `select_actions' to respond to `Enter' key press if
			-- Current supports it.
		do
		end

	tab_action (direction: BOOLEAN)
			-- Go to the next widget that takes the focus through to the tab
			-- key. If `direction' it goes to the next widget otherwise,
			-- it goes to the previous one.
		local
			hwnd: POINTER
			window: detachable WEL_WINDOW
			l_top: like top_level_window_imp
		do
			l_top := top_level_window_imp
			if l_top /= Void then
				hwnd := next_dlgtabitem (l_top.wel_item, wel_item, direction)
				if hwnd /= default_pointer then
					if hwnd /= wel_item then
							-- Don't do anything if search returns `Current'.
						window := window_of_item (hwnd)
						if window /= Void then
								-- Set, then reset, {EV_APPLICATION_I}.current_tab_navigation_state.
							if direction then
								application_implementation.set_tab_navigation_state ({EV_APPLICATION_I}.tab_state_from_previous)
							else
								application_implementation.set_tab_navigation_state ({EV_APPLICATION_I}.tab_state_from_next)
							end
							window.set_focus
							application_implementation.set_tab_navigation_state ({EV_APPLICATION_I}.tab_state_none)
						end
					end
				end
			end
		end

	process_navigation_key (virtual_key: INTEGER)
			-- Process a tab or arrow key press to give the focus to the next
			-- widget. Need to be called in the feature on_key_down when the
			-- control needs to process this kind of keys.
		do
			if
				virtual_key = ({WEL_INPUT_CONSTANTS}.Vk_tab) and then
				flag_set (style, {WEL_WINDOW_CONSTANTS}.Ws_tabstop)
			then
				tab_action (not key_down ({WEL_INPUT_CONSTANTS}.Vk_shift))
			end
		end

	is_tabable_from: BOOLEAN
			-- Can current widget be used as a starting point for key navigation
		do
			Result := True
		end

feature {NONE} -- Implementation

	ignore_character_code (a_char_code: INTEGER): BOOLEAN
			-- Should default processing for `a_char_code' be cancelled?
		do
				-- By default we ignore default processing for the Enter key.
				-- This prevents unnecessary system beeps in some controls.
			Result := a_char_code = 13
		end

	on_key_down (virtual_key, key_data: INTEGER)
			-- Executed when a key is pressed.
		do
			process_standard_key_press (virtual_key)
		end

	on_sys_key_down (virtual_key, key_data: INTEGER)
			-- Executed when a system key is pressed.
		do
			process_standard_key_press (virtual_key)
		end

	on_sys_key_up (virtual_key, key_data: INTEGER)
		do
			process_standard_key_release (virtual_key)
		end

	on_key_up (virtual_key, key_data: INTEGER)
			-- Executed when a key is released.
		do
			process_standard_key_release (virtual_key)
		end

	on_char (character_code, key_data: INTEGER)
			-- Executed when a key is pressed.
			--| Now outputs all displayable characters, previously
			--| depended on process_standard_key returning a valid EV_KEY.
		require
			exists: exists
		local
			character_string: STRING_32
			l_char: CHARACTER_32
			l_key: detachable EV_KEY
			l_code: INTEGER_32
			l_ignore_event: BOOLEAN
		do
			if character_code = 13 then
					-- On Windows, the Enter key gives us "%R" but we need to
					-- substitute this with "%N" which is the Eiffel newline character.
				l_char := '%N'
			else
				l_char := character_code.as_natural_32.to_character_32
			end
			create character_string.make(1)
			character_string.append_character (l_char)
			inspect
				character_code
			when 8, 27, 127 then
				-- Do not fire `key_press_string_actions' if Backspace, Esc or del
				-- are pressed as they are not displayable characters.
				l_ignore_event := True
			else
					-- Process char event
				l_ignore_event := False
			end


			l_code := {WEL_API}.vk_key_scan (l_char) & 0xFF
				-- Mask out any control key values in the upper bit.
			if l_code /= -1 and then valid_wel_code (l_code) then
				if default_key_processing_handler /= Void then
					create l_key.make_with_code (key_code_from_wel (l_code))
				end
					-- Ignore string event should an accelerator be valid.
				if not l_ignore_event then
					l_ignore_event := accelerator_from_key_code (key_code_from_wel (l_code)) /= Void
				end
			end

				-- Check to see if default processing should be disabled.
			if
				(l_key /= Void and then attached default_key_processing_handler as l_default_key_processing_handler and then not l_default_key_processing_handler.item ([l_key])) or else
					-- If we have a default key processing handler, check to see if we should disable default processing.
				(not has_focus or ignore_character_code (character_code))
					-- When we loose the focus or press return, we do not perform the
					-- default processing since it causes a system beep.
			then
				disable_default_processing
			end

			if not l_ignore_event then
				if application_imp.key_press_string_actions_internal /= Void then
					application_imp.key_press_string_actions.call ([attached_interface, character_string])
				end
				if key_press_string_actions_internal /= Void then
					key_press_string_actions.call ([character_string])
				end
			end
		end

	on_mouse_wheel (delta, keys, x_pos, y_pos: INTEGER)
			-- Wm_mousewheel received.
		local
			l_ignore_default_processing: BOOLEAN
			l_delta: INTEGER
		do
			if is_displayed then
				if application_imp.pick_and_drop_source = Void then
					l_delta := delta // wheel_delta
						-- With newer mices, the `delta' might be not a multiple of `wheel_delta'
						-- or worse, less than `wheel_delta', in which case we still send a +1 or -1
						-- delta to the action sequence.
					if l_delta = 0 and delta /= 0 then
						l_delta := delta.sign
					end
					if application_imp.mouse_wheel_actions_internal /= Void then
						application_imp.mouse_wheel_actions.call ([attached_interface, l_delta])
						l_ignore_default_processing := True
					end
					if mouse_wheel_actions_internal /= Void then
						mouse_wheel_actions.call ([l_delta])
						l_ignore_default_processing := True
					end
				else
					l_ignore_default_processing := True
				end

				if l_ignore_default_processing then
						-- Only return 0 if the mouse wheel actions are not empty,
						-- as this overrides intellipoint software if installed.
					set_message_return_value (to_lresult (0))
					disable_default_processing
				end
			end
		end

	wheel_delta: INTEGER = 120
			-- Wheel rotation unit. It was set to 120. This is the threshold for action to be taken,
			-- and one such action (for example, scrolling one increment) should occur for each delta.
			--
			-- The delta was set to 120 to allow Microsoft or other vendors to build finer-resolution
			-- wheels in the future, including perhaps a freely-rotating wheel with no notches.
			-- The expectation is that such a device would send more messages per rotation, but
			-- with a smaller value in each message. To support this possibility, you should either
			-- add the incoming delta values until WHEEL_DELTA is reached (so for a delta-rotation
			-- you get the same response), or scroll partial lines in response to the more frequent
			-- messages. You could also choose your scroll granularity and accumulate deltas until it is reached.

feature {NONE} -- Implementation, focus event

	on_set_focus
			-- Called when a `Wm_setfocus' message is received.
		require
			exists: exists
		local
			l_top_level_window_imp: detachable EV_WINDOW_IMP
		do
			l_top_level_window_imp := top_level_window_imp
			if l_top_level_window_imp /= Void and then l_top_level_window_imp /= Current then
					-- Ignore focusing for EV_WINDOW_IMP and descendants as this is performed
					-- in {EV_WINDOW_IMP}.window_on_wm_activate
				Focus_on_widget.put (Current)
				if application_imp.focus_in_actions_internal /= Void then
					application_imp.focus_in_actions.call ([attached_interface])
				end
				l_top_level_window_imp.set_last_focused_widget (wel_item)
				application_imp.set_window_with_focus (l_top_level_window_imp)
				if focus_in_actions_internal /= Void then
					focus_in_actions.call (Void)
				end
			end
				-- If we still have the focus after calling the focus_in
				-- actions then we need to updated the current push button
				-- otherwise, there is no need to since the widget which
				-- has now the focus has already done it.
			if has_focus then
				update_current_push_button
			end
		end

	on_kill_focus
			-- Called when a `Wm_killfocus' message is received.
		local
			l_top_level_window_imp: like top_level_window_imp
		do
			l_top_level_window_imp := top_level_window_imp
			if l_top_level_window_imp = Void or else Current /= l_top_level_window_imp then
					-- Ignore focusing for EV_WINDOW_IMP and descendants as this is performed
					-- in {EV_WINDOW_IMP}.window_on_wm_activate
				if application_imp.focus_out_actions_internal /= Void then
					application_imp.focus_out_actions.call ([attached_interface])
				end
				if focus_out_actions_internal /= Void then
					focus_out_actions.call (Void)
				end
			end
		end

	on_desactivate
			-- Called when window loses focus via alt-tab
		do
			on_kill_focus
		end

	update_current_push_button
			-- Update the current push button
			--
			-- Current is NOT a push button so we set the current push button
			-- to be the default push button.
			-- This feature is redefined in EV_BUTTON_IMP.
		local
			top_level_dialog_imp: detachable EV_DIALOG_I
		do
			top_level_dialog_imp ?= application_imp.window_with_focus
			if top_level_dialog_imp /= Void then
				top_level_dialog_imp.set_current_push_button (top_level_dialog_imp.internal_default_push_button)
			end
		end

feature {EV_ANY_I} -- Implementation, push button

	redraw_current_push_button (focused_button: EV_BUTTON)
			-- Put a bold border on the current push button and
			-- remove any bold border to the other buttons.
		do
			-- Do nothing here, as a widget has no children. This
			-- will be redefined in descendents to either search through
			-- any children or update if a button.
			-- See versions from V_CONTAINER_IMP and EV_BUTTON_IMP.
		end

feature {NONE} -- Implementation, cursor of the widget

	on_set_cursor (hit_code: INTEGER)
			-- Called when a `Wm_setcursor' message is received.
			-- See class WEL_HT_CONSTANTS for valid `hit_code' values.
		do
				-- We must check that we are not currently executing
				-- a pick/drag as if we are, we should not do anything.
				-- This is because the setting of the cursor should only
				-- be performed by us, not windows when in transport.
			if application_imp.pick_and_drop_source /= Void then
				disable_default_processing
			elseif
				(hit_code = ({WEL_HT_CONSTANTS}.Htnowhere) or else hit_code = ({WEL_HT_CONSTANTS}.Htclient))
				and then cursor_pixmap /= Void
			then
				internal_on_set_cursor
				set_message_return_value (to_lresult (1))
				disable_default_processing
			end
		end

feature {EV_INTERNAL_COMBO_FIELD_IMP, EV_INTERNAL_COMBO_BOX_IMP} -- Implementation

	internal_on_set_cursor
			-- Called as a result of a `Wm_setcursor' message is received.
			-- This was extracted from `on_set_cursor' as if we are a combo box,
			-- we need to be able to execute this without the message processing performed
			-- in `on_set_cursor', due to the event propagation from the internal controls.
		local
			wel_cursor: WEL_CURSOR
			l_cursor_pixmap: detachable EV_POINTER_STYLE
			cursor_imp: detachable EV_POINTER_STYLE_IMP
		do
			l_cursor_pixmap := cursor_pixmap
			check l_cursor_pixmap /= Void then end
			cursor_imp ?= l_cursor_pixmap.implementation
			check cursor_imp /= Void then end
			wel_cursor := cursor_imp.wel_cursor
			wel_cursor.increment_reference

			if attached current_wel_cursor as l_current_wel_cursor then
				l_current_wel_cursor.decrement_reference
				current_wel_cursor := Void
			end

			current_wel_cursor := wel_cursor
			wel_cursor.set
		end

feature {NONE} -- Implementation, pick and drop

	widget_source: EV_WIDGET_IMP
			-- Widget drag source used for transport.
		do
			Result := Current
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_WIDGET note option: stable attribute end

feature -- Deferred features

	window_rect: WEL_RECT
			-- `Result' is rectangle of `Current'.
		deferred
		end

	absolute_y: INTEGER
			-- `Result' is y position relative to screen in pixels.
		deferred
		end

	absolute_x: INTEGER
			-- `Result' is x position relative to screen in pixels.
		deferred
		end

	is_control_in_window (hwnd_control: POINTER): BOOLEAN
			-- Is the control of handle `hwnd_control'
			-- located inside the current window?
		deferred
		end

	set_top_level_window_imp (a_window: detachable EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		deferred
		end

	exists: BOOLEAN
			-- Does the window exist?
		deferred
		end

	disable
			-- Disable mouse and keyboard input
		deferred
		end
	enable
			-- Enable mouse and keyboard input.
		deferred
		end

	on_size	(size_type, a_width, a_height: INTEGER)
			-- `Current' has been resized.
		require
			exists: exists
		do
			trigger_resize_actions (a_width, a_height)
		end

	frozen trigger_resize_actions (a_width, a_height: INTEGER)
			-- `Current' has been resized.
		require
			exists: exists
		do
			if attached resize_actions_internal as l_actions then
				l_actions.call ([screen_x, screen_y, a_width, a_height])
			end
		end

	frozen trigger_dpi_actions (a_dpi: NATURAL_32; a_width, a_height: INTEGER)
			-- `Current' has been resized.
		require
			exists: exists
		do
			if attached dpi_changed_actions_internal as l_actions then
				l_actions.call ([a_dpi, screen_x, screen_y, a_width, a_height])
			end
		end

	wel_parent: detachable WEL_WINDOW
			-- The wel parent of `Current'.
		deferred
		end

	wel_set_parent (a_parent: detachable WEL_WINDOW)
			-- Set the wel parent of `Current'.
		require
			exists: exists
		deferred
		end

	default_style: INTEGER
			-- Default style of `Current'.
		deferred
		end

	style: INTEGER
			-- Current style of `Current'
		deferred
		end

	set_style (a_style: INTEGER)
			-- Assign `a_Style' to `style' of `Current'.
		deferred
		end

	client_rect: WEL_RECT
			-- Area used by `Current'.
		deferred
		end

	update
			-- Update the client area by sending a Wm_paint message.
		deferred
		end

	invalidate
			-- Cause `Current' to re-draw.
		deferred
		end

	wel_destroy
		deferred
		end

	disable_default_processing
		deferred
		end

	set_message_return_value (v: POINTER)
		deferred
		end

	wel_item: POINTER
		deferred
		end

	wel_background_color: WEL_COLOR_REF
			-- `Result' is background color of `Current'.
		do
			if attached background_color_imp as l_color then
				Result := l_color
			else
				create Result.make_system ({WEL_COLOR_CONSTANTS}.Color_btnface)
			end
		end

	wel_foreground_color: WEL_COLOR_REF
			-- `Result' is foreground color of `Current'.
		do
			if attached foreground_color_imp as l_color then
				Result := l_color
			else
				create Result.make_rgb (0, 0, 0)
			end
		end

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		local
			l_widget: EV_WIDGET_IMP
		do
				-- Reset the start widget searched flag.
			start_widget_searched_cell.put (-1)

			if not previous then
				l_widget := next_tabstop_widget (attached_interface, 0, False)
			else
				l_widget := next_tabstop_widget (attached_interface, 1, True)
			end
			Result := l_widget.wel_item
		end

	start_widget_searched_cell: CELL [INTEGER]
			-- A cell to hold the seach index that the item tabbed from started with.
			-- This is necessary to prevent infinite recursion in the
			-- case where there is no next item as if we return to the
			-- original widget with the same search position, then we know we have exhausted all other possibilities.
		once
			create Result.put (0)
		end

	next_tabstop_widget (start_widget: EV_WIDGET; search_pos: INTEGER; forwards: BOOLEAN): EV_WIDGET_IMP
			-- Return the next widget that may by tabbed to as a result of pressing the tab key from `start_widget'.
			-- `search_pos' is the index where searching must start from for containers, and `forwards' determines the
			-- tabbing direction. If `search_pos' is less then 1 or more than `count' for containers, the parent of the
			-- container must be searched next.
		require
			start_widget_not_void: start_widget /= Void
		local
			w: detachable EV_WIDGET_IMP
			l_result: detachable EV_WIDGET_IMP
		do
			if interface /= start_widget then
				if has_tabstop then
					l_result := Current
				end
			else
				if start_widget_searched_cell.item = 1 then
						-- We have reached the original widget for the second time with the same search position
						-- meaning there is no other widget to tab to and the original
						-- widget must be returned.
					w ?= start_widget.implementation
					l_result := w
				elseif start_widget_searched_cell.item = -1 then

					-- Record the fact that we have reached the original
					-- widget at least once.
					start_widget_searched_cell.put (1)
				end
			end
			if l_result = Void then
				l_result := next_tabstop_widget_from_parent (start_widget, search_pos, forwards)
			end
			Result := l_result
		ensure
			Result_not_void: Result /= Void
				-- If there is no next tabstop widget, then simply return `start_widget'.
		end

	return_current_if_next_tabstop_widget (start_widget: EV_WIDGET; search_pos: INTEGER; forwards: BOOLEAN): detachable EV_WIDGET_IMP
			-- If `Current' is not equal to `start_widget' then return `Current' but only if `search_pos' is 1 and `forwards' or
			-- `search_pos' is 0 and not `forwards. This ensures that we return a container in the correct order (before or after)
			-- its children dependent on the state of `forwards'.
		require
			start_widget_not_void: start_widget /= Void
		local
			w: detachable EV_WIDGET_IMP
		do
			if interface /= start_widget then
				if (forwards and search_pos = 1) or (not forwards and search_pos = 0) then
					if has_tabstop then
						Result := Current
					end
				end
			else
				if start_widget_searched_cell.item = search_pos then
						-- We have reached the original widget for the second time with the same search position
						-- meaning there is no other widget to tab to and the original
						-- widget must be returned.
					w ?= start_widget.implementation
					Result := w
				elseif start_widget_searched_cell.item = -1 then
						-- Record the fact that we have reached the original
						-- widget at least once.
					start_widget_searched_cell.put (search_pos)
				end
			end
		end

	next_tabstop_widget_from_parent (start_widget: EV_WIDGET; search_pos: INTEGER; forwards: BOOLEAN): EV_WIDGET_IMP
			-- Return the next widget that may be tabbed to as a result of pressing the tab key from `start_widget'
			-- by visiting the parent of `Current' with a search index determined by `search_pos' and `forwards'.
		require
			start_widget_not_void: start_widget /= Void
		local
			l_parent_index, l_search_index: INTEGER
			l_parent_imp: like parent_imp
			l_result: detachable EV_WIDGET_IMP
		do
			l_parent_imp := parent_imp
			if l_parent_imp /= Void then
				l_parent_index := l_parent_imp.index_of_child (Current)
				if forwards then
					l_search_index := l_parent_index + 1
				else
					l_search_index := l_parent_index - 1
				end
				l_result := l_parent_imp.next_tabstop_widget (start_widget, l_search_index, forwards)
			else
					-- If parent is void then return `start_widget', it is possible for latent messages to
					-- indirectly call this routine
				l_result ?= start_widget.implementation
				check l_result /= Void then end
			end
			Result := l_result
		ensure
			Result_not_void: Result /= Void
				-- If there is no next tabstop widget, then simply return `start_widget'.
		end

	has_tabstop: BOOLEAN
			-- Does `Current' exhibit all attributes to permit it to receive the
			-- focus while tabbing?
		do
			Result :=  flag_set (style, {WEL_WINDOW_CONSTANTS}.ws_tabstop) and then is_sensitive and then is_displayed
		end

	cwin_get_next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER
			-- SDK GetNextDlgTabItem
		deferred
		end

feature {NONE} -- Implementation

	is_shown_by_default: BOOLEAN
			-- Is `Current' shown by default?
		do
			Result := True
		end

	enable_drag_accept_files
			-- Allow `Current' to be a file drag and drop target.
		deferred
		end

	disable_drag_accept_files
			-- Disallow `Current' from being a file drag and drop target.
		deferred
		end

	on_wm_dropfiles (wparam: POINTER)
			-- Wm_dropfile message
		require
			exists: exists
		local
			l_filecount, l_chars_copied: INTEGER_32
			l_string: WEL_STRING
			l_max_length: INTEGER_32
			i: INTEGER_32
			l_file_list: ARRAYED_LIST [STRING_32]
		do
			l_filecount := {WEL_API}.drag_query_file (wparam, -1, default_pointer, 0)
			if l_filecount > 0 then
				from
					i := 0
					l_max_length := 255
					create l_string.make_empty (l_max_length)
					create l_file_list.make (l_filecount)
				until
					i = l_filecount
				loop
					l_chars_copied := {WEL_API}.drag_query_file (wparam, i, l_string.item, l_max_length)
					l_file_list.extend (l_string.substring (1, l_chars_copied))
					i := i + 1
				end
				if file_drop_actions_internal /= Void then
					file_drop_actions.call (l_file_list)
				end
				if application_imp.file_drop_actions_internal /= Void then
					application_imp.file_drop_actions.call (attached_interface, l_file_list)
				end
			end
		end

feature {NONE} -- Implementation

	convert_from_wel_constant (a_wel_constant: INTEGER): INTEGER
			-- Convert from {WEL_SB_CONSTANTS} `a_wel_constant' to {EV_SCROLL_CONSTANTS}
		require
			valid_constant: True
		do
			inspect
				a_wel_constant
			when {WEL_SB_CONSTANTS}.Sb_bottom then
				Result := {EV_SCROLL_CONSTANTS}.bottom
			when {WEL_SB_CONSTANTS}.Sb_endscroll then
				Result := {EV_SCROLL_CONSTANTS}.end_scroll
			when {WEL_SB_CONSTANTS}.Sb_linedown then
				Result := {EV_SCROLL_CONSTANTS}.line_down
			when {WEL_SB_CONSTANTS}.Sb_lineup then
				Result := {EV_SCROLL_CONSTANTS}.line_up
			when {WEL_SB_CONSTANTS}.Sb_pagedown then
				Result := {EV_SCROLL_CONSTANTS}.page_down
			when {WEL_SB_CONSTANTS}.Sb_pageup then
				Result := {EV_SCROLL_CONSTANTS}.page_up
			when {WEL_SB_CONSTANTS}.Sb_thumbposition then
				Result := {EV_SCROLL_CONSTANTS}.thumb_position
			when {WEL_SB_CONSTANTS}.Sb_thumbtrack then
				Result := {EV_SCROLL_CONSTANTS}.thumb_track
			when {WEL_SB_CONSTANTS}.Sb_top then
				Result := {EV_SCROLL_CONSTANTS}.top
			else
				check invalid: False end
			end
		ensure
			valid: (create {EV_SCROLL_CONSTANTS}).is_valid (Result)
		end

feature -- Feature that should be directly implemented by externals

	show_window (hwnd: POINTER; cmd_show: INTEGER)
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- cwin_show_window deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

	cwin_show_window (hwnd: POINTER; cmd_show: INTEGER)
			-- SDK ShowWindow
			-- (from WEL_WINDOW)
			-- (export status {NONE})
		deferred
		ensure
			is_class: class
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
