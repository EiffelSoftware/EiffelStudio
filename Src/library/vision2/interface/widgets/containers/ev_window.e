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
	
--	EV_WINDOW_MANAGER_EV_WINDOW

creation
	
	make
	
feature {NONE} -- Initialization
	
        make is
                        -- Create a window. Window does not have any
                        -- parents
		require
			-- toolkit initialized
		do
			!EV_WINDOW_IMP!implementation.make
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

        set_icon_name (a_name: STRING) is
                        -- Set `icon_name' to `a_name'.
                require
                        exists: not destroyed
                        Valid_name: a_name /= Void
                do
                        implementation.set_icon_name (a_name)
                end

        delete_window_action is
                        -- Called when 'top' is destroyed.
                        -- (Will exit application if
                        -- `delete_command' is not set).
                do
                        if delete_command = Void then
--XX                                toolkit.exit
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

feature {NONE} -- Implementation

        implementation: EV_WINDOW_I
                        -- Implementation of window

invariant

--        Depth_is_zero: depth = 0
--        Has_no_parent: parent = Void

		
end -- class EV_WINDOW
