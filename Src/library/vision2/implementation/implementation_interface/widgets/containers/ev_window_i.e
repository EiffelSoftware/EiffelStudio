indexing

	description: 
		"EiffelVision window, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class

	EV_WINDOW_I
	
inherit
	
	EV_CONTAINER_I
		rename
			make as old_make
		end
	
	
feature {NONE} -- Initialization

	make_top_level (interface: EV_WINDOW) is
			-- Create a window. Window does not have any
			-- parents
		deferred
		end

	make (par: EV_WINDOW; interface: EV_WINDOW) is
			-- Create a window. Window does not have any
			-- parents
		deferred
		end


feature  -- Access


	icon_name: STRING is
			-- Short form of application name to be
			-- displayed by the window manager when
			-- application is iconified
		deferred
		end
	
	icon_mask: EV_PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		require
			exists: not destroyed
		deferred
		end

	icon_pixmap: EV_PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		require
			exists: not destroyed
		deferred
		ensure
			valid_result: Result /= Void
		end
	
	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		require
			exists: not destroyed
		deferred
		end

	widget_group: EV_WIDGET is
			-- Widget with wich current widget is associated.
			-- By convention this widget is the "leader" of a group
			-- widgets. Window manager will treat all widgets in
			-- a group in some way; for example, it may move or
			-- iconify them together
		require
			exists: not destroyed
		deferred
		end 

feature -- Element change

        set_icon_mask (mask: EV_PIXMAP) is
                        -- Set `icon_mask' to `mask'.
                require
                        exists: not destroyed
                        not_mask_void: mask /= Void
                deferred
                end

        set_icon_pixmap (pixmap: EV_PIXMAP) is
                        -- Set `icon_pixmap' to `pixmap'.
                require
                        exists: not destroyed
                        not_pixmap_void: pixmap /= Void
--XX                        valid_pixmap: pixmap.is_valid
                deferred
                end

        set_title (new_title: STRING) is
                        -- Set `title' to `new_title'.
                require
                        exists: not destroyed
                        not_title_void: new_title /= Void
                deferred
                end

        set_widget_group (group_widget: EV_WIDGET) is
                        -- Set `widget_group' to `group_widget'.
                require
                        exists: not destroyed
                deferred
		end

feature -- Status report

        is_iconic_state: BOOLEAN is
                        -- Does application start in iconic state?
                deferred
                end

feature -- Status setting

        set_iconic_state is
                        -- Set start state of the application to be iconic.
                deferred
                end

        set_normal_state is
                        -- Set start state of the application to be normal.
                deferred
                end

feature -- Element change

        set_icon_name (new_name: STRING) is
                        -- Set `icon_name' to `new__name'.
                deferred
                end
	
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
