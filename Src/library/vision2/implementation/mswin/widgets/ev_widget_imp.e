indexing
	description: "EiffelVision widget, mswindows implementation."
	note: "The parent of a widget cannot be void, except for a%
		%  window. Therefore, each feature that call the parent%
		%  here need to be redefine by EV_TITLED_WINDOW to check if%
		%  parent is `Void'"
	note: "The current class would be the equivalent of a wel_window%
		% Yet, it doesn't inherit from wel_window. Then, all the%
		% feature we used are defined as deferred. They will be%
		% implemented directly by the heirs thanks to inheritance%
		% from a heir of wel_window."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET_IMP

inherit
	EV_WIDGET_I
		redefine
			interface,
			set_default_colors
		end

	EV_SIZEABLE_IMP
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_IMP
		redefine	
			interface
		end

	EV_WEL_KEY_CONVERSION
		rename
			Key_down as Key_down_arrow,
			Key_up as Key_up_arrow
		end

	EV_WIDGET_ACTION_SEQUENCES_IMP

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

	initialize  is
			-- Initialize `Current'.
		local
			win: EV_WINDOW_IMP
		do
			initialize_sizeable
			set_default_minimum_size
			win ?= Current
			if win = Void then
				-- If `Current' is not a window.
				--| All widgets are shown as default except
				--| EV_WINDOW AND EV_TITLED_WINDOW.
				show
			end
			is_initialized := True
		end

feature -- Access

	pointer_position: EV_COORDINATE is
			-- Position of the screen pointer relative to `Current'.
		local
			wel_point: WEL_POINT
		do
			create wel_point.make (0, 0)
			wel_point.set_cursor_position
			create Result.set (wel_point.x - interface.screen_x, wel_point.y -
				interface.screen_y)
		end

	pointer_style: EV_CURSOR is
			-- Pointer displayed when the pointing device is over `Current'.
		do
			Result := cursor_pixmap
		end

	background_color: EV_COLOR is
			-- Color used for the background of `Current'.
		do
			if background_color_imp /= Void then
				Result ?= background_color_imp.interface
			else
				Result := (create {EV_STOCK_COLORS}).default_background_color
			end
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of `Current'.
		do
			if foreground_color_imp /= Void then
				Result ?= foreground_color_imp.interface
			else
				Result := (create {EV_STOCK_COLORS}).default_foreground_color
			end
		end

	top_level_window: EV_WINDOW is
			-- Top level window that contains `Current'.
		do
			Result ?= top_level_window_imp.interface
		end

	Default_parent: EV_INTERNAL_SILLY_WINDOW_IMP is
			-- A default parent for creation of `Current'.
		once
			create Result.make_top ("Eiffel Vision default parent window")
		ensure
			valid_parent: Result /= Void
		end

	Focus_on_widget: CELL [EV_WIDGET_IMP] is
			-- Widget that has currently the focus.
		once
			create Result.put (Void)
		end

	Cursor_on_widget: CELL [EV_WIDGET_IMP] is
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

	parent: EV_CONTAINER is
			-- Parent of `Current'
		do
			if parent_imp /= Void then
				Result := parent_imp.interface
			end
		end

	wel_width: INTEGER is
		deferred
		end

	width: INTEGER is
			-- Width of `Current'.
		do
			Result := minimum_width.max (ev_width)
		end

	wel_height: INTEGER is
		deferred
		end

	height: INTEGER is
			-- Height of `Current'.
		do
			Result := minimum_height.max (ev_height)
		end

	screen_x: INTEGER is
			-- Horizontal offset of `Current' relative to screen
		local
			wind: EV_WINDOW_IMP
		do
			wind ?= Current
			if wind /= Void then
				Result := x_position + wind.frame_width + wind.border_width - 1
			elseif parent /= Void
				then Result := x_position + parent.screen_x
			end
		end

	screen_y: INTEGER is
			-- Vertical offset of `Current' relative to screen. 
		local 
			wind: EV_WINDOW_IMP
		do 
			wind ?= Current
			if wind /= Void then
				Result := y_position + wind.title_height + wind.frame_height + 1
				if wind.has_menu then
					Result := Result + wind.menu_bar_height
				end
			elseif parent /= Void then
				Result := y_position + parent.screen_y
			end
		end

	x_position: INTEGER is
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
				if wel_parent /= Void then
					rect := window_rect
					create point.make (rect.x, rect.y)
					point.screen_to_client (wel_parent)
					Result := point.x
				else
					Result := absolute_x
				end
			else
				Result := child_cell.x
			end
		end

	y_position: INTEGER is
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
				if wel_parent /= Void then
					rect := window_rect
					create point.make (rect.x, rect.y)
					point.screen_to_client (wel_parent)
					Result := point.y
				else
					Result := absolute_y
				end
			else
				Result := child_cell.y
			end
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is `Current' destroyed ?
		do
			Result := not exists
		end

	is_show_requested: BOOLEAN is
			-- Is `Current' displayed in its parent?
		do
			Result := flag_set (style, feature {WEL_WINDOW_CONSTANTS}.Ws_visible)
		end

	managed: BOOLEAN is true
		-- All widgets are managed.

	has_capture: BOOLEAN is
			-- Does `Current' have capture?
		do
			if has_heavy_capture or wel_has_capture then
				Result := True
			end
		end

	has_heavy_capture: BOOLEAN is
			-- Does `Current' have heavy capture?
		deferred
		end

	wel_has_capture: BOOLEAN is
			-- Does `Current' have a windows capture?
		deferred
		end

feature -- Status setting

	destroy is
			-- Destroy `Current', but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				parent_imp.interface.prune (Current.interface)
			end
			wel_destroy
			is_destroyed := True
		end

	show is
			-- Show `Current'.
			-- Need to notify the parent.
		local
			p_imp: like parent_imp
		do
			show_window (wel_item, feature {WEL_WINDOW_CONSTANTS}.Sw_show)
			p_imp := parent_imp
			if p_imp /= Void then
				p_imp.notify_change (Nc_minsize, Current)
			end
		end

	hide is
			-- Hide `Current'.
		local
			p_imp: like parent_imp
		do
			show_window (wel_item, feature {WEL_WINDOW_CONSTANTS}.Sw_hide)
			p_imp := parent_imp
			if p_imp /= Void then
				p_imp.notify_change (Nc_minsize, Current)
			end
		end

	parent_is_sensitive: BOOLEAN is
			-- Is parent of `Current' sensitive?
		do
			if parent_imp /= Void and then parent_imp.is_sensitive then
				result := True
			end
		end

	has_parent: BOOLEAN is
			-- Is `Current' parented?
		do
			if parent_imp /= Void then
				result := True
			end
		end

	disable_sensitive is
			-- Set `Current' to insensitive mode if
			-- `flag'. This means that any events with an
			-- event type of KeyPress, KeyRelease,
			-- ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or
			-- FocusOut will not be dispatched to current
			-- widget and to all its children.  Set it to
			-- sensitive mode otherwise.
		do
			disable
		end

	enable_sensitive is
			-- Set `Current' to sensitive mode.
			--| See comment for `disable_sensitive'.
		do
			enable
		end

	set_default_minimum_size is
			-- Initialize the size of `Current'.
			-- Redefined by many widgets.
		do
			ev_set_minimum_size (0, 0)
		end

feature -- Element change

	set_default_colors is
			-- Set foreground and background color to their default values.
		do
			background_color_imp := Void
			foreground_color_imp := Void
			if is_displayed then
					-- If the widget is not hidden then invalidate.
				invalidate
			end
		end	

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of `Current'.
			-- `par' can be Void then the parent is
			-- `Default_parent'.
		deferred
		end

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		do
			background_color_imp ?= color.implementation
			if is_displayed then
				-- If the widget is not hidden then invalidate.
				invalidate
			end
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		do
			foreground_color_imp ?= color.implementation
			if is_displayed then
				-- If the widget is not hidden then invalidate.
				invalidate
			end
		end

