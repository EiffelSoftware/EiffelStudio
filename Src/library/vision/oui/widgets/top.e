--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Top is the abstract class for TOP_SHELL and BASE.

indexing

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
		do
			Result := implementation.icon_name
		end; 

	is_iconic_state: BOOLEAN is
			-- Does application start in iconic state?
		do
			Result := implementation.is_iconic_state
		end;

	set_icon_name (a_name: STRING) is
			-- Set `icon_name' to `a_name'.
		require
			Valid_name: a_name /= Void
		do
			implementation.set_icon_name (a_name)
		end;

	set_iconic_state is
			-- Set start state of the application to be iconic.
		do
			implementation.set_iconic_state
		end;

	set_normal_state is
			-- Set start state of the application to be normal.
		do
			implementation.set_normal_state
		end;

	top: TOP is
			-- Top shell or base of widget (itself here)
		do
			Result := Current
		ensure then
			Top_is_current: Result = Current
		end 

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: TOP_I;
			-- Implementation of top

invariant

	Depth_is_zero: depth = 0;
	Has_no_parent: parent = Void

end 
