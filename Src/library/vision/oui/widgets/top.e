indexing

	description: "Top is the abstract class for TOP_SHELL and BASE";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class TOP 

inherit

	SHELL
		redefine
			implementation, screen, top
		end;

	WM_SHELL
		rename
			implementation as wm_implementation
		end
	
feature 

	screen: SCREEN;
			-- Screen of current top-level

	icon_name: STRING is
			-- Short form of application name to be displayed
			-- by the window manager when application is iconified
		require
			exists: not destroyed
		do
			Result := implementation.icon_name
		end; 

	is_iconic_state: BOOLEAN is
			-- Does application start in iconic state?
		require
			exists: not destroyed
		do
			Result := implementation.is_iconic_state
		end;

	set_icon_name (a_name: STRING) is
			-- Set `icon_name' to `a_name'.
		require
			exists: not destroyed;
			Valid_name: a_name /= Void
		do
			implementation.set_icon_name (a_name)
		end;

	set_iconic_state is
			-- Set start state of the application to be iconic.
		require
			exists: not destroyed
		do
			implementation.set_iconic_state
		end;

	set_normal_state is
			-- Set start state of the application to be normal.
		require
			exists: not destroyed
		do
			implementation.set_normal_state
		end;

	top: TOP is
			-- Top shell or base of widget (itself here)
		do
			Result := Current
		ensure then
			Top_is_current: Result = Current
		end ;

	delete_window_action is
			-- Called when 'top' is destroyed.
			-- (Will exit application if
			-- `delete_command' is not set).
		local
			quit_app_com: QUIT_NOW_COM;
		do
			if delete_command = Void then
				!! quit_app_com;
				quit_app_com.execute (Void);
			else
				delete_command.execute (Void);
			end;
		end;

	set_delete_command (c: COMMAND) is
		do
			delete_command := c;
		end;

feature {NONE}

	delete_command: COMMAND;

feature {G_ANY, G_ANY_I, WIDGET_I, APPLICATION}

	implementation: TOP_I;
			-- Implementation of top

invariant

	Depth_is_zero: depth = 0;
	Has_no_parent: parent = Void

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
