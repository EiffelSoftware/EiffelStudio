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
		rename
			expandable as never_displayed
		redefine
			set_expand
		end
					
	EV_CONTAINER_IMP
		rename
			expandable as never_displayed
		export
			{NONE} never_displayed
			{NONE} set_expand
		undefine
			set_width,
			set_height,
			build
		redefine
				-- We redefine the following features because a window
				-- don't have to notify its parent in the following cases.
			plateform_build,
			parent_ask_resize,
			set_size,
			set_minimum_width,
			set_minimum_height,
			dimensions_set,
			child_minwidth_changed,
			child_minheight_changed,
			add_child,
			set_expand
--			set_vertical_resize,
--			set_horizontal_resize
		end

	WEL_FRAME_WINDOW
		rename
			set_parent as wel_set_parent,
			destroy as wel_destroy
		undefine
				-- We undefine the features refined by EV_CONTAINER_IMP
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
			on_menu_command,
			on_draw_item
		redefine
			set_menu,
			default_style,
			default_ex_style,
			background_brush,
			on_size,
			on_get_min_max_info,
			on_destroy,
			on_show,
			on_move,
			closeable
		end

creation
	make,
	make_top_level

feature {NONE} -- Initialization

	make_top_level is
			-- Create a window. Window does not have any
			-- parents
		do
			make_top ("EV_WINDOW")
--			!! min_track.make (0, 0)
--			!! max_track.make (system_metrics.screen_width, system_metrics.screen_height)
		end

	make (par: EV_WINDOW) is
			-- Create a window with a parent.
		local
			par_imp: EV_WINDOW_IMP
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
--			make_top ("EV_CHILD_WINDOW")
			make_child (par_imp, "EV_WINDOW")
--			!! min_track.make (0,0)
--			!! max_track.make (system_metrics.screen_width, system_metrics.screen_height)
--			set_maximum_width (system_metrics.screen_width)
--			set_maximum_height (system_metrics.screen_height)
		end

feature {EV_WINDOW} -- Initialization

	plateform_build (par: EV_CONTAINER_I) is
			-- Initialize few variables
		do
			{EV_CONTAINER_IMP} Precursor (par)
			resize_type := 3
			set_maximum_width (system_metrics.screen_width)
			set_maximum_height (system_metrics.screen_height)
			never_displayed := True
		end
		
feature  -- Access

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

feature -- Status report

	is_iconic_state: BOOLEAN is
			-- Does application start in iconic state?
		do
			check
                not_yet_implemented: False
            end
		end

feature -- Status setting

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
		do
			resize_type := 0
--			max_track.set_x_y (width, height)
--			min_track.set_x_y (width, height)
		end

	allow_resize is
			-- Allow the resize of the window.
		do
			resize_type := 3
--			min_track.set_x_y (minimum_width, minimum_height)
--			max_track.set_x_y (maximum_width, maximum_height)
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
			check
				not_yet_implemented: False
			end
--			set_capture
		end

feature -- Element change

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Resize the widget and don't notify the parent.
		do
			resize (minimum_width.max(new_width), minimum_height.max (new_height))
		end

	set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
			-- Must be bigger than the mswin minimum, or it does nothing
		do
			minimum_width := value --.max (system_metrics.window_minimum_width)
--			min_track.set_x (value)
		end

	set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height'.
			-- Must be bigger than the mswin minimum
		do
			minimum_height := value --.max (system_metrics.window_minimum_height)
--			min_track.set_y (value)
		end

	set_maximum_width (value: INTEGER) is
			-- Make `value' the new maximum width.
		do
			maximum_width := value
--			max_track.set_x (value)
		end

	set_maximum_height (value: INTEGER) is
			-- Make `value' the new maximum height.
		do
			maximum_height := value
--			max_track.set_y (value)
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

