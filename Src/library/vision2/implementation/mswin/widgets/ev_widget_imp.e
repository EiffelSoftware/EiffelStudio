--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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
	id: "$Id$"
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

	EV_EVENT_HANDLER_IMP

	EV_WIDGET_EVENTS_CONSTANTS_IMP

	EV_ACCELERATOR_HANDLER_IMP

	EV_PICK_AND_DROPABLE_IMP
		redefine	
			interface
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

	WEL_WM_CONSTANTS
		export
			{NONE} all
		end

	WEL_WS_CONSTANTS
		export
			{NONE} all
		end

	WEL_MK_CONSTANTS
		export
			{NONE} all
		end

	WEL_VK_CONSTANTS
		export
			{NONE} all
		end

	WEL_SW_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	initialize  is
			-- Creation of the widget.
		do
			create child_cell
			set_vertical_resize (True)
			set_horizontal_resize (True)
			set_default_colors
			set_default_minimum_size
			show
			is_initialized := True
		end

feature -- Access

	pointer_position: EV_COORDINATES is
			-- Position of the screen pointer relative to `Current'.
		do
			--|FIXME
			check
				False
			end
			create Result
		end

	pointer_style: EV_CURSOR is
			-- Cursor used currently on the widget.
		do
			if cursor_imp = Void then
--				!! Result.make
				Result := Void
			else
				Result ?= cursor_imp.interface
			end
		end

	background_color: EV_COLOR is
			-- Color used for the background of the widget
		do
			if background_color_imp /= Void then
				Result ?= background_color_imp.interface
			else
				Result := Void
			end
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of the widget
		do
			if foreground_color_imp /= Void then
				Result ?= foreground_color_imp.interface
			else
				Result := Void
			end
		end

	tooltip: STRING is
			-- Text displayed when user moves mouse over widget.
		do
			check
				to_be_implemented: False
			end
		end

	top_level_window: EV_TITLED_WINDOW is
			-- Top level window that contains the current widget.
		do
			Result ?= top_level_window_imp.interface
		end

	default_parent: EV_INTERNAL_SILLY_WINDOW_IMP is
			-- A default parent for creation of the widgets.
		once
			!! Result.make_top ("Eiffel Vision default parent window")
		ensure
			valid_parent: Result /= Void
		end

	focus_on_widget: CELL [EV_WIDGET_IMP] is
			-- Widget that has currently the focus.
		once
			!! Result.put (Void)
		end

	cursor_on_widget: CELL [EV_WIDGET_IMP] is
			-- This cell contains the widget_imp that currently
			-- has the pointer of the mouse. As it is a once 
			-- feature, it is a shared data.
			-- it is used for the `mouse_enter' and `mouse_leave'
			-- events.
		once
			!! Result.put (Void)
		ensure
			result_exists: Result /= Void
		end

	notebook_parent: ARRAYED_LIST[EV_NOTEBOOK_IMP] is
			-- Search recursively for the ancestors of type notebook.
			-- Result = list of notebook ancestors.
			-- Result can be empty.
		do
			if parent_imp /=Void then
				Result := parent_imp.notebook_parent
			end
		end

	x_position: INTEGER is
			-- Widget x position.
		do
			Result := x
		end

	y_position: INTEGER is
			-- Widget y position.
		do
			Result := y
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
		do
			--|FIXME During the major changes to vision
			--|This code was changed to wel_width.max (minimum_width)
			--|It has been changed back, but could possibly violate some
			--|Tight assertions
			--|See assertions on EV_WIDGET and EV_WIDGET_I
			--|Needs to be changed so the user can never return a minimum height
			--|Less than the height
			Result := wel_width
		end

	wel_height: INTEGER is
		deferred
		end

	height: INTEGER is
		do
			--|FIXME During the major changes to vision
			--|This code was changed to wel_height.max (minimum_height)
			--|It has been changed back, but could possibly violate some
			--|Tight assertions
			--|See assertions on EV_WIDGET and EV_WIDGET_I
			--|Needs to be changed so the user can never return a minimum height
			--|Less than the height
			Result := wel_height
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current widget destroyed ?
		do
			Result := not exists
		end

	is_show_requested: BOOLEAN is
			-- Is the widget shown in its parent?
		do
			Result := flag_set (style, Ws_visible)
		end

	managed: BOOLEAN is true

