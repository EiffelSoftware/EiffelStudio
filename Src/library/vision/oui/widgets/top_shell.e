
-- Top level shell which is used in an application that needs
-- more than one root shell.

indexing

	date: "$Date$";
	revision: "$Revision$"

class TOP_SHELL 

inherit 

	TOP
		redefine
			implementation
		end

creation

	make
	
feature -- Creation

	make  (a_name: STRING; a_screen: SCREEN) is
			-- Create a top_shell with `a_name' as identifier,
			-- only if `a_name' not void otherwise identifier
			-- will be defined as application name or the name
			-- precised with -name option and call `set_default'.
		local
			nothing: WIDGET
		do
			depth := 0;
			widget_manager.new (Current, nothing);
			if not (a_name = Void) then
				identifier:= clone (a_name);
			end;
			screen := a_screen;
			implementation:= toolkit.top_shell (Current);
			set_default
		end;
	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: TOP_SHELL_I
			-- Implementation of top_shell

feature {NONE}

	set_default is
			-- Set default values of current top shell.
		do
		end; 

end 



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
