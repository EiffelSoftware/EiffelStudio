indexing
	description: "EiffelVision window. Display a window that allows only one%
		 	% child. Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_WINDOW_IMP

inherit
	EV_WINDOW_I
					
	EV_SINGLE_CHILD_CONTAINER_IMP
		export
			{NONE} set_expand
			{NONE} set_parent
		undefine
			set_width,
			set_height,
			set_default_colors
		redefine
			destroy,
			set_parent,
			set_size,
			client_height,
			set_minimum_width,
			set_minimum_height,
			child_minwidth_changed,
			child_minheight_changed,
			parent_ask_resize,
			dimensions_set,
			set_default_minimum_size
		end

	WEL_FRAME_WINDOW
		rename
			set_parent as wel_set_parent,
			destroy as wel_destroy
		undefine
			remove_command,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_char,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_menu_command,
			background_brush,
			on_draw_item
		redefine
			default_ex_style,
			default_style,
			set_menu,
			on_size,
			on_get_min_max_info,
			on_destroy,
			on_show,
			on_move,
			closeable
		end

creation
	make,
	make_with_owner

feature {NONE} -- Initialization

	make is
			-- Create a window. Window does not have any
			-- parents
		do
			make_top ("EV_WINDOW")
		end

	make_with_owner (par: EV_WINDOW) is
			-- Create a window with a parent.
			-- For a window, we cannot set the parent after or it does a 
		local
			ww: WEL_FRAME_WINDOW
		do
			ww ?= par.implementation
			check
				valid_owner: ww /= Void
			end
			make_child (ww, "EV_WINDOW")
		end

feature  -- Access

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

	icon_name: STRING is
			-- Short form of application name to be
			-- displayed by the window manager when
			-- application is iconified
		do
			check
           		not_yet_implemented: False
    		end
		end

	icon_mask: EV_PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		do
			check
                not_yet_implemented: False
            end
		end

	icon_pixmap: EV_PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		do
			check
	            not_yet_implemented: False
            end
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

	top_level_window_imp: WEL_WINDOW is
			-- Top level window that contains the current widget.
		do
			Result := Current
		end

	status_bar: EV_STATUS_BAR_IMP
			-- Status bar of the window.

feature -- Status report

	is_iconic_state: BOOLEAN is
			-- Does application start in iconic state?
		do
			check
                not_yet_implemented: False
            end
		end

feature -- Status setting

	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				parent_imp.set_insensitive (False)
			end
			wel_destroy
		end

	set_default_minimum_size is
			-- Initialize the size of the widget.
		do
			set_minimum_width (system_metrics.window_minimum_width)
			set_minimum_height (system_metrics.window_minimum_height)
			set_maximum_width (system_metrics.screen_width)
			set_maximum_height (system_metrics.screen_height)
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
			if shown then
				new_style := style
				new_style := clear_flag (new_style, Ws_maximizebox)
				new_style := clear_flag (new_style, Ws_minimizebox)
				new_style := clear_flag (new_style, Ws_sizebox)
				set_style (new_style)
				hide
				show
			end
		end

	allow_resize is
			-- Allow the resize of the window.
		local
			new_style: INTEGER
		do
			if shown then
				new_style := style
				new_style := set_flag (new_style, Ws_maximizebox)
				new_style := set_flag (new_style, Ws_minimizebox)
				new_style := set_flag (new_style, Ws_sizebox)
				set_style (new_style)
				hide
				show
			end
		end

	set_iconic_state is
			-- Set start state of the application to be iconic.
		do
			check
				not_yet_implemented: False
			end	
		end

	set_normal_state is
			-- Set start state of the application to be normal.
		do
			check
				not_yet_implemented: False
			end
		end

	set_maximize_state is
			-- Set start state of the application to be
			-- maximized.
		do
			check
				not_yet_implemented: False
			end
		end

	set_modal is
			-- Make the window modal
		do
			set_capture
		end

