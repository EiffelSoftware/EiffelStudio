--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Root shell of an application.

indexing

	date: "$Date$";
	revision: "$Revision$"

class BASE 

inherit 

	TOP
		redefine
			implementation
		end

creation

	make
	
feature -- Creation

	make  (a_name: STRING; a_screen: SCREEN) is
			-- Create a base with `a_name' as identifier,
			-- only if `a_name' not void otherwise identifier
			-- will be defined as application name or the name
			-- precised with -name option, and call `set_default'.
		local
			nothing: WIDGET
		do
			depth := 0;
			widget_manager.new (Current, nothing);
			if not (a_name = Void) then
				identifier:= a_name.duplicate
			end;	
			screen := a_screen;
			implementation:= toolkit.base (Current);
			set_default
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: BASE_I
			-- Implementation of base

feature {NONE}

	set_default is
			-- Set default values to current base.
		do
		end;
end