feature {EV_CONTAINER_IMP, EV_PRIMITIVE_IMP} -- Implementation

	background_color_imp: EV_COLOR_IMP
			-- Color used for the background of `Current'.

	foreground_color_imp: EV_COLOR_IMP
			-- Color used for the foreground of `Current'
			-- usually the text.

	parent_imp: EV_CONTAINER_IMP is
			-- Parent container of `Current'.
		do
			if wel_parent = Default_parent then
				Result := Void
			else
				Result ?= wel_parent
			end
		end

feature {NONE} -- Implementation, mouse_button_events

	call_pointer_actions (
		actions: EV_POINTER_BUTTON_ACTION_SEQUENCE;
		a_x, a_y, s_x, s_y, button: INTEGER) is
			-- If `actions' not `Void' call with
			-- `a_x', `a_y', `s_x', `s_y', and `button'.
		do
			if actions /= Void then
				actions.call ([a_x, a_y, button, 0.0, 0.0, 0.0, s_x, s_y])
			end
		end

	on_button_down (x_pos, y_pos, button: INTEGER) is
			-- Executed when the a button is pressed.
		local
			t: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
			actions_called: BOOLEAN
		do
			--| `pointer_button_press_actions_internal' must be called before
			--| a pick and drop starts, but after a pick and drop ends.
			t := translate_coordinates (x_pos, y_pos)
			if not is_dnd_in_transport and not is_pnd_in_transport then
				call_pointer_actions (
					pointer_button_press_actions_internal,
					t.integer_item (1),
					t.integer_item (2),
					t.integer_item (3),
					t.integer_item (4),
					button
				)
				actions_called := True
			end
			pnd_press (
				t.integer_item (1),
				t.integer_item (2),
				button,
				t.integer_item (3),
				t.integer_item (4))
			if not actions_called then
				call_pointer_actions (
					pointer_button_press_actions_internal,
					t.integer_item (1),
					t.integer_item (2),
					t.integer_item (3),
					t.integer_item (4),
					button
				)
			end
		end

	on_button_up (x_pos, y_pos, button: INTEGER) is
			-- Executed when the a button is pressed.
		local
			t: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
		do
			t := translate_coordinates (x_pos, y_pos)
			call_pointer_actions (
				pointer_button_release_actions_internal,
				t.integer_item (1),
				t.integer_item (2),
				t.integer_item (3),
				t.integer_item (4),
				button
			)
		end

	on_button_double_click (x_pos, y_pos, button: INTEGER) is
			-- Executed when the a button is pressed.
		local
			t: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
			actions_called: BOOLEAN
		do
			t := translate_coordinates (x_pos, y_pos)
			if not is_dnd_in_transport and not is_pnd_in_transport then
				call_pointer_actions (
					pointer_double_press_actions_internal,
					t.integer_item (1),
					t.integer_item (2),
					t.integer_item (3),
					t.integer_item (4),
					button
				)
				actions_called := True
			end

			pnd_press (
				t.integer_item (1),
				t.integer_item (2),
				button,
				t.integer_item (3),
				t.integer_item (4))

			if not actions_called then
				call_pointer_actions (
					pointer_double_press_actions_internal,
					t.integer_item (1),
					t.integer_item (2),
					t.integer_item (3),
					t.integer_item (4),
					button
				)
			end
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
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

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the middle button is pressed.
		do
			on_button_down (x_pos, y_pos, 2)
		end
	
	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is pressed.
		do
			on_button_down (x_pos, y_pos, 3)
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is released.
		do
			check_drag_and_drop_release (x_pos, y_pos)
			on_button_up (x_pos, y_pos, 1)
		end

	on_middle_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the middle button is released.
		do
			on_button_up (x_pos, y_pos, 2)
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is released.
		do
			on_button_up (x_pos, y_pos, 3)
		end

	on_left_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is double clicked.
		do
			on_button_double_click (x_pos, y_pos, 1)
		end

	on_middle_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the middle button is double clicked.
		do
			on_button_double_click (x_pos, y_pos, 2)
		end

	on_right_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
		do
			on_button_double_click (x_pos, y_pos, 3)
		end
		
feature {EV_ANY_I} -- Implementation

	propagate_syncpaint is
			-- Propagate `wm_syncpaint' message recevived by `top_level_window_imp' to
			-- children. No need to do anything here as there are no children. See
			-- "WM_SYNCPAINT" in MSDN for more information.
		do
		end
		
	update_for_pick_and_drop (starting: BOOLEAN) is
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		deferred
		end
		