feature -- Status setting

	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				--parent_imp.remove_child (Current)
				parent_imp.interface.prune (Current.interface)
			end
			wel_destroy
			is_destroyed := True
			destroy_just_called := True
		end

	show is
			-- Show the window
			-- Need to notify the parent.
		do
			show_window (wel_item, Sw_show)
			if parent_imp /= Void then
				parent_imp.notify_change (1 + 2)
			end
		end

	hide is
			-- Hide the window
		do
			show_window (wel_item, Sw_hide)
			if parent_imp /= Void then
				parent_imp.notify_change (1 + 2)
			end
		end

	disable_sensitive is
			-- Set current widget in insensitive mode if
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
		do
			enable
		end

-- 	set_horizontal_resize (flag: BOOLEAN) is
-- 			-- Adapt `resize_type' to `flag'.
-- 		do
-- 			if flag then
-- 				if vertical_resizable then
-- 					resize_type := 3
-- 				else
-- 					resize_type := 1
-- 				end
-- 			else
-- 				if vertical_resizable then
-- 					resize_type := 2
-- 				else
-- 					resize_type := 0
-- 				end				
-- 			end
-- 			if parent_imp /= Void then
-- 				parent_ask_resize (child_cell.width, child_cell.height)
-- 			end
-- 		end
-- 
-- 	set_vertical_resize (flag: BOOLEAN) is
-- 			-- Adapt `resize_type' to `flag'.
-- 		do
-- 			if flag then
-- 				if horizontal_resizable then
-- 					resize_type := 3
-- 			else
-- 					resize_type := 2
-- 				end
-- 			else
-- 				if horizontal_resizable then
-- 					resize_type := 1
-- 				else
-- 					resize_type := 0
-- 				end				
-- 			end
-- 			if parent_imp /= Void then
-- 				parent_ask_resize (child_cell.width, child_cell.height)
-- 			end
-- 		end

	set_default_minimum_size is
			-- Initialize the size of the widget.
			-- Redefine by some widgets.
		do
			internal_set_minimum_size (0, 0)
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the
			-- default_parent.
		deferred
		end

	set_pointer_style (value: EV_CURSOR) is
			-- Make `value' the new cursor of the widget
		do
			if value /= Void then
				cursor_imp ?= value.implementation
				if cursor_on_widget.item = Current then
					cursor_imp.set
				end
			else
				cursor_imp := Void
			end
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

	set_tooltip (a_text: STRING) is
			-- Set `tooltip' to `a_text'.
	    do
			check
				to_be_implemented: False
			end
		end

	remove_tooltip is
			-- Set `tooltip' to `Void'.
	    do
			check
				to_be_implemented: False
			end
		end

