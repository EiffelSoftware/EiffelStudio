--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision untitled window, mswindows implementation."
	note: " In the implementation of the window, we use internal_changes to know%
		% if the user changed the size of the window. In this case, we won't%
		% resize it to the minimum_size. The bit used are the following:%
		% bit 7 -> The user has set the width of the window while it was hidden (64),%
		% bit 8 -> The user has set the height of the window shile it was hidden (128)."
	id: "$Id$"
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
			interface
		end

	EV_SINGLE_CHILD_CONTAINER_IMP
		export
			{NONE} set_parent
		undefine
			set_default_colors,
			show,
			hide
		redefine
			destroy,
			set_parent,
			set_width,
			set_height,
			set_size,
			client_height,
			parent_ask_resize,
			dimensions_set,
			set_default_minimum_size,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size,
			internal_set_minimum_width,
			internal_set_minimum_height,
			internal_set_minimum_size,
			on_destroy,
			notebook_parent,
			interface
		end

	WEL_FRAME_WINDOW
		rename
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			set_width as wel_set_width,
			set_height as wel_set_height,
			item as wel_item,
			move as move_to,
			enabled as is_sensitive,
			set_x as set_x_position,
			set_y as set_y_position,
			width as wel_width,
			height as wel_height
		undefine
			remove_command,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_menu_command,
			background_brush,
			on_draw_item,
			on_accelerator_command,
			on_set_cursor,
			window_process_message,
			on_color_control,
			on_wm_vscroll,
			on_wm_hscroll,
			on_destroy
		redefine
			default_ex_style,
			default_style,
			on_size,
			on_get_min_max_info,
			on_destroy,
			on_show,
			on_move,
			closeable,
			default_process_message,
			move_and_resize
		end

	WEL_MA_CONSTANTS
		export
			{NONE} all
		end

	WEL_SIZE_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a window. Window does not have any
			-- parents
		do
			base_make (an_interface)
			make_top ("")
		end

feature -- Access

	client_height: INTEGER is
			-- Height of the client area of container
		do
			Result := client_rect.height
			if status_bar /= Void then
				Result := (Result - status_bar.height).max (0)
			end
		end

	maximum_height: INTEGER
			-- Maximum height that application wishes widget
			-- instance to have

	maximum_width: INTEGER
			-- Maximum width that application wishes widget
			-- instance to have

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		do
			Result := text
       	end

	widget_group: EV_WIDGET is
			-- Widget with wich current widget is associated.
			-- By convention this widget is the "leader" of a group
			-- widgets. Window manager will treat all widgets in
			-- a group in some way; for example, it may move or
			-- iconify them together
		do
			check
				not_yet_implemented: False
			end
		end 

	top_level_window_imp: like Current is
			-- Top level window that contains the current widget.
		do
			Result := Current
		end
    
	menu_bar: EV_MENU_BAR
			-- Horizontal bar at top of client area that contains menu's.

	status_bar: EV_STATUS_BAR
			-- Status bar of the window.

	notebook_parent: ARRAYED_LIST[EV_NOTEBOOK_IMP] is
			-- By default all windows are not notebooks.
			-- Redefined in EV_NOTEBOOK.
		do
			Result := Void
		end

	blocking_window: EV_WINDOW
			-- Window this dialog is a transient for.

	is_modal: BOOLEAN
			-- Must the window be closed before application continues?

feature -- Status setting

	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			application.item.remove_root_window (interface)
			if parent_imp /= Void then
				parent_imp.disable_sensitive
			end
			wel_destroy
		end

	set_default_minimum_size is
			-- Initialize the size of the widget.
		do
			internal_set_minimum_size (window_minimum_width, window_minimum_height)
			set_maximum_width (maximized_window_width)
			set_maximum_height (maximized_window_height)
		end

--	set_horizontal_resize (flag: BOOLEAN) is
--			-- Allow the window to be verticaly resized.
--		do
--			{EV_CONTAINER_IMP} Precursor (flag)
--			if flag then
--				min_track.set_x (width)
--				max_track.set_x (width)
--			else
--				min_track.set_x (minimum_width)
--				max_track.set_x (maximum_width)
--			end
--		end