feature {NONE} -- Implementation
		
	default_process_message (msg, wparam, lparam: INTEGER) is
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
			if msg = (feature {WEL_WINDOW_CONSTANTS}.Wm_mouseleave) then
				on_mouse_leave
				Cursor_on_widget.put (Void)
			end
		end

	client_to_screen (a_x, a_y: INTEGER): WEL_POINT is
			-- Absolute screen coordinates in pixels
			-- of coordinates `a_x', a_y' on `Current'.
		local
			ww: WEL_WINDOW
		do
			create Result.make (a_x, a_y)
			ww ?= Current
			check
				wel_window_not_void: ww/= Void
			end
			Result.client_to_screen (ww)
		end

	translate_coordinates (a_x, a_y: INTEGER): TUPLE [INTEGER, INTEGER, INTEGER, INTEGER] is
			-- For `a_x', `a_y', give actual x and y and screen x and y.
			-- By default, actual x and y are the same as `a_x', `a_y'.
			-- Redefined in EV_PIXMAP_IMP_WIDGET.
		local
			pt: WEL_POINT
		do
			pt := client_to_screen (a_x, a_y)
			Result := [a_x, a_y, pt.x, pt.y]
		end

	track_mouse_event (info: WEL_TRACK_MOUSE_EVENT): BOOLEAN is
		deferred
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse move.
		local
			t: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
			track_mouse: WEL_TRACK_MOUSE_EVENT
			track_mouse_successful: BOOLEAN
		do
				--| We check the position of the cursor, as when in a pick and
				--| drop, `cursor_on_widget' is `Void' meaning every time the
				--| mouse moves while not over the original widget for the pick,
				--| the enter and leave actions are fired.
			if cursor_on_widget.item = Void and x_pos >= 0 and y_pos >= 0 and
			x_pos <= width and y_pos <= height then
					-- Create a WEL_TRACK_MOUSE_EVENT structure so
					-- we will recieve the Wm_mouse_leave notification
					-- message when the pointer leaves `Current'. 
				create track_mouse.make
				track_mouse.set_hwndtrack (wel_item)
				track_mouse.set_dwflags (feature {WEL_TME_CONSTANTS}.tme_leave)
				track_mouse_successful := track_mouse_event (track_mouse)
				check
					mouse_successfully_tracking: track_mouse_successful = True
				end
		
				on_mouse_enter
				Cursor_on_widget.replace (Current)	
				track_mouse.dispose
			end
			if (is_transport_enabled and mode_is_drag_and_drop) or
				(mode_is_pick_and_drop and is_pnd_in_transport) then
				t := translate_coordinates (x_pos, y_pos)
				pnd_motion (
					t.integer_item (1),
					t.integer_item (2),
					t.integer_item (3),
					t.integer_item (4)
				)
			end
			if pointer_motion_actions_internal /= Void then
				if t = Void then
					t := translate_coordinates (x_pos, y_pos)
				end
				pointer_motion_actions_internal.call ([
					t.integer_item (1),
					t.integer_item (2),
					0.0, 0.0, 0.0,
					t.integer_item (3),
					t.integer_item (4)
				])
			end
		end

	on_mouse_enter is
			-- Called when the mouse enters `Current'.
		do
			if pointer_enter_actions_internal /= Void then
				pointer_enter_actions_internal.call ([])
			end
		end

