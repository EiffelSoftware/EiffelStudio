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
	
	WEL_CONSTANTS
		export
			{NONE} all
		end

	WEL_HT_CONSTANTS
		export
			{NONE} all
		end

	WEL_WM_CONSTANTS
		export
			{NONE} all
		end

	WEL_TME_CONSTANTS
		export
			{NONE} all
		end

	EV_WIDGET_ACTION_SEQUENCES_IMP

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

	pointer_position: EV_COORDINATES is
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

	default_parent: EV_INTERNAL_SILLY_WINDOW_IMP is
			-- A default parent for creation of `Current'.
		once
			create Result.make_top ("Eiffel Vision default parent window")
		ensure
			valid_parent: Result /= Void
		end

	focus_on_widget: CELL [EV_WIDGET_IMP] is
			-- Widget that has currently the focus.
		once
			create Result.put (Void)
		end

	cursor_on_widget: CELL [EV_WIDGET_IMP] is
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
			Result := flag_set (style, Wel_window_constants.Ws_visible)
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
			show_window (wel_item, Wel_window_constants.Sw_show)
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
			show_window (wel_item, Wel_window_constants.Sw_hide)
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
		end	

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of `Current'.
			-- `par' can be Void then the parent is the
			-- default_parent.
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
			if wel_parent = default_parent then
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
			if msg = Wm_mouseleave then
				on_mouse_leave
				cursor_on_widget.put (Void)
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
				track_mouse.set_dwflags (tme_leave)
				track_mouse_successful := track_mouse_event (track_mouse)
				check
					mouse_successfully_tracking: track_mouse_successful = True
				end
		
				on_mouse_enter
				cursor_on_widget.replace (Current)
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
			if valid_wel_code (virtual_key) then
				create key.make_with_code (key_code_from_wel (virtual_key))
				
					-- Windows does not seem to generate any messages when a key is
					-- pressed in a modal or modeless dialog, so if `Current' is parented
					-- in one of these, we must force the calling of the key_press_actions.
				common_dialog_imp ?= top_level_window_imp
				if common_dialog_imp /= Void then
					common_dialog_imp.key_press_actions.call ([key])
				end							
				-- If escape or tab has been pressed then end pick and drop.
				--| This is to stop the user from ever using Alt + tab
				--| to switch between applications while in PND.
				if key.code = key.key_escape or virtual_key = vk_menu then
					escape_pnd
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
			character_string.append_character(character_code.ascii_char)
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
			focus_on_widget.put (Current)
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

