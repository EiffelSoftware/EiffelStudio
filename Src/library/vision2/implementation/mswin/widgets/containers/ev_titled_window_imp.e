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
		end
					
	EV_CONTAINER_IMP
		rename
			expandable as never_displayed
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
			child_minwidth_changed,
			child_minheight_changed,
			add_child
		end

	WEL_FRAME_WINDOW
		rename
			parent as wel_parent,
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
			on_key_up
		redefine
			set_menu,
			default_style,
			default_ex_style,
			background_brush,
			on_size,
			on_get_min_max_info,
			on_destroy,
			on_menu_command,
			on_show
		end

creation
	make, make_top_level

feature {NONE} -- Initialization

	make_top_level is
			-- Create a window. Window does not have any
			-- parents
		do
			make_top ("EV_WINDOW")
			!! min_track.make (0, 0)
			!! max_track.make (1000, 1000)
			set_maximum_width (1000)
			set_maximum_height (1000)
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
			make_child (par_imp, "EV_WINDOW")
			!! min_track.make (0,0)
			!! max_track.make (1000, 1000)
			set_maximum_width (1000)
			set_maximum_height (1000)
		end

	plateform_build (par: EV_CONTAINER_IMP) is
			-- Initialize few variables
		do
			{EV_CONTAINER_IMP} Precursor (par)
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

	forbid_resize is
			-- Forbid the resize of the window.
		do
			max_track.set_x_y (width, height)
			min_track.set_x_y (width, height)
		end

	allow_resize is
			-- Allow the resize of the window.
		do
			min_track.set_x_y (minimum_width, minimum_height)
			max_track.set_x_y (maximum_width, maximum_height)
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

feature -- Element change

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Resize the widget and don't notify the parent.
		do
			resize (minimum_width.max(new_width), minimum_height.max (new_height))
		end

	set_minimum_width (value: INTEGER) is
			-- Minimum width of window
			-- Must be bigger than the mswin minimum, or it does nothing
		do
			minimum_width := value --.max (system_metrics.window_minimum_width)
			min_track.set_x (value)
		end

	set_minimum_height (value: INTEGER) is
			-- Minimum heigth of window, must be bigger than the mswin minimum
		do
			minimum_height := value --.max (system_metrics.window_minimum_height)
			min_track.set_y (value)
		end

	set_maximum_width (value: INTEGER) is
			-- Make `value' the new maximum width.
		do
			maximum_width := value
			max_track.set_x (value)
		end

	set_maximum_height (value: INTEGER) is
			-- Make `value' the new maximum height.
		do
			maximum_height := value
			max_track.set_y (value)
		end

	set_title (new_title: STRING) is
			-- Make `new_title' the title of the window.            
		do
			set_text (new_title)
		end

	set_icon_name (a_name: STRING) is
			-- Set `icon_name' to `a_name'.
		do
			check
				not_yet_implemented: False
			end
		end	

	set_icon_mask (mask: EV_PIXMAP) is
			-- Set `icon_mask' to `mask'.
		do
			check
				not_yet_implemented: False
			end
		end

	set_icon_pixmap (pixmap: EV_PIXMAP) is
			-- Set `icon_pixmap' to `pixmap'.
		do
			check
				not_yet_implemented: False
			end
		end

	set_widget_group (group_widget: EV_WIDGET) is
			-- Set `widget_group' to `group_widget'.
		do
			check
                not_yet_implemented: False
            end
		end

feature -- Event - command association

	add_resize_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when the
			-- widget is resized.
		do
		end

	add_move_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when the
			-- widget is resized.
		do
		end

feature {EV_WIDGET_IMP} -- Implementation

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

	add_child (child_imp: EV_WIDGET_I) is
			-- Add child into composite
		do
			child ?= child_imp
			if has_menu then
				set_minimum_size (child.minimum_width + 2*window_frame_width, child.minimum_height + title_bar_height + menu_bar_height + window_border_height + 2 * window_frame_height)
			else
				set_minimum_size (child.minimum_width + 2*window_frame_width, child.minimum_height + title_bar_height + window_border_height + 2 * window_frame_height)
			end
		end

feature {NONE} -- Implementation

	plateform_closed is
			-- Nothing to do here, because WEL take care of 
			-- everything.
		do
		end 

	default_style: INTEGER is
		-- Set with the option `Ws_clipchildren' to avoid flashing.
		once
			Result := Ws_overlappedwindow + Ws_clipchildren
					 + Ws_clipsiblings
		end

	default_ex_style: INTEGER is
		-- Set with the option `Ws_ex_controlparent' to allow
		-- the user to use the tab key.
		once
			Result := Ws_ex_controlparent
		end

	background_brush: WEL_BRUSH is
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
			-- By default there is no background
		do
			if background_color /= Void then
				!! Result.make_solid (background_color)
--				disable_default_processing
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
			never_displayed := False
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Called when the window is resized.
			-- Resize the child if it exists.
		do
			if shown and then child /= Void then
				child.parent_ask_resize (a_width, a_height)
			end
		end

	min_track: WEL_POINT
			-- Minimum position where the user can track the window

	max_track: WEL_POINT
			-- Maximum position where the user can track the window

	on_get_min_max_info (min_max_info: WEL_MIN_MAX_INFO) is
		do
			min_max_info.set_min_track_size (min_track)
--			min_max_info.set_max_track_size (max_track)
		end

	on_destroy is
			-- Called when the window is destroy.
			-- Set the parent sensitive if it exists.
		do
			if parent_imp /= Void and then parent_imp.insensitive then
				parent_imp.set_insensitive (False)
			end
		end

	on_menu_command (menu_id: INTEGER) is
			-- The `menu_id' has been choosen from the menu.
			-- If this feature is called, it means that the 
			-- child is a menu.
		do
			if current_menu /= Void then
				current_menu.on_menu_command (menu_id)
			end
		end

feature {EV_STATIC_MENU_BAR_IMP} -- implementation

	set_menu (a_menu: WEL_MENU) is
			-- Set `menu' with `a_menu'.
		do
			{WEL_FRAME_WINDOW} Precursor (a_menu)
			current_menu ?= a_menu
			if child /= Void then
				set_minimum_size (child.minimum_width + 2*window_frame_width, child.minimum_height + title_bar_height + menu_bar_height + window_border_height + 2 * window_frame_height)
			else
				set_minimum_size (2*window_frame_width, title_bar_height + menu_bar_height + window_border_height + 2 * window_frame_height)
			end
		ensure then
			current_menu_set: current_menu /= Void
		end

feature {NONE} -- Implementation

	system_metrics: WEL_SYSTEM_METRICS is
			-- System metrics to query things like
			-- window_frame_width
		once
			!!Result
		end

	current_menu: EV_MENU_CONTAINER_IMP
			-- The current menu of the window.

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
