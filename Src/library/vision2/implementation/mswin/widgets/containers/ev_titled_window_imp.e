indexing

	description: 
		"EiffelVision window. Display a window that allows only one%
		 % child. Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_WINDOW_IMP
	
inherit
	EV_WINDOW_I
		select
			interface,
			parent_imp
		end
					
	EV_CONTAINER_IMP
		rename
			interface as wrong_interface,
			parent_imp as wrong_parent_imp
		redefine
			wel_window,	
			set_width,
			set_height,
			set_size,
			set_minimum_width,
			set_minimum_height,
			child_has_resized,
			on_show
		end

creation
	make, make_top_level

feature {NONE} -- Initialization
	
	old_make (par: EV_WINDOW) is
			-- do nothing
		do
		end

	make_top_level is
			-- Create a window. Window does not have any
			-- parents
		do
			!!wel_window.make_top ("EV_WINDOW")
			wel_window.initialize (Current)
		end

	make (par: EV_WINDOW) is
			-- Create a window with a parent.
		do
			test_and_set_parent (par)
			!!wel_window.make_child (parent_imp.wel_window, "EV_WINDOW")
			wel_window.initialize (Current)
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
			Result := wel_window.text
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
			-- Set `title' to `new_title'.            
		do
			wel_window.set_text (new_title)
        end

	set_widget_group (group_widget: EV_WIDGET) is
			-- Set `widget_group' to `group_widget'.
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


feature -- Element change

	set_icon_name (a_name: STRING) is
			-- Set `icon_name' to `a_name'.
		do
			check
                not_yet_implemented: False
            end
		end	


feature -- Resizing

	child_has_resized (new_width, new_height: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Resize the container according to the 
			-- resize of the child
		do
			-- XX Have to take into account the borders 
			-- (new_width and new_height are the 
			-- dimensions of the client area)
			set_size (new_width + 2*system_metrics.window_frame_width, 
				  new_height + system_metrics.title_bar_height + system_metrics.window_border_height + 2 * system_metrics.window_frame_height)
		end

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Resize the widget and don't notify the parent.
		do
			wel_window.resize (minimum_width.max(new_width), minimum_height.max (new_height))
		end

	
	set_width (new_width :INTEGER) is
			-- Set `width' to `new_width'.
		do
			wel_window.set_width (minimum_width.max(new_width))
		end

		
	set_height (new_height: INTEGER) is
			-- Set `height' to `new_height'
		do
			wel_window.set_height (minimum_height.max(new_height))
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

feature {EV_WEL_FRAME_WINDOW} -- Event handling

	on_show is
			-- When the wel_window receive the on_show message,
			-- it resizes the wel_window at the minimum_size.
		do
			if child /= Void then
				parent_ask_resize (child.minimum_width, child.minimum_height)
			end
		end

	on_size (a_width, a_height: INTEGER) is
			-- Called when the wel_window is resized.
			-- Resize the child if it exists.
		do
			if child /= Void then
					child.parent_ask_resize (a_width, a_height)
			end
		end

	on_destroy is
			-- Called when the wel_window is destroy.
			-- Set the parent sensitive if it exists.
		do
			if parent_imp /= Void and not parent_imp.destroyed then
				parent_imp.set_insensitive (False)
			end
		end

	on_menu_command (menu_id: INTEGER) is
			-- The `menu_id' has been choosen from the menu.
			-- If this feature is called, it means that the 
			-- child is a menu.
		local
			current_menu: EV_MENU_ITEM_CONTAINER_IMP
		do
			current_menu ?= child
			if current_menu /= Void then
				current_menu.on_menu_command (menu_id)
			end
		end

feature --{EV_WINDOW_IMP} -- Implementation
	
	system_metrics: WEL_SYSTEM_METRICS is
			-- System metrics to query things like
			-- window_frame_width
		once
			!!Result
		end

feature {EV_APPLICATION_IMP, EV_WINDOW_IMP} -- Implementation
	
	wel_window: EV_WEL_FRAME_WINDOW

end

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