feature {NONE} -- Implementation, cursor of the widget

	on_set_cursor (hit_code: INTEGER) is
			-- Called when a `Wm_setcursor' message is received.
			-- See class WEL_HT_CONSTANTS for valid `hit_code' values.
		local
			wel_cursor: WEL_CURSOR
			cursor_imp: EV_PIXMAP_IMP_STATE
		do
			if
				(hit_code = Htnowhere or else hit_code = Htclient)
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
				create Result.make_system (Wel_color_constants.Color_btnface)
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
--| Revision 1.78  2001/06/07 23:08:14  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.49.4.82  2001/05/27 20:31:37  pichery
--| Optimization: Replaced inspect clause with only one `when' statement
--| with `if' statement.
--|
--| Revision 1.49.4.81  2001/05/25 16:04:55  rogers
--| We no longer check the focus_on_widget_item in on_set_focus. As this was
--| a fic for EV_COMBO_BOX_IMP, it has been moved there.
--|
--| Revision 1.49.4.80  2001/05/21 19:14:27  rogers
--| Added a check in on_set_focus that the widget is not the already focused
--| widget. This stops problems with EV_COMBO_BOX_IMP and possibly other
--| widgets built in this fashion.
--|
--| Revision 1.49.4.79  2001/05/18 21:32:00  rogers
--| Removed destroy_just_called.
--|
--| Revision 1.49.4.78  2001/05/17 20:02:12  rogers
--| Set_focus now stores `Current' in the `top_level_window_imp', so we
--| can restore the focus to a widget in a window, when using alt-tab to
--| switch betweeen the windows.
--|
--| Revision 1.49.4.77  2001/05/15 22:45:22  rogers
--| Removed aggregate cell check within parent.
--|
--| Revision 1.49.4.76  2001/05/15 09:47:47  pichery
--| Cosmetics
--|
--| Revision 1.49.4.75  2001/05/14 23:22:37  rogers
--| Removed unreferenced locals from on_key and on_sys_key.
--|
--| Revision 1.49.4.74  2001/04/25 17:58:54  rogers
--| Removed redundent and commented code. Simplified check for dialog parent
--| in process_standard_key_*******.
--|
--| Revision 1.49.4.73  2001/04/25 17:52:35  rogers
--| Refactored code in on_key_up and on_sys_key_up in
--| process_standard_key_release. If `Current' is contained in a modal or
--| modeless_dialog, we also now force the calling of the key_press and
--| key_release actions on this dialog before they are called on the widget.
--| This is necessary as windows does not seem to send a notification to
--| the dialog.
--|
--| Revision 1.49.4.72  2001/04/24 19:06:50  rogers
--| Removed code in key handling which would fire the left_meta and right_meta
--| actions when alt was pressed. This was a mistake in the understanding of
--| which key the meta keys were.
--|
--| Revision 1.49.4.71  2001/03/30 23:48:47  rogers
--| Process_standard_key_press is now exported to EV_DIALOG_IMP_COMMON.
--|
--| Revision 1.49.4.70  2001/03/30 22:53:54  rogers
--| On_set_focus now uses application_imp directly.
--|
--| Revision 1.49.4.69  2001/03/30 01:17:24  rogers
--| Fixed bug in on_mouse_move. Now the enter and leave actions are no
--| longer fired every time the mouse moves while a pick and drop is
--| executing and not over the "original" widget.
--|
--| Revision 1.49.4.68  2001/03/30 00:16:31  rogers
--| Corrected comment in on_mouse_leave.
--|
--| Revision 1.49.4.66  2001/03/16 19:21:19  rogers
--| Added update_for_pick_and_drop as deferred.
--|
--| Revision 1.49.4.65  2001/03/14 19:16:12  rogers
--| Added propagate_syncpaint message.
--|
--| Revision 1.49.4.64  2001/02/25 17:56:28  pichery
--| Added tight reference tracking for GDI objects.
--|
--| Revision 1.49.4.63  2001/02/10 01:41:09  rogers
--| `Process_code_if_alt' now uses `application_imp' inherited from
--| EV_PICK_AND_DROPABLE_IMP.
--|
--| Revision 1.49.4.62  2001/01/27 01:06:02  rogers
--| Removed unreferenced local and improved fixme comment.
--|
--| Revision 1.49.4.61  2001/01/26 23:41:22  rogers
--| Further improvements/refactoring on handling key press/release events.
--| Added on_sys_key_up as deferred, to handle the alt key  or F10 being
--| released.
--|
--| Revision 1.49.4.60  2001/01/25 17:55:15  rogers
--| Added process_standard_key_press. Repeated code from on_key_down and
--| on_sys_key_down has been re-factored into this new feature.
--|
--| Revision 1.49.4.59  2001/01/25 01:14:07  rogers
--| Fixed bug in on_button_double_click. Previously the button_press_actions
--| were called instead of the double_press_actions under certain
--| circumstances.
--|
--| Revision 1.49.4.58  2001/01/24 21:06:35  rogers
--| Fixed on_key_down and on_sys_key_down so that they can distinguish
--| between the left and right meta keys.
--|
--| Revision 1.49.4.57  2001/01/24 00:58:40  rogers
--| On_sys_key_down now calls the key_press_actions. Pressing F10 previously
--| did not call the key_press_actions.
--|
--| Revision 1.49.4.56  2001/01/23 00:37:15  rogers
--| Fixed bug with on_button_double_click. The double click event is now
--| handled by PND. For example, double clicking will start and end a PND.
--|
--| Revision 1.49.4.55  2001/01/09 23:15:29  rogers
--| Improved comment for cursor_on_widget.
--|
--| Revision 1.49.4.53  2001/01/09 18:55:16  rogers
--| Added track_mouse_event as deferred, added default_process_message.
--| Modified on_mouse_move. These changes were made to fix the bug in
--| pointer_leave_actions which would only ever be called when the pointer
--| entered a new widget in the application, instead of when the pointer
--| actually left the current widget.
--|
--| Revision 1.49.4.52  2000/12/29 23:53:11  rogers
--| On_left_button_down now disables default processing if the current press
--| is about to end a pick and drop.
--|
--| Revision 1.49.4.51  2000/12/13 18:24:33  rogers
--| Tightened export status of background_color_imp, foreground_color_imp
--| and parent_imp.
--|
--| Revision 1.49.4.50  2000/11/22 18:43:06  rogers
--| Removed unreferenced variable from on_key_down.
--|
--| Revision 1.49.4.49  2000/11/20 18:18:44  rogers
--| On_char now uses key.is_numpad instead of is_keypad.
--|
--| Revision 1.49.4.46  2000/11/16 18:31:27  rogers
--| Modified on_char so that the key string actions are only ever called
--| with a displayable character string or "" to represent a non displayable
--| character.
--|
--| Revision 1.49.4.45  2000/11/14 18:56:56  rogers
--| Implemented has_capture and added wel_has_capture as deferred.
--|
--| Revision 1.49.4.44  2000/11/06 19:37:09  king
--| Accounted for default to stock name change
--|
--| Revision 1.49.4.43  2000/11/06 17:52:38  rogers
--| Modified on_key_down to call escape_pnd. Added on_sys_key_down which
--| calls escape_pnd if the Alt key is pressed. This will now automatically
--| stop an executing pick and drop before a user is able to press Alt tab
--| to change windows.
--|
--| Revision 1.49.4.42  2000/11/03 23:36:38  rogers
--| Modified on_key_down, so that if escape has been pressed, we cancel a
--| pick and drop if one is executing.
--|
--| Revision 1.49.4.41  2000/11/01 01:43:18  rogers
--| Modified on_set_focus so it sets the window_with_focus in application
--| to an EV_TITLED_WINDOW instead of an EV_WINDOW.
--|
--| Revision 1.49.4.40  2000/10/27 02:11:17  manus
--| No more calls to `set_default_colors' from `initialize' since it is not needed
--| anymore. A Void background color means that is the default one.
--| To find out the default colors we introduced `wel_foreground_color' and `wel_background_color'
--| that returns the corresponding color if set, otherwise they return their default color.
--|
--| Revision 1.49.4.39  2000/10/25 03:11:51  manus
--| Fixed side effects of setting the cursor to a different shape. In `on_set_cursor' we should
--| test the `hit_code' to figure out if we have to change the shape or not, namely it has to be
--| done when the hit_code is either `nowhere' or `client'. The rest is taken care by Windows.
--|
--| Even though doing this fix, does not work for EV_SPLIT_AREA_IMP because the cursor it lost,
--| so I forced the setting of the cursor to its `class_cursor' when it was needed.
--|
--| Fixed a bug in EV_SPLIT_AREA_IMP and descendants where `cursor_on_widget' was not updated
--| in `on_mouse_move' because we forgot to call its Precursor.
--|
--| Revision 1.49.4.38  2000/10/24 16:39:53  rogers
--| Modified on_button_down so that `pointer_button_press_actions' are called
--| before a PND starts and after a PND ends.
--|
--| Revision 1.49.4.37  2000/10/20 00:26:31  rogers
--| Removed fixmes as there is nothing to fix and they are no longer relevent.
--|
--| Revision 1.49.4.36  2000/10/17 23:30:41  rogers
--| Removed call to key_press_string_actions as already implemented.
--|
--| Revision 1.49.4.35  2000/10/16 21:09:57  rogers
--| On_key_down now calls key_press_string_actions_internal. This fixes
--| the bug with key_press_string_actions never being called.
--|
--| Revision 1.49.4.34  2000/10/10 23:57:33  raphaels
--| Redefined `on_desactivate' to call `on_kill_focus'.
--|
--| Revision 1.49.4.33  2000/10/05 20:27:44  manus
--| Removed special notebook handling for `Tab' action. Now it will never stop on tab buttons
--| but this is better than completely loosing the focus.
--|
--| Revision 1.49.4.32  2000/09/13 21:37:06  rogers
--| Further optimization in on_mouse_move. Corrected mistake with t /= Void.
--|
--| Revision 1.49.4.31  2000/09/13 19:37:05  rogers
--| Performance optimization of on_mouse_move.
--|
--| Revision 1.49.4.30  2000/08/17 00:13:42  rogers
--| Added comments to has_parent and parent_is_sensitive.
--|
--| Revision 1.49.4.29  2000/08/15 23:53:10  rogers
--| Added parent_is_sensitive and has_parent which are required for contract
--| support for features inherited from EV_SENSITIVE_I.
--|
--| Revision 1.49.4.28  2000/08/11 18:59:03  rogers
--| Fixed copyright clause. Now use ! instead of |.
--|
--| Revision 1.49.4.27  2000/08/08 02:19:28  manus
--| Removed non-used deferred routines to avoid polymorphic tables.
--| Renamed `on_key_string' by `on_char' so that `Wm_char' messages are properly handled.
--| No need for redefining `window_process_message' because the new one from WEL will do
--|   what we want.
--| Removed useless assignment of Void to Result when it is not used.
--| `height' and `width' computation is done by using their `minimum_' counterpart before
--|   doing the max to `ev_*'.
--| `x_position' and `y_position' are retrieved from WEL when widget is shown, otherwise
--|   from `child_cell'.
--| `hide/show' calls directly `notify_change' on parent if any.
--| We call `ev_set_minimum_*' instead of `internal_set_minimum*'
--| Optimization of `on_size' with new action sequences.
--| Cosmetics
--|
--| Revision 1.49.4.26  2000/08/04 00:51:40  rogers
--| Replaced action sequence calls made through the interface of `Current' with
--| calls to the internal action sequences.
--|
--| Revision 1.49.4.25  2000/08/03 17:03:33  rogers
--| Removed the split_area fix from x_position and y_position. The split area
--| is now actually the parent of `Current', so no special code is now required
--| to calculate the position realtive to the parent.
--|
--| Revision 1.49.4.24  2000/07/25 23:26:43  rogers
--| x_position and y_position had a fix for EV_SPLIT_AREA, which is being
--| re-implemetned. Therefore the fix has been commented as it will no longer
--| work with the new implementation, and it may also be fixed.
--|
--| Revision 1.49.4.23  2000/07/25 22:20:00  brendel
--| Reduced duplicate code.
--| Added feature translate_coordinates, redefined by EV_PIXMAP_IMP_WIDGET
--| to avoid redefinition of all coordinate events.
--|
--| Revision 1.49.4.22  2000/07/24 22:50:56  rogers
--| Now inherits EV_WIDGET_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.49.4.21  2000/07/13 17:49:13  rogers
--| Screen_y now takes into account the height of the menu if `Current' is of
--| type EV_wINDOW_IMP. All widgets that were contained in a window with a menu
--| had incorrect screen_y positions before this fix.
--|
--| Revision 1.49.4.20  2000/07/12 16:27:42  rogers
--| Modified to correct x_position and y_position for widgets contained within
--| EV_SPLIT_AREA. Added window_rect, absolute_y, absolute_x as deferred.
--| Implemented x_position and y_position with fix for children of
--| EV_SPLIT_AREA as they are not actually contained in the split area, but in
--| cells which are contained in the split area.
--|
--| Revision 1.49.4.19  2000/06/27 08:20:45  pichery
--| - Improved `show' and `hide' in order to avoid infinite loops
--|
--| Revision 1.49.4.18  2000/06/13 18:28:46  rogers
--| Removed inheritance from EV_EVENT_HANDLER_IMP. This was used by the old
--| event system and therefore is redundent in the current implementation of
--| Vision2.
--|
--| Revision 1.49.4.16  2000/06/05 21:08:03  manus
--| Updated call to `notify_parent' because it requires now an extra parameter which is
--| tells the parent which children did request the change. Usefull in case of NOTEBOOK
--| for performance reasons (See EV_NOTEBOOK_IMP log for more details)
--|
--| Revision 1.49.4.15  2000/05/30 16:46:53  rogers
--| Removed debugging io.putstrings from on_key_up and on_key_down.
--|
--| Revision 1.49.4.14  2000/05/30 16:20:33  rogers
--| Removed unreferenced local variables.
--|
--| Revision 1.49.4.13  2000/05/22 18:58:41  rogers
--| changed top_level_window: EV_TITLED_WINDOW to EV_WINDOW to fix bug in
--| creation of EV_WINDOW with the setting of the focus to that window.
--|
--| Revision 1.49.4.12  2000/05/20 00:25:03  rogers
--| Removed debuggging io.putstrings.
--|
--| Revision 1.49.4.10  2000/05/15 21:59:51  rogers
--| On_mouse_move now only calls pnd_motion if the transport is enabled
--| unless `Current' has drag and drop.
--|
--| Revision 1.49.4.9  2000/05/10 23:10:01  king
--| Integrated tooltipable changes
--|
--| Revision 1.49.4.8  2000/05/09 18:40:03  brendel
--| Whoops! Once again, we need HEIGHT->INTEGER and WIDTH->INTEGER!!!
--|
--| Revision 1.49.4.7  2000/05/08 22:13:17  brendel
--| Changed width and height again while waiting for a size specification.
--|
--| Revision 1.49.4.6  2000/05/05 22:30:39  pichery
--| Removed useless comment
--|
--| Revision 1.49.4.5  2000/05/04 17:34:07  brendel
--| Changed `width' and `height' back. Size can be less than minimum size.
--|
--| Revision 1.49.4.4  2000/05/04 04:25:39  pichery
--| Adaptation to the new EV_CURSOR class.
--|
--| Revision 1.49.4.3  2000/05/03 22:35:01  brendel
--| Fixed resize_actions.
--|
--| Revision 1.49.4.2  2000/05/03 22:22:39  pichery
--| - Fixed bug in features `width' and `height'. We now
--| return the wel size or the minimal size depending on
--| which is valid.
--|
--| Revision 1.49.4.1  2000/05/03 19:09:19  oconnor
--| mergred from HEAD
--|
--| Revision 1.73  2000/05/03 16:57:04  rogers
--| Comments, formatting.
--|
--| Revision 1.72  2000/05/03 00:32:40  pichery
--| Changed constants retrieval
--|
--| Revision 1.71  2000/05/01 23:28:47  rogers
--| Implemented pointer_position.
--|
--| Revision 1.70  2000/05/01 19:33:59  pichery
--| Added feature `is_control_in_window' used
--| to determine if a certain control is contained
--| inside the current window.
--|
--| Revision 1.69  2000/04/29 03:21:26  pichery
--| Removed Constants from inheritance
--|
--| Revision 1.68  2000/04/27 16:33:08  rogers
--| On_left_button_up now calls check_drag_and_drop_release which
--| will end current drag and drop if underway.
--|
--| Revision 1.67  2000/04/14 20:54:20  brendel
--| Removed on_parented and on_orphaned.
--|
--| Revision 1.66  2000/04/10 17:04:19  rogers
--| Commented client to screen.
--|
--| Revision 1.65  2000/04/03 17:52:25  rogers
--| Fixed initialize so windows are no longer shown as default.
--|
--| Revision 1.64  2000/03/29 01:18:30  brendel
--| Improved `parent'.
--|
--| Revision 1.63  2000/03/23 23:23:41  brendel
--| Renamed on_contained to on_parented.
--| Added on_orphaned.
--|
--| Revision 1.62  2000/03/23 01:14:28  brendel
--| Widget is now only shown by default if it is not of type EV_TITLED_WINDOW
--| Removed obsolete accelerator code.
--| Cleaned up key event code.
--|
--| Revision 1.61  2000/03/21 02:29:07  brendel
--| Replaced unnecessary assignment attempt with assignment.
--|
--| Revision 1.60  2000/03/20 23:23:23  pichery
--| - Added `on_contained' notion. A widget is now notified when it is put
--|   in a container (usefull for pixmap)
--|
--| Revision 1.59  2000/03/17 23:24:49  brendel
--| Implemented recently changed key event to take EV_KEY.
--|
--| Revision 1.58  2000/03/17 23:02:51  rogers
--| Removed set_pointer_style and cursor_imp. They are now in
--| EV_PICK_AND_DROPABLE.
--|
--| Revision 1.57  2000/03/17 18:20:31  rogers
--| Implemented screen_x and screen_y as they are now deferred from EV_WIDGET_I.
--| Removed set_vertical_resize, set_horizontal_resize.
--|
--| Revision 1.56  2000/03/14 20:02:36  brendel
--| Rearranged initialization.
--|
--| Revision 1.55  2000/03/14 18:45:10  rogers
--| Uncommented pnd_press in on_right_button_down.
--|
--| Revision 1.54  2000/03/14 03:02:54  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.53  2000/03/09 21:10:05  rogers
--| All calls to interface.pointer.button_***_actions are passes 0.0 instead of 
--| 0.
--|
--| Revision 1.52.2.2  2000/03/09 21:39:47  brendel
--| Replaced x with x_position and y with y_position.
--| Before, both were available.
--|
--| Revision 1.52.2.1  2000/03/09 17:53:04  brendel
--| Removed inheritance of EV_SIZEABLE_IMP.
--|
--| Revision 1.52  2000/02/19 06:34:13  oconnor
--| removed old command stuff
--|
--| Revision 1.51  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.50  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.49.6.17  2000/02/09 01:23:59  pichery
--| - implemented key_press_string_actions for Windows platforms
--|
--| Revision 1.49.6.16  2000/02/07 20:44:25  rogers
--| Removed old command association which is redundent now.
--|
--| Revision 1.49.6.15  2000/02/06 22:10:44  brendel
--| Changed 0 to 0.0 in call to action sequence where doubles where expected
--| instead of integers. (Fails on `valid_operands').
--|
--| Revision 1.49.6.14  2000/02/06 21:21:05  brendel
--| Fixed bug in call to pointer_motion_actions, where the 3rd, 4th and 5th
--| argument were integers instead of reals.
--|
--| Revision 1.49.6.13  2000/02/04 19:09:21  rogers
--| Replaced all references to displayed with is_displayed.
--|
--| Revision 1.49.6.12  2000/01/29 01:14:01  brendel
--| Added not yet implemented tootip features.
--|
--| Revision 1.49.6.11  2000/01/29 01:00:46  brendel
--| Changed removing of Current from parent when destroyed.
--|
--| Revision 1.49.6.10  2000/01/27 19:30:17  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.49.6.9  2000/01/26 20:00:43  brendel
--| Merged versions 1.49.1.6 and 1.49.1.8.
--|
--| Revision 1.49.6.6  2000/01/25 17:37:51  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.49.6.5  2000/01/21 23:17:01  brendel
--| Removed deferred features set_capture and release_capture.
--|
--| Revision 1.49.6.4  2000/01/19 23:49:02  rogers
--| Added show to initialize, and added managed which means that all widgets
--| are automatically managed by their parents.
--|
--| Revision 1.49.6.3  1999/12/22 17:54:15  rogers
--| Implemented most of the mouse actions to use the new events.
--|
--| Revision 1.49.6.2  1999/12/17 01:00:56  rogers
--| Altered to fit in with the review branch. No inherits
--| EV_PICK_AND_DROPABLE instead of the two old pick and drop classe.
--| is_show_requested replaces shown.
--|
--| Revision 1.49.6.1  1999/11/24 17:30:23  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.49.2.3  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