--	set_vertical_resize (flag: BOOLEAN) is
--			-- Allow the window to be horizontaly resized.
--		do
--			{EV_CONTAINER_IMP} Precursor (flag)
--			if flag then
--				min_track.set_y (height)
--				max_track.set_y (height)
--			else
--				min_track.set_y (maximum_height)
--				max_track.set_y (maximum_height)
--			end
--		end

	forbid_resize is
			-- Forbid the resize of the window.
		local
			new_style: INTEGER
		do
			new_style := style
			new_style := clear_flag (new_style, Ws_maximizebox)
			new_style := clear_flag (new_style, Ws_minimizebox)
			new_style := clear_flag (new_style, Ws_sizebox)
			set_style (new_style)
			if is_show_requested then
				hide
				show
			end
		end

	allow_resize is
			-- Allow the resize of the window.
		local
			new_style: INTEGER
		do
			new_style := style
			new_style := set_flag (new_style, Ws_maximizebox)
			new_style := set_flag (new_style, Ws_minimizebox)
			new_style := set_flag (new_style, Ws_sizebox)
			set_style (new_style)
			if is_show_requested then
				hide
				show
			end
		end

feature -- Element change

	--|FIXME This should no longer be required.
	--|Julian Rogers  12021999
	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
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
			-- If the Current size is larger, the size
			-- change.
		do
			maximum_width := value
			if value < width then
				resize (value, height)
			end
		end

	set_maximum_height (value: INTEGER) is
			-- Make `value' the new maximum height.
			-- If the Current size is larger, the size
			-- change.
		do
			maximum_height := value
			if value < height then
				resize (width, value)
			end
		end

	set_title (txt: STRING) is
			-- Make `txt' the title of the window.            
		do
			set_text (txt)
		end

	set_widget_group (widget: EV_WIDGET) is
			-- Make Current part of the group of `widget'.
		do
			check
				not_yet_implemented: False
			end
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR) is
			-- Set `menu_bar' to `a_menu_bar'.
		local
			mb_imp: WEL_MENU
		do
			menu_bar := a_menu_bar
			mb_imp ?= menu_bar.implementation
			set_menu (mb_imp)
			compute_minimum_height
		end

	remove_menu_bar is
			-- Set `menu_bar' to `Void'.
		do
			menu_bar := Void
			unset_menu
			compute_minimum_height
		end

	set_status_bar (a_bar: EV_STATUS_BAR) is
			-- Make `a_bar' the new status bar of the window.
		do
			status_bar := a_bar
			compute_minimum_height
		end

	remove_status_bar is
			-- Remove the current status bar of the window.
		do
			status_bar := Void
			compute_minimum_height
		end

	enable_modal is
			-- Set `is_modal' to `True'.
		do
			is_modal := True
			enable_capture
		end

	disable_modal is
			-- Set `is_modal' to `False'.
		do
			is_modal := False
			disable_capture
		end

	set_blocking_window (a_window: EV_WINDOW) is
			-- Set as transient for `a_window'.
		do
			blocking_window := a_window
		end

feature -- Resizing

	set_size (w, h: INTEGER) is
			-- Resize the widget when it is not managed.
			-- We don't redefine it because of the post-conditions.
		do
			if is_show_requested then
				resize (w.max (minimum_width).min (maximum_width), h.max (minimum_height).min (maximum_height))
			else
				internal_changes := set_bit (internal_changes, 64, True)
				internal_changes := set_bit (internal_changes, 128, True)
				resize (w, h)
			end
		end

	set_width (value:INTEGER) is
			-- Make `value' the new width of the widget when
			-- it is not managed.
		do
			if is_show_requested then
				wel_set_width (value.max (minimum_width).min (maximum_width))
			else
				internal_changes := set_bit (internal_changes, 64, True)
				wel_set_width (value)
			end
		end

	set_height (value: INTEGER) is
			-- Make `value' the new height of the widget when
			-- it is not managed.
		do
			if is_show_requested then
				wel_set_height (value.max (minimum_height).min (maximum_height))
			else
				internal_changes := set_bit (internal_changes, 128, True)
				wel_set_height (value)
			end
		end

feature -- Event - command association

	add_close_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the window is closed.
		do
			add_command (Cmd_close, cmd, arg)
		end

	add_resize_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the window is resized.
		do
			add_command (Cmd_size, cmd, arg)
		end

	add_move_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget is resized.
		do
			add_command (Cmd_move, cmd, arg)
		end

feature -- Event -- removing command association

	remove_close_commands is
			-- Empty the list of commands to be executed
			-- when the window is closed.
		do
			remove_command (Cmd_close)
		end

	remove_resize_commands is
			-- Empty the list of commands to be executed
			-- when the window is resized.
		do
			remove_command (Cmd_size)
		end

	remove_move_commands is
			-- Empty the list of commands to be executed
			-- when the widget is resized.
		do
			remove_command (Cmd_move)
		end

feature -- Assertion features

	dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
			-- we must redefine it because windows do not
			-- allow as little windows as we want.
		do
			Result := (width = new_width or else width = minimum_width.max (window_minimum_width) or else width = maximum_width) and then
				  (height = new_height or else height = minimum_height.max (window_minimum_height)or else height = maximum_height)
		end

feature {NONE} -- Implementation

	internal_set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
			-- If the Current size is smaller, the size
			-- change.
		do
			{EV_SINGLE_CHILD_CONTAINER_IMP} Precursor (value)
			if value > width then
				resize (value, height)
			end
		end

	internal_set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height'.
			-- If the Current size is smaller, the size
			-- change.
		do
			{EV_SINGLE_CHILD_CONTAINER_IMP} Precursor (value)
			if value > height then
				resize (width, value)
			end
		end

	internal_set_minimum_size (mw, mh: INTEGER) is
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height. If the Current size is smaller,
			-- the size change.
		do
			{EV_SINGLE_CHILD_CONTAINER_IMP} Precursor (mw, mh)
			if mw > width then
				if mh > height then
					resize (mw, mh)
				else
					resize (mw, height)
				end
			elseif mh > height then
				resize (width, mh)
			end
		end

	compute_minimum_width is
			-- Recompute the minimum width of the object.
		local
			mw: INTEGER
		do
			-- We calculate the values first
			mw := 2 * window_frame_width

			if child /= Void then
				mw := mw + child.minimum_width
			end

			-- Finaly, we set the value
			internal_set_minimum_width (mw)
		end

	compute_minimum_height is
			-- Recompute the minimum height of the object.
		local
			mh: INTEGER
		do
			-- We calculate the values first
			mh := 2 * window_frame_height

			if child /= Void then
				mh := mh + child.minimum_height
			end
			if has_menu then
				mh := mh + menu_bar_height
			end
			if status_bar /= Void then
				mh := mh + status_bar.height
			end

			-- Finaly, we set the value
			internal_set_minimum_height (mh)
		end

	compute_minimum_size is
			-- Recompute the minimum size of the object.
		local
			mw, mh: INTEGER
		do
			-- We calculate the values first
			mw := 2 * window_frame_width
			mh := 2 * window_frame_height

			if child /= Void then
				mw := mw + child.minimum_width
				mh := mh + child.minimum_height
			end
			if has_menu then
				mh := mh + menu_bar_height
			end
			if status_bar /= Void then
				mh := mh + status_bar.height
			end

			-- Finaly, we set the value
			internal_set_minimum_size (mw, mh)
		end

feature {NONE} -- Inapplicable

	parent_ask_resize (a_width, a_height: INTEGER) is
			-- When the parent asks the resize, it's not
			-- necessary to send him back the information
			-- Can be called but do nothing.
		do
			check
				Inapplicable: True
			end
		end

	set_top_level_window_imp (a_window: EV_TITLED_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		do
			check
				Inapplicable: True
			end
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
		-- Set with the option `Ws_clipchildren' to avoid flashing.
		do
			Result := Ws_popup + Ws_overlapped + Ws_dlgframe
					+ Ws_clipchildren + Ws_clipsiblings
		end

	default_ex_style: INTEGER is
		do
			Result := Ws_ex_controlparent
		end

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		do
			{WEL_FRAME_WINDOW} Precursor (a_x, a_y, a_width, a_height, repaint)
			if a_width = width and a_height = height then
				on_size (0, a_width, a_height)
			end
		end

	default_process_message (msg, wparam, lparam: INTEGER) is
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
			if msg = Wm_mouseactivate then
				on_wm_mouseactivate (wparam, lparam)
			end
		end

	on_show is
			-- When the window receive the on_show message,
			-- it resizes the window at the size of the child.
			-- And it send the message to the child because wel
			-- don't
		local
			w, h: INTEGER
		do
			-- The width to give to the window
			if bit_set (internal_changes, 64) then
				w := width
				internal_changes := set_bit (internal_changes, 64, False)
			else
				w := 0
			end

			-- The height to give to the window
			if bit_set (internal_changes, 128) then
				h := height
				internal_changes := set_bit (internal_changes, 128, False)
			else
				h := 0
			end

			-- We check if there is a menu
			if has_menu then
				draw_menu
			end

			-- We resize everything and draw the menu.
			resize (w.max (minimum_width).min (maximum_width), h.max (minimum_height).min (maximum_height))
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Called when the window is resized.
			-- Resize the child if it exists.
		local
			sb_imp: EV_STATUS_BAR_IMP
		do
			if size_type /= size_minimized then
				if child /= Void then
					child.parent_ask_resize (client_width, client_height)
				end
				if status_bar /= Void then
					sb_imp ?= status_bar.implementation
					if sb_imp /= Void then
						sb_imp.reposition
					end
				end
				interface.resize_actions.call ([x, y, a_width, a_height])
			end
		end

   	on_move (x_pos, y_pos: INTEGER) is
   			-- Wm_move message.
   			-- This message is sent after a window has been moved.
   			-- `x_pos' specifies the x-coordinate of the upper-left
   			-- corner of the client area of the window.
   			-- `y_pos' specifies the y-coordinate of the upper-left
   			-- corner of the client area of the window.
   		do
 		end

	closeable: BOOLEAN is
			-- Can the user close the window?
			-- Yes by default.
		do
			--|FIXME is this a command or a query, seperate?
			--if (command_list = Void) or else 
			--		(command_list @ Cmd_close) = Void then
			--	Result := True
			--	interface.remove_implementation
			--else
			--	execute_command (Cmd_close, Void)
			--	Result := False
			--end
		end

	on_get_min_max_info (min_max_info: WEL_MIN_MAX_INFO) is
		local
			min_track, max_track: WEL_POINT
			w, h: BOOLEAN
		do
			w := horizontal_resizable
			h := vertical_resizable
			if w and h then
				!! min_track.make (internal_minimum_width, internal_minimum_height)
				!! max_track.make (maximum_width, maximum_height)
			elseif w then
				!! min_track.make (internal_minimum_width, height)
				!! max_track.make (maximum_width, height)
			elseif h then
				!! min_track.make (width, internal_minimum_height)
				!! max_track.make (width, maximum_height)
			else
				!! min_track.make (width, height)
				!! max_track.make (width, height)
			end
			min_max_info.set_min_track_size (min_track)
			min_max_info.set_max_track_size (max_track)
		end

	on_destroy is
			-- Called when the window is destroy.
			-- Set the parent sensitive if it exists.
		do
			{EV_SINGLE_CHILD_CONTAINER_IMP} Precursor
			if parent_imp /= Void and not parent_imp.destroyed and then not parent_imp.is_sensitive then
				parent_imp.disable_sensitive
			end
		end

	on_wm_mouseactivate (wparam, lparam: INTEGER) is
			-- The window have been activated thanks to the click of a window.
			-- If it was a right click, we do not raise the window to the front of
			-- the screen because of the pick-and-drop.
		local
			msg: INTEGER
		do
			msg := cwin_hi_word (lparam)
			if msg = Wm_rbuttondown then
				set_message_return_value (Ma_noactivate)
			end
		end

feature {EV_PND_TRANSPORTER_IMP}

	title_height: INTEGER is
			-- `Result' is absolute x position of client rect.
		do
			Result := title_bar_height
		end

	frame_height: INTEGER is
		do
			Result := window_frame_height
		end

	frame_width: INTEGER is
		do
			Result := window_frame_width
		end
	
	border_width: INTEGER is
		do
			Result := window_border_width
		end

feature {NONE} -- Feature that should be directly implemented by externals

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

feature --

	interface: EV_WINDOW

end -- class EV_WINDOW_IMP

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
