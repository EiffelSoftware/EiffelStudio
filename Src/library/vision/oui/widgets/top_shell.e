indexing

	description:
		"Top level shell which is used in an application that needs %
		%more than one root shell";
	status: "See notice at end of class";
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
	
feature {NONE} -- Creation

	make  (a_name: STRING; a_screen: SCREEN) is
			-- Create a top_shell with `a_name' as identifier,
			-- only if `a_name' not void otherwise identifier
			-- will be defined as application name and call
			-- `set_default'.
		require
			non_void_screen: a_screen /= Void;
			valid_screen: a_screen.is_valid			
		do
			depth := 0;
			screen := a_screen;
			identifier := clone (a_name);
			widget_manager.new (Current, Void);
			implementation := toolkit.top_shell (Current);
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