feature -- Event - command association

	add_close_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Make `cmd' the executed command when the window is closed.
		do
			add_command (Cmd_close, cmd, arg)
		end

	add_resize_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed
			-- when the window is resized.
		do
			add_command (Cmd_size, cmd, arg)
		end

	add_move_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget is resized.
		do
			add_command (Cmd_move, cmd, arg)
		end

feature {EV_WIDGET_IMP} -- Implementation

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

	child_minwidth_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Resize the container according to the 
			-- resize of the child
		do
			set_minimum_width (value + 2*system_metrics.window_frame_width)
			if minimum_width > width then
				set_size (minimum_width, height)
			end
		end

	child_minheight_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Resize the container according to the 
			-- resize of the child
		do
			if has_menu then
				set_minimum_height (value + system_metrics.title_bar_height
					+ system_metrics.window_border_height + menu_bar_height
					+ 2 * system_metrics.window_frame_height)
			else
				set_minimum_height (value + system_metrics.title_bar_height
					+ system_metrics.window_border_height 
					+ 2 * system_metrics.window_frame_height)
			end
			if minimum_height > height then
				set_size (width, minimum_height)
			end
		end

	parent_ask_resize (new_width, new_height: INTEGER) is
			-- When the parent asks the resize, it's not 
			-- necessary to send him back the information
		do
			{EV_CONTAINER_IMP} Precursor (new_width, new_height)
			if child /= Void then
				child.parent_ask_resize (client_width, client_height)
			end
		end

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite
		do
			{EV_CONTAINER_IMP} Precursor (child_imp)
			if has_menu then
				set_minimum_size (child_imp.minimum_width + 2*window_frame_width, child_imp.minimum_height + title_bar_height + menu_bar_height + window_border_height + 2 * window_frame_height)
			else
				set_minimum_size (child_imp.minimum_width + 2*window_frame_width, child_imp.minimum_height + title_bar_height + window_border_height + 2 * window_frame_height)
			end
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
		-- Set with the option `Ws_clipchildren' to avoid flashing.
		once
			Result := Ws_border + Ws_dlgframe + Ws_sysmenu 
					+ Ws_thickframe + Ws_overlapped
					+ Ws_minimizebox + Ws_maximizebox
					+ Ws_clipchildren + Ws_clipsiblings
		end

	default_ex_style: INTEGER is
		-- Set with the option `Ws_ex_controlparent' to allow
		-- the user to use the tab key.
		once
			Result := Ws_ex_controlparent + Ws_ex_left
					+ Ws_ex_ltrreading
		end

	background_brush: WEL_BRUSH is
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
			-- By default there is no background
		do
			if background_color /= Void then
				!! Result.make_solid (background_color_imp)
			end
		end

	on_show is
			-- When the window receive the on_show message,
			-- it resizes the window at the size of the child.
			-- And it send the message to the child because wel
			-- don't
		do
			if child /= Void and never_displayed then
				child.on_first_display
				set_size (child.width + 2*system_metrics.window_frame_width,
							child.height + system_metrics.title_bar_height
							+ system_metrics.window_border_height 
							+ 2 * system_metrics.window_frame_height)
			end
			if has_menu then
				draw_menu
			end
			never_displayed := False
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Called when the window is resized.
			-- Resize the child if it exists.
		do
			execute_command (Cmd_size, Void)
			if shown and then child /= Void then
				child.parent_ask_resize (client_width, client_height)
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
			execute_command (Cmd_close, Void)
			interface.remove_implementation
			Result := True
		end

--	min_track: WEL_POINT
--			-- Minimum position where the user can track the window

--	max_track: WEL_POINT
--			-- Maximum position where the user can track the window

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



feature {EV_STATIC_MENU_BAR_IMP} -- implementation

	set_menu (a_menu: WEL_MENU) is
			-- Set `menu' with `a_menu'.
		do
			{WEL_FRAME_WINDOW} Precursor (a_menu)
			if child /= Void then
				set_minimum_size (child.minimum_width + 2*window_frame_width, child.minimum_height + title_bar_height + menu_bar_height + window_border_height + 2 * window_frame_height)
			else
				set_minimum_size (2*window_frame_width, title_bar_height + menu_bar_height + window_border_height + 2 * window_frame_height)
			end
		end

feature {NONE} -- Implementation

	system_metrics: WEL_SYSTEM_METRICS is
			-- System metrics to query things like
			-- window_frame_width
		once
			!!Result
		end

feature {NONE} -- Inapplicable

	set_expand (flag: BOOLEAN) is
			-- Not applicable for windows.
		do
			check
				Inapplicable: False
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
