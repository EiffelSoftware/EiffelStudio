
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
	
feature {NONE} -- Creation

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
			if a_name /= Void then
				identifier:= clone (a_name);
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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