feature {EV_WIDGET_IMP} -- Implementation

	on_mouse_leave is
			-- Called when the mouse leaves `Current'.
			-- This is called by the WEL_TRACK_MOUSE_EVENT instantiated
			-- in on_mouse_move.
		do
			if pointer_leave_actions_internal /= Void then
				pointer_leave_actions_internal.call ([])
			end
		end

feature {EV_DIALOG_IMP_COMMON} -- Implementation

	process_standard_key_press (virtual_key: INTEGER) is
			-- Process key press represented by `virtual_key'.
		local
			key: EV_KEY
			common_dialog_imp: EV_DIALOG_IMP_COMMON
		do
				-- If escape or tab has been pressed then end pick and drop.
				--| This is to stop the user from ever using Alt + tab
				--| to switch between applications while in PND.
			if virtual_key = vk_menu or virtual_key = vk_escape then
				escape_pnd
			end
			if valid_wel_code (virtual_key) then
				create key.make_with_code (key_code_from_wel (virtual_key))
				
					-- Windows does not seem to generate any messages when a key is
					-- pressed in a modal or modeless dialog, so if `Current' is parented
					-- in one of these, we must force the calling of the key_press_actions.
				common_dialog_imp ?= top_level_window_imp
				if common_dialog_imp /= Void then
					common_dialog_imp.key_press_actions.call ([key])
				end							
				if key_press_actions_internal /= Void then
					key_press_actions_internal.call ([key])
				end
			end
		end
		
	process_standard_key_release (virtual_key: INTEGER) is
			-- Process key release represented by `virtual_key'.
		local
			key: EV_KEY
			common_dialog_imp: EV_DIALOG_IMP_COMMON
		do
			if valid_wel_code (virtual_key) then
				create key.make_with_code (key_code_from_wel (virtual_key))
				
					-- Windows does not seem to generate any messages when a key is
					-- pressed in a modal or modeless dialog, so if `Current' is parented
					-- in one of these, we must force the calling of the key_press_actions.
				common_dialog_imp ?= top_level_window_imp
				if common_dialog_imp /= Void then
					common_dialog_imp.key_release_actions.call ([key])
				end							
				if key_release_actions_internal /= Void then
					key_release_actions_internal.call ([key])
				end
			end
		end

feature {NONE} -- Implementation
	
	on_key_down (virtual_key, key_data: INTEGER) is
			-- Executed when a key is pressed.
		do
			process_standard_key_press (virtual_key)
		end

	on_sys_key_down (virtual_key, key_data: INTEGER) is
			-- Executed when a system key is pressed.
		do
			process_standard_key_press (virtual_key)
		end

	on_sys_key_up (virtual_key, ke_data: INTEGER) is
		do
			process_standard_key_release (virtual_key)
		end

	on_key_up (virtual_key, key_data: INTEGER) is
			-- Executed when a key is released.
		do
			process_standard_key_release (virtual_key)
		end

	on_char (character_code, key_data: INTEGER) is
			-- Executed when a key is pressed. 
			--| Now outputs all displayable characters, previously
			--| depended on process_standard_key returning a valid EV_KEY.
		local
			character_string: STRING
		do
			create character_string.make(1)
			character_string.append_character(character_code.to_character)
			if key_press_string_actions_internal /= Void then
				key_press_string_actions_internal.call ([character_string])
			end
		end

feature {NONE} -- Implementation, focus event

	on_set_focus is
			-- Called when a `Wm_setfocus' message is recieved.
		local
			top_level_titled_window: EV_TITLED_WINDOW
		do
				-- We now store `Current' in `top_level_window_imp' so
				-- we can restore the focus to it when required.
				--| See window_process_message in EV_WINDOW_IMP.
			top_level_window_imp.set_last_focused_widget (wel_item)	
			top_level_titled_window ?= top_level_window_imp.interface
			if top_level_titled_window /= Void then
				application_imp.set_window_with_focus (top_level_titled_window)
			end
			update_current_push_button
			Focus_on_widget.put (Current)
			if focus_in_actions_internal /= Void then
				focus_in_actions_internal.call ([])
			end
		end
		
	on_kill_focus is
			-- Called when a `Wm_killfocus' message is recieved.
		do
			if focus_out_actions_internal /= Void then
				focus_out_actions_internal.call ([])
			end
		end

	on_desactivate is
			-- Called when window loses focus via alt-tab
		do
			on_kill_focus
		end

	update_current_push_button is
			-- Update the current push button
			--
			-- Current is NOT a push button so we set the current push button
			-- to be the default push button.
			-- This feature is redefined in EV_BUTTON_IMP.
		local
			top_level_dialog_imp: EV_DIALOG_I
		do
			top_level_dialog_imp ?= application_imp.window_with_focus
			if top_level_dialog_imp /= Void then
				top_level_dialog_imp.set_current_push_button (top_level_dialog_imp.internal_default_push_button)
			end
		end

feature {EV_ANY_I} -- Implementation, push button

	redraw_current_push_button (focused_button: EV_BUTTON) is
			-- Put a bold border on the current push button and
			-- remove any bold border to the other buttons.
		do
		end

feature {NONE} -- Implementation, cursor of the widget

	on_set_cursor (hit_code: INTEGER) is
			-- Called when a `Wm_setcursor' message is received.
			-- See class WEL_HT_CONSTANTS for valid `hit_code' values.
		local
			wel_cursor: WEL_CURSOR
			cursor_imp: EV_PIXMAP_IMP_STATE
		do
				-- We must check that we are not currently executing
				-- a pick/drag as if we are, we should not do anything.
				-- This is because the setting of the cursor should only
				-- be performed by us, not windows when in transport.
			if application_imp.pick_and_drop_source /= Void then
				disable_default_processing	
			elseif
				(hit_code = (feature {WEL_HT_CONSTANTS}.Htnowhere) or else hit_code = (feature {WEL_HT_CONSTANTS}.Htclient))
				and then cursor_pixmap /= Void
			then
				cursor_imp ?= cursor_pixmap.implementation
				wel_cursor := cursor_imp.cursor
				if wel_cursor = Void then	
					wel_cursor := cursor_imp.build_cursor
					wel_cursor.enable_reference_tracking
				else
					wel_cursor.increment_reference
				end
				
				if current_wel_cursor /= Void then
					current_wel_cursor.decrement_reference
					current_wel_cursor := Void
				end
				current_wel_cursor := wel_cursor
				wel_cursor.set
				
				set_message_return_value (1)
				disable_default_processing
			end
		end

feature {NONE} -- Implementation, pick and drop

	widget_source: EV_WIDGET_IMP is
			-- Widget drag source used for transport.
		do
			Result := Current
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_WIDGET

feature -- Deferred features

	window_rect: WEL_RECT is
			-- `Result' is rectangle of `Current'.
		deferred
		end

	absolute_y: INTEGER is
			-- `Result' is y position relative to screen in pixels.
		deferred
		end

	absolute_x: INTEGER is
			-- `Result' is x position relative to screen in pixels.
		deferred
		end

	is_control_in_window (hwnd_control: POINTER): BOOLEAN is
			-- Is the control of handle `hwnd_control'
			-- located inside the current window?
		deferred
		end

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		deferred
		end

	exists: BOOLEAN is
			-- Does the window exist?
		deferred
		end

	disable is
			-- Disable mouse and keyboard input
		deferred
		end
	enable is
			-- Enable mouse and keyboard input.
		deferred
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- `Current' has been resized.
		local
			t: like resize_actions_internal
		do
			t := resize_actions_internal
			if t /= Void then
				t.call ([screen_x, screen_y, a_width, a_height])
			end
		end

	wel_parent: WEL_WINDOW is
			-- The wel parent of `Current'.
		deferred
		end

	wel_set_parent (a_parent: WEL_WINDOW) is
			-- Set the wel parent of `Current'.
		deferred
		end

	default_style: INTEGER is
			-- Default style of `Current'.
		deferred
		end

	style: INTEGER is
			-- Current style of `Current'
		deferred
		end

	set_style (a_style: INTEGER) is
			-- Assign `a_Style' to `style' of `Current'.
		deferred
		end

	client_rect: WEL_RECT is
			-- Area used by `Current'.
		deferred
		end

	invalidate is
			-- Cause `Current' to re-draw.
		deferred
		end

	wel_destroy is
		deferred
		end	

	disable_default_processing is
		deferred
		end

	set_message_return_value (v: INTEGER) is
		deferred
		end

	wel_item: POINTER is
		deferred
		end

	wel_background_color: WEL_COLOR_REF is
			-- `Result' is background color of `Current'.
		do
			Result := background_color_imp
			if Result = Void then
				create Result.make_system (feature {WEL_COLOR_CONSTANTS}.Color_btnface)
			end
		end

	wel_foreground_color: WEL_COLOR_REF is
			-- `Result' is foreground color of `Current'.
		do
			Result := foreground_color_imp
			if Result = Void then
				create Result.make_rgb (0, 0, 0)
			end
		end

feature -- Feature that should be directly implemented by externals

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- cwin_show_window deferred but it does not wotk because
			-- it would be implemented by an external.
		deferred
		end

end -- class EV_WIDGET_IMP

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

