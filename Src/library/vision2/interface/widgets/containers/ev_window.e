indexing

	description: 
		"EiffelVision window. Window is a visible window on the screen."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
class 
	EV_WINDOW

inherit
	
	EV_CONTAINER
		rename
			make as widget_make
		export
			{NONE} widget_make
		redefine
			implementation
		end
	
	
creation
	
	make
	
feature {NONE} -- Initialization
	
        make is
                        -- Create a window. Window does not have any
                        -- parents
		require
			-- toolkit initialized
		do
			!EV_WINDOW_IMP!implementation.make (Current)
		end
	
		
feature  -- Access

        icon_name: STRING is
                        -- Short form of application name to be
                        -- displayed by the window manager when
                        -- application is iconified 
                require
                        exists: not destroyed
                do
                        Result := implementation.icon_name
                end 
	
        icon_mask: EV_PIXMAP is
                        -- Bitmap that could be used by window manager
                        -- to clip `icon_pixmap' bitmap to make the
                        -- icon nonrectangular 
                require
                        exists: not destroyed
                do
                        Result := implementation.icon_mask
                end

        icon_pixmap: EV_PIXMAP is
                        -- Bitmap that could be used by the window manager
                        -- as the application's icon
                require
                        exists: not destroyed
                do
                        Result := implementation.icon_pixmap
                ensure
                        valid_result: Result /= Void
                end
	
        title: STRING is
                        -- Application name to be displayed by
                        -- the window manager
                require
                        exists: not destroyed
                do
                        Result := implementation.title
                end

        widget_group: EV_WIDGET is
                        -- Widget with wich current widget is associated.
                        -- By convention this widget is the "leader" of a group
                        -- widgets. Window manager will treat all widgets in
                        -- a group in some way; for example, it may move or
                        -- iconify them together
                require
                        exists: not destroyed
                do
                        Result := implementation.widget_group
                end 


feature -- Element change
	
        set_icon_mask (mask: EV_PIXMAP) is
                        -- Set `icon_mask' to `mask'.
                require
                        exists: not destroyed
                        not_mask_void: mask /= Void
                do
                        implementation.set_icon_mask (mask)
                end

        set_icon_pixmap (pixmap: EV_PIXMAP) is
                        -- Set `icon_pixmap' to `pixmap'.
                require
                        exists: not destroyed
                        not_pixmap_void: pixmap /= Void
--XX                        valid_pixmap: pixmap.is_valid
                do
                        implementation.set_icon_pixmap (pixmap)
                end

        set_title (new_title: STRING) is
                        -- Set `title' to `new_title'.
                require
                        exists: not destroyed
                        not_title_void: new_title /= Void
                do
                        implementation.set_title (new_title)
                end

        set_widget_group (group_widget: EV_WIDGET) is
                        -- Set `widget_group' to `group_widget'.
                require
                        exists: not destroyed
                do
                        implementation.set_widget_group (group_widget)
                end

feature -- Status report

        is_iconic_state: BOOLEAN is
                        -- Does application start in iconic state?
                require
                        exists: not destroyed
                do
                        Result := implementation.is_iconic_state
                end

feature -- Status setting

        set_iconic_state is
                        -- Set start state of the application to be iconic.
                require
                        exists: not destroyed
                do
                        implementation.set_iconic_state
                end

        set_normal_state is
                        -- Set start state of the application to be normal.
                require
                        exists: not destroyed
                do
                        implementation.set_normal_state
                end

feature -- Element change

        set_icon_name (new_name: STRING) is
                        -- Set `icon_name' to `new_name'.
                require
                        exists: not destroyed
                        Valid_name: new_name /= Void
                do
                        implementation.set_icon_name (new_name)
                end

        delete_window_action is
                        -- Called when the window is deleted (closed).
                        -- (Will exit application if `delete_command'
                        -- is not set).
                do
                        if delete_command = Void then
                                if application /= Void then
					application.exit
				end
                        else
                                delete_command.execute (Void)
                        end
                end

feature -- Removal

        set_delete_command (c: EV_COMMAND) is
                do
                        delete_command := c
                end

feature {NONE} -- Implementation

        delete_command: EV_COMMAND


        implementation: EV_WINDOW_I
                        -- Implementation of window

feature {EV_APPLICATION} -- Implementation
	
	application: EV_APPLICATION
			-- EiffelVision application associated to the
			-- window.
	
	set_application (app: EV_APPLICATION) is
			-- Associate the window with 'app'. Is this 
			-- is done, exiting the window will exit the 
			-- application, unless delete_command is set.
		do
			application := app
		end
		
invariant

--        Depth_is_zero: depth = 0
--        Has_no_parent: parent = Void

		
end -- class EV_WINDOW
