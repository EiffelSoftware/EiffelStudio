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
			build
		end
					
	EV_CONTAINER_IMP
		rename
			expandable as never_displayed
		undefine
			set_width,
			set_height,
			initialize_colors
		redefine
				-- We redefine the following features because a window
				-- don't have to notify its parent in the following cases.
			build,
			parent_ask_resize,
			set_size,
			set_minimum_width,
			set_minimum_height,
			child_width_changed,
			child_height_changed,
			on_show
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
			!! child_cell
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
		end

	build is
			-- Initialize few variables
		do
			never_displayed := True
		end
		
feature  -- Access

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

feature -- Measurement

	maximum_height: INTEGER is
                        -- Maximum height that application wishes widget
                        -- instance to have
 		do
                        check
                                not_yet_implemented: False
                        end
		end	

	maximum_width: INTEGER is
                        -- Maximum width that application wishes widget
                        -- instance to have
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

	set_title (new_title: STRING) is
			-- Make `new_title' the title of the window.            
		do
			set_text (new_title)
		end

	set_widget_group (group_widget: EV_WIDGET) is
			-- Set `widget_group' to `group_widget'.
		do
			check
                not_yet_implemented: False
            end
		end

	set_icon_name (a_name: STRING) is
			-- Set `icon_name' to `a_name'.
		do
			check
				not_yet_implemented: False
			end
		end	

	plateform_closed is
			-- Nothing to do here, because WEL take care of 
			-- everything.
		do
		end 

feature -- Resizing

	child_width_changed (new_width: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Resize the container according to the 
			-- resize of the child
		do
			set_width (new_width + 2*system_metrics.window_frame_width)
		end

	child_height_changed (new_height: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Resize the container according to the 
			-- resize of the child
		do
			set_height (new_height + system_metrics.title_bar_height
					+ system_metrics.window_border_height 
					+ 2 * system_metrics.window_frame_height)
		end

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Resize the widget and don't notify the parent.
		do
			resize (minimum_width.max(new_width), minimum_height.max (new_height))
		end

	set_minimum_width (min_width: INTEGER) is
			-- Minimum width of window
			-- Must be bigger than the mswin minimum, or it does nothing
		do
			minimum_width := min_width --.max (system_metrics.window_minimum_width)
		end

	set_minimum_height (min_height: INTEGER) is
			-- Minimum heigth of window, must be bigger than the mswin minimum
		do
			minimum_height := min_height --.max (system_metrics.window_minimum_height)
		end

	set_maximum_height (max_height: INTEGER) is
                        -- Set `maximum_height' to `max_height'.
		do
                        check
                                not_yet_implemented: False
                        end		
		end

	set_maximum_width (max_width: INTEGER) is
                        -- Set `maximum_width' to `max_width'.
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

feature -- Implementation : WEL redefinition

	default_style: INTEGER is
		-- Set with the option `Ws_clipchildren' to avoid flashing.
		once
			Result := Ws_overlappedwindow + Ws_clipchildren
		end

	background_brush: WEL_BRUSH is
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
			-- By default there is no background
		do
			if background_color /= Void then
				!! Result.make_solid (background_color)
				disable_default_processing
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
				child_width_changed (child.child_cell.width, child)
				child_height_changed (child.child_cell.height, child)
				never_displayed := False
			end
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Called when the window is resized.
			-- Resize the child if it exists.
		do
			if shown and then child /= Void then
				child.parent_ask_resize (a_width, a_height)
			end
		end

	on_get_min_max_info (min_max_info: WEL_MIN_MAX_INFO) is
		local
			min_track: WEL_POINT
		do
			if child /= Void then
				if has_menu then
					!! min_track.make (child.minimum_width + 2*window_frame_width, child.minimum_height + title_bar_height + menu_bar_height + window_border_height + 2 * window_frame_height)
				else
					!! min_track.make (child.minimum_width + 2*window_frame_width, child.minimum_height + title_bar_height + window_border_height + 2 * window_frame_height)
				end
				min_max_info.set_min_track_size (min_track)
			end
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

	set_menu (a_menu: WEL_MENU) is
			-- Set `menu' with `a_menu'.
		do
			{WEL_FRAME_WINDOW} Precursor (a_menu)
			current_menu ?= a_menu
		ensure then
			current_menu_set: current_menu /= Void
		end

feature {EV_WIDGET_IMP} -- Implementation
	
	parent_ask_resize (new_width, new_height: INTEGER) is
			-- When the parent asks the resize, it's not 
			-- necessary to send him back the information
		do
			{EV_CONTAINER_IMP} Precursor (new_width, new_height)
			if child /= Void then
				child.parent_ask_resize (client_width, client_height)
			end
		end

feature {NONE} -- Implementation

	system_metrics: WEL_SYSTEM_METRICS is
			-- System metrics to query things like
			-- window_frame_width
		once
			!!Result
		end

	current_menu: EV_MENU_ITEM_CONTAINER_IMP
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