feature -- Element change

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

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Resize the widget and don't notify the parent.
		do
			resize (minimum_width.max(new_width), minimum_height.max (new_height))
		end

	set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
			-- If the Current size is smaller, the size
			-- change.
		do
			minimum_width := value 
			if value > width then
				resize (value, height)
			end
		end

	set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height'.
			-- If the Current size is smaller, the size
			-- change.
		do
			minimum_height := value
			if value > height then
				resize (width, value)
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
--			max_track.set_x (value)
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

	set_icon_name (txt: STRING) is
			-- Make `txt' the new icon name.
		do
			check
				not_yet_implemented: False
			end
		end	

	set_icon_mask (pixmap: EV_PIXMAP) is
			-- Make `pixmap' the new icon mask.
		do
			check
				not_yet_implemented: False
			end
		end

	set_icon_pixmap (pixmap: EV_PIXMAP) is
			-- Make `pixmap' the new icon pixmap.
		do
			check
				not_yet_implemented: False
			end
		end

	set_widget_group (widget: EV_WIDGET) is
			-- Make Current part of the group of `widget'.
		do
			check
                not_yet_implemented: False
            end
		end

	set_status_bar (a_bar: EV_STATUS_BAR_IMP) is
			-- Make `a_bar' the new status bar of the window.
		do
			status_bar := a_bar
			update_minimum_size
		end

	remove_status_bar is
			-- Remove the current status bar of the window.
		do
			status_bar := Void
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
			Result := (width = new_width or else width = minimum_width.max (system_metrics.window_minimum_width)) and then
				  (height = new_height or else height = minimum_height.max (system_metrics.window_minimum_height))
		end

feature {EV_WIDGET_IMP} -- Implementation

	child_minwidth_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Resize the container according to the 
			-- resize of the child
		do
			set_minimum_width (value + 2*system_metrics.window_frame_width)
		end

	child_minheight_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Resize the container according to the 
			-- resize of the child
		do
			update_minimum_size
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
		-- Set with the option `Ws_clipchildren' to avoid flashing.
		do
			Result := Ws_border + Ws_dlgframe + Ws_sysmenu 
					+ Ws_thickframe + Ws_overlapped
					+ Ws_minimizebox + Ws_maximizebox
					+ Ws_clipchildren + Ws_clipsiblings
		end

	default_ex_style: INTEGER is
		do
			Result := Ws_ex_controlparent
		end

	on_show is
			-- When the window receive the on_show message,
			-- it resizes the window at the size of the child.
			-- And it send the message to the child because wel
			-- don't
		do
			if child /= Void and not already_displayed then
				child.on_first_display
				set_size (child.minimum_width + 2*system_metrics.window_frame_width,
					child.minimum_height + system_metrics.title_bar_height
					+ system_metrics.window_border_height 
					+ 2 * system_metrics.window_frame_height)
			end
			if has_menu then
				draw_menu
			end
			already_displayed := True
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Called when the window is resized.
			-- Resize the child if it exists.
		do
			execute_command (Cmd_size, Void)
			if child /= Void then
				child.parent_ask_resize (client_width, client_height)
			end
			if status_bar /= Void then
				status_bar.reposition
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
			execute_command (Cmd_move, Void)
 		end

	closeable: BOOLEAN is
			-- Can the user close the window?
			-- Yes by default.
		do
			if (command_list = Void) or else 
					(command_list @ Cmd_close) = Void then
				Result := True
				interface.remove_implementation
			else
				execute_command (Cmd_close, Void)
				Result := False
			end
		end

	on_get_min_max_info (min_max_info: WEL_MIN_MAX_INFO) is
		local
			min_track, max_track: WEL_POINT
		do
			inspect resize_type
			when 0 then
				!! min_track.make (width, height)
				!! max_track.make (width, height)
			when 1 then
				!! min_track.make (minimum_width, height)
				!! max_track.make (maximum_width, height)
			when 2 then
				!! min_track.make (width, minimum_height)
				!! max_track.make (width, maximum_height)
			when 3 then
				!! min_track.make (minimum_width, minimum_height)
				!! max_track.make (maximum_width, maximum_height)
			end
			min_max_info.set_min_track_size (min_track)
			min_max_info.set_max_track_size (max_track)
		end

	on_destroy is
			-- Called when the window is destroy.
			-- Set the parent sensitive if it exists.
		do
			if parent_imp /= Void and not parent_imp.destroyed and then parent_imp.insensitive then
				parent_imp.set_insensitive (False)
			end
		end

	system_metrics: WEL_SYSTEM_METRICS is
			-- System metrics to query things like
			-- window_frame_width
		once
			!!Result
		end

feature {EV_STATIC_MENU_BAR_IMP} -- Implementation

	set_menu (a_menu: WEL_MENU) is
			-- Set `menu' with `a_menu'.
		do
			{WEL_FRAME_WINDOW} Precursor (a_menu)
			update_minimum_size
		end

	update_minimum_size is
			-- Update the minimum_size of the window according
			-- to the component inside the window.
		local
			value: INTEGER
		do
			-- For the width first
			value := 2*window_frame_width
			if child /= Void then
				value := value + child.minimum_width
			end
			set_minimum_width (value)

			-- For the height then
			value := title_bar_height + window_border_height + 2 * window_frame_height
			if child /= Void then
				value := value + child.minimum_height
			end
			if has_menu then
				value := value + menu_bar_height
			end
			if status_bar /= Void then
				value := value + status_bar.height
			end
			set_minimum_height (value)
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

	set_top_level_window_imp (a_window: WEL_WINDOW) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		do
			check
				Inapplicable: True
			end
		end

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