feature -- Accelerators - command association

	add_accelerator_command (acc: EV_ACCELERATOR; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when `acc' is completed by the user.
		do
			add_accel_command (acc, cmd, arg)
		end

	remove_accelerator_commands (acc: EV_ACCELERATOR) is
			-- Empty the list of commands to be executed when
			-- `acc' is completed by the user.
		do
			remove_accel_commands (acc)
		end

feature -- Implementation

	cursor_imp: EV_CURSOR_IMP
			-- Current cursor used on the widget.

	background_color_imp: EV_COLOR_IMP
			-- Color used for the background of the widget

	foreground_color_imp: EV_COLOR_IMP
			-- Color used for the foreground of the widget,
			-- usually the text.

	parent_imp: EV_CONTAINER_IMP is
			-- Parent container of this widget. The same than
			-- parent but with a different type.
		do
			if wel_parent = default_parent then
				Result := Void
			else
				Result ?= wel_parent
			end
		end

feature {NONE} -- Implementation, mouse button events

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			pt: WEL_POINT
		do
			pt := client_to_screen (x_pos, y_pos)
			pnd_press (x_pos, y_pos, 1, pt.x, pt.y)
			interface.pointer_button_press_actions.call ([x_pos, y_pos, 1, 0.0, 0.0, 0.0, pt.x, pt.y])
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the middle button is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			pt: WEL_POINT
		do
			pt := client_to_screen (x_pos, y_pos)
			pnd_press (x_pos, y_pos, 2, pt.x, pt.y)
			interface.pointer_button_press_actions.call ([x_pos, y_pos, 2, 0, 0, 0, pt.x, pt.y])
		end
	
	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			pnd_press (x_pos, y_pos, 3, pt.x, pt.y)
			interface.pointer_button_press_actions.call ([x_pos, y_pos, 3, 0, 0, 0, pt.x, pt.y])
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			interface.pointer_button_release_actions.call ([x_pos, y_pos, 1, 0.0, 0.0, 0.0, pt.x, pt.y])
		end

	on_middle_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the middle button is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			interface.pointer_button_release_actions.call ([x_pos, y_pos, 2, 0, 0, 0, pt.x, pt.y])
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			interface.pointer_button_release_actions.call ([x_pos, y_pos, 3, 0, 0, 0, pt.x, pt.y])
		end

	on_left_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			interface.pointer_double_press_actions.call ([x_pos, y_pos, 1, 0, 0, 0, pt.x, pt.y])
		end

	on_middle_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			interface.pointer_double_press_actions.call ([x_pos, y_pos, 2, 0, 0, 0, pt.x, pt.y])
		end

	on_right_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			interface.pointer_double_press_actions.call ([x_pos, y_pos, 3, 0, 0, 0, pt.x, pt.y])
		end

feature {NONE} -- Implementation, mouse move, enter and leave events

	client_to_screen (a_x, a_y: INTEGER): WEL_POINT is
			-- 
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

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse move.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			wid: EV_WIDGET
			pt: WEL_POINT
		do
			pt := client_to_screen (x_pos, y_pos)
			pnd_motion (x_pos, y_pos, pt.x, pt.y)
			if cursor_on_widget.item /= Current then
				if cursor_on_widget.item /= Void then
					cursor_on_widget.item.on_mouse_leave
				end
				cursor_on_widget.replace (Current)
				on_mouse_enter
			end
			interface.pointer_motion_actions.call ([x_pos, y_pos, 0.0, 0.0, 0.0, pt.x, pt.y])
		end

	on_mouse_enter is
		do
			interface.pointer_enter_actions.call ([])
		end

feature {EV_WIDGET_IMP} -- on_mouse_leave must be visible 

	on_mouse_leave is
		do
			interface.pointer_leave_actions.call ([])
		end

feature {NONE} -- Implementation, key events

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Executed when a key is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			interface.key_press_actions.call ([virtual_key])
		end

	on_key_up (virtual_key, key_data: INTEGER) is
			-- Executed when a key is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			interface.key_release_actions.call ([virtual_key])
		end

	on_key_string (character_code, key_data: INTEGER) is
			-- Executed when a key is pressed.
		local	
			character_string: STRING
		do
			create character_string.make(1)
			character_string.append_character(character_code.ascii_char)
			interface.key_press_string_actions.call ([character_string])
		end

feature {NONE} -- Implementation, focus event

	on_set_focus is
			-- Wm_setfocus message
		local
			notebooks: ARRAY[EV_NOTEBOOK_IMP]
			counter: INTEGER
		do
				focus_on_widget.put (Current)
				interface.focus_in_actions.call ([])
				notebooks := notebook_parent
				if notebooks /= Void then
					from
						counter := 1
					until
						counter = notebooks.count + 1
					loop
						notebooks.item (counter).set_ex_style (Ws_ex_controlparent)
						counter := counter + 1
					end
				end
		end

	on_kill_focus is
			-- Wm_killfocus message
		local
			notebooks: ARRAY[EV_NOTEBOOK_IMP]
			counter: INTEGER
		do
			interface.focus_out_actions.call ([])
			notebooks := notebook_parent
			if notebooks /= Void then
				from
					counter :=1
				until
					counter = notebooks.count + 1
				loop
					notebooks.item (counter).set_ex_style (0)
					counter := counter + 1
				end
			end
		end

feature {NONE} -- Implementation, cursor of the widget

	on_set_cursor (hit_code: INTEGER) is
			-- Wm_setcursor message.
			-- See class WEL_HT_CONSTANTS for valid `hit_code' values.
		do
			if cursor_imp /= Void then
				cursor_imp.set
				set_message_return_value (1)
				disable_default_processing
			end
		end

feature {WEL_DISPATCHER} -- Message dispatcher

	window_process_message (hwnd: POINTER; msg,
			wparam, lparam: INTEGER): INTEGER is
			-- Call the routine `on_*' corresponding to the
			-- message `msg'.
		require
			exists: exists
		do
			if msg = Wm_mousemove then
				on_mouse_move (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_setcursor then
				on_set_cursor (cwin_lo_word (lparam))
			elseif msg = Wm_size then
				on_size (wparam,
					cwin_lo_word (lparam),
					cwin_hi_word (lparam))
			elseif msg = Wm_move then
				on_move (cwin_lo_word (lparam),
					cwin_hi_word (lparam))
			elseif msg = Wm_lbuttondown then
				on_left_button_down (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = wm_lbuttonup then
				on_left_button_up (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_lbuttondblclk then
				on_left_button_double_click (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_mbuttondown then
				on_middle_button_down (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_mbuttonup then
				on_middle_button_up (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_mbuttondblclk then
				on_middle_button_double_click (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_rbuttondown then
				on_right_button_down (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_rbuttonup then
				on_right_button_up (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_rbuttondblclk then
				on_right_button_double_click (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_timer then
				on_timer (wparam)
			elseif msg = Wm_setfocus then
				on_set_focus
			elseif msg = Wm_killfocus then
				on_kill_focus
			elseif msg = Wm_keydown then
				on_key_down (wparam, lparam)
			elseif msg = Wm_keyup then
				on_key_up (wparam, lparam)
			elseif msg = Wm_char then
				on_key_string (wparam, lparam)
			elseif msg = Wm_showwindow then
				on_wm_show_window (wparam, lparam)
			elseif msg = Wm_notify then
				on_wm_notify (wparam, lparam)
			elseif msg = Wm_destroy then
				on_wm_destroy
			else
				default_process_message (msg, wparam, lparam)
			end
		end

feature {NONE} -- Implementation, pick and drop

	widget_source: EV_WIDGET_IMP is
			-- Widget drag source used for transport
		do
			Result := Current
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_WIDGET

feature -- Deferred features

	top_level_window_imp: EV_WINDOW_IMP is
			-- Top level window that contains the current widget.
		deferred
		end

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
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
		deferred
		end

	on_move (x_pos, y_pos: INTEGER) is
			-- Wm_move message.
		deferred
		end

	on_wm_show_window (wparam, lparam: INTEGER) is
			-- Wm_showwindow message
		deferred
		end

	on_wm_notify (wparam, lparam: INTEGER) is
			-- Wm_notify message
		deferred
		end

	on_wm_destroy is
			-- Wm_destroy message.
			-- The window must be unregistered
		deferred
		end

	on_timer (timer_id: INTEGER) is
			-- Wm_timer message.
		deferred
		end

	default_process_message (msg, wparam, lparam: INTEGER) is
			-- Process `msg' which has not been processed by
			-- `process_message'.
		deferred
		end

	wel_parent: WEL_WINDOW is
		deferred
		end

	wel_set_parent (a_parent: WEL_WINDOW) is
		deferred
		end

	default_style: INTEGER is
		deferred
		end

	style: INTEGER is
		deferred
		end

	set_style (a_style: INTEGER) is
		deferred
		end

	client_rect: WEL_RECT is
		deferred
		end

	invalidate is
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

feature {NONE} -- Feature that should be directly implemented by externals

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		deferred
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		deferred
		end

feature -- Feature that should be directly implemented by externals

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		deferred
		end

end -- class EV_WIDGET_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--| Added show to initialize, and added managed which means that all widgets are automatically managed by their parents.
--|
--| Revision 1.49.6.3  1999/12/22 17:54:15  rogers
--| Implemented most of the mouse actions to use the new events.
--|
--| Revision 1.49.6.2  1999/12/17 01:00:56  rogers
--| Altered to fit in with the review branch. No inherits EV_PICK_AND_DROPABLE instead of the two old pick and drop classe. is_show_requested replaces shown.
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
